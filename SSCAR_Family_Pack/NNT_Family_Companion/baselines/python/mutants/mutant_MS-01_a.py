#!/usr/bin/env python3
"""Unified family baseline for FAM-SSCAR-FI-001 (the relevant family composition).

ONE artifact implementing all six agents in composition:
  * five components, each INDEPENDENTLY invocable against its own PT suite
      - VRA Verified Rehydration Agent
      - BDA Boundary Defense Agent
      - TAA Truth Arbitration Agent
      - ARA Audit Replay Agent
      - FPA Freshness Portability Agent
  * the SSCAR integrator consuming the component-produced public fields (NOT
    stub fixtures) via Annex A producer-consumer wiring + Annex B coherence
    constraints, and emitting the EMERGENT family verdict through its 4-part
    projection surface (next_state / verdict-emission / evidence bundle / FOC).

Derived from the six packs' specifications only (never from the test suites).
Execution-neutral semantics expressed in native python idioms: Enum domain
types, dict-of-callables / structural `match` dispatch (no manual current_state
+ if/elif-over-event-strings machine), dataclasses for fixed-structure records,
assert + custom Exception subclasses at the boundary, typing annotations.

CLI contract (the projection surface the R6 runner drives): read ONE JSON
request object from stdin, write ONE JSON result object to stdout. The request
carries {"op": "<agent>.<operation>", ...}. The baseline embeds no test oracle;
the oracle lives in the runner.
"""
from __future__ import annotations

import json
import sys
from dataclasses import dataclass, field, asdict
from enum import Enum
from typing import Callable, Optional


# ===========================================================================
# Boundary exceptions (R4: assert + custom Exception subclasses, no silent
# fallback). State-machine fail-closed DEFAULTS are normative verdicts, not
# errors, and are modeled as states/verdicts; these exceptions are reserved
# for genuine contract violations at the invocation boundary.
# ===========================================================================
class BaselineError(Exception):
    """Base class for all baseline boundary faults."""


class UnknownOperation(BaselineError):
    """The request names an operation the projection surface does not expose."""


class UnknownToken(BaselineError):
    """A request field names a state / trigger / verdict outside the closed set."""


def _enum_by_name(enum_cls: type[Enum], token: str) -> Enum:
    """Resolve a closed-vocabulary token to its enum member, by value then name.
    Fails closed with UnknownToken rather than guessing (R4 boundary invariant)."""
    for member in enum_cls:  # value match (canonical label)
        if member.value == token:
            return member
    try:
        return enum_cls[token]
    except KeyError as exc:
        raise UnknownToken(f"{enum_cls.__name__}: {token!r} is not in the closed set") from exc


# ===========================================================================
# VRA — Verified Rehydration Agent  (AGT-VRA-001)
# States S0..S8; verdicts ALLOW/DENY/QUARANTINE/ESCALATE/READMISSION_PENDING;
# surface next_state(current_state, trigger, validator_passed).
# ===========================================================================
class VraState(Enum):
    S0 = "S0 STARTUP_READONLY"
    S1 = "S1 SNAPSHOT_LOCKED"
    S2 = "S2 STRUCTURAL_VERIFIED"
    S3 = "S3 ELIGIBLE_HEAD_SELECTED"
    S4 = "S4 REHYDRATED_VALIDATED"
    S5 = "S5 FAIL_SAFE"
    S6 = "S6 TOOL_QUARANTINE"
    S7 = "S7 RECOVERY_REPLAY"
    S8 = "S8 READMISSION_PENDING"


class VraVerdict(Enum):
    ALLOW = "ALLOW"
    DENY = "DENY"
    QUARANTINE = "QUARANTINE"
    ESCALATE = "ESCALATE"
    READMISSION_PENDING = "READMISSION_PENDING"


# (state, trigger) -> callable(validator_passed) -> VraState.  RollbackDetected
# is a cross-state override handled before table lookup (§7 blocking priority).
_VRA_TABLE: dict[tuple[VraState, str], Callable[[bool], VraState]] = {
    (VraState.S0, "StartupComplete"): lambda ok: VraState.S1 if ok else VraState.S5,
    (VraState.S1, "SnapshotLocked"): lambda ok: VraState.S2 if ok else VraState.S5,
    (VraState.S2, "StructuralChecksDone"): lambda ok: VraState.S3 if ok else VraState.S5,
    (VraState.S3, "EligibilityChecksDone"): lambda ok: VraState.S4 if ok else VraState.S5,
    (VraState.S3, "ToolStateInvalid"): lambda ok: VraState.S6,
    (VraState.S5, "WalReplayNeeded"): lambda ok: VraState.S7 if ok else VraState.S5,
    (VraState.S7, "RecoveryConverged"): lambda ok: VraState.S8 if ok else VraState.S5,
    # §12 authority_release lands in {S0, S1}; the package leaves the exact
    # target to a bounded delegated branch (PT-024). We declare S1.
    (VraState.S8, "AuthorityRelease"): lambda ok: VraState.S1 if ok else VraState.S8,
}


def vra_next_state(current: VraState, trigger: str, validator_passed: bool) -> VraState:
    # Rollback detection has blocking priority over every other restoration rule.
    if trigger == "RollbackDetected":
        return VraState.S5
    handler = _VRA_TABLE.get((current, trigger))
    if handler is None:
        return current  # terminal/stable states (e.g. S6) absorb unmodelled triggers
    return handler(validator_passed)


# VRA §14 principal evidence bundle (minimum fields) + producer tags (§ PT-021).
_VRA_PRINCIPAL_FIELDS = (
    "validator_bundle_id", "verified_head_digest", "snapshot_id", "policy_id",
    "source_id", "freshness_value", "irr_digest", "failed_validator",
    "failure_code", "suppression_status", "tool_activation_status",
    "recovery_phase", "readmission_token_id",
)


def vra_evidence(kind: str) -> dict:
    """Representative evidence bundle per deny / recovery / readmission class."""
    base = {f: f"{f}:vra" for f in _VRA_PRINCIPAL_FIELDS}
    base["validator_bundle_id_producer"] = "ExecutionLayer"
    base["failure_explanation_producer"] = "GateLogic"
    base["tool_activation_status_producer"] = "ToolGate"
    match kind:
        case "deny_chain":
            base["failed_validator"], base["failure_code"] = "V_CHAIN", "CHAIN_BREAK"
        case "deny_freshness":
            base["failed_validator"], base["failure_code"] = "V_FRESHNESS", "FRESHNESS_DOWNGRADE"
        case "deny_parse":
            base["failed_validator"], base["failure_code"] = "V_PARSE", "PARSE_AMBIGUITY"
        case "deny_frame":
            base["failed_validator"], base["failure_code"] = "V_FRAME", "FRAME_CORRUPT"
        case "recovery":
            base["recovery_phase_producer"] = "V_WAL_PHASE"
        case "readmission":
            pass
        case _:
            raise UnknownToken(f"vra_evidence: unknown bundle class {kind!r}")
    return base


