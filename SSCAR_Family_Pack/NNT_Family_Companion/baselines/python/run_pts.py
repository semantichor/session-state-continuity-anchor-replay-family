#!/usr/bin/env python3
"""R6 acceptance runner for the FAM-SSCAR-FI-001 unified family baseline.

Relocatable + fail-closed (R6):
  * discovers its own directory and resolves the baseline as `baseline.py`
    beside it; no absolute machine path is baked in;
  * drives the baseline through the interpreter running THIS script
    (sys.executable — absolute, so no Windows App-Execution-Alias interception,
    and relocatable);
  * if the baseline is absent or cannot be started, exits non-zero naming the
    missing path and writes NO pt_results.json.

For every pinned canonical PT-ID it invokes the baseline's projection surface
with that record's documented input, captures the real stdout, compares against
the record's spec-derived oracle, and appends one pt_run_log.txt block + one
pt_results.json row. Cited SKIPs are reported (never omitted) with the owning
pack's licensing clause. Re-running against the delivered baseline reproduces
the delivered statuses.
"""
from __future__ import annotations

import json
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASELINE = HERE / "baseline.py"
PY = sys.executable  # absolute interpreter path; relocatable; alias-safe
LOG = HERE / "pt_run_log.txt"
RESULTS = HERE / "pt_results.json"


# --- oracle check helpers (closures over the parsed baseline result) --------
def eq(field, value):
    return lambda r: r.get(field) == value


def member(field, values):
    return lambda r: r.get(field) in values


def bundle_present(*keys):
    return lambda r: all(r.get("bundle", {}).get(k) not in (None, "", [], {}) for k in keys)


def bundle_eq(key, value):
    return lambda r: r.get("bundle", {}).get(key) == value


def truth(field):
    return lambda r: bool(r.get(field)) is True


def verdict_is(v):
    return lambda r: r.get("family_verdict") == v


def terminal_is(s):
    return lambda r: r.get("terminal_state") == s


def has_foc(code):
    return lambda r: code in (r.get("outputs") or {})


def foc_field(code, key):
    return lambda r: (r.get("outputs") or {}).get(code, {}).get(key) not in (None, "", [], {})


def evid_field(key):
    return lambda r: (r.get("evidence_bundle") or {}).get(key) not in (None, "", [], {})


def result_field(field, value):
    return lambda r: r.get(field) == value


def req(op, **kw):
    d = {"op": op}
    d.update(kw)
    return d


# ===========================================================================
# Pinned canonical record table.  Each entry:
#   (pt_id, category, spec)
#   spec = ("SKIP", "<owning-pack cite>")  |  ("EX", [(request, check), ...])
# A record PASSes only if every probe exits 0, parses, carries no "error", and
# satisfies its check.
# ===========================================================================
S = lambda cite: ("SKIP", cite)


def EX(*probes):
    return ("EX", list(probes))


RECORDS: list[tuple[str, str, tuple]] = []


def add(pt_id, category, spec):
    RECORDS.append((pt_id, category, spec))


# ---- VRA component suite (PT-001..029) ------------------------------------
add("PT-001", "runnable", EX((req("vra.next_state", state="S0 STARTUP_READONLY", trigger="StartupComplete", validator_passed=True), eq("result", "S1 SNAPSHOT_LOCKED"))))
add("PT-002", "runnable", EX((req("vra.next_state", state="S2 STRUCTURAL_VERIFIED", trigger="StructuralChecksDone", validator_passed=True), eq("result", "S3 ELIGIBLE_HEAD_SELECTED"))))
add("PT-003", "runnable", EX((req("vra.next_state", state="S3 ELIGIBLE_HEAD_SELECTED", trigger="EligibilityChecksDone", validator_passed=True), eq("result", "S4 REHYDRATED_VALIDATED"))))
for _pt in ("PT-004", "PT-005", "PT-006", "PT-007"):
    add(_pt, "runnable", EX((req("vra.next_state", state="S2 STRUCTURAL_VERIFIED", trigger="StructuralChecksDone", validator_passed=False), eq("result", "S5 FAIL_SAFE"))))
for _pt in ("PT-008", "PT-009"):
    add(_pt, "runnable", EX((req("vra.next_state", state="S3 ELIGIBLE_HEAD_SELECTED", trigger="EligibilityChecksDone", validator_passed=False), eq("result", "S5 FAIL_SAFE"))))
add("PT-010", "runnable", EX((req("vra.next_state", state="S0 STARTUP_READONLY", trigger="StartupComplete", validator_passed=False), eq("result", "S5 FAIL_SAFE"))))
add("PT-011", "runnable", EX((req("vra.next_state", state="S3 ELIGIBLE_HEAD_SELECTED", trigger="RollbackDetected", validator_passed=True), eq("result", "S5 FAIL_SAFE"))))
add("PT-012", "runnable", EX((req("vra.next_state", state="S5 FAIL_SAFE", trigger="WalReplayNeeded", validator_passed=True), eq("result", "S7 RECOVERY_REPLAY"))))
add("PT-013", "runnable", EX((req("vra.next_state", state="S3 ELIGIBLE_HEAD_SELECTED", trigger="ToolStateInvalid", validator_passed=True), eq("result", "S6 TOOL_QUARANTINE"))))
add("PT-014", "runnable", EX(
    (req("vra.next_state", state="S3 ELIGIBLE_HEAD_SELECTED", trigger="ToolStateInvalid", validator_passed=True), eq("result", "S6 TOOL_QUARANTINE")),
    (req("vra.next_state", state="S3 ELIGIBLE_HEAD_SELECTED", trigger="EligibilityChecksDone", validator_passed=True), eq("result", "S4 REHYDRATED_VALIDATED"))))
add("PT-015", "runnable", EX((req("vra.next_state", state="S6 TOOL_QUARANTINE", trigger="StartupComplete", validator_passed=True), eq("result", "S6 TOOL_QUARANTINE"))))
add("PT-016", "runnable", EX((req("vra.evidence", kind="deny_chain"), bundle_present("validator_bundle_id", "verified_head_digest", "snapshot_id"))))
add("PT-017", "runnable", EX((req("vra.evidence", kind="deny_freshness"), bundle_present("validator_bundle_id", "verified_head_digest", "snapshot_id", "policy_id", "source_id", "freshness_value", "irr_digest", "tool_activation_status"))))
add("PT-018", "runnable", EX((req("vra.evidence", kind="deny_parse"), bundle_present("failure_code", "failed_validator", "suppression_status"))))
add("PT-019", "runnable", EX((req("vra.evidence", kind="recovery"), bundle_present("recovery_phase", "recovery_phase_producer"))))
add("PT-020", "runnable", EX((req("vra.evidence", kind="readmission"), bundle_present("readmission_token_id"))))
add("PT-021", "runnable", EX((req("vra.evidence", kind="deny_frame"), lambda r: r["bundle"].get("validator_bundle_id_producer") == "ExecutionLayer" and r["bundle"].get("failure_explanation_producer") == "GateLogic" and r["bundle"].get("tool_activation_status_producer") == "ToolGate")))
add("PT-022", "runnable", EX((req("vra.taxonomy"), truth("distinct"))))
add("PT-023", "runnable", EX((req("vra.taxonomy"), truth("pairwise_distinct"))))
add("PT-024", "parameterized", EX((req("vra.next_state", state="S8 READMISSION_PENDING", trigger="AuthorityRelease", validator_passed=True), member("result", {"S0 STARTUP_READONLY", "S1 SNAPSHOT_LOCKED"}))))
add("PT-025", "runnable", EX((req("vra.evidence", kind="deny_freshness"), lambda r: bool(r["bundle"].get("freshness_value")) and bool(r["bundle"].get("policy_id")) and r["bundle"].get("failed_validator") == "V_FRESHNESS")))
add("PT-026", "runnable", EX((req("vra.evidence", kind="recovery"), lambda r: bool(r["bundle"].get("recovery_phase")) and r["bundle"].get("recovery_phase_producer") == "V_WAL_PHASE")))
add("PT-027", "runnable", EX((req("vra.next_state", state="S3 ELIGIBLE_HEAD_SELECTED", trigger="ToolStateInvalid", validator_passed=True), eq("result", "S6 TOOL_QUARANTINE"))))
add("PT-028", "declarative", EX((req("vra.declarative", check="V_COMPAT"), truth("evidence_preserved"))))
add("PT-029", "declarative", EX((req("vra.declarative", check="V_WRITER_LOCK"), truth("single_writer_enforced"))))

