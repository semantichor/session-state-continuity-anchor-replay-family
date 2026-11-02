#!/usr/bin/env bash
# =====================================================================
# run_pts.sh — relocatable conformance runner for the FAM-SSCAR-FI-001
# bash family baseline. Drives baseline.sh against the 231 pinned
# canonical records (7 family suites + Annex-C connector suite), captures
# real stdout, compares to the spec-derived oracle, writes pt_run_log.txt
# (append-per-execution) + pt_results.json beside itself.
#
# RELOCATABLE: resolves its own directory; invokes the baseline with
# "$BASH" (the running interpreter's own absolute path — no baked path,
# alias-safe). FAIL-CLOSED: absent/unstartable baseline -> exit non-zero,
# name the missing path, write NO pt_results.json.
# =====================================================================
set -u -o pipefail

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
BASE="$SELF_DIR/baseline.sh"
LOG="$SELF_DIR/pt_run_log.txt"
JSON="$SELF_DIR/pt_results.json"
TMP="$SELF_DIR/.pt_tmp.$$"

if [ ! -f "$BASE" ]; then
  echo "FATAL: baseline not found at $BASE — fails closed; no pt_results.json." >&2; exit 2
fi
if ! "$BASH" "$BASE" selfcheck >/dev/null 2>&1; then
  echo "FATAL: baseline at $BASE did not start (selfcheck) — fails closed; no pt_results.json." >&2; exit 2
fi

: > "$LOG"
ROWS=(); P=0; F=0; S=0; E=0; TOT=0

san() { printf '%s' "$1" | tr '\n' ' ' | tr -d '"\\'; }
record() {
  ROWS+=("{\"id\":\"$1\",\"category\":\"$2\",\"status\":\"$3\",\"notes\":\"$(san "$4")\"}")
  case "$3" in PASS) P=$((P+1));; FAIL) F=$((F+1));; SKIP) S=$((S+1));; ERROR) E=$((E+1));; esac
  TOT=$((TOT+1))
}
ck_ns() { local id=$1 cat=$2 a=$3 s=$4 t=$5 v=$6 exp=$7 out res ec
  out=$("$BASH" "$BASE" "$a" next_state "$s" "$t" "$v" 2>&1); ec=$?
  res=$(printf '%s' "$out" | sed -n 's/.*result_state=\([^ ]*\).*/\1/p')
  { printf 'PT-ID: %s\nCOMMAND: baseline.sh %s next_state %s %s %s\nEXIT_CODE: %s\nSTDOUT_TAIL: %s\n' "$id" "$a" "$s" "$t" "$v" "$ec" "$out"; } >> "$LOG"
  case "$res" in "$exp") record "$id" "$cat" PASS "next_state=$res (==$exp)";; *) record "$id" "$cat" FAIL "next_state=$res expected=$exp";; esac
}
ck_in() { local id=$1 cat=$2 a=$3 s=$4 t=$5 v=$6 set=$7 out res ec
  out=$("$BASH" "$BASE" "$a" next_state "$s" "$t" "$v" 2>&1); ec=$?
  res=$(printf '%s' "$out" | sed -n 's/.*result_state=\([^ ]*\).*/\1/p')
  { printf 'PT-ID: %s\nCOMMAND: baseline.sh %s next_state %s %s %s\nEXIT_CODE: %s\nSTDOUT_TAIL: %s\n' "$id" "$a" "$s" "$t" "$v" "$ec" "$out"; } >> "$LOG"
  case " $set " in *" $res "*) record "$id" "$cat" PASS "next_state=$res in {$set}";; *) record "$id" "$cat" FAIL "$res not in {$set}";; esac
}
ck_multi() { local id=$1 cat=$2; shift 2; : > "$TMP"; local allpass=1 note="" tup a s t v exp out res ec
  for tup in "$@"; do
    IFS=: read -r a s t v exp <<<"$tup"
    out=$("$BASH" "$BASE" "$a" next_state "$s" "$t" "$v" 2>&1); ec=$?
    res=$(printf '%s' "$out" | sed -n 's/.*result_state=\([^ ]*\).*/\1/p')
    printf 'COMMAND: baseline.sh %s next_state %s %s %s\nEXIT_CODE: %s\nSTDOUT_TAIL: %s\n' "$a" "$s" "$t" "$v" "$ec" "$out" >> "$TMP"
    case "$res" in "$exp") note="$note [$s/$t=>$res]";; *) allpass=0; note="$note [$s/$t=>$res!=$exp]";; esac
  done
  { printf 'PT-ID: %s\n' "$id"; cat "$TMP"; } >> "$LOG"
  case "$allpass" in 1) record "$id" "$cat" PASS "$note";; *) record "$id" "$cat" FAIL "$note";; esac
}
ck_out() { local id=$1 cat=$2; shift 2; local args=() pats=() seen=0 x
  for x in "$@"; do case "$seen" in 0) case "$x" in --) seen=1;; *) args+=("$x");; esac;; 1) pats+=("$x");; esac; done
  local out ec; out=$("$BASH" "$BASE" "${args[@]}" 2>&1); ec=$?
  { printf 'PT-ID: %s\nCOMMAND: baseline.sh %s\nEXIT_CODE: %s\nSTDOUT_TAIL: %s\n' "$id" "${args[*]}" "$ec" "$out"; } >> "$LOG"
  local ok=1 miss="" p; for p in "${pats[@]}"; do printf '%s' "$out" | grep -q -- "$p" || { ok=0; miss="$miss|$p"; }; done
  case "$ok" in 1) record "$id" "$cat" PASS patterns_ok;; *) record "$id" "$cat" FAIL "missing:$miss";; esac
}
ck_cmds() { local id=$1 cat=$2; shift 2; : > "$TMP"; local ok=1 miss="" spec args pat out ec
  for spec in "$@"; do
    args=${spec%@@*}; pat=${spec#*@@}
    out=$("$BASH" "$BASE" $args 2>&1); ec=$?
    printf 'COMMAND: baseline.sh %s\nEXIT_CODE: %s\nSTDOUT_TAIL: %s\n' "$args" "$ec" "$out" >> "$TMP" 2>/dev/null
    printf '%s' "$out" | grep -q -- "$pat" || { ok=0; miss="$miss|$pat"; }
  done
  { printf 'PT-ID: %s\n' "$id"; cat "$TMP"; } >> "$LOG"
  case "$ok" in 1) record "$id" "$cat" PASS cmds_ok;; *) record "$id" "$cat" FAIL "$miss";; esac
}
ck_pair() { local id=$1 cat=$2 c1=$3 p1=$4 c2=$5 p2=$6 o1 o2 e1 e2 ok=1 miss="" p OIFS
  o1=$("$BASH" "$BASE" $c1 2>&1); e1=$?; o2=$("$BASH" "$BASE" $c2 2>&1); e2=$?
  { printf 'PT-ID: %s\n' "$id"
    printf 'COMMAND: baseline.sh %s\nEXIT_CODE: %s\nSTDOUT_TAIL: %s\n' "$c1" "$e1" "$o1"
    printf 'COMMAND: baseline.sh %s\nEXIT_CODE: %s\nSTDOUT_TAIL: %s\n' "$c2" "$e2" "$o2"; } >> "$LOG"
  OIFS=$IFS; IFS=';'
  for p in $p1; do printf '%s' "$o1" | grep -q -- "$p" || { ok=0; miss="$miss|1:$p"; }; done
  for p in $p2; do printf '%s' "$o2" | grep -q -- "$p" || { ok=0; miss="$miss|2:$p"; }; done
  IFS=$OIFS
  case "$ok" in 1) record "$id" "$cat" PASS pair_ok;; *) record "$id" "$cat" FAIL "$miss";; esac
}
skip() { { printf 'PT-ID: %s\nCOMMAND: (no invocation -- SKIP: %s)\nEXIT_CODE: -1\nSTDOUT_TAIL: (not invoked; see pt_results.json notes)\n' "$1" "$3"; } >> "$LOG"; record "$1" "$2" SKIP "$3"; }