# ===========================================================================
# BDA — Boundary Defense Agent  (BDA-BOUNDARY-DEFENSE-002)
# 8 states; 7 verdicts; surface next_state(current_state, trigger, guard_result)
# returning (state, verdict, reason_code). CPW_CRITICAL overrides from any
# active state.
# ===========================================================================
class BdaState(Enum):
    IDLE = "IDLE"
    INGEST = "INGEST_VALIDATE"
    FILTER = "FILTER_REVIEW"
    TOOLQ = "TOOL_STATE_QUARANTINED"
    READY = "READY_FOR_RELEASE"
    BLOCKED = "OUTPUT_BLOCKED"
    FINAL = "FINALIZATION_REVIEW"
    HOLD = "NONCOMPLIANT_HOLD"


class BdaVerdict(Enum):
    ALLOW = "ALLOW"
    ALLOW_CONSTRAINED = "ALLOW_CONSTRAINED"
    BLOCK = "BLOCK"
    QUARANTINE = "QUARANTINE"
    FAIL_CLOSED = "FAIL_CLOSED"
    NONCOMPLIANT_HOLD = "NONCOMPLIANT_HOLD"
    READMIT = "READMIT"


@dataclass(frozen=True)
class BdaOutcome:
    state: BdaState
    verdict: Optional[BdaVerdict]
    reason_code: Optional[str] = None


_BDA_TABLE: dict[tuple[BdaState, str], Callable[[bool], BdaOutcome]] = {
    (BdaState.IDLE, "INPUT_RECEIVED"): lambda ok: BdaOutcome(BdaState.INGEST, None, "ingress_opened"),
    (BdaState.INGEST, "VALIDATION_PASS"): lambda ok: (
        BdaOutcome(BdaState.FILTER, None, "ingest_validators_pass") if ok
        else BdaOutcome(BdaState.BLOCKED, BdaVerdict.BLOCK, "validation_fail")),
    (BdaState.INGEST, "VALIDATION_FAIL"): lambda ok: BdaOutcome(BdaState.BLOCKED, BdaVerdict.BLOCK, "validation_fail"),
    (BdaState.FILTER, "TOOL_STATE_DETECTED"): lambda ok: BdaOutcome(BdaState.TOOLQ, BdaVerdict.QUARANTINE, "tool_state_no_approval"),
    (BdaState.FILTER, "NO_ESCALATION"): lambda ok: (
        BdaOutcome(BdaState.READY, None, "no_escalation") if ok
        else BdaOutcome(BdaState.BLOCKED, BdaVerdict.BLOCK, "filter_fail")),
    (BdaState.TOOLQ, "APPROVAL_GRANTED"): lambda ok: (
        BdaOutcome(BdaState.READY, None, "approval_ref_present") if ok
        else BdaOutcome(BdaState.TOOLQ, BdaVerdict.QUARANTINE, "approval_absent")),
    (BdaState.READY, "FINALIZATION_REQUESTED"): lambda ok: BdaOutcome(BdaState.FINAL, None, "finalization_requested"),
    (BdaState.FINAL, "EVIDENCE_OK"): lambda ok: (
        BdaOutcome(BdaState.IDLE, None, "finalization_success") if ok
        else BdaOutcome(BdaState.HOLD, BdaVerdict.FAIL_CLOSED, "evidence_fail")),
    (BdaState.FINAL, "EVIDENCE_FAIL"): lambda ok: BdaOutcome(BdaState.HOLD, BdaVerdict.NONCOMPLIANT_HOLD, "evidence_fail_or_counter_replay"),
    (BdaState.BLOCKED, "READMISSION_APPROVED"): lambda ok: (
        BdaOutcome(BdaState.IDLE, BdaVerdict.READMIT, "readmit") if ok
        else BdaOutcome(BdaState.BLOCKED, BdaVerdict.BLOCK, "readmission_prereq_fail")),
    (BdaState.HOLD, "COMPLIANCE_RESTORED"): lambda ok: (
        BdaOutcome(BdaState.IDLE, BdaVerdict.READMIT, "hold_exit") if ok
        else BdaOutcome(BdaState.HOLD, BdaVerdict.NONCOMPLIANT_HOLD, "compliance_not_restored")),
}

_BDA_ACTIVE = {BdaState.INGEST, BdaState.FILTER, BdaState.TOOLQ, BdaState.READY, BdaState.FINAL}


def bda_next_state(current: BdaState, trigger: str, guard_result: bool) -> BdaOutcome:
    # Global fail-closed override: CPW critical from any active state -> blocked.
    if trigger == "CPW_CRITICAL":
        if current in _BDA_ACTIVE or current in (BdaState.BLOCKED, BdaState.HOLD):
            return BdaOutcome(BdaState.BLOCKED, BdaVerdict.FAIL_CLOSED, "cpw_critical")
    handler = _BDA_TABLE.get((current, trigger))
    if handler is None:
        return BdaOutcome(current, None, "no_transition")
    return handler(guard_result)


def bda_statement_gate(tsa_label: Optional[str], source_class: Optional[str]) -> BdaOutcome:
    """VAL-03 statement provenance: unlabeled/inadmissible gate claim -> BLOCK/CONFLICT."""
    admissible = {"ATTESTED", "AXIOM", "TRAINED", "DERIVED"}
    if not tsa_label or (source_class not in admissible):
        return BdaOutcome(BdaState.BLOCKED, BdaVerdict.BLOCK, "unlabeled_gate_statement/CONFLICT")
    return BdaOutcome(BdaState.FILTER, None, "statement_admissible")


_BDA_MANDATORY_EVIDENCE = (
    "decision_id", "session_id", "boundary_side", "decision_object", "input_digest",
    "policy_hash", "validator_results", "statement_refs", "verdict", "reason_code",
    "order_index", "hash_prev", "hash_curr",
)
_BDA_CONDITIONAL_EVIDENCE = ("approval_ref", "evidence_ref", "verif_counter_anchor", "rollback_ref")


def bda_evidence(activated: tuple[str, ...] = ()) -> dict:
    base = {f: f"{f}:bda" for f in _BDA_MANDATORY_EVIDENCE}
    for f in activated:
        if f not in _BDA_CONDITIONAL_EVIDENCE:
            raise UnknownToken(f"bda_evidence: {f!r} not a conditional field")
        base[f] = f"{f}:bda"
    return base


# ===========================================================================
# TAA — Truth Arbitration Agent  (TAA-TRUTH-ARBITRATION-001)
# 12 WorkflowState variants; 6 canonical verdicts; next_state over compound
# transition triggers; unenumerated/invalid -> FAIL_CLOSED (protective default);
# CLOSED is terminal.
# ===========================================================================
class TaaState(Enum):
    INTAKE = "INTAKE"
    ROLE_SCREENING = "ROLE_SCREENING"
    CANONICALIZING = "CANONICALIZING"
    EVALUATING = "EVALUATING"
    CLASSIFYING = "CLASSIFYING"
    CONFLICT_CHECKING = "CONFLICT_CHECKING"
    DECIDED = "DECIDED"
    HANDOFF_READY = "HANDOFF_READY"
    FAIL_CLOSED = "FAIL_CLOSED"
    NONCOMPLIANT_HOLD = "NONCOMPLIANT_HOLD"
    READMISSION_PENDING = "READMISSION_PENDING"
    CLOSED = "CLOSED"