# ---- BDA component suite (PTS-BDA-001..036) -------------------------------
add("PTS-BDA-001", "runnable", EX((req("bda.next_state", state="IDLE", trigger="INPUT_RECEIVED"), eq("result", "INGEST_VALIDATE"))))
add("PTS-BDA-002", "runnable", EX((req("bda.next_state", state="INGEST_VALIDATE", trigger="VALIDATION_PASS", guard_result=True), eq("result", "FILTER_REVIEW"))))
add("PTS-BDA-003", "runnable", EX((req("bda.next_state", state="FILTER_REVIEW", trigger="NO_ESCALATION", guard_result=True), eq("result", "READY_FOR_RELEASE"))))
add("PTS-BDA-004", "runnable", EX((req("bda.next_state", state="FINALIZATION_REVIEW", trigger="EVIDENCE_OK", guard_result=True), eq("result", "IDLE"))))
add("PTS-BDA-005", "runnable", EX((req("bda.next_state", state="INGEST_VALIDATE", trigger="VALIDATION_FAIL", guard_result=True), lambda r: r.get("result") == "OUTPUT_BLOCKED" and r.get("verdict") == "BLOCK")))
add("PTS-BDA-006", "runnable", EX((req("bda.next_state", state="FILTER_REVIEW", trigger="TOOL_STATE_DETECTED", guard_result=True), lambda r: r.get("result") == "TOOL_STATE_QUARANTINED" and r.get("verdict") == "QUARANTINE")))
add("PTS-BDA-007", "runnable", EX((req("bda.next_state", state="INGEST_VALIDATE", trigger="VALIDATION_FAIL", guard_result=True), lambda r: r.get("result") == "OUTPUT_BLOCKED" and r.get("verdict") == "BLOCK")))
add("PTS-BDA-008", "runnable", EX((req("bda.next_state", state="TOOL_STATE_QUARANTINED", trigger="APPROVAL_GRANTED", guard_result=False), eq("result", "TOOL_STATE_QUARANTINED"))))
add("PTS-BDA-009", "runnable", EX((req("bda.next_state", state="INGEST_VALIDATE", trigger="VALIDATION_FAIL", guard_result=True), lambda r: r.get("result") == "OUTPUT_BLOCKED" and r.get("verdict") == "BLOCK")))
add("PTS-BDA-010", "runnable", EX((req("bda.next_state", state="INGEST_VALIDATE", trigger="VALIDATION_FAIL", guard_result=True), lambda r: r.get("result") == "OUTPUT_BLOCKED" and r.get("verdict") == "BLOCK")))
add("PTS-BDA-011", "declarative", EX((req("bda.statement", tsa_label=None, source_class=None), lambda r: r.get("result") == "OUTPUT_BLOCKED" and r.get("verdict") == "BLOCK")))
add("PTS-BDA-012", "runnable", EX((req("bda.taxonomy"), truth("allow_ne_constrained"))))
add("PTS-BDA-013", "runnable", EX((req("bda.next_state", state="FILTER_REVIEW", trigger="CPW_CRITICAL"), lambda r: r.get("result") == "OUTPUT_BLOCKED" and r.get("verdict") == "FAIL_CLOSED")))
add("PTS-BDA-014", "runnable", EX(
    (req("bda.next_state", state="INGEST_VALIDATE", trigger="VALIDATION_FAIL", guard_result=True), eq("result", "OUTPUT_BLOCKED")),
    (req("bda.next_state", state="FINALIZATION_REVIEW", trigger="EVIDENCE_FAIL", guard_result=True), eq("result", "NONCOMPLIANT_HOLD"))))
add("PTS-BDA-015", "runnable", EX((req("bda.next_state", state="FILTER_REVIEW", trigger="CPW_CRITICAL"), eq("result", "OUTPUT_BLOCKED"))))
add("PTS-BDA-016", "runnable", EX((req("bda.next_state", state="FINALIZATION_REVIEW", trigger="CPW_CRITICAL"), eq("result", "OUTPUT_BLOCKED"))))
add("PTS-BDA-017", "runnable", EX((req("bda.next_state", state="TOOL_STATE_QUARANTINED", trigger="CPW_CRITICAL"), eq("result", "OUTPUT_BLOCKED"))))
add("PTS-BDA-018", "runnable", EX((req("bda.next_state", state="OUTPUT_BLOCKED", trigger="READMISSION_APPROVED", guard_result=True), lambda r: r.get("result") == "IDLE" and r.get("verdict") == "READMIT")))
add("PTS-BDA-019", "runnable", EX((req("bda.next_state", state="NONCOMPLIANT_HOLD", trigger="COMPLIANCE_RESTORED", guard_result=True), lambda r: r.get("result") == "IDLE" and r.get("verdict") == "READMIT")))
add("PTS-BDA-020", "runnable", EX((req("bda.next_state", state="OUTPUT_BLOCKED", trigger="READMISSION_APPROVED", guard_result=False), eq("result", "OUTPUT_BLOCKED"))))
add("PTS-BDA-021", "runnable", EX(
    (req("bda.next_state", state="OUTPUT_BLOCKED", trigger="READMISSION_APPROVED", guard_result=True), eq("result", "IDLE")),
    (req("bda.next_state", state="IDLE", trigger="INPUT_RECEIVED"), eq("result", "INGEST_VALIDATE"))))