# ---------------- VRA component suite (PT-001..029) ----------------
ck_ns PT-001 runnable vra S0_STARTUP_READONLY StartupComplete true S1_SNAPSHOT_LOCKED
ck_ns PT-002 runnable vra S2_STRUCTURAL_VERIFIED StructuralChecksDone true S3_ELIGIBLE_HEAD_SELECTED
ck_ns PT-003 runnable vra S3_ELIGIBLE_HEAD_SELECTED EligibilityChecksDone true S4_REHYDRATED_VALIDATED
ck_ns PT-004 runnable vra S2_STRUCTURAL_VERIFIED StructuralChecksDone false S5_FAIL_SAFE
ck_ns PT-005 runnable vra S2_STRUCTURAL_VERIFIED StructuralChecksDone false S5_FAIL_SAFE
ck_ns PT-006 runnable vra S2_STRUCTURAL_VERIFIED StructuralChecksDone false S5_FAIL_SAFE
ck_ns PT-007 runnable vra S2_STRUCTURAL_VERIFIED StructuralChecksDone false S5_FAIL_SAFE
ck_ns PT-008 runnable vra S3_ELIGIBLE_HEAD_SELECTED EligibilityChecksDone false S5_FAIL_SAFE
ck_ns PT-009 runnable vra S3_ELIGIBLE_HEAD_SELECTED EligibilityChecksDone false S5_FAIL_SAFE
ck_ns PT-010 runnable vra S0_STARTUP_READONLY StartupComplete false S5_FAIL_SAFE
ck_ns PT-011 runnable vra S3_ELIGIBLE_HEAD_SELECTED RollbackDetected true S5_FAIL_SAFE
ck_ns PT-012 runnable vra S5_FAIL_SAFE WalReplayNeeded true S7_RECOVERY_REPLAY
ck_ns PT-013 runnable vra S3_ELIGIBLE_HEAD_SELECTED ToolStateInvalid true S6_TOOL_QUARANTINE
ck_multi PT-014 runnable "vra:S3_ELIGIBLE_HEAD_SELECTED:ToolStateInvalid:true:S6_TOOL_QUARANTINE" "vra:S3_ELIGIBLE_HEAD_SELECTED:EligibilityChecksDone:true:S4_REHYDRATED_VALIDATED"
ck_ns PT-015 runnable vra S6_TOOL_QUARANTINE StartupComplete true S6_TOOL_QUARANTINE
ck_out PT-016 runnable vra evidence EB-01 -- "validator_bundle_id=." "verified_head_digest=." "snapshot_id=."
ck_out PT-017 runnable vra evidence EB-02 -- "validator_bundle_id=." "verified_head_digest=." "snapshot_id=." "policy_id=." "source_id=." "freshness_value=." "irr_digest=." "tool_activation_status=."
ck_out PT-018 runnable vra evidence EB-03 -- "failure_code=." "failed_validator=." "suppression_status=."
ck_out PT-019 runnable vra evidence EB-05 -- "recovery_phase=." "recovery_phase_producer=."
ck_out PT-020 runnable vra evidence EB-06 -- "readmission_token_id=."
ck_out PT-021 runnable vra evidence EB-04 -- "validator_bundle_id_producer=ExecutionLayer" "failure_explanation_producer=GateLogic" "tool_activation_status_producer=ToolGate"
ck_out PT-022 runnable vra distinct QUARANTINE S6_TOOL_QUARANTINE -- "distinct=yes"
ck_cmds PT-023 runnable "vra distinct DENY ESCALATE@@distinct=yes" "vra distinct DENY QUARANTINE@@distinct=yes" "vra distinct ESCALATE QUARANTINE@@distinct=yes"
ck_in PT-024 parameterized vra S8_READMISSION_PENDING AuthorityRelease true "S0_STARTUP_READONLY S1_SNAPSHOT_LOCKED"
ck_out PT-025 runnable vra evidence EB-02 -- "freshness_value=." "policy_id=." "failed_validator=V_FRESHNESS"
ck_out PT-026 runnable vra evidence EB-05 -- "recovery_phase=." "recovery_phase_producer=V_WAL_PHASE"
ck_ns PT-027 runnable vra S3_ELIGIBLE_HEAD_SELECTED ToolStateInvalid true S6_TOOL_QUARANTINE
ck_out PT-028 declarative vra attest V_COMPAT -- "attested=true" "compat_status=enforced"
ck_out PT-029 declarative vra attest V_WRITER_LOCK -- "attested=true" "writer_lock_status=single_writer"