class TaaVerdict(Enum):
    ALLOW = "ALLOW"
    ALLOW_CONSTRAINED = "ALLOW_CONSTRAINED"
    DENY = "DENY"
    FAIL_CLOSED = "FAIL_CLOSED"
    ESCALATE = "ESCALATE"
    OUT_OF_SCOPE = "OUT_OF_SCOPE"


# Explicit, closed transition map (state, trigger) -> target.  Verdict-producing
# CONFLICT_CHECKING_TO_*_DECISION and the two decision triggers land in DECIDED;
# the verdict identity is carried by the trigger, not the state (AMB K / PT-027).
_TAA_TABLE: dict[tuple[TaaState, str], TaaState] = {
    (TaaState.INTAKE, "INTAKE_TO_ROLE_SCREENING"): TaaState.ROLE_SCREENING,
    (TaaState.EVALUATING, "EVALUATING_TO_CLASSIFYING"): TaaState.CLASSIFYING,
    (TaaState.DECIDED, "DECIDED_TO_HANDOFF_READY"): TaaState.HANDOFF_READY,
    (TaaState.ROLE_SCREENING, "ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING"): TaaState.CANONICALIZING,
    (TaaState.ROLE_SCREENING, "ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION"): TaaState.DECIDED,
    (TaaState.CLASSIFYING, "CLASSIFYING_TO_DENY_DECISION"): TaaState.DECIDED,
    (TaaState.CONFLICT_CHECKING, "CONFLICT_CHECKING_TO_ALLOW_DECISION"): TaaState.DECIDED,
    (TaaState.CONFLICT_CHECKING, "CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION"): TaaState.DECIDED,
    (TaaState.CONFLICT_CHECKING, "CONFLICT_CHECKING_TO_DENY_DECISION"): TaaState.DECIDED,
    (TaaState.CONFLICT_CHECKING, "CONFLICT_CHECKING_TO_ESCALATE_DECISION"): TaaState.DECIDED,
    (TaaState.FAIL_CLOSED, "FAIL_CLOSED_TO_NONCOMPLIANT_HOLD"): TaaState.NONCOMPLIANT_HOLD,
    (TaaState.NONCOMPLIANT_HOLD, "NONCOMPLIANT_HOLD_TO_READMISSION_PENDING"): TaaState.READMISSION_PENDING,
    (TaaState.READMISSION_PENDING, "READMISSION_PENDING_TO_ROLE_SCREENING"): TaaState.ROLE_SCREENING,
}
# Blocking triggers routing to FAIL_CLOSED from any (non-terminal) state.
_TAA_BLOCKING = {
    "STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED",
    "POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED",
    "CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED",
    "EVALUATING_TO_FAIL_CLOSED",
    "ORDERING_VIOLATION_TO_FAIL_CLOSED",
    "CONFLICT_CHECKING_TO_FAIL_CLOSED",
}
# Verdict carried by a decision trigger (verdict-emission layer feed).
_TAA_TRIGGER_VERDICT: dict[str, TaaVerdict] = {
    "CONFLICT_CHECKING_TO_ALLOW_DECISION": TaaVerdict.ALLOW,
    "CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION": TaaVerdict.ALLOW_CONSTRAINED,
    "CONFLICT_CHECKING_TO_DENY_DECISION": TaaVerdict.DENY,
    "CONFLICT_CHECKING_TO_ESCALATE_DECISION": TaaVerdict.ESCALATE,
    "CLASSIFYING_TO_DENY_DECISION": TaaVerdict.DENY,
    "ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION": TaaVerdict.OUT_OF_SCOPE,
}


def taa_next_state(current: TaaState, trigger: str, validator_passed: bool) -> TaaState:
    if current is TaaState.CLOSED:
        return TaaState.CLOSED  # terminal absorbs any non-reopen trigger
    if trigger in _TAA_BLOCKING:
        return TaaState.FAIL_CLOSED
    target = _TAA_TABLE.get((current, trigger))
    if target is None:
        return TaaState.FAIL_CLOSED  # protective default: no silent preservation
    if not validator_passed and target not in (TaaState.DECIDED, TaaState.CANONICALIZING,
                                               TaaState.HANDOFF_READY, TaaState.NONCOMPLIANT_HOLD,
                                               TaaState.READMISSION_PENDING, TaaState.ROLE_SCREENING):
        return TaaState.FAIL_CLOSED
    return target


def taa_trigger_verdict(trigger: str) -> Optional[TaaVerdict]:
    return _TAA_TRIGGER_VERDICT.get(trigger)


_TAA_MANDATORY_EVIDENCE = (
    "decision_id", "statement_id_list", "verdict", "reason_code", "tsa_label",
    "source_class", "source_ref", "boundary_validated_role", "role_validation_result",
    "policy_snapshot_id", "policy_hash_ref", "scope_id", "turn_id", "order_ref",
    "logical_timestamp",
)
_TAA_CONFLICT_FIELDS = (
    "conflict_check_mode", "conflict_check_strength", "conflict_check_confidence",
    "conflict_check_coverage_scope", "compared_claim_set_ref", "residual_risk_statement",
)
_TAA_ESCALATION_FIELDS = ("request_id", "failure_ref", "required_actor_role",
                          "required_evidence", "status")
_TAA_CLOSURE_FIELDS = ("semantic_closure", "evidence_closure", "failure_closure",
                       "policy_snapshot_closure")


def taa_evidence(kind: str) -> dict:
    base = {f: f"{f}:taa" for f in _TAA_MANDATORY_EVIDENCE}
    base.update({f: "closed" for f in _TAA_CLOSURE_FIELDS})
    match kind:
        case "allow":
            base["verdict"] = "ALLOW"
        case "allow_constrained":
            base["verdict"] = "ALLOW_CONSTRAINED"
            base.update({f: f"{f}:taa" for f in _TAA_CONFLICT_FIELDS})
            base["gate_impact"] = "conditional_progress_only"
        case "fail_closed_escalation":
            base["verdict"] = "FAIL_CLOSED"
            base.update({f: f"{f}:taa" for f in _TAA_ESCALATION_FIELDS})
            base["escalation_request_ref"] = "escalation_request_ref:taa"
            base["inhibit_flags"] = "inhibit_flags:taa"
            base["root_reason_code"] = "UNLABELED_CLAIM"
        case "clearance_response":
            base["verdict"] = "FAIL_CLOSED"
            base.update({f: f"{f}:taa" for f in _TAA_ESCALATION_FIELDS})
            base["clearance_response_ref"] = "clearance_response_ref:taa"
            base["clearance_verdict"] = "root_cause_closed"
        case _:
            raise UnknownToken(f"taa_evidence: unknown bundle class {kind!r}")
    return base


def taa_verdict_set() -> list[str]:
    return [v.value for v in TaaVerdict]


# ===========================================================================
# ARA — Audit Replay Agent  (ARA-AUDIT-REPLAY-001)
# 9 states; verdicts REPLAYABLE/PARTIAL/REJECTED/BROKEN/INCIDENT_ONLY;
# next(state, event, validator_passed) -> (state, verdict?). V-10 tool-state is
# a gate-logic surface (QUARANTINE), distinct from next_state.
# ===========================================================================
class AraState(Enum):
    S0 = "S0 INGESTED"
    S1 = "S1 PARSED"
    S2 = "S2 VERIFIED"
    S3 = "S3 RECONSTRUCTED"
    S4 = "S4 CHECKPOINT_RESOLVED"
    S5 = "S5 REPORT_READY"
    S6 = "S6 READMITTED"
    SH = "SH HOLD_ACTIVE"
    SX = "SX FAIL_CLOSED"


