// run_pts.rs — relocatable conformance runner for the FAM-SSCAR-FI-001 rust
// baseline. Drives all 231 pinned canonical records across the 7 family test
// suites against the baseline's projection surfaces, compares captured stdout
// to spec-derived oracles, and writes pt_results.json + pt_run_log.txt.
//
// Relocatable: resolves the baseline as `baseline.exe` in the runner's OWN
// directory by default (argv[1] overrides); output dir defaults to the current
// working directory (argv[2] overrides). No absolute machine paths are baked in.
// Fail-closed: if the baseline cannot be resolved or started, exits non-zero and
// writes NO pt_results.json.

use std::env;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

// ---- record model ----------------------------------------------------------
struct Step {
    args: Vec<String>,
    expects: Vec<String>,
}
struct Rec {
    id: String,
    cat: &'static str, // runnable|parameterized|declarative|connector
    steps: Vec<Step>,  // empty => SKIP
    skip: Option<String>,
}

fn st(cmd: &str, expects: &[&str]) -> Step {
    Step {
        args: cmd.split(' ').filter(|s| !s.is_empty()).map(|s| s.to_string()).collect(),
        expects: expects.iter().map(|s| s.to_string()).collect(),
    }
}
fn rec(id: &str, cat: &'static str, steps: Vec<Step>) -> Rec {
    Rec { id: id.to_string(), cat, steps, skip: None }
}
fn skp(id: &str, cat: &'static str, cite: &str) -> Rec {
    Rec { id: id.to_string(), cat, steps: vec![], skip: Some(cite.to_string()) }
}

fn json_escape(s: &str) -> String {
    let mut o = String::new();
    for c in s.chars() {
        match c {
            '"' => o.push_str("\\\""),
            '\\' => o.push_str("\\\\"),
            '\n' => o.push_str("\\n"),
            '\r' => o.push_str("\\r"),
            '\t' => o.push_str("\\t"),
            c if (c as u32) < 0x20 => o.push_str(&format!("\\u{:04x}", c as u32)),
            c => o.push(c),
        }
    }
    o
}

fn main() {
    // ---- resolve baseline + output dir (relocatable) ----
    let exe_dir: PathBuf = env::current_exe()
        .ok()
        .and_then(|p| p.parent().map(|d| d.to_path_buf()))
        .unwrap_or_else(|| PathBuf::from("."));
    let args: Vec<String> = env::args().collect();
    let baseline: PathBuf = if args.len() > 1 {
        PathBuf::from(&args[1])
    } else {
        exe_dir.join("baseline.exe")
    };
    let out_dir: PathBuf = if args.len() > 2 {
        PathBuf::from(&args[2])
    } else {
        env::current_dir().unwrap_or_else(|_| PathBuf::from("."))
    };

    // ---- fail-closed: baseline must resolve AND start ----
    if !baseline.exists() {
        eprintln!("FAIL-CLOSED: baseline not found at {}", baseline.display());
        std::process::exit(2);
    }
    match Command::new(&baseline).arg("selfcheck").output() {
        Ok(o) if o.status.success() => {}
        Ok(o) => {
            eprintln!(
                "FAIL-CLOSED: baseline selfcheck exited {}",
                o.status.code().unwrap_or(-1)
            );
            std::process::exit(2);
        }
        Err(e) => {
            eprintln!("FAIL-CLOSED: baseline could not be started: {}", e);
            std::process::exit(2);
        }
    }

    let recs = build_records();

    // ---- execute ----
    let mut log = String::new();
    let mut results: Vec<(String, &'static str, &'static str, String)> = Vec::new(); // id,cat,status,notes
    let (mut npass, mut nfail, mut nskip, mut nerror) = (0, 0, 0, 0);

    for r in &recs {
        if let Some(cite) = &r.skip {
            log.push_str(&format!("PT-ID: {}\n", r.id));
            log.push_str(&format!("COMMAND: (no invocation -- SKIP: {})\n", cite));
            log.push_str("EXIT_CODE: -1\n");
            log.push_str("STDOUT_TAIL: (not invoked; see pt_results.json notes)\n\n");
            results.push((r.id.clone(), r.cat, "SKIP", format!("cited SKIP — {}", cite)));
            nskip += 1;
            continue;
        }
        log.push_str(&format!("PT-ID: {}\n", r.id));
        let mut status = "PASS";
        let mut note = String::new();
        for step in &r.steps {
            let cmd_disp = format!("baseline.exe {}", step.args.join(" "));
            let out = Command::new(&baseline).args(&step.args).output();
            match out {
                Ok(o) => {
                    let code = o.status.code().unwrap_or(-1);
                    let stdout = String::from_utf8_lossy(&o.stdout).to_string();
                    let tail = if stdout.len() > 4096 {
                        stdout[stdout.len() - 4096..].to_string()
                    } else {
                        stdout.clone()
                    };
                    log.push_str(&format!("COMMAND: {}\n", cmd_disp));
                    log.push_str(&format!("EXIT_CODE: {}\n", code));
                    log.push_str(&format!("STDOUT_TAIL: {}\n", tail.trim_end()));
                    if code != 0 {
                        status = "ERROR";
                        note = format!("non-zero exit {} on `{}`", code, cmd_disp);
                        break;
                    }
                    let missing: Vec<&String> =
                        step.expects.iter().filter(|e| !stdout.contains(e.as_str())).collect();
                    if !missing.is_empty() {
                        if status != "ERROR" {
                            status = "FAIL";
                        }
                        note = format!(
                            "`{}` output missing {:?}",
                            cmd_disp,
                            missing.iter().map(|m| m.as_str()).collect::<Vec<_>>()
                        );
                        // keep scanning remaining steps for a full log trail
                    }
                }
                Err(e) => {
                    log.push_str(&format!("COMMAND: {}\n", cmd_disp));
                    log.push_str("EXIT_CODE: -1\n");
                    log.push_str(&format!("STDOUT_TAIL: (spawn error: {})\n", e));
                    status = "ERROR";
                    note = format!("spawn error on `{}`: {}", cmd_disp, e);
                    break;
                }
            }
        }
        log.push('\n');
        if note.is_empty() {
            note = format!("{} step(s) invoked; oracle matched", r.steps.len());
        }
        match status {
            "PASS" => npass += 1,
            "FAIL" => nfail += 1,
            "ERROR" => nerror += 1,
            _ => {}
        }
        results.push((r.id.clone(), r.cat, status, note));
    }

    // ---- write pt_run_log.txt ----
    let log_path = out_dir.join("pt_run_log.txt");
    if let Err(e) = fs::write(&log_path, &log) {
        eprintln!("FAIL: could not write {}: {}", log_path.display(), e);
        std::process::exit(3);
    }

    // ---- write pt_results.json ----
    let total = results.len();
    let ts = "2026-10-26T00:00:00Z";
    let mut js = String::new();
    js.push_str("{\n");
    js.push_str("  \"agent_id\": \"FAM-SSCAR-FI-001\",\n");
    js.push_str("  \"lang\": \"rust\",\n");
    js.push_str(&format!("  \"test_run_timestamp_utc\": \"{}\",\n", ts));
    js.push_str("  \"execution_mode\": \"live\",\n");
    js.push_str("  \"protocol\": \"buyer-conformance\",\n");
    js.push_str(&format!(
        "  \"totals\": {{\"total\": {}, \"pass\": {}, \"fail\": {}, \"skip\": {}, \"error\": {}}},\n",
        total, npass, nfail, nskip, nerror
    ));
    js.push_str("  \"results\": [\n");
    for (i, (id, cat, status, note)) in results.iter().enumerate() {
        js.push_str(&format!(
            "    {{\"id\": \"{}\", \"category\": \"{}\", \"status\": \"{}\", \"notes\": \"{}\"}}{}\n",
            json_escape(id),
            cat,
            status,
            json_escape(note),
            if i + 1 < results.len() { "," } else { "" }
        ));
    }
    js.push_str("  ]\n}\n");
    let json_path = out_dir.join("pt_results.json");
    if let Err(e) = fs::write(&json_path, &js) {
        eprintln!("FAIL: could not write {}: {}", json_path.display(), e);
        std::process::exit(3);
    }

    println!(
        "run_pts complete: total={} pass={} fail={} skip={} error={}",
        total, npass, nfail, nskip, nerror
    );
    println!("wrote {}", log_path.display());
    println!("wrote {}", json_path.display());
    let _ = Path::new(".");
}