# ---------------- BDA component suite (PTS-BDA-001..036) ----------------
ck_ns PTS-BDA-001 runnable bda IDLE INPUT_RECEIVED true INGEST_VALIDATE
ck_ns PTS-BDA-002 runnable bda INGEST_VALIDATE VALIDATION_PASS true FILTER_REVIEW
ck_ns PTS-BDA-003 runnable bda FILTER_REVIEW NO_ESCALATION true READY_FOR_RELEASE
ck_ns PTS-BDA-004 runnable bda FINALIZATION_REVIEW EVIDENCE_OK true IDLE
ck_ns PTS-BDA-005 runnable bda INGEST_VALIDATE VALIDATION_FAIL true OUTPUT_BLOCKED
ck_ns PTS-BDA-006 runnable bda FILTER_REVIEW TOOL_STATE_DETECTED true TOOL_STATE_QUARANTINED
ck_ns PTS-BDA-007 runnable bda INGEST_VALIDATE VALIDATION_FAIL true OUTPUT_BLOCKED
ck_ns PTS-BDA-008 runnable bda TOOL_STATE_QUARANTINED APPROVAL_GRANTED false TOOL_STATE_QUARANTINED
ck_ns PTS-BDA-009 runnable bda INGEST_VALIDATE VALIDATION_FAIL true OUTPUT_BLOCKED
ck_ns PTS-BDA-010 runnable bda INGEST_VALIDATE VALIDATION_FAIL true OUTPUT_BLOCKED
ck_out PTS-BDA-011 declarative bda attest conflict_evidence -- "verdict=BLOCK" "conflict_recorded=true" "attested=true"
ck_out PTS-BDA-012 runnable bda distinct ALLOW ALLOW_CONSTRAINED -- "distinct=yes"
ck_ns PTS-BDA-013 runnable bda FILTER_REVIEW CPW_CRITICAL true OUTPUT_BLOCKED
ck_multi PTS-BDA-014 runnable "bda:INGEST_VALIDATE:VALIDATION_FAIL:true:OUTPUT_BLOCKED" "bda:FINALIZATION_REVIEW:EVIDENCE_FAIL:true:NONCOMPLIANT_HOLD"
ck_ns PTS-BDA-015 runnable bda FILTER_REVIEW CPW_CRITICAL true OUTPUT_BLOCKED
ck_ns PTS-BDA-016 runnable bda FINALIZATION_REVIEW CPW_CRITICAL true OUTPUT_BLOCKED
ck_ns PTS-BDA-017 runnable bda TOOL_STATE_QUARANTINED CPW_CRITICAL true OUTPUT_BLOCKED
ck_ns PTS-BDA-018 runnable bda OUTPUT_BLOCKED READMISSION_APPROVED true IDLE
ck_ns PTS-BDA-019 runnable bda NONCOMPLIANT_HOLD COMPLIANCE_RESTORED true IDLE
ck_ns PTS-BDA-020 runnable bda OUTPUT_BLOCKED READMISSION_APPROVED false OUTPUT_BLOCKED
ck_multi PTS-BDA-021 runnable "bda:IDLE:INPUT_RECEIVED:true:INGEST_VALIDATE" "bda:IDLE:FINALIZATION_REQUESTED:true:OUTPUT_BLOCKED"
ck_out PTS-BDA-022 runnable bda evidence full -- "decision_id=." "verdict=." "reason_code=." "validator_results=." "statement_refs=." "input_digest=."
ck_out PTS-BDA-023 runnable bda evidence full -- "decision_id=." "session_id=." "boundary_side=." "decision_object=." "input_digest=." "policy_hash=." "validator_results=." "statement_refs=." "verdict=." "reason_code=." "order_index=." "hash_prev=." "hash_curr=."
ck_out PTS-BDA-024 runnable bda evidence approval -- "approval_ref=."
ck_out PTS-BDA-025 runnable bda evidence finalization -- "evidence_ref=." "verif_counter_anchor=."
ck_out PTS-BDA-026 runnable bda evidence rollback -- "rollback_ref=."
skip PTS-BDA-027 declarative "BDA Conformance Tests §5 Minimal Run Note 'Bounded external obligations not locally runnable: ... authorized non-validator producer grounding'"
ck_ns PTS-BDA-028 runnable bda READY_FOR_RELEASE CPW_CRITICAL true OUTPUT_BLOCKED
skip PTS-BDA-029 declarative "BDA Conformance Tests §5 Minimal Run Note 'Bounded external obligations not locally runnable: ... distributed enforcement legitimacy where not exposed by local transition function'"
ck_out PTS-BDA-030 runnable bda verdicts -- "verdicts=ALLOW ALLOW_CONSTRAINED BLOCK QUARANTINE FAIL_CLOSED NONCOMPLIANT_HOLD READMIT"
ck_cmds PTS-BDA-031 runnable "bda distinct BLOCK QUARANTINE@@distinct=yes" "bda distinct FAIL_CLOSED NONCOMPLIANT_HOLD@@distinct=yes" "bda distinct OUTPUT_BLOCKED NONCOMPLIANT_HOLD@@distinct=yes"
ck_multi PTS-BDA-032 parameterized "bda:INGEST_VALIDATE:VALIDATION_FAIL:true:OUTPUT_BLOCKED" "bda:FILTER_REVIEW:TOOL_STATE_DETECTED:true:TOOL_STATE_QUARANTINED" "bda:FILTER_REVIEW:NO_ESCALATION:true:READY_FOR_RELEASE"
ck_ns PTS-BDA-033 runnable bda FILTER_REVIEW CPW_CRITICAL true OUTPUT_BLOCKED
ck_out PTS-BDA-034 runnable bda evidence approval -- "approval_ref=."
ck_multi PTS-BDA-035 runnable "bda:FINALIZATION_REVIEW:EVIDENCE_OK:true:IDLE" "bda:FINALIZATION_REVIEW:EVIDENCE_FAIL:true:NONCOMPLIANT_HOLD"
ck_out PTS-BDA-036 declarative bda distinct ALLOW ALLOW_CONSTRAINED -- "distinct=yes"