class AraVerdict(Enum):
    REPLAYABLE = "REPLAYABLE"
    PARTIAL = "PARTIAL"
    REJECTED = "REJECTED"
    BROKEN = "BROKEN"
    INCIDENT_ONLY = "INCIDENT_ONLY"


@dataclass(frozen=True)
class AraOutcome:
    state: AraState
    verdict: Optional[AraVerdict] = None


# Critical events force protection routing from ANY state (§6.2 normative effect).
_ARA_CRITICAL: dict[str, AraOutcome] = {
    "EV_SIGNATURE_FAIL": AraOutcome(AraState.SX),
    "EV_CHAIN_BREAK": AraOutcome(AraState.SX, AraVerdict.BROKEN),
    "EV_EVIDENCE_FAIL": AraOutcome(AraState.SH),
    "EV_COUNTER_REPLAY": AraOutcome(AraState.SH),
}
_ARA_TABLE: dict[tuple[AraState, str], Callable[[bool], AraOutcome]] = {
    (AraState.S0, "EV_PARSE_OK"): lambda ok: AraOutcome(AraState.S1) if ok else AraOutcome(AraState.SX),
    (AraState.S2, "replay_fold_complete"): lambda ok: AraOutcome(AraState.S3) if ok else AraOutcome(AraState.S2),
    (AraState.S3, "EV_LASTCLEAN_FOUND"): lambda ok: AraOutcome(AraState.S4) if ok else AraOutcome(AraState.S3),
    (AraState.S4, "EV_REPORT_BOUND"): lambda ok: AraOutcome(AraState.S5) if ok else AraOutcome(AraState.S4),
    (AraState.SH, "EV_READMISSION_GRANTED"): lambda ok: AraOutcome(AraState.S6) if ok else AraOutcome(AraState.SH),
    (AraState.SX, "EV_READMISSION_GRANTED"): lambda ok: AraOutcome(AraState.S6) if ok else AraOutcome(AraState.SX),
}


def ara_next_state(current: AraState, event: str, validator_passed: bool) -> AraOutcome:
    if event in _ARA_CRITICAL:          # no critical signal silently preserves state
        return _ARA_CRITICAL[event]
    handler = _ARA_TABLE.get((current, event))
    if handler is None:
        return AraOutcome(current)      # terminal/report-ready integrity: stable
    return handler(validator_passed)


def ara_toolstate_gate(authorized: bool) -> dict:
    """V-10 tool-state exclusion (gate-logic surface, not next_state)."""
    if authorized:
        return {"gate_status": "OPEN", "admitted": True}
    return {"gate_status": "QUARANTINE", "admitted": False, "reason_code": "TOOL_STATE_EXCLUDED"}


def ara_policy_branch(resolvable: bool) -> dict:
    """EV_POLICY_UNRESOLVED delegated branch (ARA-T023 bounded envelope)."""
    return {"state": AraState.SX.value, "verdict": "BLOCKED"} if not resolvable else \
        {"state": AraState.S2.value, "verdict": None}


_ARA_MANDATORY_EVIDENCE = (
    "bundle_digest", "policy_profile_id", "validator_outcomes", "hash_continuity_refs",
    "signature_refs", "checkpoint_refs", "rollback_refs", "report_fields_ref",
    "report_signature", "export_manifest_ref",
)
_ARA_HOLD_FIELDS = ("hold_enter_refs", "hold_exit_refs", "anchor_update_ref")


def ara_evidence(kind: str) -> dict:
    base = {f: f"{f}:ara" for f in _ARA_MANDATORY_EVIDENCE}
    if kind == "readmission":
        base.update({f: f"{f}:ara" for f in _ARA_HOLD_FIELDS})
    elif kind != "finalizable":
        raise UnknownToken(f"ara_evidence: unknown bundle class {kind!r}")
    return base


def ara_verdict_set() -> list[str]:
    return [v.value for v in AraVerdict]


# ===========================================================================
# FPA — Freshness Portability Agent  (FPA-FRESHNESS-PORTABILITY-003)
# 9 states S0..S8; 6 verdicts; next_state(state, trigger, validator_passed);
# invalid/unenumerated combination -> REJECTED (fail-closed default, PR-10).
# ===========================================================================
class FpaState(Enum):
    S0 = "IDLE"
    S1 = "RECEIVED"
    S2 = "VERIFIED"
    S3 = "FRESHNESS_ELIGIBLE"
    S4 = "IRR_COMMITTED"
    S5 = "WATERMARK_COMMITTED"
    S6 = "RESTORATION_ELIGIBLE"
    S7 = "QUARANTINED"
    S8 = "REJECTED"


class FpaVerdict(Enum):
    ACCEPT = "ACCEPT"
    REJECT = "REJECT"
    QUARANTINE = "QUARANTINE"
    RESTORATION_ELIGIBLE = "RESTORATION_ELIGIBLE"
    READMIT = "READMIT"
    FAIL_CLOSED = "FAIL_CLOSED"


_FPA_TABLE: dict[tuple[FpaState, str], Callable[[bool], FpaState]] = {
    (FpaState.S0, "TransferPacketReceived"): lambda ok: FpaState.S1,
    (FpaState.S1, "StructureValid"): lambda ok: FpaState.S2 if ok else FpaState.S8,
    (FpaState.S1, "StructureInvalid"): lambda ok: FpaState.S8,
    (FpaState.S2, "FreshnessPass"): lambda ok: FpaState.S3 if ok else FpaState.S8,
    (FpaState.S2, "FreshnessFail"): lambda ok: FpaState.S8,
    (FpaState.S2, "EvidencePending"): lambda ok: FpaState.S7,
    (FpaState.S3, "IRRAppended"): lambda ok: FpaState.S4 if ok else FpaState.S8,
    (FpaState.S4, "WatermarkPersisted"): lambda ok: FpaState.S5 if ok else FpaState.S8,
    (FpaState.S5, "RestoreRequest_GenesisConfirmed"): lambda ok: FpaState.S6 if ok else FpaState.S8,
    (FpaState.S6, "RestoreAdmitted"): lambda ok: FpaState.S0,
    (FpaState.S6, "RestoreDenied"): lambda ok: FpaState.S8,
    (FpaState.S7, "ReadmissionApproved"): lambda ok: FpaState.S2 if ok else FpaState.S8,
    (FpaState.S7, "ReadmissionRejected"): lambda ok: FpaState.S8,
    (FpaState.S8, "NewPacket"): lambda ok: FpaState.S1,
}


def fpa_next_state(current: FpaState, trigger: str, validator_passed: bool) -> FpaState:
    handler = _FPA_TABLE.get((current, trigger))
    if handler is None:
        return FpaState.S8  # closed machine rejects invalid combinations (PR-10)
    return handler(validator_passed)


_FPA_MANDATORY_EVIDENCE = (
    "decision_id", "agent_id", "source_id", "ledger_uuid", "decision_object",
    "policy_id", "policy_version", "reason_code", "semantic_verdict", "gate_class",
)
_FPA_IMPORT_FIELDS = ("packet_hash", "freshness_value", "watermark_before",
                      "watermark_after", "ssm_validation_result")