add("PTS-BDA-022", "runnable", EX((req("bda.evidence"), bundle_present("decision_id", "verdict", "reason_code", "validator_results", "statement_refs", "input_digest"))))
add("PTS-BDA-023", "runnable", EX((req("bda.evidence"), bundle_present("decision_id", "session_id", "boundary_side", "decision_object", "input_digest", "policy_hash", "validator_results", "statement_refs", "verdict", "reason_code", "order_index", "hash_prev", "hash_curr"))))
add("PTS-BDA-024", "runnable", EX((req("bda.evidence", activated=["approval_ref"]), bundle_present("approval_ref"))))
add("PTS-BDA-025", "runnable", EX((req("bda.evidence", activated=["evidence_ref", "verif_counter_anchor"]), bundle_present("evidence_ref", "verif_counter_anchor"))))
add("PTS-BDA-026", "runnable", EX((req("bda.evidence", activated=["rollback_ref"]), bundle_present("rollback_ref"))))
add("PTS-BDA-027", "declarative", S("Boundary_Defense_Agent_Conformance_Tests.md §5 Minimal Run Note — 'Bounded external obligations not locally runnable': 'authorized non-validator producer grounding' (whole-assertion coverage)."))
add("PTS-BDA-028", "runnable", EX((req("bda.next_state", state="READY_FOR_RELEASE", trigger="CPW_CRITICAL", guard_result=True), eq("result", "OUTPUT_BLOCKED"))))
add("PTS-BDA-029", "declarative", S("Boundary_Defense_Agent_Conformance_Tests.md §5 Minimal Run Note — 'Bounded external obligations not locally runnable': 'distributed enforcement legitimacy where not exposed by local transition function'."))
add("PTS-BDA-030", "runnable", EX((req("bda.taxonomy"), lambda r: r.get("count") == 7 and r.get("pairwise_distinct") is True)))
add("PTS-BDA-031", "runnable", EX((req("bda.taxonomy"), lambda r: r.get("block_ne_quarantine") is True and r.get("failclosed_ne_hold") is True)))
add("PTS-BDA-032", "parameterized", EX(
    (req("bda.next_state", state="INGEST_VALIDATE", trigger="VALIDATION_FAIL", guard_result=True), eq("verdict", "BLOCK")),
    (req("bda.next_state", state="FILTER_REVIEW", trigger="TOOL_STATE_DETECTED", guard_result=True), eq("verdict", "QUARANTINE"))))
add("PTS-BDA-033", "runnable", EX((req("bda.next_state", state="FILTER_REVIEW", trigger="CPW_CRITICAL"), lambda r: r.get("result") == "OUTPUT_BLOCKED" and r.get("verdict") == "FAIL_CLOSED")))
add("PTS-BDA-034", "runnable", EX(
    (req("bda.next_state", state="TOOL_STATE_QUARANTINED", trigger="APPROVAL_GRANTED", guard_result=True), eq("result", "READY_FOR_RELEASE")),
    (req("bda.evidence", activated=["approval_ref"]), bundle_present("approval_ref"))))
add("PTS-BDA-035", "runnable", EX(
    (req("bda.next_state", state="FINALIZATION_REVIEW", trigger="EVIDENCE_OK", guard_result=True), eq("result", "IDLE")),
    (req("bda.next_state", state="FINALIZATION_REVIEW", trigger="EVIDENCE_FAIL", guard_result=True), eq("result", "NONCOMPLIANT_HOLD"))))
add("PTS-BDA-036", "declarative", EX((req("bda.taxonomy"), truth("allow_ne_constrained"))))