# ---------------- TAA component suite (TAA-PT-* + VP-GEN-*) ----------------
taa_dispatch() { local id=$1 n=$2; case "$n" in
  001) ck_ns "$id" runnable taa INTAKE INTAKE_TO_ROLE_SCREENING true ROLE_SCREENING ;;
  002) ck_ns "$id" runnable taa EVALUATING EVALUATING_TO_CLASSIFYING true CLASSIFYING ;;
  003) ck_ns "$id" runnable taa DECIDED DECIDED_TO_HANDOFF_READY true HANDOFF_READY ;;
  004) ck_ns "$id" runnable taa EVALUATING EVALUATING_TO_CLASSIFYING false FAIL_CLOSED ;;
  005) ck_cmds "$id" runnable "taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION true@@result_state=DECIDED" "taa evidence allow_constrained@@verdict=ALLOW_CONSTRAINED" ;;
  006) ck_cmds "$id" runnable "taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ESCALATE_DECISION true@@result_state=DECIDED" "taa evidence fail_closed_escalation@@escalation_request_ref=." ;;
  007) ck_ns "$id" runnable taa ROLE_SCREENING ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING true CANONICALIZING ;;
  008) ck_multi "$id" runnable "taa:CLASSIFYING:CLASSIFYING_TO_DENY_DECISION:true:DECIDED" "taa:EVALUATING:EVALUATING_TO_FAIL_CLOSED:true:FAIL_CLOSED" ;;
  009) ck_ns "$id" runnable taa INTAKE STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED true FAIL_CLOSED ;;
  010) ck_ns "$id" runnable taa CLASSIFYING POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED true FAIL_CLOSED ;;
  011) ck_ns "$id" runnable taa EVALUATING CONFLICT_CHECKING_TO_ALLOW_DECISION true FAIL_CLOSED ;;
  012) ck_multi "$id" runnable "taa:FAIL_CLOSED:FAIL_CLOSED_TO_NONCOMPLIANT_HOLD:true:NONCOMPLIANT_HOLD" "taa:NONCOMPLIANT_HOLD:NONCOMPLIANT_HOLD_TO_READMISSION_PENDING:true:READMISSION_PENDING" ;;
  013) ck_ns "$id" runnable taa READMISSION_PENDING READMISSION_PENDING_TO_ROLE_SCREENING true ROLE_SCREENING ;;
  014) ck_ns "$id" runnable taa CLOSED DECIDED_TO_HANDOFF_READY true CLOSED ;;
  015) ck_out "$id" runnable taa evidence base -- "semantic_closure=closed" "evidence_closure=closed" "failure_closure=closed" "policy_snapshot_closure=closed" ;;
  016) ck_out "$id" runnable taa evidence base -- "decision_id=." "statement_id_list=." "verdict=." "reason_code=." "tsa_label=." "source_class=." "policy_snapshot_id=." "scope_id=." "turn_id=." "order_ref=." "logical_timestamp=." ;;
  017) ck_out "$id" runnable taa evidence allow_constrained -- "conflict_check_mode=." "conflict_check_strength=." "conflict_check_confidence=." "conflict_check_coverage_scope=." "compared_claim_set_ref=." "residual_risk_statement=." ;;
  018) ck_out "$id" runnable taa evidence fail_closed_escalation -- "request_id=." "failure_ref=." "required_actor_role=." "required_evidence=." "status=." ;;
  019) ck_ns "$id" runnable taa DECIDED CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED true FAIL_CLOSED ;;
  020) skip "$id" declarative "TAA Conformance Tests record-kind 'Declarative conformance claim (not a buyer-runnable unit test)' + Minimal run note 'the 1 declarative record (VP-GEN-020 / TAA-PT-020-DECL) is preserved as a buyer obligation rather than a runnable assertion'" ;;
  021) ck_out "$id" runnable taa verdicts -- "verdicts=ALLOW ALLOW_CONSTRAINED DENY FAIL_CLOSED ESCALATE OUT_OF_SCOPE" ;;
  022) ck_multi "$id" runnable "taa:ROLE_SCREENING:ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING:true:CANONICALIZING" "taa:ROLE_SCREENING:ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION:true:DECIDED" ;;
  023) ck_multi "$id" parameterized "taa:CONFLICT_CHECKING:CONFLICT_CHECKING_TO_DENY_DECISION:true:DECIDED" "taa:CONFLICT_CHECKING:CONFLICT_CHECKING_TO_FAIL_CLOSED:true:FAIL_CLOSED" ;;
  024) ck_ns "$id" runnable taa EVALUATING EVALUATING_TO_FAIL_CLOSED true FAIL_CLOSED ;;
  025) ck_out "$id" runnable taa evidence allow_constrained -- "verdict=ALLOW_CONSTRAINED" "residual_risk_statement=." ;;
  026) ck_multi "$id" runnable "taa:ROLE_SCREENING:ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING:true:CANONICALIZING" "taa:CONFLICT_CHECKING:CONFLICT_CHECKING_TO_DENY_DECISION:true:DECIDED" ;;
  027) ck_multi "$id" runnable "taa:CONFLICT_CHECKING:CONFLICT_CHECKING_TO_ALLOW_DECISION:true:DECIDED" "taa:CONFLICT_CHECKING:CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION:true:DECIDED" "taa:CONFLICT_CHECKING:CONFLICT_CHECKING_TO_DENY_DECISION:true:DECIDED" "taa:CONFLICT_CHECKING:CONFLICT_CHECKING_TO_ESCALATE_DECISION:true:DECIDED" ;;