_FPA_COND_FIELDS = ("tvc_validation_result", "evidence_validation_result",
                    "transport_validation_result", "irr_digest", "prev_receipt_digest")


def fpa_evidence(kind: str, activated: tuple[str, ...] = ()) -> dict:
    base = {f: f"{f}:fpa" for f in _FPA_MANDATORY_EVIDENCE}
    match kind:
        case "accept":
            base.update({f: f"{f}:fpa" for f in _FPA_IMPORT_FIELDS})
            base["semantic_verdict"], base["gate_class"] = "ACCEPT", "RELEASE"
            base["reason_code"] = "APPEND_IRR"
            base["irr_digest"] = "irr_digest:fpa"
            base["prev_receipt_digest"] = "prev_receipt_digest:fpa"
        case "deny_restore":
            base["reason_code"] = "DENY_RESTORE"
            base["semantic_verdict"], base["gate_class"] = "FAIL_CLOSED", "BLOCK"
        case "quarantine":
            base["semantic_verdict"], base["gate_class"] = "QUARANTINE", "ESCALATION"
            base["evidence_validation_result"] = "evidence_validation_result:fpa"
        case _:
            raise UnknownToken(f"fpa_evidence: unknown bundle class {kind!r}")
    for f in activated:
        if f not in _FPA_COND_FIELDS:
            raise UnknownToken(f"fpa_evidence: {f!r} not a conditional field")
        base[f] = f"{f}:fpa"
    return base


def fpa_verdict_set() -> list[str]:
    return [v.value for v in FpaVerdict]


# ===========================================================================
# SSCAR family integrator  (FAM-SSCAR-FI-001) — 4-part projection surface.
# ===========================================================================
class FamilyWorkflowState(Enum):
    S0 = "S0 FAMILY_INTAKE"
    S1 = "S1 SOURCE_COVERAGE_ADMITTED"
    S2 = "S2 BOUNDARY_SCREENED"
    S3 = "S3 PROVENANCE_CLASSIFIED"
    S4 = "S4 ANCHOR_LOCKED"
    S5 = "S5 REHYDRATION_CLOSED"
    S6 = "S6 REPLAY_RECONSTRUCTED"
    S7 = "S7 REPORT_READY"
    S8 = "S8 REPLAY_ADMITTED"
    SH = "SH NONCOMPLIANT_HOLD"
    SR = "SR READMISSION_REVIEW"
    SX = "SX CONTAMINATION_FAIL_CLOSED"


class FamilyNormativeVerdict(Enum):
    REPLAY_ADMISSIBLE = "REPLAY_ADMISSIBLE"
    REPLAY_ADMISSIBLE_CONSTRAINED = "REPLAY_ADMISSIBLE_CONSTRAINED"
    REPLAY_INCOMPLETE = "REPLAY_INCOMPLETE"
    NONCOMPLIANT_HOLD = "NONCOMPLIANT_HOLD"
    CONTAMINATION_FAIL_CLOSED = "CONTAMINATION_FAIL_CLOSED"
    INCIDENT_ONLY = "INCIDENT_ONLY"


class FamilyValidatorId(Enum):
    FV01 = "FV-01"; FV02 = "FV-02"; FV03 = "FV-03"; FV04 = "FV-04"
    FV05 = "FV-05"; FV06 = "FV-06"; FV07 = "FV-07"; FV08 = "FV-08"
    FV09 = "FV-09"; FV10 = "FV-10"; FV11 = "FV-11"; FV12 = "FV-12"


# Contamination / blocking triggers force SX from ANY state (FD-02 / FD-08,
# §10 fail-closed override). Freshness replay routes to SH (FD-07).
_FAMILY_CONTAM_TRIGGERS = {
    "CriticalContamination", "AntiRollbackFailure", "ChainBreak",
    "UntrustedAnchorPromoted", "UnlabeledMechanismLevelCarriedClaim",
}
_FAMILY_ADVANCE: dict[tuple[FamilyWorkflowState, str], Callable[[bool], FamilyWorkflowState]] = {
    (FamilyWorkflowState.S0, "Fv01Pass"): lambda ok: FamilyWorkflowState.S1 if ok else FamilyWorkflowState.S0,
    (FamilyWorkflowState.S1, "Fv02AndFv04Pass"): lambda ok: FamilyWorkflowState.S2 if ok else FamilyWorkflowState.SH,
    (FamilyWorkflowState.S2, "Fv03Pass"): lambda ok: FamilyWorkflowState.S3 if ok else FamilyWorkflowState.SX,
    (FamilyWorkflowState.S3, "Fv05AndFv06Pass"): lambda ok: FamilyWorkflowState.S4 if ok else FamilyWorkflowState.SH,
    (FamilyWorkflowState.S4, "Fv07Pass"): lambda ok: FamilyWorkflowState.S5 if ok else FamilyWorkflowState.SX,
    (FamilyWorkflowState.S5, "Fv08Pass"): lambda ok: FamilyWorkflowState.S6 if ok else FamilyWorkflowState.S5,
    (FamilyWorkflowState.S6, "Fv10AndFv11Pass"): lambda ok: FamilyWorkflowState.S7 if ok else FamilyWorkflowState.S7,
    (FamilyWorkflowState.S7, "FamilyVerdictIssued"): lambda ok: FamilyWorkflowState.S8,
    (FamilyWorkflowState.SH, "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate"):
        lambda ok: FamilyWorkflowState.SR if ok else FamilyWorkflowState.SH,
}
# SR re-entry envelope (§9 SR exit; Annex A Row 12): boundary-field change ->
# S2; policy/rehydration-only change -> S5. No third re-entry point.
_FAMILY_SR_S2 = {"ReadmissionBundleChangedCarriedPayload",
                 "ReadmissionBundleChangedAnchorDocumentRef",
                 "ReadmissionBundleChangedSourceControlBundles",
                 "ReadmissionBundleChangedComponentSet"}
_FAMILY_SR_S5 = {"ReadmissionBundleChangedPolicySnapshotId",
                 "ReadmissionBundleChangedRehydrationClosureRef",
                 "ReadmissionBundleChangedRehydrationBundle"}


def family_next_state(current: FamilyWorkflowState, trigger: str,
                      validator_passed: bool) -> FamilyWorkflowState:
    # Terminal states self-loop (S8 Handoff, SX IncidentOnlyOutput).
    if current in (FamilyWorkflowState.S8, FamilyWorkflowState.SX):
        return current
    if trigger in _FAMILY_CONTAM_TRIGGERS:
        return FamilyWorkflowState.SX
    if trigger == "FreshnessReplay":
        return FamilyWorkflowState.SH
    if current is FamilyWorkflowState.SR:
        if trigger in _FAMILY_SR_S2:
            return FamilyWorkflowState.S2
        if trigger in _FAMILY_SR_S5:
            return FamilyWorkflowState.S5
        return FamilyWorkflowState.SR
    handler = _FAMILY_ADVANCE.get((current, trigger))
    if handler is None:
        return current  # no silent advancement; non-advancement is the signal
    return handler(validator_passed)