// ===========================================================================
// The 231 pinned canonical records (ids pinned by the harness; expected values
// derived from each OWNING pack's conformance apparatus + specification).
// ===========================================================================
fn build_records() -> Vec<Rec> {
    let mut v: Vec<Rec> = Vec::new();

    // cited-SKIP bases (owning-pack verbatim disposition clauses) --------------
    let pts_cite = "SSCAR_Conformance_Tests.md:27 §5 closed enumeration — \"7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here.\"";
    let taa020_cite = "Truth_Arbitration_Agent_Conformance_Tests.md §4/record-kind — \"Declarative conformance claim (not a buyer-runnable unit test)\"; MRN bounded-external: ordering enforcement distributed across §11 + §9, satisfied at the runtime layer (AMB-011).";
    let fpad_cite = "Freshness_Portability_Agent_Conformance_Tests.md §F.D — \"Declarative obligations (not locally runnable on the published surface)\"; §H: each §F.D obligation \"documented in the buyer's conformance record as a non-runnable but required obligation.\"";
    let bda027_cite = "Boundary_Defense_Agent_Conformance_Tests.md:516 §5 Minimal Run Note bounded-external — \"authorized non-validator producer grounding\".";
    let bda029_cite = "Boundary_Defense_Agent_Conformance_Tests.md:516 §5 Minimal Run Note bounded-external — \"distributed enforcement legitimacy where not exposed by local transition function\".";

    // ---- VRA component suite (PT-001..029) -----------------------------------
    v.push(rec("PT-001", "runnable", vec![st("vra next_state S0 StartupComplete true", &["state=S1"])]));
    v.push(rec("PT-002", "runnable", vec![st("vra next_state S2 StructuralChecksDone true", &["state=S3"])]));
    v.push(rec("PT-003", "runnable", vec![st("vra next_state S3 EligibilityChecksDone true", &["state=S4"])]));
    v.push(rec("PT-004", "runnable", vec![st("vra next_state S2 StructuralChecksDone false", &["state=S5"])]));
    v.push(rec("PT-005", "runnable", vec![st("vra next_state S2 StructuralChecksDone false", &["state=S5"])]));
    v.push(rec("PT-006", "runnable", vec![st("vra next_state S2 StructuralChecksDone false", &["state=S5"])]));
    v.push(rec("PT-007", "runnable", vec![st("vra next_state S2 StructuralChecksDone false", &["state=S5"])]));
    v.push(rec("PT-008", "runnable", vec![st("vra next_state S3 EligibilityChecksDone false", &["state=S5"])]));
    v.push(rec("PT-009", "runnable", vec![st("vra next_state S3 EligibilityChecksDone false", &["state=S5"])]));
    v.push(rec("PT-010", "runnable", vec![st("vra next_state S0 StartupComplete false", &["state=S5"])]));
    v.push(rec("PT-011", "runnable", vec![st("vra next_state S3 RollbackDetected true", &["state=S5"])]));
    v.push(rec("PT-012", "runnable", vec![st("vra next_state S5 WalReplayNeeded true", &["state=S7"])]));
    v.push(rec("PT-013", "runnable", vec![st("vra next_state S3 ToolStateInvalid true", &["state=S6"])]));
    v.push(rec("PT-014", "runnable", vec![
        st("vra next_state S3 ToolStateInvalid true", &["state=S6"]),
        st("vra next_state S3 EligibilityChecksDone true", &["state=S4"]),
    ]));
    v.push(rec("PT-015", "runnable", vec![st("vra next_state S6 StartupComplete true", &["state=S6"])]));
    v.push(rec("PT-016", "runnable", vec![st("vra evidence deny_chain", &["validator_bundle_id", "verified_head_digest", "snapshot_id"])]));
    v.push(rec("PT-017", "runnable", vec![st("vra evidence deny_freshness", &["validator_bundle_id", "verified_head_digest", "snapshot_id", "policy_id", "source_id", "freshness_value", "irr_digest", "tool_activation_status"])]));
    v.push(rec("PT-018", "runnable", vec![st("vra evidence deny_parse", &["failure_code", "failed_validator", "suppression_status"])]));
    v.push(rec("PT-019", "runnable", vec![st("vra evidence recovery", &["recovery_phase", "recovery_phase_producer"])]));
    v.push(rec("PT-020", "runnable", vec![st("vra evidence readmission", &["readmission_token_id"])]));
    v.push(rec("PT-021", "runnable", vec![st("vra evidence producers", &["validator_bundle_id_producer=ExecutionLayer", "failure_explanation_producer=GateLogic", "tool_activation_status_producer=ToolGate"])]));
    v.push(rec("PT-022", "runnable", vec![st("vra verdict_vocab", &["QUARANTINE", "DENY", "ESCALATE"])]));
    v.push(rec("PT-023", "runnable", vec![st("vra verdict_vocab", &["DENY", "ESCALATE", "QUARANTINE"])]));
    v.push(rec("PT-024", "parameterized", vec![st("vra next_state S8 AuthorityRelease true", &["state=S0"])]));
    v.push(rec("PT-025", "runnable", vec![st("vra evidence deny_freshness", &["freshness_value", "policy_id", "failed_validator=V_FRESHNESS"])]));
    v.push(rec("PT-026", "runnable", vec![st("vra evidence recovery", &["recovery_phase", "recovery_phase_producer=V_WAL_PHASE"])]));
    v.push(rec("PT-027", "runnable", vec![st("vra next_state S3 ToolStateInvalid true", &["state=S6"])]));
    v.push(rec("PT-028", "declarative", vec![st("vra evidence compat", &["v_compat_enforcement", "compat_status"])]));
    v.push(rec("PT-029", "declarative", vec![st("vra evidence writer_lock", &["v_writer_lock_enforcement", "writer_lock_status", "contention_status"])]));

    // ---- BDA component suite (PTS-BDA-001..036) ------------------------------
    v.push(rec("PTS-BDA-001", "runnable", vec![st("bda next_state IDLE INPUT_RECEIVED true", &["state=INGEST_VALIDATE"])]));
    v.push(rec("PTS-BDA-002", "runnable", vec![st("bda next_state INGEST_VALIDATE VALIDATION_PASS true", &["state=FILTER_REVIEW"])]));
    v.push(rec("PTS-BDA-003", "runnable", vec![st("bda next_state FILTER_REVIEW NO_ESCALATION true", &["state=READY_FOR_RELEASE"])]));
    v.push(rec("PTS-BDA-004", "runnable", vec![st("bda next_state FINALIZATION_REVIEW EVIDENCE_OK true", &["state=IDLE"])]));
    v.push(rec("PTS-BDA-005", "runnable", vec![st("bda next_state INGEST_VALIDATE VALIDATION_FAIL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-006", "runnable", vec![st("bda next_state FILTER_REVIEW TOOL_STATE_DETECTED true", &["state=TOOL_STATE_QUARANTINED"])]));
    v.push(rec("PTS-BDA-007", "runnable", vec![st("bda next_state INGEST_VALIDATE VALIDATION_FAIL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-008", "runnable", vec![st("bda next_state TOOL_STATE_QUARANTINED APPROVAL_GRANTED false", &["state=TOOL_STATE_QUARANTINED"])]));
    v.push(rec("PTS-BDA-009", "runnable", vec![st("bda next_state INGEST_VALIDATE VALIDATION_FAIL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-010", "runnable", vec![st("bda next_state INGEST_VALIDATE VALIDATION_FAIL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-011", "declarative", vec![st("bda evidence conflict", &["verdict=BLOCK", "conflict_evidence"])]));
    v.push(rec("PTS-BDA-012", "declarative", vec![st("bda verdict_vocab", &["ALLOW", "ALLOW_CONSTRAINED"])]));
    v.push(rec("PTS-BDA-013", "runnable", vec![st("bda next_state FILTER_REVIEW CPW_CRITICAL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-014", "runnable", vec![
        st("bda next_state INGEST_VALIDATE VALIDATION_FAIL true", &["state=OUTPUT_BLOCKED"]),
        st("bda next_state FINALIZATION_REVIEW EVIDENCE_FAIL true", &["state=NONCOMPLIANT_HOLD"]),
    ]));
    v.push(rec("PTS-BDA-015", "runnable", vec![st("bda next_state FILTER_REVIEW CPW_CRITICAL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-016", "runnable", vec![st("bda next_state FINALIZATION_REVIEW CPW_CRITICAL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-017", "runnable", vec![st("bda next_state TOOL_STATE_QUARANTINED CPW_CRITICAL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-018", "runnable", vec![st("bda next_state OUTPUT_BLOCKED READMISSION_APPROVED true", &["state=IDLE"])]));
    v.push(rec("PTS-BDA-019", "runnable", vec![st("bda next_state NONCOMPLIANT_HOLD COMPLIANCE_RESTORED true", &["state=IDLE"])]));
    v.push(rec("PTS-BDA-020", "runnable", vec![st("bda next_state OUTPUT_BLOCKED READMISSION_APPROVED false", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-021", "runnable", vec![
        st("bda next_state OUTPUT_BLOCKED READMISSION_APPROVED true", &["state=IDLE"]),
        st("bda next_state IDLE INPUT_RECEIVED true", &["state=INGEST_VALIDATE"]),
    ]));
    v.push(rec("PTS-BDA-022", "runnable", vec![st("bda evidence verdict_artifact", &["decision_id", "verdict", "reason_code", "validator_results", "statement_refs", "input_digest"])]));
    v.push(rec("PTS-BDA-023", "runnable", vec![st("bda evidence mandatory", &["decision_id", "session_id", "boundary_side", "decision_object", "input_digest", "policy_hash", "validator_results", "statement_refs", "verdict", "reason_code", "order_index", "hash_prev", "hash_curr"])]));
    v.push(rec("PTS-BDA-024", "runnable", vec![st("bda evidence approval", &["approval_ref"])]));
    v.push(rec("PTS-BDA-025", "runnable", vec![st("bda evidence finalization", &["evidence_ref", "verif_counter_anchor"])]));
    v.push(rec("PTS-BDA-026", "runnable", vec![st("bda evidence rollback", &["rollback_ref"])]));
    v.push(skp("PTS-BDA-027", "declarative", bda027_cite));
    v.push(rec("PTS-BDA-028", "runnable", vec![st("bda next_state READY_FOR_RELEASE CPW_CRITICAL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(skp("PTS-BDA-029", "declarative", bda029_cite));
    v.push(rec("PTS-BDA-030", "runnable", vec![st("bda verdict_vocab", &["ALLOW", "ALLOW_CONSTRAINED", "BLOCK", "QUARANTINE", "FAIL_CLOSED", "NONCOMPLIANT_HOLD", "READMIT"])]));
    v.push(rec("PTS-BDA-031", "runnable", vec![st("bda verdict_vocab", &["BLOCK", "QUARANTINE", "FAIL_CLOSED", "NONCOMPLIANT_HOLD"])]));
    v.push(rec("PTS-BDA-032", "parameterized", vec![
        st("bda next_state INGEST_VALIDATE VALIDATION_FAIL true", &["state=OUTPUT_BLOCKED"]),
        st("bda next_state FILTER_REVIEW TOOL_STATE_DETECTED true", &["state=TOOL_STATE_QUARANTINED"]),
    ]));
    v.push(rec("PTS-BDA-033", "runnable", vec![st("bda next_state FILTER_REVIEW CPW_CRITICAL true", &["state=OUTPUT_BLOCKED"])]));
    v.push(rec("PTS-BDA-034", "runnable", vec![st("bda evidence approval", &["approval_ref"])]));
    v.push(rec("PTS-BDA-035", "runnable", vec![
        st("bda next_state FINALIZATION_REVIEW EVIDENCE_OK true", &["state=IDLE"]),
        st("bda next_state FINALIZATION_REVIEW EVIDENCE_FAIL true", &["state=NONCOMPLIANT_HOLD"]),
    ]));
    v.push(rec("PTS-BDA-036", "declarative", vec![st("bda verdict_vocab", &["ALLOW", "ALLOW_CONSTRAINED"])]));

    // ---- TAA component suite: TAA-PT-001..027 + VP-GEN-001..027 --------------
    // Each TAA-PT-NNN and its VP-GEN-NNN alias exercise the same projection.
    let taa_steps: Vec<(&str, Vec<Step>)> = vec![
        ("001", vec![st("taa next_state INTAKE INTAKE_TO_ROLE_SCREENING true", &["state=ROLE_SCREENING"])]),
        ("002", vec![st("taa next_state EVALUATING EVALUATING_TO_CLASSIFYING true", &["state=CLASSIFYING"])]),
        ("003", vec![st("taa next_state DECIDED DECIDED_TO_HANDOFF_READY true", &["state=HANDOFF_READY"])]),
        ("004", vec![st("taa next_state EVALUATING EVALUATING_TO_CLASSIFYING false", &["state=FAIL_CLOSED"])]),
        ("005", vec![st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION true", &["state=DECIDED"])]),
        ("006", vec![st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ESCALATE_DECISION true", &["state=DECIDED"])]),
        ("007", vec![st("taa next_state ROLE_SCREENING ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING true", &["state=CANONICALIZING"])]),
        ("008", vec![
            st("taa next_state CLASSIFYING CLASSIFYING_TO_DENY_DECISION true", &["state=DECIDED"]),
            st("taa next_state EVALUATING EVALUATING_TO_FAIL_CLOSED false", &["state=FAIL_CLOSED"]),
        ]),
        ("009", vec![st("taa next_state INTAKE STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED false", &["state=FAIL_CLOSED"])]),
        ("010", vec![st("taa next_state CLASSIFYING POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED false", &["state=FAIL_CLOSED"])]),
        ("011", vec![st("taa next_state EVALUATING CONFLICT_CHECKING_TO_ALLOW_DECISION false", &["state=FAIL_CLOSED"])]),
        ("012", vec![
            st("taa next_state FAIL_CLOSED FAIL_CLOSED_TO_NONCOMPLIANT_HOLD false", &["state=NONCOMPLIANT_HOLD"]),
            st("taa next_state NONCOMPLIANT_HOLD NONCOMPLIANT_HOLD_TO_READMISSION_PENDING false", &["state=READMISSION_PENDING"]),
        ]),
        ("013", vec![st("taa next_state READMISSION_PENDING READMISSION_PENDING_TO_ROLE_SCREENING true", &["state=ROLE_SCREENING"])]),
        ("014", vec![st("taa next_state CLOSED EVALUATING_TO_CLASSIFYING true", &["state=CLOSED"])]),
        ("015", vec![st("taa evidence closure", &["semantic_closure", "evidence_closure", "failure_closure", "policy_snapshot_closure"])]),
        ("016", vec![st("taa evidence mandatory", &["decision_id", "statement_id_list", "verdict", "reason_code", "tsa_label", "source_class", "boundary_validated_role", "policy_snapshot_id", "order_ref"])]),
        ("017", vec![st("taa evidence conditional_conflict", &["conflict_check_mode", "conflict_check_confidence", "compared_claim_set_ref", "residual_risk_statement"])]),
        ("018", vec![st("taa evidence escalation", &["request_id", "failure_ref", "required_actor_role", "required_evidence", "status"])]),
        ("019", vec![st("taa next_state DECIDED CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED false", &["state=FAIL_CLOSED"])]),
        // 020 is the dual-ID declarative SKIP (handled below, not here)
        ("021", vec![st("taa verdict_vocab", &["ALLOW", "ALLOW_CONSTRAINED", "DENY", "FAIL_CLOSED", "ESCALATE", "OUT_OF_SCOPE"])]),
        ("022", vec![
            st("taa next_state ROLE_SCREENING ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING true", &["state=CANONICALIZING"]),
            st("taa next_state ROLE_SCREENING ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION true", &["state=DECIDED"]),
        ]),
        ("023", vec![
            st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_DENY_DECISION true", &["state=DECIDED"]),
            st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_FAIL_CLOSED false", &["state=FAIL_CLOSED"]),
        ]),
        ("024", vec![st("taa next_state EVALUATING EVALUATING_TO_FAIL_CLOSED false", &["state=FAIL_CLOSED"])]),
        ("025", vec![st("taa evidence conditional_conflict", &["conflict_check_mode", "residual_risk_statement"])]),
        ("026", vec![st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_DECISION true", &["state=DECIDED"])]),
        ("027", vec![
            st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_DECISION true", &["state=DECIDED"]),
            st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION true", &["state=DECIDED"]),
            st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_DENY_DECISION true", &["state=DECIDED"]),
            st("taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ESCALATE_DECISION true", &["state=DECIDED"]),
        ]),
    ];
    // TAA-PT ids (020 is SKIP)
    for (n, steps) in &taa_steps {
        let cat = if *n == "023" { "parameterized" } else { "runnable" };
        v.push(dup(&format!("TAA-PT-{}", n), cat, steps));
    }
    v.push(skp("TAA-PT-020", "declarative", taa020_cite));
    // VP-GEN aliases (020 is SKIP)
    for (n, steps) in &taa_steps {
        let cat = if *n == "023" { "parameterized" } else { "runnable" };
        v.push(dup(&format!("VP-GEN-{}", n), cat, steps));
    }
    v.push(skp("VP-GEN-020", "declarative", taa020_cite));

    // ---- ARA component suite (ARA-T001..027) ---------------------------------
    v.push(rec("ARA-T001", "runnable", vec![st("ara next_state S0 EV_PARSE_OK true", &["state=S1"])]));
    v.push(rec("ARA-T002", "runnable", vec![st("ara next_state S2 replay_fold_complete true", &["state=S3"])]));
    v.push(rec("ARA-T003", "runnable", vec![st("ara next_state S4 EV_REPORT_BOUND true", &["state=S5"])]));
    v.push(rec("ARA-T004", "runnable", vec![
        st("ara next_state S2 EV_SIGNATURE_FAIL true", &["state=SX"]),
        st("ara next_state S4 EV_CHAIN_BREAK false", &["state=SX"]),
        st("ara verdict chain_break", &["verdict=BROKEN"]),
    ]));
    v.push(rec("ARA-T005", "runnable", vec![st("ara verdict report_insufficient", &["verdict=PARTIAL"])]));
    v.push(rec("ARA-T006", "runnable", vec![st("ara next_state S3 EV_EVIDENCE_FAIL true", &["state=SH"])]));
    v.push(rec("ARA-T007", "runnable", vec![st("ara next_state S3 EV_LASTCLEAN_FOUND false", &["state=S3"])]));
    v.push(rec("ARA-T008", "runnable", vec![
        st("ara next_state S2 EV_SIGNATURE_FAIL true", &["state=SX"]),
        st("ara next_state S2 EV_CHAIN_BREAK true", &["state=SX"]),
        st("ara next_state S2 EV_COUNTER_REPLAY true", &["state=SH"]),
        st("ara next_state S2 EV_EVIDENCE_FAIL true", &["state=SH"]),
    ]));
    v.push(rec("ARA-T009", "runnable", vec![st("ara next_state S2 EV_SIGNATURE_FAIL true", &["state=SX"])]));
    v.push(rec("ARA-T010", "runnable", vec![
        st("ara next_state S4 EV_CHAIN_BREAK false", &["state=SX"]),
        st("ara verdict chain_break", &["verdict=BROKEN"]),
    ]));
    v.push(rec("ARA-T011", "runnable", vec![
        st("ara next_state S1 EV_SIGNATURE_FAIL true", &["state=SX"]),
        st("ara next_state S1 EV_CHAIN_BREAK true", &["state=SX"]),
        st("ara next_state S1 EV_EVIDENCE_FAIL true", &["state=SH"]),
    ]));
    v.push(rec("ARA-T012", "runnable", vec![st("ara next_state SH EV_READMISSION_GRANTED true", &["state=S6"])]));
    v.push(rec("ARA-T013", "runnable", vec![st("ara next_state SH EV_READMISSION_GRANTED false", &["state=SH"])]));
    v.push(rec("ARA-T014", "runnable", vec![st("ara next_state S5 EV_PARSE_OK true", &["state=S5"])]));
    v.push(rec("ARA-T015", "runnable", vec![st("ara evidence final_export", &["report_signature", "export_manifest_ref"])]));
    v.push(rec("ARA-T016", "runnable", vec![st("ara evidence mandatory", &["bundle_digest", "policy_profile_id", "validator_outcomes", "hash_continuity_refs", "checkpoint_refs", "rollback_refs"])]));
    v.push(rec("ARA-T017", "runnable", vec![st("ara evidence hold_readmission", &["hold_enter_refs", "hold_exit_refs", "anchor_update_ref"])]));
    v.push(rec("ARA-T018", "runnable", vec![st("ara evidence producers", &["producer_provenance"])]));
    v.push(rec("ARA-T019", "declarative", vec![st("ara evidence quarantine_gate", &["v10_quarantine", "admission_to_reconstruction"])]));
    v.push(rec("ARA-T020", "declarative", vec![st("ara evidence quarantine_gate", &["v10_quarantine", "classification"])]));
    v.push(rec("ARA-T021", "runnable", vec![st("ara verdict_vocab", &["REPLAYABLE", "PARTIAL", "REJECTED", "BROKEN", "INCIDENT_ONLY"])]));
    v.push(rec("ARA-T022", "runnable", vec![st("ara verdict_vocab", &["BROKEN", "REJECTED", "INCIDENT_ONLY"])]));
    v.push(rec("ARA-T023", "parameterized", vec![
        st("ara next_state S2 EV_POLICY_UNRESOLVED true sx", &["state=SX"]),
        st("ara next_state S2 EV_POLICY_UNRESOLVED true", &["state=S2"]),
    ]));
    v.push(rec("ARA-T024", "runnable", vec![st("ara next_state S3 EV_LASTCLEAN_FOUND true", &["state=S4"])]));
    v.push(rec("ARA-T025", "runnable", vec![st("ara evidence hold_readmission", &["hold_exit_refs", "anchor_update_ref"])]));
    v.push(rec("ARA-T026", "runnable", vec![st("ara next_state S4 EV_REPORT_BOUND true", &["state=S5"])]));
    v.push(rec("ARA-T027", "declarative", vec![st("ara evidence quarantine_gate", &["v10_quarantine", "classification"])]));

    // ---- FPA component suite (FPA-D-01..06 SKIP; FPA-T-* / FPA-T-PR-*) -------
    for n in ["01", "02", "03", "04", "05", "06"] {
        v.push(skp(&format!("FPA-D-{}", n), "declarative", fpad_cite));
    }
    v.push(rec("FPA-T-01", "runnable", vec![st("fpa next_state IDLE TransferPacketReceived true", &["state=RECEIVED"])]));
    v.push(rec("FPA-T-02", "runnable", vec![st("fpa next_state RECEIVED StructureValid true", &["state=VERIFIED"])]));
    v.push(rec("FPA-T-03", "runnable", vec![st("fpa next_state RESTORATION_ELIGIBLE RestoreAdmitted true", &["state=IDLE"])]));
    v.push(rec("FPA-T-04", "runnable", vec![
        st("fpa next_state RECEIVED StructureValid false", &["state=REJECTED"]),
        st("fpa next_state RECEIVED StructureInvalid true", &["state=REJECTED"]),
    ]));
    v.push(rec("FPA-T-06", "runnable", vec![st("fpa next_state VERIFIED EvidencePending false", &["state=QUARANTINED"])]));
    v.push(rec("FPA-T-08a", "runnable", vec![st("fpa next_state VERIFIED FreshnessFail true", &["state=REJECTED"])]));
    v.push(rec("FPA-T-08b", "runnable", vec![st("fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed false", &["state=REJECTED"])]));
    v.push(rec("FPA-T-08c", "runnable", vec![st("fpa verdict_vocab", &["REJECT", "FAIL_CLOSED"])]));
    v.push(rec("FPA-T-09", "runnable", vec![st("fpa next_state VERIFIED FreshnessPass false", &["state=REJECTED"])]));
    v.push(rec("FPA-T-10", "runnable", vec![st("fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed false", &["state=REJECTED"])]));
    v.push(rec("FPA-T-11", "runnable", vec![st("fpa next_state IRR_COMMITTED FreshnessPass true", &["state=REJECTED"])]));
    v.push(rec("FPA-T-12", "runnable", vec![st("fpa next_state QUARANTINED ReadmissionApproved true", &["state=VERIFIED"])]));
    v.push(rec("FPA-T-13a", "runnable", vec![st("fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed true", &["state=RESTORATION_ELIGIBLE"])]));
    v.push(rec("FPA-T-13b", "runnable", vec![st("fpa next_state RESTORATION_ELIGIBLE RestoreAdmitted true", &["state=IDLE"])]));
    v.push(rec("FPA-T-14", "runnable", vec![st("fpa next_state REJECTED FreshnessPass true", &["state=REJECTED"])]));
    v.push(rec("FPA-T-15", "runnable", vec![st("fpa evidence deny_restore", &["reason_code=DENY_RESTORE", "semantic_verdict=FAIL_CLOSED", "gate_class=BLOCK"])]));
    v.push(rec("FPA-T-16", "runnable", vec![st("fpa evidence accept", &["semantic_verdict=ACCEPT", "gate_class=RELEASE", "packet_hash", "freshness_value", "watermark_before", "watermark_after", "ssm_validation_result"])]));
    v.push(rec("FPA-T-17A", "parameterized", vec![
        st("fpa evidence tvc", &["tvc_validation_result"]),
        st("fpa evidence tvc_absent", &["OK"]),
    ]));
    v.push(rec("FPA-T-17B", "parameterized", vec![
        st("fpa evidence evidence_bin", &["evidence_validation_result"]),
        st("fpa evidence evidence_bin_absent", &["OK"]),
    ]));
    v.push(rec("FPA-T-17C", "parameterized", vec![
        st("fpa evidence transport", &["transport_validation_result"]),
        st("fpa evidence transport_absent", &["OK"]),
    ]));
    v.push(rec("FPA-T-17D", "runnable", vec![st("fpa evidence receipt_linkage", &["irr_digest", "prev_receipt_digest"])]));
    v.push(rec("FPA-T-18", "runnable", vec![st("fpa evidence producers", &["non_validator_producer"])]));
    v.push(rec("FPA-T-21", "runnable", vec![st("fpa verdict_vocab", &["RESTORATION_ELIGIBLE"])]));
    v.push(rec("FPA-T-23", "parameterized", vec![
        st("fpa next_state VERIFIED EvidencePending true", &["state=QUARANTINED"]),
        st("fpa next_state VERIFIED FreshnessPass false", &["state=REJECTED"]),
    ]));
    v.push(rec("FPA-T-24", "runnable", vec![st("fpa next_state VERIFIED FreshnessPass true", &["state=FRESHNESS_ELIGIBLE"])]));
    v.push(rec("FPA-T-25", "parameterized", vec![st("fpa evidence quarantine", &["evidence_validation_result", "semantic_verdict=QUARANTINE", "gate_class=ESCALATION"])]));
    v.push(rec("FPA-T-26", "runnable", vec![st("fpa next_state FRESHNESS_ELIGIBLE IRRAppended true", &["state=IRR_COMMITTED"])]));
    v.push(rec("FPA-T-PR-01", "runnable", vec![st("fpa next_state VERIFIED FreshnessFail true", &["state=REJECTED"])]));
    v.push(rec("FPA-T-PR-02", "runnable", vec![
        st("fpa next_state FRESHNESS_ELIGIBLE IRRAppended true", &["state=IRR_COMMITTED"]),
        st("fpa next_state IRR_COMMITTED WatermarkPersisted true", &["state=WATERMARK_COMMITTED"]),
        st("fpa next_state FRESHNESS_ELIGIBLE WatermarkPersisted true", &["state=REJECTED"]),
    ]));
    v.push(rec("FPA-T-PR-03", "runnable", vec![st("fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed true", &["state=RESTORATION_ELIGIBLE"])]));
    v.push(rec("FPA-T-PR-09", "runnable", vec![
        st("fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed true", &["state=RESTORATION_ELIGIBLE"]),
        st("fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed false", &["state=REJECTED"]),
    ]));
    v.push(rec("FPA-T-PR-10", "runnable", vec![st("fpa next_state IDLE RestoreAdmitted true", &["state=REJECTED"])]));
    v.push(rec("FPA-T-PR-12", "runnable", vec![
        st("fpa next_state QUARANTINED ReadmissionApproved true", &["state=VERIFIED"]),
        st("fpa next_state IDLE ReadmissionApproved true", &["state=REJECTED"]),
    ]));
    v.push(rec("FPA-T-PR-13", "runnable", vec![
        st("fpa next_state VERIFIED FreshnessPass true", &["state=FRESHNESS_ELIGIBLE"]),
        st("fpa next_state FRESHNESS_ELIGIBLE IRRAppended true", &["state=IRR_COMMITTED"]),
    ]));
    v.push(rec("FPA-T-PR-14", "runnable", vec![st("fpa next_state IRR_COMMITTED WatermarkPersisted false", &["state=REJECTED"])]));

    // ---- SSCAR integrator Public Test Suite (PTS-*) --------------------------
    v.push(rec("PTS-001", "runnable", vec![st("fam next_state S0 Fv01Pass true", &["state=S1"])]));
    v.push(rec("PTS-002", "runnable", vec![st("fam next_state S2 Fv03Pass true", &["state=S3"])]));
    v.push(rec("PTS-003", "runnable", vec![st("fam compose ct08", &["state=S8", "verdict=REPLAY_ADMISSIBLE", "FOC-01"])]));
    v.push(rec("PTS-004a", "runnable", vec![st("fam next_state S1 Fv02AndFv04Pass false", &["state=SX"])]));
    v.push(rec("PTS-004b", "runnable", vec![st("fam next_state S2 UnlabeledMechanismLevelCarriedClaim false", &["state=SX"])]));
    v.push(skp("PTS-005", "declarative", pts_cite));
    v.push(rec("PTS-006", "runnable", vec![
        st("fam next_state S3 FreshnessReplay false", &["state=SH"]),
        st("fam verdict_layer FV-06", &["verdict=NONCOMPLIANT_HOLD"]),
        st("fam compose ct04", &["foc=FOC-05", "hold_enter_refs"]),
    ]));
    v.push(rec("PTS-007", "parameterized", vec![st("fam compose ct13", &["state=S2"])]));
    v.push(rec("PTS-008", "runnable", vec![
        st("fam next_state S3 FreshnessReplay false", &["state=SH"]),
        st("fam next_state S3 CriticalContamination false", &["state=SX"]),
    ]));
    v.push(rec("PTS-009", "runnable", vec![
        st("fam next_state S3 CriticalContamination false", &["state=SX"]),
        st("fam next_state S5 CriticalContamination false", &["state=SX"]),
        st("fam next_state S0 CriticalContamination false", &["state=SX"]),
    ]));
    v.push(rec("PTS-010", "runnable", vec![st("fam next_state S5 AntiRollbackFailure false", &["state=SX"])]));
    v.push(rec("PTS-011", "runnable", vec![
        st("fam next_state S3 ChainBreak false", &["state=SX"]),
        st("fam next_state S3 UntrustedAnchorPromoted false", &["state=SX"]),
    ]));
    v.push(rec("PTS-012", "runnable", vec![st("fam next_state SH HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate true", &["state=SR"])]));
    v.push(rec("PTS-013", "runnable", vec![st("fam next_state SR ReadmissionBundleChangedCarriedPayload true", &["state=S2"])]));
    v.push(rec("PTS-014", "runnable", vec![
        st("fam next_state S8 Handoff false", &["state=S8"]),
        st("fam next_state SX IncidentOnlyOutput false", &["state=SX"]),
    ]));
    v.push(skp("PTS-015", "declarative", pts_cite));
    v.push(rec("PTS-016", "runnable", vec![st("fam evidence ct08", &["FEV-01_", "FEV-02_", "FEV-03_", "FEV-04_", "FEV-05_", "FEV-06_", "FEV-07_", "FEV-08_", "FEV-09_", "FEV-10_", "FEV-11_", "FEV-12_", "FEV-13_", "FEV-14_", "FEV-15_"])]));
    v.push(rec("PTS-017a", "runnable", vec![st("fam compose ct02", &["foc=FOC-04", "tsa_refs", "blocked_stage", "contaminating_ref_set"])]));
    v.push(rec("PTS-017b", "runnable", vec![st("fam compose ct04", &["freshness_before", "freshness_after", "hold_enter_refs"])]));
    v.push(rec("PTS-017d", "runnable", vec![st("fam compose ct10", &["hold_exit_refs", "anchor_update_ref"])]));
    v.push(rec("PTS-018", "runnable", vec![
        st("fam compose ct02", &["foc=FOC-04"]),
        st("fam compose ct04", &["foc=FOC-05"]),
    ]));
    v.push(skp("PTS-019", "declarative", pts_cite));
    v.push(skp("PTS-020", "declarative", pts_cite));
    v.push(rec("PTS-021", "runnable", vec![st("fam verdict_vocab", &["REPLAY_ADMISSIBLE", "CONTAMINATION_FAIL_CLOSED", "INCIDENT_ONLY"])]));
    v.push(rec("PTS-022", "runnable", vec![
        st("fam next_state S3 FreshnessReplay false", &["state=SH"]),
        st("fam verdict_layer FV-06", &["verdict=NONCOMPLIANT_HOLD"]),
        st("fam next_state S3 CriticalContamination false", &["state=SX"]),
        st("fam verdict_layer FV-09", &["verdict=CONTAMINATION_FAIL_CLOSED"]),
    ]));
    v.push(rec("PTS-023", "parameterized", vec![
        st("fam next_state SR ReadmissionBundleChangedCarriedPayload true", &["state=S2"]),
        st("fam next_state SR ReadmissionBundleChangedAnchorDocumentRef true", &["state=S2"]),
        st("fam next_state SR ReadmissionBundleChangedSourceControlBundles true", &["state=S2"]),
        st("fam next_state SR ReadmissionBundleChangedPolicySnapshot true", &["state=S5"]),
        st("fam next_state SR ReadmissionBundleChangedRehydrationClosure true", &["state=S5"]),
    ]));
    v.push(rec("PTS-024", "runnable", vec![st("fam next_state S4 Fv07Pass true", &["state=S5"])]));
    v.push(rec("PTS-025", "runnable", vec![
        st("fam next_state S5 AntiRollbackFailure false", &["state=SX"]),
        st("fam compose ct06_fail", &["verdict=CONTAMINATION_FAIL_CLOSED"]),
    ]));
    v.push(rec("PTS-026", "runnable", vec![st("fam next_state S1 Fv02AndFv04Pass false", &["state=SX"])]));
    v.push(skp("PTS-027", "declarative", pts_cite));

    // ---- Annex C Family Connector Test Suite (CT-01..14) ---------------------
    v.push(rec("CT-01", "connector", vec![st("fam compose ct01", &["state=S1", "fv01=pass"])]));
    v.push(rec("CT-02", "connector", vec![st("fam compose ct02", &["state=SX", "verdict=CONTAMINATION_FAIL_CLOSED", "blocked_stage=provenance_classification", "contamination_flags"])]));
    v.push(rec("CT-03", "connector", vec![st("fam compose ct03", &["state=S1", "verdict=CONTAMINATION_FAIL_CLOSED"])]));
    v.push(rec("CT-04", "connector", vec![st("fam compose ct04", &["state=SH", "verdict=NONCOMPLIANT_HOLD", "hold_enter_refs", "pending_requirements"])]));
    v.push(rec("CT-05", "connector", vec![
        st("fam compose ct08", &["verdict=REPLAY_ADMISSIBLE"]),
        st("fam compose ct05_broken", &["verdict=REPLAY_INCOMPLETE"]),
    ]));
    v.push(rec("CT-06", "connector", vec![
        st("fam compose ct08", &["FEV-09_rehydration_closure_ref=vra-rhc-0001"]),
        st("fam compose ct06_fail", &["verdict=CONTAMINATION_FAIL_CLOSED"]),
    ]));
    v.push(rec("CT-07", "connector", vec![
        st("fam compose ct08", &["FEV-10_replay_checkpoint_rollback"]),
        st("fam compose ct07_broken", &["verdict=REPLAY_INCOMPLETE"]),
    ]));
    v.push(rec("CT-08", "connector", vec![st("fam compose ct08", &["state=S8", "verdict=REPLAY_ADMISSIBLE", "FOC-03"])]));
    v.push(rec("CT-09", "connector", vec![st("fam compose ct09", &["state=SX", "verdict=CONTAMINATION_FAIL_CLOSED", "contaminating_ref_set"])]));
    v.push(rec("CT-10", "connector", vec![
        st("fam next_state SH HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate true", &["state=SR"]),
        st("fam compose ct10", &["hold_exit_refs", "anchor_update_ref"]),
    ]));
    v.push(rec("CT-11", "connector", vec![
        st("fam compose ct11_ok", &["verdict=REPLAY_ADMISSIBLE_CONSTRAINED"]),
        st("fam compose ct11_collapse", &["verdict=INCIDENT_ONLY"]),
    ]));
    v.push(rec("CT-12", "connector", vec![st("fam compose ct12", &["verdict=INCIDENT_ONLY", "family_validator_outcomes=empty"])]));
    v.push(rec("CT-13", "connector", vec![st("fam compose ct13", &["state=S2"])]));
    v.push(rec("CT-14", "connector", vec![
        st("fam next_state SR ReadmissionBundleChangedCarriedPayload true", &["state=S2"]),
        st("fam next_state SR ReadmissionBundleChangedAnchorDocumentRef true", &["state=S2"]),
        st("fam next_state SR ReadmissionBundleChangedPolicySnapshot true", &["state=S5"]),
        st("fam next_state SR ReadmissionBundleChangedComponentSet true", &["state=S2"]),
        st("fam next_state SR ReadmissionBundleChangedRehydrationClosure true", &["state=S5"]),
    ]));

    v
}

// clone a shared step list into a fresh record (TAA / VP-GEN aliases).
fn dup(id: &str, cat: &'static str, steps: &[Step]) -> Rec {
    let cloned: Vec<Step> = steps
        .iter()
        .map(|s| Step { args: s.args.clone(), expects: s.expects.clone() })
        .collect();
    Rec { id: id.to_string(), cat, steps: cloned, skip: None }
}