esac; }
for N in 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027; do
  taa_dispatch "TAA-PT-$N" "$N"; taa_dispatch "VP-GEN-$N" "$N"
done

# ---------------- ARA component suite (ARA-T001..027) ----------------
ck_ns ARA-T001 runnable ara S0_INGESTED EV_PARSE_OK true S1_PARSED
ck_ns ARA-T002 runnable ara S2_VERIFIED replay_fold_complete true S3_RECONSTRUCTED
ck_ns ARA-T003 runnable ara S4_CHECKPOINT_RESOLVED EV_REPORT_BOUND true S5_REPORT_READY
ck_multi ARA-T004 runnable "ara:S4_CHECKPOINT_RESOLVED:EV_SIGNATURE_FAIL:true:SX_FAIL_CLOSED" "ara:S4_CHECKPOINT_RESOLVED:EV_CHAIN_BREAK:true:SX_FAIL_CLOSED"
ck_out ARA-T005 runnable ara gate report_insufficient -- "verdict=PARTIAL" "finalize_report=blocked"
ck_ns ARA-T006 runnable ara S2_VERIFIED EV_EVIDENCE_FAIL true SH_HOLD_ACTIVE
ck_out ARA-T007 runnable ara gate checkpoint_unverified -- "rollback_sequence=INVALID"
ck_multi ARA-T008 runnable "ara:S1_PARSED:EV_SIGNATURE_FAIL:true:SX_FAIL_CLOSED" "ara:S1_PARSED:EV_COUNTER_REPLAY:true:SH_HOLD_ACTIVE"
ck_ns ARA-T009 runnable ara S1_PARSED EV_SIGNATURE_FAIL true SX_FAIL_CLOSED
ck_ns ARA-T010 runnable ara S4_CHECKPOINT_RESOLVED EV_CHAIN_BREAK false SX_FAIL_CLOSED
ck_multi ARA-T011 runnable "ara:S1_PARSED:EV_SIGNATURE_FAIL:true:SX_FAIL_CLOSED" "ara:S2_VERIFIED:EV_EVIDENCE_FAIL:true:SH_HOLD_ACTIVE" "ara:S0_INGESTED:EV_POLICY_UNRESOLVED:true:SX_FAIL_CLOSED"
ck_ns ARA-T012 runnable ara SH_HOLD_ACTIVE EV_READMISSION_GRANTED true S6_READMITTED
ck_ns ARA-T013 runnable ara SH_HOLD_ACTIVE EV_READMISSION_GRANTED false SH_HOLD_ACTIVE
ck_ns ARA-T014 runnable ara S5_REPORT_READY EV_PARSE_OK true S5_REPORT_READY
ck_out ARA-T015 runnable ara evidence mandatory -- "report_signature=." "export_manifest_ref=."
ck_out ARA-T016 runnable ara evidence mandatory -- "bundle_digest=." "policy_profile_id=." "validator_outcomes=." "hash_continuity_refs=."
ck_out ARA-T017 runnable ara evidence hold_readmission -- "hold_enter_refs=." "hold_exit_refs=." "anchor_update_ref=."
ck_out ARA-T018 runnable ara evidence producers -- "orphaned_producer=none"
ck_out ARA-T019 declarative ara gate V-10_quarantine -- "gate_status=QUARANTINE" "attested=true"
ck_out ARA-T020 declarative ara gate distributed_enforcement -- "orphaned=false" "attested=true"
ck_out ARA-T021 runnable ara verdicts -- "verdicts=REPLAYABLE PARTIAL REJECTED BROKEN INCIDENT_ONLY"
ck_cmds ARA-T022 runnable "ara distinct BROKEN REJECTED@@distinct=yes" "ara distinct SX_FAIL_CLOSED SH_HOLD_ACTIVE@@distinct=yes" "ara distinct INCIDENT_ONLY FAIL_CLOSED@@distinct=yes"
ck_multi ARA-T023 parameterized "ara:S0_INGESTED:EV_POLICY_UNRESOLVED:true:SX_FAIL_CLOSED" "ara:S6_READMITTED:controlled_resumption:true:S2_VERIFIED"
ck_ns ARA-T024 runnable ara S3_RECONSTRUCTED EV_LASTCLEAN_FOUND true S4_CHECKPOINT_RESOLVED
ck_out ARA-T025 runnable ara evidence hold_readmission -- "hold_exit_refs=." "anchor_update_ref=."
ck_ns ARA-T026 runnable ara S4_CHECKPOINT_RESOLVED EV_REPORT_BOUND true S5_REPORT_READY
ck_out ARA-T027 declarative ara gate transparent_classification -- "hidden_omission=none" "attested=true"