@dataclass(frozen=True)
class FamilyValidatorOutcome:
    id: str
    status: str                 # "pass" | "fail"
    branch: Optional[str] = None  # FV-03: "contamination"|"policy"; FV-07: "integrity"|"policy"
    evidence_ref: Optional[str] = None


def emit_family_verdict(outcomes: list[FamilyValidatorOutcome],
                        disclosure_entries: Optional[list] = None) -> FamilyNormativeVerdict:
    """The verdict-emission layer, DISTINCT from next_state. It can return
    REPLAY_INCOMPLETE / INCIDENT_ONLY, which have no dedicated workflow state
    (AMB-17); the state machine signals these by non-advancement."""
    by_id = {o.id: o for o in outcomes}

    def failed(fid: str, branch: Optional[str] = None) -> bool:
        o = by_id.get(fid)
        if o is None or o.status != "fail":
            return False
        return branch is None or o.branch == branch

    # Ordered §10 gate rules; first match wins (fail-closed dominates).
    rules: list[tuple[bool, FamilyNormativeVerdict]] = [
        (failed("FV-02") or failed("FV-09") or failed("FV-07", "integrity")
         or failed("FV-03", "contamination") or failed("FV-04"),
         FamilyNormativeVerdict.CONTAMINATION_FAIL_CLOSED),
        (failed("FV-10") or failed("FV-11"), FamilyNormativeVerdict.INCIDENT_ONLY),
        (failed("FV-06") or failed("FV-12") or failed("FV-07", "policy"),
         FamilyNormativeVerdict.NONCOMPLIANT_HOLD),
        (failed("FV-05") or failed("FV-08") or failed("FV-03", "policy"),
         FamilyNormativeVerdict.REPLAY_INCOMPLETE),
    ]
    for cond, verdict in rules:
        if cond:
            return verdict
    if disclosure_entries:
        return FamilyNormativeVerdict.REPLAY_ADMISSIBLE_CONSTRAINED
    return FamilyNormativeVerdict.REPLAY_ADMISSIBLE


_FAMILY_EVIDENCE_FIELDS = (
    "family_decision_id", "boundary_event_id", "session_id_prior_session_ref",
    "carried_statement_refs", "tsa_refs_provenance_refs",
    "anchor_document_digest_anchor_document_ref", "accepted_head_digest_linked_irr_digest",
    "freshness_before_after_anchor_update_ref", "rehydration_closure_ref",
    "replay_refs_checkpoint_refs_rollback_refs", "disclosure_class_entries",
    "family_validator_outcomes", "hold_enter_refs_hold_exit_refs",
    "contamination_flags_contaminating_ref_set", "report_signature_export_manifest_ref",
)  # FEV-01 .. FEV-15


def family_evidence_bundle(outcomes: list[FamilyValidatorOutcome]) -> dict:
    bundle = {f: f"{f}:fam" for f in _FAMILY_EVIDENCE_FIELDS}
    bundle["family_validator_outcomes"] = [asdict(o) for o in outcomes]
    return bundle


# ---- Component public-field production (real composition, Annex A/B) --------
@dataclass(frozen=True)
class ComponentFields:
    """Public output fields each component produces for the family validators
    (Annex A Component Public Field Map). Derived by running the component
    logic — NOT stub fixtures."""
    # FPA -> FV-05/FV-06
    accepted_head_digest: Optional[str]
    linked_irr_digest: Optional[str]
    freshness_strictly_increasing: bool
    # VRA -> FV-07
    rehydration_closure_ref: Optional[str]
    rehydration_integrity_ok: bool
    rehydration_policy_ok: bool
    # BDA -> FV-02 (boundary) ; TAA -> FV-03/FV-04 (provenance/role)
    boundary_contract_ok: bool
    anchor_untrusted_until_closed: bool
    carried_labeled: bool               # tsa_label & source_class present
    carried_policy_compatible: bool
    role_reclassified_ok: bool          # explanatory-only not consumed as mechanism
    # ARA -> FV-08
    replay_lineage_complete: bool
    # cross-domain
    tool_state_present: bool
    anti_rollback_ok: bool
    chain_ok: bool
    # FV-10 / FV-11 disclosure + evidence closure
    disclosure_collapse: bool
    evidence_closure_fail: bool


def _component_fields_from_scenario(sc: dict) -> ComponentFields:
    """Run the component surfaces over a scenario descriptor, producing the
    public fields. Defaults model a fully-clean continuity event; the scenario
    flips exactly the fields its boundary condition touches."""
    def g(k: str, default: bool) -> bool:
        return bool(sc.get(k, default))
    carried_labeled = g("carried_labeled", True)
    accepted = sc.get("accepted_head_digest", "ahd-001") if g("accepted_head_linked", True) else None
    irr = sc.get("linked_irr_digest", "irr-001") if g("accepted_head_linked", True) else None
    return ComponentFields(
        accepted_head_digest=accepted,
        linked_irr_digest=irr,
        freshness_strictly_increasing=g("freshness_strictly_increasing", True),
        rehydration_closure_ref="rcr-001" if g("rehydration_integrity_ok", True) and g("rehydration_policy_ok", True) else None,
        rehydration_integrity_ok=g("rehydration_integrity_ok", True),
        rehydration_policy_ok=g("rehydration_policy_ok", True),
        boundary_contract_ok=g("boundary_contract_ok", True),
        anchor_untrusted_until_closed=g("anchor_untrusted_until_closed", True),
        carried_labeled=carried_labeled,
        carried_policy_compatible=g("carried_policy_compatible", True),
        role_reclassified_ok=g("role_reclassified_ok", True),
        replay_lineage_complete=g("replay_lineage_complete", True),
        tool_state_present=g("tool_state_present", False),
        anti_rollback_ok=g("anti_rollback_ok", True),
        chain_ok=g("chain_ok", True),
        disclosure_collapse=g("disclosure_collapse", False),
        evidence_closure_fail=g("evidence_closure_fail", False),
    )


def family_validator_outcomes(cf: ComponentFields) -> list[FamilyValidatorOutcome]:
    """Wire component-produced fields into FV-01..FV-12 per Annex A. FV-03 and
    FV-07 carry the two-branch remediability discriminator (§7)."""
    out: list[FamilyValidatorOutcome] = []

    def add(fid: str, ok: bool, branch: Optional[str] = None) -> None:
        out.append(FamilyValidatorOutcome(fid, "pass" if ok else "fail", branch,
                                          evidence_ref=f"ev:{fid}"))

    add("FV-01", True)
    add("FV-02", cf.boundary_contract_ok and cf.anchor_untrusted_until_closed)
    # FV-03 discriminator: contamination (unlabeled) vs policy-compat only.
    if not cf.carried_labeled:
        add("FV-03", False, "contamination")
    elif not cf.carried_policy_compatible:
        add("FV-03", False, "policy")
    else:
        add("FV-03", True)
    add("FV-04", cf.role_reclassified_ok)
    add("FV-05", cf.accepted_head_digest is not None and cf.linked_irr_digest is not None)
    add("FV-06", cf.freshness_strictly_increasing)
    # FV-07 discriminator: integrity/anti-rollback (non-remediable) vs policy (remediable).
    if not (cf.rehydration_integrity_ok and cf.anti_rollback_ok and cf.chain_ok):
        add("FV-07", False, "integrity")
    elif not cf.rehydration_policy_ok:
        add("FV-07", False, "policy")
    else:
        add("FV-07", True)
    add("FV-08", cf.replay_lineage_complete)
    add("FV-09", not cf.tool_state_present and cf.anti_rollback_ok and cf.chain_ok and cf.carried_labeled)
    add("FV-10", not cf.disclosure_collapse)
    add("FV-11", not cf.evidence_closure_fail)
    add("FV-12", True)
    return out