# ---- TAA component suite (TAA-PT-* + VP-GEN-*, dual-ID) --------------------
def _taa_probe(nnn):
    reclass = {"validator_passed": True}
    table = {
        "001": EX((req("taa.next_state", state="INTAKE", trigger="INTAKE_TO_ROLE_SCREENING", validator_passed=True), eq("result", "ROLE_SCREENING"))),
        "002": EX((req("taa.next_state", state="EVALUATING", trigger="EVALUATING_TO_CLASSIFYING", validator_passed=True), eq("result", "CLASSIFYING"))),
        "003": EX((req("taa.next_state", state="DECIDED", trigger="DECIDED_TO_HANDOFF_READY", validator_passed=True), eq("result", "HANDOFF_READY"))),
        "004": EX((req("taa.next_state", state="EVALUATING", trigger="EVALUATING_TO_CLASSIFYING", validator_passed=False), eq("result", "FAIL_CLOSED"))),
        "005": EX(
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION", validator_passed=True), lambda r: r.get("result") == "DECIDED" and r.get("verdict") == "ALLOW_CONSTRAINED"),
            (req("taa.evidence", kind="allow_constrained"), bundle_eq("verdict", "ALLOW_CONSTRAINED"))),
        "006": EX(
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_ESCALATE_DECISION", validator_passed=True), lambda r: r.get("result") == "DECIDED" and r.get("verdict") == "ESCALATE"),
            (req("taa.evidence", kind="fail_closed_escalation"), bundle_present("request_id", "failure_ref", "required_actor_role", "required_evidence", "status"))),
        "007": EX((req("taa.next_state", state="ROLE_SCREENING", trigger="ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING", validator_passed=True), eq("result", "CANONICALIZING"))),
        "008": EX(
            (req("taa.next_state", state="CLASSIFYING", trigger="CLASSIFYING_TO_DENY_DECISION", validator_passed=True), eq("result", "DECIDED")),
            (req("taa.next_state", state="EVALUATING", trigger="EVALUATING_TO_FAIL_CLOSED", validator_passed=True), eq("result", "FAIL_CLOSED"))),
        "009": EX((req("taa.next_state", state="INTAKE", trigger="STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED", validator_passed=True), eq("result", "FAIL_CLOSED"))),
        "010": EX((req("taa.next_state", state="CLASSIFYING", trigger="POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED", validator_passed=True), eq("result", "FAIL_CLOSED"))),
        "011": EX((req("taa.next_state", state="EVALUATING", trigger="CONFLICT_CHECKING_TO_ALLOW_DECISION", validator_passed=True), eq("result", "FAIL_CLOSED"))),
        "012": EX(
            (req("taa.next_state", state="FAIL_CLOSED", trigger="FAIL_CLOSED_TO_NONCOMPLIANT_HOLD", validator_passed=True), eq("result", "NONCOMPLIANT_HOLD")),
            (req("taa.next_state", state="NONCOMPLIANT_HOLD", trigger="NONCOMPLIANT_HOLD_TO_READMISSION_PENDING", validator_passed=True), eq("result", "READMISSION_PENDING"))),
        "013": EX((req("taa.next_state", state="READMISSION_PENDING", trigger="READMISSION_PENDING_TO_ROLE_SCREENING", validator_passed=True), eq("result", "ROLE_SCREENING"))),
        "014": EX((req("taa.next_state", state="CLOSED", trigger="DECIDED_TO_HANDOFF_READY", validator_passed=True), eq("result", "CLOSED"))),
        "015": EX((req("taa.evidence", kind="allow"), lambda r: all(r["bundle"].get(k) == "closed" for k in ("semantic_closure", "evidence_closure", "failure_closure", "policy_snapshot_closure")))),
        "016": EX((req("taa.evidence", kind="allow"), bundle_present("decision_id", "statement_id_list", "verdict", "reason_code", "tsa_label", "source_class", "source_ref", "boundary_validated_role", "role_validation_result", "policy_snapshot_id", "policy_hash_ref", "scope_id", "turn_id", "order_ref", "logical_timestamp"))),
        "017": EX((req("taa.evidence", kind="allow_constrained"), bundle_present("conflict_check_mode", "conflict_check_strength", "conflict_check_confidence", "conflict_check_coverage_scope", "compared_claim_set_ref", "residual_risk_statement"))),
        "018": EX((req("taa.evidence", kind="fail_closed_escalation"), bundle_present("request_id", "failure_ref", "required_actor_role", "required_evidence", "status"))),
        "019": EX((req("taa.next_state", state="DECIDED", trigger="CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED", validator_passed=True), eq("result", "FAIL_CLOSED"))),
        "021": EX((req("taa.verdict_set"), lambda r: r.get("count") == 6)),
        "022": EX(
            (req("taa.next_state", state="ROLE_SCREENING", trigger="ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING", validator_passed=True), eq("result", "CANONICALIZING")),
            (req("taa.next_state", state="ROLE_SCREENING", trigger="ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION", validator_passed=True), lambda r: r.get("result") == "DECIDED" and r.get("verdict") == "OUT_OF_SCOPE")),
        "023": EX(
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_DENY_DECISION", validator_passed=True), lambda r: r.get("result") == "DECIDED" and r.get("verdict") == "DENY"),
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_FAIL_CLOSED", validator_passed=True), eq("result", "FAIL_CLOSED"))),
        "024": EX((req("taa.next_state", state="EVALUATING", trigger="EVALUATING_TO_FAIL_CLOSED", validator_passed=True), eq("result", "FAIL_CLOSED"))),
        "025": EX((req("taa.evidence", kind="allow_constrained"), lambda r: r["bundle"].get("verdict") == "ALLOW_CONSTRAINED" and bool(r["bundle"].get("residual_risk_statement")))),
        "026": EX(
            (req("taa.next_state", state="INTAKE", trigger="INTAKE_TO_ROLE_SCREENING", validator_passed=True), eq("result", "ROLE_SCREENING")),
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_DENY_DECISION", validator_passed=True), eq("result", "DECIDED"))),
        "027": EX(
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_ALLOW_DECISION", validator_passed=True), eq("result", "DECIDED")),
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION", validator_passed=True), eq("result", "DECIDED")),
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_DENY_DECISION", validator_passed=True), eq("result", "DECIDED")),
            (req("taa.next_state", state="CONFLICT_CHECKING", trigger="CONFLICT_CHECKING_TO_ESCALATE_DECISION", validator_passed=True), eq("result", "DECIDED"))),
    }
    return table[nnn]


_TAA_CAT = {"023": "parameterized"}
for _n in [f"{i:03d}" for i in range(1, 28)]:
    if _n == "020":
        cite = ("Truth_Arbitration_Agent_Conformance_Tests.md §1 Declarative public conformance record — 'Record kind: Declarative conformance claim (not a buyer-runnable unit test)'; §4 Minimal run note bounded-external list.")
        add("TAA-PT-020", "declarative", S(cite))
        add("VP-GEN-020", "declarative", S(cite))
        continue
    _cat = _TAA_CAT.get(_n, "runnable")
    add(f"TAA-PT-{_n}", _cat, _taa_probe(_n))
    add(f"VP-GEN-{_n}", _cat, _taa_probe(_n))

# ---- ARA component suite (ARA-T001..027) ----------------------------------
add("ARA-T001", "runnable", EX((req("ara.next_state", state="S0 INGESTED", event="EV_PARSE_OK", validator_passed=True), eq("result", "S1 PARSED"))))
add("ARA-T002", "runnable", EX((req("ara.next_state", state="S2 VERIFIED", event="replay_fold_complete", validator_passed=True), eq("result", "S3 RECONSTRUCTED"))))
add("ARA-T003", "runnable", EX((req("ara.next_state", state="S4 CHECKPOINT_RESOLVED", event="EV_REPORT_BOUND", validator_passed=True), eq("result", "S5 REPORT_READY"))))
add("ARA-T004", "runnable", EX(
    (req("ara.next_state", state="S0 INGESTED", event="EV_SIGNATURE_FAIL", validator_passed=True), eq("result", "SX FAIL_CLOSED")),
    (req("ara.next_state", state="S0 INGESTED", event="EV_CHAIN_BREAK", validator_passed=True), lambda r: r.get("result") == "SX FAIL_CLOSED" and r.get("verdict") == "BROKEN")))
add("ARA-T005", "runnable", EX((req("ara.next_state", state="S4 CHECKPOINT_RESOLVED", event="EV_REPORT_BOUND", validator_passed=False), eq("result", "S4 CHECKPOINT_RESOLVED"))))
add("ARA-T006", "runnable", EX((req("ara.next_state", state="S2 VERIFIED", event="EV_EVIDENCE_FAIL", validator_passed=True), eq("result", "SH HOLD_ACTIVE"))))
add("ARA-T007", "runnable", EX((req("ara.next_state", state="S3 RECONSTRUCTED", event="EV_LASTCLEAN_FOUND", validator_passed=False), eq("result", "S3 RECONSTRUCTED"))))
add("ARA-T008", "runnable", EX(
    (req("ara.next_state", state="S2 VERIFIED", event="EV_SIGNATURE_FAIL", validator_passed=True), eq("result", "SX FAIL_CLOSED")),
    (req("ara.next_state", state="S2 VERIFIED", event="EV_CHAIN_BREAK", validator_passed=True), lambda r: r.get("result") == "SX FAIL_CLOSED" and r.get("verdict") == "BROKEN"),
    (req("ara.next_state", state="S2 VERIFIED", event="EV_COUNTER_REPLAY", validator_passed=True), eq("result", "SH HOLD_ACTIVE"))))
add("ARA-T009", "runnable", EX((req("ara.next_state", state="S2 VERIFIED", event="EV_SIGNATURE_FAIL", validator_passed=True), eq("result", "SX FAIL_CLOSED"))))
add("ARA-T010", "runnable", EX((req("ara.next_state", state="S4 CHECKPOINT_RESOLVED", event="EV_CHAIN_BREAK", validator_passed=False), lambda r: r.get("result") == "SX FAIL_CLOSED" and r.get("verdict") == "BROKEN")))
add("ARA-T011", "runnable", EX(
    (req("ara.next_state", state="S2 VERIFIED", event="EV_SIGNATURE_FAIL", validator_passed=True), eq("result", "SX FAIL_CLOSED")),
    (req("ara.next_state", state="S2 VERIFIED", event="EV_EVIDENCE_FAIL", validator_passed=True), eq("result", "SH HOLD_ACTIVE"))))
add("ARA-T012", "runnable", EX((req("ara.next_state", state="SH HOLD_ACTIVE", event="EV_READMISSION_GRANTED", validator_passed=True), eq("result", "S6 READMITTED"))))
add("ARA-T013", "runnable", EX((req("ara.next_state", state="SH HOLD_ACTIVE", event="EV_READMISSION_GRANTED", validator_passed=False), eq("result", "SH HOLD_ACTIVE"))))
add("ARA-T014", "runnable", EX((req("ara.next_state", state="S5 REPORT_READY", event="EV_REPORT_BOUND", validator_passed=True), eq("result", "S5 REPORT_READY"))))
add("ARA-T015", "runnable", EX((req("ara.evidence", kind="finalizable"), bundle_present("report_signature", "export_manifest_ref"))))
add("ARA-T016", "runnable", EX((req("ara.evidence", kind="finalizable"), bundle_present("bundle_digest", "policy_profile_id", "validator_outcomes", "hash_continuity_refs", "checkpoint_refs", "rollback_refs", "report_fields_ref"))))
add("ARA-T017", "runnable", EX((req("ara.evidence", kind="readmission"), bundle_present("hold_enter_refs", "hold_exit_refs", "anchor_update_ref"))))
add("ARA-T018", "runnable", EX((req("ara.evidence", kind="finalizable"), bundle_present("validator_outcomes", "signature_refs", "report_fields_ref"))))
add("ARA-T019", "declarative", EX((req("ara.gate", authorized=False), lambda r: r.get("gate_status") == "QUARANTINE" and r.get("admitted") is False)))
add("ARA-T020", "declarative", EX((req("ara.gate", authorized=False), eq("gate_status", "QUARANTINE"))))
add("ARA-T021", "runnable", EX((req("ara.taxonomy"), lambda r: r.get("count") == 5 and r.get("pairwise_distinct") is True)))
add("ARA-T022", "runnable", EX((req("ara.taxonomy"), lambda r: r.get("broken_ne_rejected") is True and r.get("sx_ne_sh") is True and r.get("incident_ne_failclosed") is True)))
add("ARA-T023", "parameterized", EX((req("ara.policy_branch", resolvable=False), lambda r: r.get("state") == "SX FAIL_CLOSED" and r.get("verdict") == "BLOCKED")))
add("ARA-T024", "runnable", EX((req("ara.next_state", state="S3 RECONSTRUCTED", event="EV_LASTCLEAN_FOUND", validator_passed=True), eq("result", "S4 CHECKPOINT_RESOLVED"))))
add("ARA-T025", "runnable", EX((req("ara.evidence", kind="readmission"), bundle_present("hold_exit_refs", "anchor_update_ref"))))
add("ARA-T026", "runnable", EX((req("ara.next_state", state="S4 CHECKPOINT_RESOLVED", event="EV_REPORT_BOUND", validator_passed=True), eq("result", "S5 REPORT_READY"))))
add("ARA-T027", "declarative", EX(
    (req("ara.gate", authorized=False), eq("gate_status", "QUARANTINE")),
    (req("ara.policy_branch", resolvable=False), eq("verdict", "BLOCKED"))))

# ---- FPA component suite (FPA-T-*/FPA-D-*) --------------------------------
for _d, _basis in [("FPA-D-01", "VP-GEN-004 action token REJECT_INVALID"), ("FPA-D-02", "VP-GEN-013 non-inheritance to tool-state"),
                   ("FPA-D-03", "VP-GEN-019/027 VAL-011 gate-logic enforcement"), ("FPA-D-04", "VP-GEN-020 distributed enforcement legitimacy"),
                   ("FPA-D-05", "FPA-PR-14 watermark monotonic security finding"), ("FPA-D-06", "IRR append-only two-step effectivity")]:
    add(_d, "declarative", S(f"Freshness_Portability_Agent_Conformance_Tests.md §F.D Declarative obligations ({_basis}) + §H Minimal Run Note: 'Every declarative obligation in §F.D is documented in the buyer's conformance record as a non-runnable but required obligation.'"))
add("FPA-T-01", "runnable", EX((req("fpa.next_state", state="IDLE", trigger="TransferPacketReceived", validator_passed=True), eq("result", "RECEIVED"))))
add("FPA-T-02", "runnable", EX((req("fpa.next_state", state="RECEIVED", trigger="StructureValid", validator_passed=True), eq("result", "VERIFIED"))))
add("FPA-T-03", "runnable", EX((req("fpa.next_state", state="RESTORATION_ELIGIBLE", trigger="RestoreAdmitted", validator_passed=True), eq("result", "IDLE"))))
add("FPA-T-04", "runnable", EX(
    (req("fpa.next_state", state="RECEIVED", trigger="StructureValid", validator_passed=False), eq("result", "REJECTED")),
    (req("fpa.next_state", state="RECEIVED", trigger="StructureInvalid", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-06", "runnable", EX((req("fpa.next_state", state="VERIFIED", trigger="EvidencePending", validator_passed=False), eq("result", "QUARANTINED"))))
add("FPA-T-08a", "runnable", EX((req("fpa.next_state", state="VERIFIED", trigger="FreshnessFail", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-08b", "runnable", EX((req("fpa.next_state", state="WATERMARK_COMMITTED", trigger="RestoreRequest_GenesisConfirmed", validator_passed=False), eq("result", "REJECTED"))))
add("FPA-T-08c", "runnable", EX((req("fpa.taxonomy"), truth("reject_ne_failclosed"))))
add("FPA-T-09", "runnable", EX((req("fpa.next_state", state="VERIFIED", trigger="FreshnessPass", validator_passed=False), eq("result", "REJECTED"))))
add("FPA-T-10", "runnable", EX((req("fpa.next_state", state="WATERMARK_COMMITTED", trigger="RestoreRequest_GenesisConfirmed", validator_passed=False), eq("result", "REJECTED"))))
add("FPA-T-11", "runnable", EX((req("fpa.next_state", state="IRR_COMMITTED", trigger="FreshnessPass", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-12", "runnable", EX((req("fpa.next_state", state="QUARANTINED", trigger="ReadmissionApproved", validator_passed=True), eq("result", "VERIFIED"))))
add("FPA-T-13a", "runnable", EX((req("fpa.next_state", state="WATERMARK_COMMITTED", trigger="RestoreRequest_GenesisConfirmed", validator_passed=True), eq("result", "RESTORATION_ELIGIBLE"))))
add("FPA-T-13b", "runnable", EX((req("fpa.next_state", state="RESTORATION_ELIGIBLE", trigger="RestoreAdmitted", validator_passed=True), eq("result", "IDLE"))))
add("FPA-T-14", "runnable", EX((req("fpa.next_state", state="REJECTED", trigger="FreshnessPass", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-15", "runnable", EX((req("fpa.evidence", kind="deny_restore"), lambda r: r["bundle"].get("reason_code") == "DENY_RESTORE" and r["bundle"].get("semantic_verdict") == "FAIL_CLOSED" and r["bundle"].get("gate_class") == "BLOCK")))
add("FPA-T-16", "runnable", EX((req("fpa.evidence", kind="accept"), lambda r: all(r["bundle"].get(k) for k in ("decision_id", "agent_id", "source_id", "ledger_uuid", "decision_object", "policy_id", "policy_version", "reason_code", "semantic_verdict", "gate_class", "packet_hash", "freshness_value", "watermark_before", "watermark_after", "ssm_validation_result")) and r["bundle"].get("semantic_verdict") == "ACCEPT" and r["bundle"].get("gate_class") == "RELEASE")))
add("FPA-T-17A", "parameterized", EX((req("fpa.evidence", kind="accept", activated=["tvc_validation_result"]), bundle_present("tvc_validation_result"))))
add("FPA-T-17B", "parameterized", EX((req("fpa.evidence", kind="accept", activated=["evidence_validation_result"]), bundle_present("evidence_validation_result"))))
add("FPA-T-17C", "parameterized", EX((req("fpa.evidence", kind="accept", activated=["transport_validation_result"]), bundle_present("transport_validation_result"))))
add("FPA-T-17D", "runnable", EX((req("fpa.evidence", kind="accept"), bundle_present("irr_digest", "prev_receipt_digest"))))
add("FPA-T-18", "runnable", EX((req("fpa.evidence", kind="accept"), bundle_present("decision_id", "agent_id", "source_id", "ledger_uuid", "decision_object", "reason_code", "gate_class", "watermark_before", "watermark_after"))))
add("FPA-T-21", "runnable", EX((req("fpa.taxonomy"), lambda r: r.get("restoration_eligible_verdict") == "RESTORATION_ELIGIBLE" and r.get("restoration_eligible_state") == "RESTORATION_ELIGIBLE")))
add("FPA-T-23", "parameterized", EX(
    (req("fpa.next_state", state="VERIFIED", trigger="EvidencePending", validator_passed=False), eq("result", "QUARANTINED")),
    (req("fpa.next_state", state="VERIFIED", trigger="FreshnessPass", validator_passed=False), eq("result", "REJECTED"))))
add("FPA-T-24", "runnable", EX((req("fpa.next_state", state="VERIFIED", trigger="FreshnessPass", validator_passed=True), eq("result", "FRESHNESS_ELIGIBLE"))))
add("FPA-T-25", "parameterized", EX((req("fpa.evidence", kind="quarantine"), lambda r: r["bundle"].get("semantic_verdict") == "QUARANTINE" and r["bundle"].get("gate_class") == "ESCALATION" and bool(r["bundle"].get("evidence_validation_result")))))
add("FPA-T-26", "runnable", EX((req("fpa.next_state", state="FRESHNESS_ELIGIBLE", trigger="IRRAppended", validator_passed=True), eq("result", "IRR_COMMITTED"))))
add("FPA-T-PR-01", "runnable", EX((req("fpa.next_state", state="VERIFIED", trigger="FreshnessFail", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-PR-02", "runnable", EX(
    (req("fpa.next_state", state="FRESHNESS_ELIGIBLE", trigger="IRRAppended", validator_passed=True), eq("result", "IRR_COMMITTED")),
    (req("fpa.next_state", state="IRR_COMMITTED", trigger="WatermarkPersisted", validator_passed=True), eq("result", "WATERMARK_COMMITTED")),
    (req("fpa.next_state", state="FRESHNESS_ELIGIBLE", trigger="WatermarkPersisted", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-PR-03", "runnable", EX((req("fpa.next_state", state="WATERMARK_COMMITTED", trigger="RestoreRequest_GenesisConfirmed", validator_passed=True), eq("result", "RESTORATION_ELIGIBLE"))))
add("FPA-T-PR-09", "runnable", EX(
    (req("fpa.next_state", state="WATERMARK_COMMITTED", trigger="RestoreRequest_GenesisConfirmed", validator_passed=True), eq("result", "RESTORATION_ELIGIBLE")),
    (req("fpa.next_state", state="WATERMARK_COMMITTED", trigger="RestoreRequest_GenesisConfirmed", validator_passed=False), eq("result", "REJECTED"))))
add("FPA-T-PR-10", "runnable", EX((req("fpa.next_state", state="IDLE", trigger="RestoreAdmitted", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-PR-12", "runnable", EX(
    (req("fpa.next_state", state="QUARANTINED", trigger="ReadmissionApproved", validator_passed=True), eq("result", "VERIFIED")),
    (req("fpa.next_state", state="IDLE", trigger="ReadmissionApproved", validator_passed=True), eq("result", "REJECTED"))))
add("FPA-T-PR-13", "runnable", EX(
    (req("fpa.next_state", state="VERIFIED", trigger="FreshnessPass", validator_passed=True), eq("result", "FRESHNESS_ELIGIBLE")),
    (req("fpa.next_state", state="FRESHNESS_ELIGIBLE", trigger="IRRAppended", validator_passed=True), eq("result", "IRR_COMMITTED"))))
add("FPA-T-PR-14", "runnable", EX((req("fpa.next_state", state="IRR_COMMITTED", trigger="WatermarkPersisted", validator_passed=False), eq("result", "REJECTED"))))

# ---- SSCAR integrator Public Test Suite (PTS-*) ---------------------------
add("PTS-001", "runnable", EX((req("family.next_state", state="S0 FAMILY_INTAKE", trigger="Fv01Pass", validator_passed=True), eq("result", "S1 SOURCE_COVERAGE_ADMITTED"))))
add("PTS-002", "runnable", EX((req("family.next_state", state="S2 BOUNDARY_SCREENED", trigger="Fv03Pass", validator_passed=True), eq("result", "S3 PROVENANCE_CLASSIFIED"))))
add("PTS-003", "runnable", EX((req("family.compose", scenario={}), lambda r: r.get("family_verdict") == "REPLAY_ADMISSIBLE" and r.get("terminal_state") == "S8 REPLAY_ADMITTED" and "FOC-01" in (r.get("outputs") or {}))))
add("PTS-004a", "runnable", EX((req("family.next_state", state="S1 SOURCE_COVERAGE_ADMITTED", trigger="Fv02AndFv04Pass", validator_passed=False), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-004b", "runnable", EX((req("family.next_state", state="S2 BOUNDARY_SCREENED", trigger="UnlabeledMechanismLevelCarriedClaim", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-005", "declarative", S("SSCAR_Conformance_Tests.md §5 note — closed enumeration: declarative record listed in §7 Public Oracles (ORC-VERDICT-SET verdict-layer subset), not the §5 buyer-runnable table."))
add("PTS-006", "runnable", EX(
    (req("family.next_state", state="S3 PROVENANCE_CLASSIFIED", trigger="FreshnessReplay", validator_passed=True), eq("result", "SH NONCOMPLIANT_HOLD")),
    (req("family.verdict", outcomes=[{"id": "FV-06", "status": "fail"}]), eq("verdict", "NONCOMPLIANT_HOLD")),
    (req("family.compose", scenario={"freshness_strictly_increasing": False}), has_foc("FOC-05"))))
add("PTS-007", "parameterized", EX((req("family.reclassify", explicit_reclassification=True), lambda r: r.get("blocks_at") == "S2 BOUNDARY_SCREENED" and r.get("verdict_change") is False and r.get("policy_executed") is True)))
add("PTS-008", "runnable", EX(
    (req("family.next_state", state="S3 PROVENANCE_CLASSIFIED", trigger="FreshnessReplay", validator_passed=True), eq("result", "SH NONCOMPLIANT_HOLD")),
    (req("family.next_state", state="S4 ANCHOR_LOCKED", trigger="CriticalContamination", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-009", "runnable", EX(
    (req("family.next_state", state="S3 PROVENANCE_CLASSIFIED", trigger="CriticalContamination", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED")),
    (req("family.next_state", state="S5 REHYDRATION_CLOSED", trigger="CriticalContamination", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED")),
    (req("family.next_state", state="S0 FAMILY_INTAKE", trigger="CriticalContamination", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-010", "runnable", EX((req("family.next_state", state="S5 REHYDRATION_CLOSED", trigger="AntiRollbackFailure", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-011", "runnable", EX(
    (req("family.next_state", state="S3 PROVENANCE_CLASSIFIED", trigger="ChainBreak", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED")),
    (req("family.next_state", state="S3 PROVENANCE_CLASSIFIED", trigger="UntrustedAnchorPromoted", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-012", "runnable", EX((req("family.next_state", state="SH NONCOMPLIANT_HOLD", trigger="HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate", validator_passed=True), eq("result", "SR READMISSION_REVIEW"))))
add("PTS-013", "runnable", EX((req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedCarriedPayload", validator_passed=True), eq("result", "S2 BOUNDARY_SCREENED"))))
add("PTS-014", "runnable", EX(
    (req("family.next_state", state="S8 REPLAY_ADMITTED", trigger="Handoff", validator_passed=True), eq("result", "S8 REPLAY_ADMITTED")),
    (req("family.next_state", state="SX CONTAMINATION_FAIL_CLOSED", trigger="IncidentOnlyOutput", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-015", "declarative", S("SSCAR_Conformance_Tests.md §5 note — closed enumeration: §7-relocated declarative record (verdict-layer subset), not on the §5 buyer-runnable table."))
add("PTS-016", "runnable", EX((req("family.compose", scenario={}), lambda r: all((r.get("evidence_bundle") or {}).get(f) not in (None, "", [], {}) for f in ("family_decision_id", "boundary_event_id", "session_id_prior_session_ref", "carried_statement_refs", "tsa_refs_provenance_refs", "anchor_document_digest_anchor_document_ref", "accepted_head_digest_linked_irr_digest", "freshness_before_after_anchor_update_ref", "rehydration_closure_ref", "replay_refs_checkpoint_refs_rollback_refs", "disclosure_class_entries", "family_validator_outcomes", "hold_enter_refs_hold_exit_refs", "contamination_flags_contaminating_ref_set", "report_signature_export_manifest_ref")))))
add("PTS-017a", "runnable", EX((req("family.compose", scenario={"carried_labeled": False}), lambda r: "FOC-04" in (r.get("outputs") or {}) and (r["outputs"]["FOC-04"].get("contaminating_ref_set") and r["outputs"]["FOC-04"].get("blocked_stage")) and (r.get("evidence_bundle") or {}).get("tsa_refs_provenance_refs"))))
add("PTS-017b", "runnable", EX((req("family.compose", scenario={"freshness_strictly_increasing": False}), lambda r: "FOC-05" in (r.get("outputs") or {}) and r["outputs"]["FOC-05"].get("hold_enter_refs") and (r.get("evidence_bundle") or {}).get("freshness_before_after_anchor_update_ref"))))
add("PTS-017d", "runnable", EX(
    (req("family.next_state", state="SH NONCOMPLIANT_HOLD", trigger="HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate", validator_passed=True), eq("result", "SR READMISSION_REVIEW")),
    (req("family.compose", scenario={}), lambda r: (r.get("evidence_bundle") or {}).get("hold_enter_refs_hold_exit_refs") and (r.get("evidence_bundle") or {}).get("freshness_before_after_anchor_update_ref"))))
add("PTS-018", "runnable", EX(
    (req("family.compose", scenario={"carried_labeled": False}), has_foc("FOC-04")),
    (req("family.compose", scenario={"freshness_strictly_increasing": False}), has_foc("FOC-05"))))
add("PTS-019", "declarative", S("SSCAR_Conformance_Tests.md §5 note — closed enumeration: §7-relocated declarative (ORC-FOC-PRODUCERS), not on the §5 buyer-runnable table."))
add("PTS-020", "declarative", S("SSCAR_Conformance_Tests.md §5 note — closed enumeration: §7-relocated declarative (ORC-DISTRIBUTED-LEGITIMACY), not on the §5 buyer-runnable table."))
add("PTS-021", "runnable", EX((req("family.types"), lambda r: r.get("disjoint_identity") is True and r.get("verdicts_without_state") == ["REPLAY_INCOMPLETE", "INCIDENT_ONLY"])))
add("PTS-022", "runnable", EX(
    (req("family.next_state", state="S3 PROVENANCE_CLASSIFIED", trigger="FreshnessReplay", validator_passed=True), eq("result", "SH NONCOMPLIANT_HOLD")),
    (req("family.verdict", outcomes=[{"id": "FV-06", "status": "fail"}]), eq("verdict", "NONCOMPLIANT_HOLD")),
    (req("family.next_state", state="S4 ANCHOR_LOCKED", trigger="CriticalContamination", validator_passed=True), eq("result", "SX CONTAMINATION_FAIL_CLOSED")),
    (req("family.verdict", outcomes=[{"id": "FV-09", "status": "fail"}]), eq("verdict", "CONTAMINATION_FAIL_CLOSED"))))
add("PTS-023", "parameterized", EX(
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedCarriedPayload", validator_passed=True), eq("result", "S2 BOUNDARY_SCREENED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedAnchorDocumentRef", validator_passed=True), eq("result", "S2 BOUNDARY_SCREENED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedSourceControlBundles", validator_passed=True), eq("result", "S2 BOUNDARY_SCREENED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedPolicySnapshotId", validator_passed=True), eq("result", "S5 REHYDRATION_CLOSED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedRehydrationClosureRef", validator_passed=True), eq("result", "S5 REHYDRATION_CLOSED"))))
add("PTS-024", "runnable", EX((req("family.next_state", state="S4 ANCHOR_LOCKED", trigger="Fv07Pass", validator_passed=True), eq("result", "S5 REHYDRATION_CLOSED"))))
add("PTS-025", "runnable", EX((req("family.compose", scenario={"anti_rollback_ok": False, "rehydration_integrity_ok": False}), lambda r: r.get("family_verdict") == "CONTAMINATION_FAIL_CLOSED" and "FOC-04" in (r.get("outputs") or {}) and (r.get("evidence_bundle") or {}).get("rehydration_closure_ref") and (r.get("evidence_bundle") or {}).get("family_validator_outcomes"))))
add("PTS-026", "runnable", EX((req("family.next_state", state="S1 SOURCE_COVERAGE_ADMITTED", trigger="Fv02AndFv04Pass", validator_passed=False), eq("result", "SX CONTAMINATION_FAIL_CLOSED"))))
add("PTS-027", "declarative", S("SSCAR_Conformance_Tests.md §5 note — closed enumeration: §7-relocated declarative (canonical verdict taxonomy, ORC-VERDICT-SET), not on the §5 buyer-runnable table."))

# ---- Annex C Family Connector Test Suite (CT-01..CT-14) -------------------
add("CT-01", "connector", EX(
    (req("family.next_state", state="S0 FAMILY_INTAKE", trigger="Fv01Pass", validator_passed=True), eq("result", "S1 SOURCE_COVERAGE_ADMITTED")),
    (req("family.compose", scenario={}), lambda r: any(o["id"] == "FV-01" and o["status"] == "pass" for o in r.get("family_validator_outcomes", [])))))
add("CT-02", "connector", EX((req("family.compose", scenario={"carried_labeled": False}), lambda r: r.get("family_verdict") == "CONTAMINATION_FAIL_CLOSED" and "FOC-04" in (r.get("outputs") or {}) and "FOC-03" not in (r.get("outputs") or {}) and r["outputs"]["FOC-04"].get("blocked_stage"))))
add("CT-03", "connector", EX((req("family.compose", scenario={"boundary_contract_ok": False}), lambda r: r.get("family_verdict") == "CONTAMINATION_FAIL_CLOSED" and r.get("terminal_state") == "SX CONTAMINATION_FAIL_CLOSED")))
add("CT-04", "connector", EX((req("family.compose", scenario={"freshness_strictly_increasing": False}), lambda r: r.get("family_verdict") == "NONCOMPLIANT_HOLD" and "FOC-05" in (r.get("outputs") or {}) and r["outputs"]["FOC-05"].get("hold_enter_refs"))))
add("CT-05", "connector", EX(
    (req("family.compose", scenario={"accepted_head_linked": False}), verdict_is("REPLAY_INCOMPLETE")),
    (req("family.compose", scenario={}), lambda r: any(o["id"] == "FV-05" and o["status"] == "pass" for o in r.get("family_validator_outcomes", [])))))
add("CT-06", "connector", EX(
    (req("family.compose", scenario={}), lambda r: (r.get("outputs") or {}).get("FOC-03", {}).get("rehydration_closure_ref") and any(o["id"] == "FV-07" and o["status"] == "pass" for o in r.get("family_validator_outcomes", []))),
    (req("family.compose", scenario={"rehydration_integrity_ok": False, "anti_rollback_ok": False}), verdict_is("CONTAMINATION_FAIL_CLOSED"))))
add("CT-07", "connector", EX(
    (req("family.compose", scenario={"replay_lineage_complete": False}), verdict_is("REPLAY_INCOMPLETE")),
    (req("family.compose", scenario={}), verdict_is("REPLAY_ADMISSIBLE"))))
add("CT-08", "connector", EX((req("family.compose", scenario={}), lambda r: r.get("family_verdict") == "REPLAY_ADMISSIBLE" and len([o for o in r.get("family_validator_outcomes", []) if o["status"] == "pass"]) == 12 and (r.get("evidence_bundle") or {}).get("report_signature_export_manifest_ref") and "FOC-03" in (r.get("outputs") or {}))))
add("CT-09", "connector", EX((req("family.compose", scenario={"tool_state_present": True}), lambda r: r.get("family_verdict") == "CONTAMINATION_FAIL_CLOSED" and r["outputs"].get("FOC-04", {}).get("contaminating_ref_set"))))
add("CT-10", "connector", EX((req("family.next_state", state="SH NONCOMPLIANT_HOLD", trigger="HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate", validator_passed=True), eq("result", "SR READMISSION_REVIEW"))))
add("CT-11", "connector", EX(
    (req("family.compose", scenario={"disclosure_class_entries": [{"ref": "o1", "class": "BOUNDED_EXECUTION_NEUTRAL_OPENNESS"}]}), verdict_is("REPLAY_ADMISSIBLE_CONSTRAINED")),
    (req("family.compose", scenario={"disclosure_collapse": True}), verdict_is("INCIDENT_ONLY"))))
add("CT-12", "connector", EX(
    (req("family.compose", scenario={"evidence_closure_fail": True}), verdict_is("INCIDENT_ONLY")),
    (req("family.compose", scenario={}), lambda r: len(r.get("family_validator_outcomes", [])) == 12 and (r.get("outputs") or {}).get("FOC-01", {}).get("family_evidence_refs"))))
add("CT-13", "connector", EX((req("family.compose", scenario={"role_reclassified_ok": False}), verdict_is("CONTAMINATION_FAIL_CLOSED")))
    )
add("CT-14", "connector", EX(
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedCarriedPayload", validator_passed=True), eq("result", "S2 BOUNDARY_SCREENED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedAnchorDocumentRef", validator_passed=True), eq("result", "S2 BOUNDARY_SCREENED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedPolicySnapshotId", validator_passed=True), eq("result", "S5 REHYDRATION_CLOSED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedComponentSet", validator_passed=True), eq("result", "S2 BOUNDARY_SCREENED")),
    (req("family.next_state", state="SR READMISSION_REVIEW", trigger="ReadmissionBundleChangedRehydrationBundle", validator_passed=True), eq("result", "S5 REHYDRATION_CLOSED"))))


# ===========================================================================
# Execution
# ===========================================================================
def invoke(request: dict) -> tuple[str, int, str]:
    payload = json.dumps(request, ensure_ascii=False)
    proc = subprocess.run([PY, str(BASELINE)], input=payload, capture_output=True, text=True)
    cmd = f'"{PY}" "{BASELINE.name}"  # stdin={payload}'
    out = (proc.stdout or "") + (("\n[stderr] " + proc.stderr) if proc.stderr.strip() else "")
    return cmd, proc.returncode, out


def run() -> int:
    if not BASELINE.exists():
        sys.stderr.write(f"FAIL-CLOSED: baseline not found at {BASELINE}\n")
        return 2
    # Startability probe (fail-closed): the baseline must answer a trivial op.
    probe = subprocess.run([PY, str(BASELINE)],
                           input=json.dumps({"op": "family.types"}),
                           capture_output=True, text=True)
    if probe.returncode != 0:
        sys.stderr.write(f"FAIL-CLOSED: baseline at {BASELINE} did not start "
                         f"(exit {probe.returncode}): {probe.stderr.strip()}\n")
        return 2

    log_lines: list[str] = []
    results: list[dict] = []
    totals = {"total": 0, "pass": 0, "fail": 0, "skip": 0, "error": 0}

    for pt_id, category, spec in RECORDS:
        totals["total"] += 1
        if spec[0] == "SKIP":
            cite = spec[1]
            log_lines.append(f"PT-ID: {pt_id}")
            log_lines.append(f"COMMAND: (no invocation -- SKIP: {cite})")
            log_lines.append("EXIT_CODE: -1")
            log_lines.append("STDOUT_TAIL: (not invoked; see pt_results.json notes)")
            log_lines.append("")
            results.append({"id": pt_id, "category": category, "status": "SKIP", "notes": cite})
            totals["skip"] += 1
            continue

        probes = spec[1]
        status = "PASS"
        notes_bits: list[str] = []
        log_lines.append(f"PT-ID: {pt_id}")
        for request, check in probes:
            cmd, code, out = invoke(request)
            log_lines.append(f"COMMAND: {cmd}")
            log_lines.append(f"EXIT_CODE: {code}")
            tail = out[-4096:]
            log_lines.append(f"STDOUT_TAIL: {tail}")
            if code != 0:
                status = "ERROR" if status != "FAIL" else status
                notes_bits.append(f"exit={code}")
                continue
            try:
                res = json.loads(out.split("\n[stderr]")[0])
            except json.JSONDecodeError:
                status = "ERROR"
                notes_bits.append("unparseable stdout")
                continue
            if isinstance(res, dict) and "error" in res:
                status = "ERROR"
                notes_bits.append(f"baseline error: {res.get('error')}")
                continue
            try:
                ok = bool(check(res))
            except Exception as exc:  # a check that cannot read the result => FAIL, honestly
                ok = False
                notes_bits.append(f"check raised {type(exc).__name__}")
            if not ok:
                status = "FAIL"
                notes_bits.append("oracle mismatch")
        log_lines.append("")
        note = "converged on documented oracle" if status == "PASS" else "; ".join(notes_bits)
        results.append({"id": pt_id, "category": category, "status": status, "notes": note})
        totals[status.lower()] += 1

    LOG.write_text("\n".join(log_lines) + "\n", encoding="utf-8")
    RESULTS.write_text(json.dumps({
        "agent_id": "FAM-SSCAR-FI-001",
        "lang": "python",
        "test_run_timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "execution_mode": "live",
        "protocol": "buyer-conformance",
        "totals": totals,
        "results": results,
    }, indent=2, ensure_ascii=False), encoding="utf-8")

    print(f"run_pts: total={totals['total']} pass={totals['pass']} fail={totals['fail']} "
          f"skip={totals['skip']} error={totals['error']}")
    return 0


if __name__ == "__main__":
    sys.exit(run())