# ---------------- FPA component suite (FPA-D-* + FPA-T-*) ----------------
FPAD="FPA Conformance Tests §F.D 'Declarative obligations (not locally runnable on the published surface)' + §H Minimal Run Note 'Bounded external obligations not locally runnable: FPA-D-01 through FPA-D-06'"
skip FPA-D-01 declarative "$FPAD"
skip FPA-D-02 declarative "$FPAD"
skip FPA-D-03 declarative "$FPAD"
skip FPA-D-04 declarative "$FPAD"
skip FPA-D-05 declarative "$FPAD"
skip FPA-D-06 declarative "$FPAD"
ck_ns FPA-T-01 runnable fpa IDLE TransferPacketReceived true RECEIVED
ck_ns FPA-T-02 runnable fpa RECEIVED StructureValid true VERIFIED
ck_ns FPA-T-03 runnable fpa RESTORATION_ELIGIBLE RestoreAdmitted true IDLE
ck_multi FPA-T-04 runnable "fpa:RECEIVED:StructureValid:false:REJECTED" "fpa:RECEIVED:StructureInvalid:true:REJECTED"
ck_ns FPA-T-06 runnable fpa VERIFIED EvidencePending false QUARANTINED
ck_ns FPA-T-08a runnable fpa VERIFIED FreshnessFail true REJECTED
ck_ns FPA-T-08b runnable fpa WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed false REJECTED
ck_out FPA-T-08c runnable fpa distinct REJECT FAIL_CLOSED -- "distinct=yes"
ck_ns FPA-T-09 runnable fpa VERIFIED FreshnessPass false REJECTED
ck_ns FPA-T-10 runnable fpa WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed false REJECTED
ck_ns FPA-T-11 runnable fpa IRR_COMMITTED FreshnessPass true REJECTED
ck_ns FPA-T-12 runnable fpa QUARANTINED ReadmissionApproved true VERIFIED
ck_ns FPA-T-13a runnable fpa WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed true RESTORATION_ELIGIBLE
ck_ns FPA-T-13b runnable fpa RESTORATION_ELIGIBLE RestoreAdmitted true IDLE
ck_ns FPA-T-14 runnable fpa REJECTED FreshnessPass true REJECTED
ck_out FPA-T-15 runnable fpa evidence deny_restore -- "reason_code=DENY_RESTORE" "semantic_verdict=FAIL_CLOSED" "gate_class=BLOCK"
ck_out FPA-T-16 runnable fpa evidence accept -- "decision_id=." "agent_id=." "source_id=." "ledger_uuid=." "decision_object=." "policy_id=." "policy_version=." "reason_code=." "semantic_verdict=ACCEPT" "gate_class=RELEASE" "packet_hash=." "freshness_value=." "watermark_before=." "watermark_after=." "ssm_validation_result=."
ck_out FPA-T-17A parameterized fpa evidence tvc -- "tvc_validation_result=."
ck_out FPA-T-17B parameterized fpa evidence evidence -- "evidence_validation_result=."
ck_out FPA-T-17C parameterized fpa evidence transport -- "transport_validation_result=."
ck_out FPA-T-17D runnable fpa evidence accept -- "irr_digest=." "prev_receipt_digest=."
ck_out FPA-T-18 runnable fpa evidence accept -- "decision_id=." "agent_id=." "watermark_before=." "watermark_after=."
ck_out FPA-T-21 runnable fpa verdicts -- "verdicts=ACCEPT REJECT QUARANTINE RESTORATION_ELIGIBLE READMIT FAIL_CLOSED"
ck_multi FPA-T-23 parameterized "fpa:VERIFIED:EvidencePending:true:QUARANTINED" "fpa:VERIFIED:FreshnessPass:false:REJECTED"
ck_ns FPA-T-24 runnable fpa VERIFIED FreshnessPass true FRESHNESS_ELIGIBLE
ck_out FPA-T-25 parameterized fpa evidence quarantine -- "evidence_validation_result=." "semantic_verdict=QUARANTINE" "gate_class=ESCALATION"
ck_ns FPA-T-26 runnable fpa FRESHNESS_ELIGIBLE IRRAppended true IRR_COMMITTED
ck_ns FPA-T-PR-01 runnable fpa VERIFIED FreshnessFail true REJECTED
ck_multi FPA-T-PR-02 runnable "fpa:FRESHNESS_ELIGIBLE:IRRAppended:true:IRR_COMMITTED" "fpa:IRR_COMMITTED:WatermarkPersisted:true:WATERMARK_COMMITTED" "fpa:FRESHNESS_ELIGIBLE:WatermarkPersisted:true:REJECTED"
ck_ns FPA-T-PR-03 runnable fpa WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed true RESTORATION_ELIGIBLE
ck_multi FPA-T-PR-09 runnable "fpa:WATERMARK_COMMITTED:RestoreRequest_GenesisConfirmed:true:RESTORATION_ELIGIBLE" "fpa:WATERMARK_COMMITTED:RestoreRequest_GenesisConfirmed:false:REJECTED"
ck_ns FPA-T-PR-10 runnable fpa IDLE RestoreAdmitted true REJECTED
ck_multi FPA-T-PR-12 runnable "fpa:QUARANTINED:ReadmissionApproved:true:VERIFIED" "fpa:IDLE:ReadmissionApproved:true:REJECTED"
ck_multi FPA-T-PR-13 runnable "fpa:VERIFIED:FreshnessPass:true:FRESHNESS_ELIGIBLE" "fpa:FRESHNESS_ELIGIBLE:IRRAppended:true:IRR_COMMITTED"
ck_ns FPA-T-PR-14 runnable fpa IRR_COMMITTED WatermarkPersisted false REJECTED