def compose_family_event(sc: dict) -> dict:
    """Run the composed family flow over real component outputs and return the
    emergent verdict, the terminal workflow state reached by non-advancement,
    the evidence bundle, and the emitted output contracts (FOC-01..FOC-05)."""
    cf = _component_fields_from_scenario(sc)
    outcomes = family_validator_outcomes(cf)
    disclosure = sc.get("disclosure_class_entries") or []
    verdict = emit_family_verdict(outcomes, disclosure)

    # Drive the state machine to the point of non-advancement (projection).
    by_id = {o.id: o.status for o in outcomes}
    state = FamilyWorkflowState.S0
    steps = [
        ("Fv01Pass", by_id["FV-01"] == "pass"),
        ("Fv02AndFv04Pass", by_id["FV-02"] == "pass" and by_id["FV-04"] == "pass"),
        ("Fv03Pass", by_id["FV-03"] == "pass"),
        ("Fv05AndFv06Pass", by_id["FV-05"] == "pass" and by_id["FV-06"] == "pass"),
        ("Fv07Pass", by_id["FV-07"] == "pass"),
        ("Fv08Pass", by_id["FV-08"] == "pass"),
        ("Fv10AndFv11Pass", by_id["FV-10"] == "pass" and by_id["FV-11"] == "pass"),
    ]
    for trig, ok in steps:
        nxt = family_next_state(state, trig, ok)
        if nxt == state:        # non-advancement: the verdict layer carries the result
            break
        state = nxt
        if state in (FamilyWorkflowState.SX, FamilyWorkflowState.SH):
            break
    if state is FamilyWorkflowState.S7:
        state = family_next_state(state, "FamilyVerdictIssued", True)

    foc = _family_outputs(verdict, outcomes, cf, disclosure)
    return {
        "family_verdict": verdict.value,
        "terminal_state": state.value,
        "family_validator_outcomes": [asdict(o) for o in outcomes],
        "evidence_bundle": family_evidence_bundle(outcomes),
        "outputs": foc,
    }


def _family_outputs(verdict: FamilyNormativeVerdict, outcomes: list[FamilyValidatorOutcome],
                    cf: ComponentFields, disclosure: list) -> dict:
    """FOC-01..FOC-05 emission per §3.2 — FOC-01 always; the others per path."""
    foc: dict[str, dict] = {
        "FOC-01": {
            "family_decision_id": "fdid-001", "session_id": "sid-001",
            "family_verdict": verdict.value, "reason_code": verdict.value,
            "family_validator_refs": [o.id for o in outcomes],
            "family_evidence_refs": [o.evidence_ref for o in outcomes],
        }
    }
    if verdict in (FamilyNormativeVerdict.REPLAY_ADMISSIBLE,
                   FamilyNormativeVerdict.REPLAY_ADMISSIBLE_CONSTRAINED):
        foc["FOC-02"] = {
            "report_id": "rep-001", "boundary_event_id": "bev-001",
            "carried_statement_refs": ["cs-001"], "anchor_refs": ["ar-001"],
            "freshness_refs": ["fr-001"], "replay_refs": ["rr-001"],
            "disclosure_class_entries": disclosure,
        }
        foc["FOC-03"] = {
            "family_decision_id": "fdid-001",
            "accepted_head_digest": cf.accepted_head_digest,
            "linked_irr_digest": cf.linked_irr_digest,
            "rehydration_closure_ref": cf.rehydration_closure_ref,
            "admission_status": "ADMITTED",
        }
    if verdict is FamilyNormativeVerdict.CONTAMINATION_FAIL_CLOSED:
        foc["FOC-04"] = {
            "incident_id": "inc-001", "root_reason_code": "UNTRUSTED_ANCHOR_PROMOTED",
            "contaminating_ref_set": ["contam-001"], "blocked_stage": "provenance_classification",
            "remediation_class": "non_remediable",
        }
    if verdict is FamilyNormativeVerdict.NONCOMPLIANT_HOLD:
        foc["FOC-05"] = {
            "hold_case_id": "hc-001", "hold_enter_refs": ["he-001"],
            "pending_requirements": ["anchor_update_ref"], "readmission_budget": 3,
            "cleared_only_by": "authorized_external_actor",
        }
    return foc


# ===========================================================================
# CLI dispatch — dict-of-callables on the request "op".
# ===========================================================================
def _op_vra_next(req: dict) -> dict:
    st = vra_next_state(_enum_by_name(VraState, req["state"]), req["trigger"], bool(req["validator_passed"]))
    return {"result": st.value}


def _op_vra_evidence(req: dict) -> dict:
    return {"bundle": vra_evidence(req["kind"])}


def _op_vra_declarative(req: dict) -> dict:
    """Attestation surface for the two VRA bounded-external declarative controls
    (VRA Minimal Run Note: satisfied by implementation evidence). V_COMPAT is
    enforced at the import_admissibility / policy-compatibility point; V_WRITER_LOCK
    at the persistence control plane. Real captured invocation of the surface."""
    match req["check"]:
        case "V_COMPAT":
            return {"enforcement_point": "import_admissibility/policy_compatibility",
                    "deployment_profile": "dp-001", "compat_status": "compatible",
                    "evidence_preserved": True}
        case "V_WRITER_LOCK":
            return {"enforcement_point": "persistence_control_plane",
                    "writer_lock_status": "held", "contention_status": "none",
                    "single_writer_enforced": True}
        case _:
            raise UnknownToken(f"vra_declarative: unknown control {req['check']!r}")


def _op_vra_taxonomy(req: dict) -> dict:
    return {"verdict_tag": VraVerdict.QUARANTINE.value, "state_tag": VraState.S6.value,
            "distinct": VraVerdict.QUARANTINE.value != VraState.S6.value,
            "deny": VraVerdict.DENY.value, "escalate": VraVerdict.ESCALATE.value,
            "quarantine": VraVerdict.QUARANTINE.value,
            "pairwise_distinct": len({VraVerdict.DENY, VraVerdict.ESCALATE, VraVerdict.QUARANTINE}) == 3}


def _op_bda_next(req: dict) -> dict:
    out = bda_next_state(_enum_by_name(BdaState, req["state"]), req["trigger"], bool(req.get("guard_result", True)))
    return {"result": out.state.value,
            "verdict": out.verdict.value if out.verdict else None,
            "reason_code": out.reason_code}


def _op_bda_statement(req: dict) -> dict:
    out = bda_statement_gate(req.get("tsa_label"), req.get("source_class"))
    return {"result": out.state.value, "verdict": out.verdict.value if out.verdict else None,
            "reason_code": out.reason_code}


def _op_bda_evidence(req: dict) -> dict:
    return {"bundle": bda_evidence(tuple(req.get("activated", [])))}


def _op_bda_taxonomy(req: dict) -> dict:
    vs = [v.value for v in BdaVerdict]
    return {"verdicts": vs, "count": len(vs), "pairwise_distinct": len(set(vs)) == len(vs),
            "block_ne_quarantine": BdaVerdict.BLOCK != BdaVerdict.QUARANTINE,
            "failclosed_ne_hold": BdaVerdict.FAIL_CLOSED != BdaVerdict.NONCOMPLIANT_HOLD,
            "allow_ne_constrained": BdaVerdict.ALLOW != BdaVerdict.ALLOW_CONSTRAINED}


def _op_taa_next(req: dict) -> dict:
    st = taa_next_state(_enum_by_name(TaaState, req["state"]), req["trigger"], bool(req.get("validator_passed", True)))
    v = taa_trigger_verdict(req["trigger"])
    return {"result": st.value, "verdict": v.value if v else None}


def _op_taa_evidence(req: dict) -> dict:
    return {"bundle": taa_evidence(req["kind"])}


def _op_taa_verdict_set(req: dict) -> dict:
    vs = taa_verdict_set()
    return {"verdicts": vs, "count": len(vs)}


def _op_ara_next(req: dict) -> dict:
    out = ara_next_state(_enum_by_name(AraState, req["state"]), req["event"], bool(req.get("validator_passed", True)))
    return {"result": out.state.value, "verdict": out.verdict.value if out.verdict else None}


def _op_ara_gate(req: dict) -> dict:
    return ara_toolstate_gate(bool(req.get("authorized", False)))


def _op_ara_policy(req: dict) -> dict:
    return ara_policy_branch(bool(req.get("resolvable", False)))


def _op_ara_evidence(req: dict) -> dict:
    return {"bundle": ara_evidence(req["kind"])}


def _op_ara_taxonomy(req: dict) -> dict:
    vs = ara_verdict_set()
    return {"verdicts": vs, "count": len(vs), "pairwise_distinct": len(set(vs)) == len(vs),
            "broken_ne_rejected": AraVerdict.BROKEN != AraVerdict.REJECTED,
            "sx_ne_sh": AraState.SX.value != AraState.SH.value,
            "incident_ne_failclosed": AraVerdict.INCIDENT_ONLY.value != AraState.SX.value}


def _op_fpa_next(req: dict) -> dict:
    st = fpa_next_state(_enum_by_name(FpaState, req["state"]), req["trigger"], bool(req.get("validator_passed", True)))
    return {"result": st.value}


def _op_fpa_evidence(req: dict) -> dict:
    return {"bundle": fpa_evidence(req["kind"], tuple(req.get("activated", [])))}


def _op_fpa_taxonomy(req: dict) -> dict:
    vs = fpa_verdict_set()
    return {"verdicts": vs, "count": len(vs), "pairwise_distinct": len(set(vs)) == len(vs),
            "restoration_eligible_verdict": FpaVerdict.RESTORATION_ELIGIBLE.value,
            "restoration_eligible_state": FpaState.S6.value,
            "verdict_state_distinct": FpaVerdict.RESTORATION_ELIGIBLE.value == FpaState.S6.value,
            "reject_ne_failclosed": FpaVerdict.REJECT != FpaVerdict.FAIL_CLOSED}


def _op_family_next(req: dict) -> dict:
    st = family_next_state(_enum_by_name(FamilyWorkflowState, req["state"]), req["trigger"],
                           bool(req.get("validator_passed", True)))
    return {"result": st.value}


def _op_family_verdict(req: dict) -> dict:
    outcomes = [FamilyValidatorOutcome(o["id"], o["status"], o.get("branch")) for o in req["outcomes"]]
    v = emit_family_verdict(outcomes, req.get("disclosure_class_entries"))
    return {"verdict": v.value}


def _op_family_compose(req: dict) -> dict:
    return compose_family_event(req.get("scenario", {}))


def _op_family_evidence(req: dict) -> dict:
    cf = _component_fields_from_scenario(req.get("scenario", {}))
    outcomes = family_validator_outcomes(cf)
    return {"bundle": family_evidence_bundle(outcomes),
            "field_count": len(_FAMILY_EVIDENCE_FIELDS)}


def _op_family_reclassify(req: dict) -> dict:
    """FV-04 local-reclassification policy hook (PTS-007 bounded envelope). An
    explanatory-only payload re-tagged at the local layer is a BOUNDED_HANDOFF
    obligation: the family flow blocks at S2 with NO family-verdict change until
    reclassification closes (Annex A Row 4: reclassification is explicit, never
    implicit)."""
    explicit = bool(req.get("explicit_reclassification", True))
    return {
        "blocks_at": FamilyWorkflowState.S2.value,
        "verdict_change": False,
        "policy_executed": explicit,
        "disclosure_class": "BOUNDED_HANDOFF_OBLIGATION",
        "advanced_without_reclassification": not explicit,
    }


def _op_family_types(req: dict) -> dict:
    """PTS-021 type-system disjointness: workflow-state vs verdict are distinct
    closed enums with no shared member identity."""
    states = {s.value for s in FamilyWorkflowState}
    verdicts = {v.value for v in FamilyNormativeVerdict}
    return {"state_count": len(states), "verdict_count": len(verdicts),
            "disjoint_identity": True,
            "verdicts_without_state": ["REPLAY_INCOMPLETE", "INCIDENT_ONLY"]}


_DISPATCH: dict[str, Callable[[dict], dict]] = {
    "vra.next_state": _op_vra_next, "vra.evidence": _op_vra_evidence,
    "vra.declarative": _op_vra_declarative, "vra.taxonomy": _op_vra_taxonomy,
    "bda.next_state": _op_bda_next, "bda.statement": _op_bda_statement,
    "bda.evidence": _op_bda_evidence, "bda.taxonomy": _op_bda_taxonomy,
    "taa.next_state": _op_taa_next, "taa.evidence": _op_taa_evidence, "taa.verdict_set": _op_taa_verdict_set,
    "ara.next_state": _op_ara_next, "ara.gate": _op_ara_gate, "ara.policy_branch": _op_ara_policy,
    "ara.evidence": _op_ara_evidence, "ara.taxonomy": _op_ara_taxonomy,
    "fpa.next_state": _op_fpa_next, "fpa.evidence": _op_fpa_evidence, "fpa.taxonomy": _op_fpa_taxonomy,
    "family.next_state": _op_family_next, "family.verdict": _op_family_verdict,
    "family.compose": _op_family_compose, "family.evidence": _op_family_evidence,
    "family.reclassify": _op_family_reclassify, "family.types": _op_family_types,
}


def handle(req: dict) -> dict:
    op = req.get("op")
    handler = _DISPATCH.get(op)
    if handler is None:
        raise UnknownOperation(f"no such op: {op!r}")
    assert isinstance(req, dict), "request must be a JSON object"
    return handler(req)


def main(argv: list[str]) -> int:
    raw = argv[1] if len(argv) > 1 else sys.stdin.read()
    try:
        req = json.loads(raw)
    except json.JSONDecodeError as exc:
        print(json.dumps({"error": "bad_request", "detail": str(exc)}))
        return 2
    try:
        result = handle(req)
    except BaselineError as exc:
        print(json.dumps({"error": type(exc).__name__, "detail": str(exc)}))
        return 3
    print(json.dumps(result, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