# ---------------- SSCAR integrator Public Test Suite (PTS-*) ----------------
ck_ns PTS-001 runnable family S0 Fv01Pass true S1
ck_ns PTS-002 runnable family S2 Fv03Pass true S3
ck_cmds PTS-003 runnable "family compose clean@@reached_state=S8" "family compose clean@@family_verdict=REPLAY_ADMISSIBLE$" "family foc FOC-01 REPLAY_ADMISSIBLE@@contract=FOC-01"
ck_ns PTS-004a runnable family S1 Fv02AndFv04Pass false SX
ck_ns PTS-004b runnable family S2 UnlabeledMechanismLevelCarriedClaim _ SX
skip PTS-005 declarative "SSCAR Conformance Tests §5 '7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here'"
ck_cmds PTS-006 runnable "family next_state S3 FreshnessReplay _@@result_state=SH" "family verdict FV-06@@family_verdict=NONCOMPLIANT_HOLD" "family foc FOC-05@@hold_enter_refs=."
ck_out PTS-007 parameterized family compose fv04_reclass -- "reached_state=SX" "family_verdict=CONTAMINATION_FAIL_CLOSED"
ck_multi PTS-008 runnable "family:S3:FreshnessReplay:_:SH" "family:S3:CriticalContamination:_:SX"
ck_multi PTS-009 runnable "family:S3:CriticalContamination:_:SX" "family:S5:CriticalContamination:_:SX" "family:S0:CriticalContamination:_:SX"
ck_ns PTS-010 runnable family S5 AntiRollbackFailure _ SX
ck_multi PTS-011 runnable "family:S3:ChainBreak:_:SX" "family:S3:UntrustedAnchorPromoted:_:SX"
ck_ns PTS-012 runnable family SH HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate true SR
ck_ns PTS-013 runnable family SR ReadmissionBundleChangedCarriedPayload true S2
ck_multi PTS-014 runnable "family:S8:Handoff:_:S8" "family:SX:IncidentOnlyOutput:_:SX"
skip PTS-015 declarative "SSCAR Conformance Tests §5 '7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here'"
ck_out PTS-016 runnable family evidence -- "FEV-01_family_decision_id=." "FEV-02_boundary_event_id=." "FEV-03_session_id=." "FEV-04_carried_statement_refs=." "FEV-05_tsa_refs=." "FEV-06_anchor_document_ref=." "FEV-07_accepted_head_digest=." "FEV-08_freshness=." "FEV-09_rehydration_closure_ref=." "FEV-10_replay_refs=." "FEV-11_disclosure_class_entries=." "FEV-12_family_validator_outcomes=." "FEV-13_hold_refs=." "FEV-14_contamination_flags=." "FEV-15_report_signature=."
ck_out PTS-017a runnable family foc FOC-04 -- "contaminating_ref_set=." "blocked_stage=." "root_reason_code=."
ck_out PTS-017b runnable family foc FOC-05 -- "hold_enter_refs=." "pending_requirements=."
ck_out PTS-017d runnable family evidence none HEN-0001/HEX-0001 none -- "FEV-08_freshness=.*ANCHOR-UPD" "FEV-13_hold_refs=.*HEX"
ck_cmds PTS-018 runnable "family foc FOC-04@@contaminating_ref_set=." "family foc FOC-05@@hold_case_id=."
skip PTS-019 declarative "SSCAR Conformance Tests §5 '7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here'"
skip PTS-020 declarative "SSCAR Conformance Tests §5 '7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here'"
ck_cmds PTS-021 runnable "family distinct SH NONCOMPLIANT_HOLD@@distinct=yes" "family distinct SX CONTAMINATION_FAIL_CLOSED@@distinct=yes"
ck_multi PTS-022 runnable "family:S3:FreshnessReplay:_:SH" "family:S3:CriticalContamination:_:SX"
ck_multi PTS-023 parameterized "family:SR:ReadmissionBundleChangedCarriedPayload:true:S2" "family:SR:ReadmissionBundleChangedAnchorDocumentRef:true:S2" "family:SR:ReadmissionBundleChangedSourceControlBundles:true:S2" "family:SR:ReadmissionBundleChangedPolicySnapshotId:true:S5" "family:SR:ReadmissionBundleChangedRehydrationClosureRef:true:S5"
ck_ns PTS-024 runnable family S4 Fv07Pass true S5
ck_cmds PTS-025 runnable "family compose fv07_antirollback@@family_verdict=CONTAMINATION_FAIL_CLOSED" "family evidence@@FEV-09_rehydration_closure_ref=." "family evidence@@FEV-12_family_validator_outcomes=."
ck_ns PTS-026 runnable family S1 Fv02AndFv04Pass false SX
skip PTS-027 declarative "SSCAR Conformance Tests §5 '7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here'"

# ---------------- Annex-C Family Connector Test Suite (CT-01..14) ----------------
ck_out CT-01 connector family compose clean -- "components_admitted=5" "family_verdict=REPLAY_ADMISSIBLE$"
ck_out CT-02 connector family compose fv03_unlabeled -- "failed_validator=FV-03" "family_verdict=CONTAMINATION_FAIL_CLOSED"
ck_out CT-03 connector family compose fv02_untrusted_anchor -- "failed_validator=FV-02" "reached_state=SX"
ck_out CT-04 connector family compose fv06_freshness_replay -- "failed_validator=FV-06" "family_verdict=NONCOMPLIANT_HOLD" "reached_state=SH"
ck_pair CT-05 connector "family compose clean" "cc01_head_link=yes" "family compose fv05_brokenlink" "family_verdict=REPLAY_INCOMPLETE;cc01_head_link=no"
ck_pair CT-06 connector "family compose clean" "rehydration_closure_ref=REHYD" "family compose fv07_antirollback" "family_verdict=CONTAMINATION_FAIL_CLOSED"
ck_pair CT-07 connector "family compose clean" "checkpoint_refs=CKPT" "family compose fv08_incomplete_replay" "family_verdict=REPLAY_INCOMPLETE"
ck_out CT-08 connector family compose clean -- "family_verdict=REPLAY_ADMISSIBLE$" "reached_state=S8"
ck_out CT-09 connector family compose fv09_toolstate -- "failed_validator=FV-09" "family_verdict=CONTAMINATION_FAIL_CLOSED"
ck_ns CT-10 connector family SH HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate true SR
ck_pair CT-11 connector "family compose constrained" "family_verdict=REPLAY_ADMISSIBLE_CONSTRAINED" "family compose fv10_disclosure_collapse" "family_verdict=INCIDENT_ONLY"
ck_pair CT-12 connector "family compose fv11_empty_outcomes" "family_verdict=INCIDENT_ONLY" "family compose clean" "family_verdict=REPLAY_ADMISSIBLE$"
ck_out CT-13 connector family compose fv04_reclass -- "failed_validator=FV-04" "reached_state=SX"
ck_multi CT-14 connector "family:SR:ReadmissionBundleChangedCarriedPayload:true:S2" "family:SR:ReadmissionBundleChangedAnchorDocumentRef:true:S2" "family:SR:ReadmissionBundleChangedPolicySnapshotId:true:S5" "family:SR:ReadmissionBundleChangedComponentSet:true:S2" "family:SR:ReadmissionBundleChangedRehydrationClosureRef:true:S5"

# ---------------- emit pt_results.json ----------------
{
  printf '{\n'
  printf '  "agent_id": "FAM-SSCAR-FI-001",\n'
  printf '  "lang": "bash",\n'
  printf '  "test_run_timestamp_utc": "%s",\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date -u)"
  printf '  "execution_mode": "live",\n'
  printf '  "protocol": "buyer-conformance",\n'
  printf '  "totals": {"total": %s, "pass": %s, "fail": %s, "skip": %s, "error": %s},\n' "$TOT" "$P" "$F" "$S" "$E"
  printf '  "results": [\n'
  n=${#ROWS[@]}
  for ((i=0;i<n;i++)); do
    if [ $((i+1)) -lt "$n" ]; then printf '    %s,\n' "${ROWS[$i]}"; else printf '    %s\n' "${ROWS[$i]}"; fi
  done
  printf '  ]\n}\n'
} > "$JSON"
rm -f "$TMP"
echo "run_pts: total=$TOT pass=$P fail=$F skip=$S error=$E -> $JSON"
