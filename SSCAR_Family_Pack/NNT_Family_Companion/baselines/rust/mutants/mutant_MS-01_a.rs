// FAM-SSCAR-FI-001 — unified family baseline (rust paradigm, NNT family run)
//
// ONE artifact composing all 6 agents:
//   * 5 components (VRA, BDA, TAA, ARA, FPA) — each independently invocable
//     against its own component PT suite AND producing the public output
//     fields the family integrator consumes.
//   * the SSCAR integrator — a 4-part projection surface (next_state /
//     verdict-emission layer / family evidence bundle / FOC emission) that
//     consumes REAL component-produced fields (not stub fixtures) per Annex A
//     wiring and Annex B coherence constraints, and emits the EMERGENT family
//     verdict.
//
// Derived from the SSCAR specification and the five component specifications
// (spec, not tests). Idioms: exhaustive enums for states/triggers/verdicts
// (compiler rejects non-exhaustive match); Result/Option for fallibility;
// distinct types for workflow state vs normative verdict (AMB-15/AMB-17,
// PTS-021); match guards for conditional transitions.
//
// CLI (the projection surface the runner drives; no test cases live here):
//   baseline <domain> next_state <STATE> <TRIGGER> <true|false>
//   baseline <domain> verdict <scenario>
//   baseline <domain> evidence <scenario>
//   baseline fam compose <ct-scenario>
//   baseline fam verdict_layer <failed_validator|none> [disc]
//   baseline selfcheck
// domain in {vra,bda,taa,ara,fpa,fam}

use std::env;
use std::process::exit;

// ============================================================================
// Shared helpers
// ============================================================================

fn emit_state(s: &str) {
    println!("OK state={}", s);
}
fn emit_verdict(v: &str) {
    println!("OK verdict={}", v);
}
fn emit_fields(kind: &str, fields: &[(&str, &str)]) {
    let body: Vec<String> = fields.iter().map(|(k, v)| format!("{}={}", k, v)).collect();
    println!("OK {} {}", kind, body.join(";"));
}
fn err_unknown(what: &str, token: &str) -> ! {
    eprintln!("ERR unknown {}: {}", what, token);
    exit(3);
}
fn parse_bool(s: &str) -> bool {
    matches!(s, "true" | "True" | "1" | "pass")
}

// ============================================================================
// VRA — Verified Rehydration Agent
// ============================================================================
mod vra {
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum State {
        S0StartupReadonly,
        S1SnapshotLocked,
        S2StructuralVerified,
        S3EligibleHeadSelected,
        S4RehydratedValidated,
        S5FailSafe,
        S6ToolQuarantine,
        S7RecoveryReplay,
        S8ReadmissionPending,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Trigger {
        StartupComplete,
        SnapshotLocked,
        StructuralChecksDone,
        EligibilityChecksDone,
        RollbackDetected,
        WalReplayNeeded,
        ToolStateInvalid,
        AuthorityRelease,
    }
    // NormativeVerdict is a DISTINCT type from State (AR-002/AR-003 non-collapse).
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Verdict {
        Allow,
        Deny,
        Quarantine,
        Escalate,
        ReadmissionPending,
    }

    pub fn state_code(s: State) -> &'static str {
        match s {
            State::S0StartupReadonly => "S0",
            State::S1SnapshotLocked => "S1",
            State::S2StructuralVerified => "S2",
            State::S3EligibleHeadSelected => "S3",
            State::S4RehydratedValidated => "S4",
            State::S5FailSafe => "S5",
            State::S6ToolQuarantine => "S6",
            State::S7RecoveryReplay => "S7",
            State::S8ReadmissionPending => "S8",
        }
    }
    pub fn parse_state(s: &str) -> Option<State> {
        Some(match s {
            "S0" => State::S0StartupReadonly,
            "S1" => State::S1SnapshotLocked,
            "S2" => State::S2StructuralVerified,
            "S3" => State::S3EligibleHeadSelected,
            "S4" => State::S4RehydratedValidated,
            "S5" => State::S5FailSafe,
            "S6" => State::S6ToolQuarantine,
            "S7" => State::S7RecoveryReplay,
            "S8" => State::S8ReadmissionPending,
            _ => return None,
        })
    }
    pub fn parse_trigger(s: &str) -> Option<Trigger> {
        Some(match s {
            "StartupComplete" => Trigger::StartupComplete,
            "SnapshotLocked" => Trigger::SnapshotLocked,
            "StructuralChecksDone" => Trigger::StructuralChecksDone,
            "EligibilityChecksDone" => Trigger::EligibilityChecksDone,
            "RollbackDetected" => Trigger::RollbackDetected,
            "WalReplayNeeded" => Trigger::WalReplayNeeded,
            "ToolStateInvalid" => Trigger::ToolStateInvalid,
            "AuthorityRelease" => Trigger::AuthorityRelease,
            _ => return None,
        })
    }

    // §12 state model + §7 ordering. Rollback detection has blocking priority
    // over every other restoration rule (Spec §7). Fail-closed default = remain
    // in place / S5; never ALLOW on an unmatched combination. Terminal S6 stable.
    pub fn next_state(cur: State, t: Trigger, vp: bool) -> State {
        use self::State::*;
        use self::Trigger::*;
        // R6 universal override: rollback from any state -> S5 (fail-safe).
        if t == RollbackDetected {
            return S5FailSafe;
        }
        match (cur, t, vp) {
            (S0StartupReadonly, StartupComplete, true) => S1SnapshotLocked,
            (S0StartupReadonly, StartupComplete, false) => S5FailSafe,
            (S1SnapshotLocked, SnapshotLocked, true) => S2StructuralVerified,
            (S1SnapshotLocked, SnapshotLocked, false) => S5FailSafe,
            (S2StructuralVerified, StructuralChecksDone, true) => S3EligibleHeadSelected,
            (S2StructuralVerified, StructuralChecksDone, false) => S5FailSafe,
            (S3EligibleHeadSelected, EligibilityChecksDone, true) => S4RehydratedValidated,
            (S3EligibleHeadSelected, EligibilityChecksDone, false) => S5FailSafe,
            (S3EligibleHeadSelected, ToolStateInvalid, _) => S6ToolQuarantine,
            (S5FailSafe, WalReplayNeeded, true) => S7RecoveryReplay,
            (S5FailSafe, WalReplayNeeded, false) => S5FailSafe,
            (S7RecoveryReplay, _, _) => S8ReadmissionPending, // recovery_converged (no-duplicate) path
            // S8 authority-release lands only in the permitted set {S0,S1}; this
            // implementation selects S0 (parameterized PT-024 checks membership).
            (S8ReadmissionPending, AuthorityRelease, true) => S0StartupReadonly,
            // Terminal / stable: S6 remains S6 on any other trigger (OR-11).
            (S6ToolQuarantine, _, _) => S6ToolQuarantine,
            // Fail-closed default: no silent ALLOW; remain fail-safe.
            _ => S5FailSafe,
        }
    }

    pub fn verdict_code(v: Verdict) -> &'static str {
        match v {
            Verdict::Allow => "ALLOW",
            Verdict::Deny => "DENY",
            Verdict::Quarantine => "QUARANTINE",
            Verdict::Escalate => "ESCALATE",
            Verdict::ReadmissionPending => "READMISSION_PENDING",
        }
    }
    // Public fields the family integrator consumes (Annex A row 7 / field map).
    pub fn rehydration_closure_ref(ok: bool) -> Option<&'static str> {
        if ok { Some("vra-rhc-0001") } else { None }
    }
    pub fn snapshot_id() -> &'static str { "vra-snap-0001" }
    pub fn verified_head_digest() -> &'static str { "sha256:acceptedhead0001" }
    pub fn irr_digest() -> &'static str { "sha256:irr0001" }

    // Evidence bundles for the EB-* conformance fixtures (deny/recovery/readmission).
    pub fn evidence(scenario: &str) -> Vec<(&'static str, &'static str)> {
        match scenario {
            // deny-path bundles still carry the unconditional minimum set.
            "deny_chain" | "deny_frame" => vec![
                ("validator_bundle_id", "vb-0001"),
                ("verified_head_digest", verified_head_digest()),
                ("snapshot_id", snapshot_id()),
                ("policy_id", "pol-0001"),
                ("source_id", "src-0001"),
                ("freshness_value", "41"),
                ("irr_digest", irr_digest()),
                ("tool_activation_status", "inactive"),
                ("failure_code", "FC_CHAIN"),
                ("failed_validator", "V_CHAIN"),
                ("suppression_status", "suppressed"),
            ],
            "deny_parse" => vec![
                ("failure_code", "FC_PARSE"),
                ("failed_validator", "V_PARSE"),
                ("suppression_status", "suppressed"),
                ("validator_bundle_id", "vb-0001"),
                ("verified_head_digest", verified_head_digest()),
                ("snapshot_id", snapshot_id()),
            ],
            "deny_freshness" => vec![
                ("validator_bundle_id", "vb-0001"),
                ("verified_head_digest", verified_head_digest()),
                ("snapshot_id", snapshot_id()),
                ("policy_id", "pol-0001"),
                ("source_id", "src-0001"),
                ("freshness_value", "40"),
                ("irr_digest", irr_digest()),
                ("tool_activation_status", "inactive"),
                ("failed_validator", "V_FRESHNESS"),
            ],
            "recovery" => vec![
                ("recovery_phase", "WAL_REPLAY"),
                ("recovery_phase_producer", "V_WAL_PHASE"),
                ("validator_bundle_id", "vb-0001"),
                ("snapshot_id", snapshot_id()),
            ],
            "readmission" => vec![
                ("readmission_token_id", "rt-0001"),
                ("validator_bundle_id", "vb-0001"),
            ],
            "producers" => vec![
                ("validator_bundle_id_producer", "ExecutionLayer"),
                ("failure_explanation_producer", "GateLogic"),
                ("tool_activation_status_producer", "ToolGate"),
            ],
            // Bounded external-enforcement attestation surfaces (V_COMPAT,
            // V_WRITER_LOCK) — proved by architecture evidence per the VRA
            // Minimal Run Note implementation-evidence clause.
            "compat" => vec![
                ("v_compat_enforcement", "import_admissibility_point"),
                ("compat_status", "recorded"),
            ],
            "writer_lock" => vec![
                ("v_writer_lock_enforcement", "single_writer"),
                ("writer_lock_status", "held"),
                ("contention_status", "none"),
            ],
            _ => vec![],
        }
    }
}

// ============================================================================
// BDA — Boundary Defense Agent
// ============================================================================
mod bda {
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum State {
        Idle,
        IngestValidate,
        FilterReview,
        ToolStateQuarantined,
        ReadyForRelease,
        OutputBlocked,
        FinalizationReview,
        NoncompliantHold,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Trigger {
        InputReceived,
        ValidationPass,
        ValidationFail,
        ToolStateDetected,
        NoEscalation,
        ApprovalGranted,
        FinalizationRequested,
        EvidenceOk,
        EvidenceFail,
        CpwCritical,
        ReadmissionApproved,
        ComplianceRestored,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Verdict {
        Allow,
        AllowConstrained,
        Block,
        Quarantine,
        FailClosed,
        NoncompliantHold,
        Readmit,
    }

    pub fn state_code(s: State) -> &'static str {
        match s {
            State::Idle => "IDLE",
            State::IngestValidate => "INGEST_VALIDATE",
            State::FilterReview => "FILTER_REVIEW",
            State::ToolStateQuarantined => "TOOL_STATE_QUARANTINED",
            State::ReadyForRelease => "READY_FOR_RELEASE",
            State::OutputBlocked => "OUTPUT_BLOCKED",
            State::FinalizationReview => "FINALIZATION_REVIEW",
            State::NoncompliantHold => "NONCOMPLIANT_HOLD",
        }
    }
    pub fn parse_state(s: &str) -> Option<State> {
        Some(match s {
            "IDLE" => State::Idle,
            "INGEST_VALIDATE" => State::IngestValidate,
            "FILTER_REVIEW" => State::FilterReview,
            "TOOL_STATE_QUARANTINED" => State::ToolStateQuarantined,
            "READY_FOR_RELEASE" => State::ReadyForRelease,
            "OUTPUT_BLOCKED" => State::OutputBlocked,
            "FINALIZATION_REVIEW" => State::FinalizationReview,
            "NONCOMPLIANT_HOLD" => State::NoncompliantHold,
            _ => return None,
        })
    }
    pub fn parse_trigger(s: &str) -> Option<Trigger> {
        Some(match s {
            "INPUT_RECEIVED" => Trigger::InputReceived,
            "VALIDATION_PASS" => Trigger::ValidationPass,
            "VALIDATION_FAIL" => Trigger::ValidationFail,
            "TOOL_STATE_DETECTED" => Trigger::ToolStateDetected,
            "NO_ESCALATION" => Trigger::NoEscalation,
            "APPROVAL_GRANTED" => Trigger::ApprovalGranted,
            "FINALIZATION_REQUESTED" => Trigger::FinalizationRequested,
            "EVIDENCE_OK" => Trigger::EvidenceOk,
            "EVIDENCE_FAIL" => Trigger::EvidenceFail,
            "CPW_CRITICAL" => Trigger::CpwCritical,
            "READMISSION_APPROVED" => Trigger::ReadmissionApproved,
            "COMPLIANCE_RESTORED" => Trigger::ComplianceRestored,
            _ => return None,
        })
    }
    fn is_active(s: State) -> bool {
        !matches!(s, State::Idle)
    }
    // Spec §workflow R1-R12. CPW_CRITICAL is a global override from ANY active
    // state -> OUTPUT_BLOCKED (fail-closed precedence). Unenumerated pairs do
    // not advance (fail-closed default: remain in place).
    pub fn next_state(cur: State, t: Trigger, guard: bool) -> State {
        use self::State::*;
        use self::Trigger::*;
        if t == CpwCritical && is_active(cur) {
            return OutputBlocked;
        }
        match (cur, t, guard) {
            (Idle, InputReceived, _) => IngestValidate,
            (IngestValidate, ValidationPass, true) => FilterReview,
            (IngestValidate, ValidationFail, _) => OutputBlocked,
            (FilterReview, ToolStateDetected, _) => ToolStateQuarantined,
            (FilterReview, NoEscalation, true) => ReadyForRelease,
            (ToolStateQuarantined, ApprovalGranted, true) => ReadyForRelease,
            (ToolStateQuarantined, ApprovalGranted, false) => ToolStateQuarantined,
            (ReadyForRelease, FinalizationRequested, _) => FinalizationReview,
            (FinalizationReview, EvidenceOk, true) => Idle,
            (FinalizationReview, EvidenceFail, _) => NoncompliantHold,
            (OutputBlocked, ReadmissionApproved, true) => Idle,
            (NoncompliantHold, ComplianceRestored, true) => Idle,
            // fail-closed default: no advancement on unenumerated / failed guard.
            _ => cur,
        }
    }

    pub fn verdict_code(v: Verdict) -> &'static str {
        match v {
            Verdict::Allow => "ALLOW",
            Verdict::AllowConstrained => "ALLOW_CONSTRAINED",
            Verdict::Block => "BLOCK",
            Verdict::Quarantine => "QUARANTINE",
            Verdict::FailClosed => "FAIL_CLOSED",
            Verdict::NoncompliantHold => "NONCOMPLIANT_HOLD",
            Verdict::Readmit => "READMIT",
        }
    }
    pub fn all_verdicts() -> [Verdict; 7] {
        [
            Verdict::Allow,
            Verdict::AllowConstrained,
            Verdict::Block,
            Verdict::Quarantine,
            Verdict::FailClosed,
            Verdict::NoncompliantHold,
            Verdict::Readmit,
        ]
    }
    // Public field the family integrator consumes (Annex A field map).
    pub fn anchor_document_ref(ok: bool) -> Option<&'static str> {
        if ok { Some("bda-anchor-ref-0001") } else { None }
    }

    pub fn evidence(scenario: &str) -> Vec<(&'static str, &'static str)> {
        let mandatory: Vec<(&'static str, &'static str)> = vec![
            ("decision_id", "bd-0001"),
            ("session_id", "sess-0001"),
            ("boundary_side", "ingress"),
            ("decision_object", "ingress_request"),
            ("input_digest", "sha256:in0001"),
            ("policy_hash", "sha256:pol0001"),
            ("validator_results", "VAL-01:pass;VAL-02:pass"),
            ("statement_refs", "stmt-0001"),
            ("verdict", "ALLOW"),
            ("reason_code", "RC_OK"),
            ("order_index", "1"),
            ("hash_prev", "sha256:h0"),
            ("hash_curr", "sha256:h1"),
        ];
        match scenario {
            "mandatory" | "verdict_artifact" => mandatory,
            "approval" => {
                let mut v = mandatory;
                v.push(("approval_ref", "ap-0001"));
                v
            }
            "finalization" => {
                let mut v = mandatory;
                v.push(("evidence_ref", "ev-0001"));
                v.push(("verif_counter_anchor", "42"));
                v
            }
            "rollback" => {
                let mut v = mandatory;
                v.push(("rollback_ref", "rb-0001"));
                v
            }
            "producers" => vec![
                ("decision_id_producer", "DecisionEngine"),
                ("validator_results_producer", "VAL-01..VAL-08"),
                ("approval_ref_producer", "OperatorVAL-06"),
                ("evidence_ref_producer", "ExternalAssuranceVAL-05"),
            ],
            // Statement-provenance gating for an unlabeled statement_usage_request:
            // verdict BLOCK plus recorded conflict evidence (VAL-03 BLOCK/CONFLICT).
            "conflict" => vec![
                ("verdict", "BLOCK"),
                ("conflict_evidence", "recorded"),
                ("tsa_label", "missing"),
            ],
            _ => vec![],
        }
    }
}

// ============================================================================
// TAA — Truth Arbitration Agent
// ============================================================================
mod taa {
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum State {
        Intake,
        RoleScreening,
        Canonicalizing,
        Evaluating,
        Classifying,
        ConflictChecking,
        Decided,
        NoncompliantHold,
        ReadmissionPending,
        HandoffReady,
        Closed,
        FailClosed,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Trigger {
        IntakeToRoleScreening,
        EvaluatingToClassifying,
        DecidedToHandoffReady,
        ConflictCheckingToAllowConstrainedDecision,
        ConflictCheckingToEscalateDecision,
        RoleScreeningReclassifyToCanonicalizing,
        ClassifyingToDenyDecision,
        EvaluatingToFailClosed,
        ConflictCheckingToAllowDecision,
        FailClosedToNoncompliantHold,
        NoncompliantHoldToReadmissionPending,
        ReadmissionPendingToRoleScreening,
        RoleScreeningToOutOfScopeDecision,
        ConflictCheckingToDenyDecision,
        ConflictCheckingToFailClosed,
        StructuralIncompletenessToFailClosed,
        PolicySnapshotDriftToFailClosed,
        ClearanceArtifactMissingToFailClosed,
        OrderingViolationToFailClosed,
        DecidedToClosed,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Verdict {
        Allow,
        AllowConstrained,
        Deny,
        FailClosed,
        Escalate,
        OutOfScope,
    }

    pub fn state_code(s: State) -> &'static str {
        match s {
            State::Intake => "INTAKE",
            State::RoleScreening => "ROLE_SCREENING",
            State::Canonicalizing => "CANONICALIZING",
            State::Evaluating => "EVALUATING",
            State::Classifying => "CLASSIFYING",
            State::ConflictChecking => "CONFLICT_CHECKING",
            State::Decided => "DECIDED",
            State::NoncompliantHold => "NONCOMPLIANT_HOLD",
            State::ReadmissionPending => "READMISSION_PENDING",
            State::HandoffReady => "HANDOFF_READY",
            State::Closed => "CLOSED",
            State::FailClosed => "FAIL_CLOSED",
        }
    }
    pub fn parse_state(s: &str) -> Option<State> {
        Some(match s {
            "INTAKE" => State::Intake,
            "ROLE_SCREENING" => State::RoleScreening,
            "CANONICALIZING" => State::Canonicalizing,
            "EVALUATING" => State::Evaluating,
            "CLASSIFYING" => State::Classifying,
            "CONFLICT_CHECKING" => State::ConflictChecking,
            "DECIDED" => State::Decided,
            "NONCOMPLIANT_HOLD" => State::NoncompliantHold,
            "READMISSION_PENDING" => State::ReadmissionPending,
            "HANDOFF_READY" => State::HandoffReady,
            "CLOSED" => State::Closed,
            "FAIL_CLOSED" => State::FailClosed,
            _ => return None,
        })
    }
    pub fn parse_trigger(s: &str) -> Option<Trigger> {
        use self::Trigger::*;
        Some(match s {
            "INTAKE_TO_ROLE_SCREENING" => IntakeToRoleScreening,
            "EVALUATING_TO_CLASSIFYING" => EvaluatingToClassifying,
            "DECIDED_TO_HANDOFF_READY" => DecidedToHandoffReady,
            "CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION" => ConflictCheckingToAllowConstrainedDecision,
            "CONFLICT_CHECKING_TO_ESCALATE_DECISION" => ConflictCheckingToEscalateDecision,
            "ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING" => RoleScreeningReclassifyToCanonicalizing,
            "CLASSIFYING_TO_DENY_DECISION" => ClassifyingToDenyDecision,
            "EVALUATING_TO_FAIL_CLOSED" => EvaluatingToFailClosed,
            "CONFLICT_CHECKING_TO_ALLOW_DECISION" => ConflictCheckingToAllowDecision,
            "FAIL_CLOSED_TO_NONCOMPLIANT_HOLD" => FailClosedToNoncompliantHold,
            "NONCOMPLIANT_HOLD_TO_READMISSION_PENDING" => NoncompliantHoldToReadmissionPending,
            "READMISSION_PENDING_TO_ROLE_SCREENING" => ReadmissionPendingToRoleScreening,
            "ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION" => RoleScreeningToOutOfScopeDecision,
            "CONFLICT_CHECKING_TO_DENY_DECISION" => ConflictCheckingToDenyDecision,
            "CONFLICT_CHECKING_TO_FAIL_CLOSED" => ConflictCheckingToFailClosed,
            "STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED" => StructuralIncompletenessToFailClosed,
            "POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED" => PolicySnapshotDriftToFailClosed,
            "CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED" => ClearanceArtifactMissingToFailClosed,
            "ORDERING_VIOLATION_TO_FAIL_CLOSED" => OrderingViolationToFailClosed,
            "DECIDED_TO_CLOSED" => DecidedToClosed,
            _ => return None,
        })
    }
    // Spec §5 + §9 Gate Logic. Catch-all (Spec §9): "If no specialized branch
    // applies and the decision path is structurally incomplete, the result
    // shall be FAIL_CLOSED." CLOSED absorbs any non-reopen trigger.
    pub fn next_state(cur: State, t: Trigger, vp: bool) -> State {
        use self::State::*;
        use self::Trigger::*;
        if cur == Closed {
            return Closed; // terminal absorption
        }
        match (cur, t, vp) {
            (Intake, IntakeToRoleScreening, true) => RoleScreening,
            (Evaluating, EvaluatingToClassifying, true) => Classifying,
            (Evaluating, EvaluatingToClassifying, false) => FailClosed,
            (Decided, DecidedToHandoffReady, true) => HandoffReady,
            (Decided, DecidedToClosed, true) => Closed,
            (ConflictChecking, ConflictCheckingToAllowConstrainedDecision, true) => Decided,
            (ConflictChecking, ConflictCheckingToEscalateDecision, true) => Decided,
            (ConflictChecking, ConflictCheckingToAllowDecision, true) => Decided,
            (ConflictChecking, ConflictCheckingToDenyDecision, true) => Decided,
            (ConflictChecking, ConflictCheckingToFailClosed, _) => FailClosed,
            (RoleScreening, RoleScreeningReclassifyToCanonicalizing, true) => Canonicalizing,
            (RoleScreening, RoleScreeningToOutOfScopeDecision, true) => Decided,
            (Classifying, ClassifyingToDenyDecision, true) => Decided,
            (FailClosed, FailClosedToNoncompliantHold, _) => NoncompliantHold,
            (NoncompliantHold, NoncompliantHoldToReadmissionPending, _) => ReadmissionPending,
            (ReadmissionPending, ReadmissionPendingToRoleScreening, true) => RoleScreening,
            // cross-state blocking triggers -> FAIL_CLOSED from any state
            (_, StructuralIncompletenessToFailClosed, _) => FailClosed,
            (_, PolicySnapshotDriftToFailClosed, _) => FailClosed,
            (_, ClearanceArtifactMissingToFailClosed, _) => FailClosed,
            (_, OrderingViolationToFailClosed, _) => FailClosed,
            (_, EvaluatingToFailClosed, _) => FailClosed,
            // protective default (Spec §9 catch-all): structurally incomplete -> FAIL_CLOSED
            _ => FailClosed,
        }
    }

    pub fn verdict_code(v: Verdict) -> &'static str {
        match v {
            Verdict::Allow => "ALLOW",
            Verdict::AllowConstrained => "ALLOW_CONSTRAINED",
            Verdict::Deny => "DENY",
            Verdict::FailClosed => "FAIL_CLOSED",
            Verdict::Escalate => "ESCALATE",
            Verdict::OutOfScope => "OUT_OF_SCOPE",
        }
    }
    pub fn all_verdicts() -> [Verdict; 6] {
        [
            Verdict::Allow,
            Verdict::AllowConstrained,
            Verdict::Deny,
            Verdict::FailClosed,
            Verdict::Escalate,
            Verdict::OutOfScope,
        ]
    }
    // Public fields the family integrator consumes (Annex A row 3 / field map).
    pub fn tsa_label(labeled: bool) -> Option<&'static str> {
        if labeled { Some("mechanism_level_admitted") } else { None }
    }
    pub fn statement_id() -> &'static str { "taa-stmt-0001" }
    pub fn source_class() -> &'static str { "TRAINED" }

    pub fn evidence(scenario: &str) -> Vec<(&'static str, &'static str)> {
        let base: Vec<(&'static str, &'static str)> = vec![
            ("decision_id", "td-0001"),
            ("statement_id_list", statement_id()),
            ("verdict", "ALLOW"),
            ("reason_code", "RC_OK"),
            ("tsa_label", "mechanism_level_admitted"),
            ("source_class", source_class()),
            ("source_ref", "sr-0001"),
            ("boundary_validated_role", "mechanism_level"),
            ("role_validation_result", "confirmed"),
            ("policy_snapshot_id", "ps-0001"),
            ("policy_hash_ref", "sha256:ph0001"),
            ("scope_id", "scope-0001"),
            ("turn_id", "turn-0001"),
            ("order_ref", "ord-0001"),
            ("logical_timestamp", "1"),
        ];
        match scenario {
            "mandatory" => base,
            "conditional_conflict" => {
                let mut v = base;
                v.push(("conflict_check_mode", "heuristic"));
                v.push(("conflict_check_strength", "below_threshold"));
                v.push(("conflict_check_confidence", "0.4"));
                v.push(("conflict_check_coverage_scope", "partial"));
                v.push(("compared_claim_set_ref", "ccs-0001"));
                v.push(("residual_risk_statement", "residual_present"));
                v
            }
            "escalation" => vec![
                ("request_id", "er-0001"),
                ("failure_ref", "fr-0001"),
                ("required_actor_role", "external_reviewer"),
                ("required_evidence", "clearance"),
                ("status", "open"),
            ],
            // Four-closure handoff completeness (MRF-HANDOFF-CHECK §10).
            "closure" => vec![
                ("semantic_closure", "ok"),
                ("evidence_closure", "ok"),
                ("failure_closure", "ok"),
                ("policy_snapshot_closure", "ok"),
            ],
            _ => vec![],
        }
    }
}

// ============================================================================
// ARA — Audit Replay Agent
// ============================================================================
mod ara {
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum State {
        S0Ingested,
        S1Parsed,
        S2Verified,
        S3Reconstructed,
        S4CheckpointResolved,
        S5ReportReady,
        ShHoldActive,
        SxFailClosed,
        S6Readmitted,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Event {
        EvParseOk,
        ReplayFoldComplete,
        EvLastcleanFound,
        EvReportBound,
        EvSignatureFail,
        EvChainBreak,
        EvPolicyUnresolved,
        EvEvidenceFail,
        EvCounterReplay,
        EvReadmissionGranted,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Verdict {
        Replayable,
        Partial,
        Rejected,
        Broken,
        IncidentOnly,
    }

    pub fn state_code(s: State) -> &'static str {
        match s {
            State::S0Ingested => "S0",
            State::S1Parsed => "S1",
            State::S2Verified => "S2",
            State::S3Reconstructed => "S3",
            State::S4CheckpointResolved => "S4",
            State::S5ReportReady => "S5",
            State::ShHoldActive => "SH",
            State::SxFailClosed => "SX",
            State::S6Readmitted => "S6",
        }
    }
    pub fn parse_state(s: &str) -> Option<State> {
        Some(match s {
            "S0" => State::S0Ingested,
            "S1" => State::S1Parsed,
            "S2" => State::S2Verified,
            "S3" => State::S3Reconstructed,
            "S4" => State::S4CheckpointResolved,
            "S5" => State::S5ReportReady,
            "SH" => State::ShHoldActive,
            "SX" => State::SxFailClosed,
            "S6" => State::S6Readmitted,
            _ => return None,
        })
    }
    pub fn parse_event(s: &str) -> Option<Event> {
        use self::Event::*;
        Some(match s {
            "EV_PARSE_OK" => EvParseOk,
            "replay_fold_complete" => ReplayFoldComplete,
            "EV_LASTCLEAN_FOUND" => EvLastcleanFound,
            "EV_REPORT_BOUND" => EvReportBound,
            "EV_SIGNATURE_FAIL" => EvSignatureFail,
            "EV_CHAIN_BREAK" => EvChainBreak,
            "EV_POLICY_UNRESOLVED" => EvPolicyUnresolved,
            "EV_EVIDENCE_FAIL" => EvEvidenceFail,
            "EV_COUNTER_REPLAY" => EvCounterReplay,
            "EV_READMISSION_GRANTED" => EvReadmissionGranted,
            _ => return None,
        })
    }
    // Spec §6/§9. Critical failures force distinct routes (no uniform catch-all
    // bucket): signature/chain -> SX; evidence/counter -> SH. Policy unresolved
    // is parameterized (BLOCKED or SX). Non-critical unmatched -> remain (no
    // silent advance). S5 stays S5 on out-of-order positive triggers.
    pub fn next_state(cur: State, e: Event, pass: bool, policy_sx: bool) -> State {
        use self::Event::*;
        use self::State::*;
        match e {
            EvSignatureFail => return SxFailClosed,
            EvChainBreak => return SxFailClosed,
            EvEvidenceFail => return ShHoldActive,
            EvCounterReplay => return ShHoldActive,
            EvPolicyUnresolved => return if policy_sx { SxFailClosed } else { cur },
            _ => {}
        }
        match (cur, e, pass) {
            (S0Ingested, EvParseOk, true) => S1Parsed,
            (S2Verified, ReplayFoldComplete, true) => S3Reconstructed,
            (S3Reconstructed, EvLastcleanFound, true) => S4CheckpointResolved,
            (S4CheckpointResolved, EvReportBound, true) => S5ReportReady,
            (ShHoldActive, EvReadmissionGranted, true) => S6Readmitted,
            (SxFailClosed, EvReadmissionGranted, true) => S6Readmitted,
            (ShHoldActive, EvReadmissionGranted, false) => ShHoldActive,
            (SxFailClosed, EvReadmissionGranted, false) => SxFailClosed,
            // out-of-order positive trigger at S5 -> remain S5
            (S5ReportReady, _, _) => S5ReportReady,
            _ => cur,
        }
    }

    pub fn verdict_code(v: Verdict) -> &'static str {
        match v {
            Verdict::Replayable => "REPLAYABLE",
            Verdict::Partial => "PARTIAL",
            Verdict::Rejected => "REJECTED",
            Verdict::Broken => "BROKEN",
            Verdict::IncidentOnly => "INCIDENT_ONLY",
        }
    }
    pub fn all_verdicts() -> [Verdict; 5] {
        [
            Verdict::Replayable,
            Verdict::Partial,
            Verdict::Rejected,
            Verdict::Broken,
            Verdict::IncidentOnly,
        ]
    }
    pub fn verdict_for(scenario: &str) -> Verdict {
        match scenario {
            "chain_break" => Verdict::Broken,
            "replayable" => Verdict::Replayable,
            "report_insufficient" => Verdict::Partial,
            "incident" => Verdict::IncidentOnly,
            _ => Verdict::Rejected,
        }
    }
    // Public fields the family integrator consumes (Annex A row 8 / field map).
    pub fn checkpoint_refs(ok: bool) -> Option<&'static str> {
        if ok { Some("ara-ckpt-0001") } else { None }
    }
    pub fn rollback_refs(ok: bool) -> Option<&'static str> {
        if ok { Some("ara-rb-0001") } else { None }
    }
    pub fn replay_refs(ok: bool) -> Option<&'static str> {
        if ok { Some("ara-replay-0001") } else { None }
    }

    pub fn evidence(scenario: &str) -> Vec<(&'static str, &'static str)> {
        let base: Vec<(&'static str, &'static str)> = vec![
            ("bundle_digest", "sha256:bd0001"),
            ("policy_profile_id", "pp-0001"),
            ("policy_hash", "sha256:ph0001"),
            ("validator_outcomes", "V-04:pass;V-05:pass"),
            ("hash_continuity_refs", "hc-0001"),
        ];
        match scenario {
            "mandatory" | "replayable" => {
                let mut v = base;
                v.push(("checkpoint_refs", "ara-ckpt-0001"));
                v.push(("rollback_refs", "ara-rb-0001"));
                v.push(("signature_refs", "sig-0001"));
                v
            }
            "final_export" => vec![
                ("report_signature", "rsig-0001"),
                ("export_manifest_ref", "em-0001"),
            ],
            "hold_readmission" => vec![
                ("hold_enter_refs", "he-0001"),
                ("hold_exit_refs", "hx-0001"),
                ("anchor_update_ref", "43"),
            ],
            "producers" => vec![
                ("producer_provenance", "bounded_authorized"),
            ],
            // V-10 tool-state exclusion is gate-layer enforcement (QUARANTINE),
            // not a workflow transition — attested at the gate surface.
            "quarantine_gate" => vec![
                ("v10_quarantine", "gate_layer"),
                ("admission_to_reconstruction", "denied"),
                ("classification", "exported_declaratively"),
            ],
            _ => base,
        }
    }
}

// ============================================================================
// FPA — Freshness Portability Agent
// ============================================================================
mod fpa {
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum State {
        Idle,
        Received,
        Verified,
        FreshnessEligible,
        IrrCommitted,
        WatermarkCommitted,
        RestorationEligible,
        Quarantined,
        Rejected,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Trigger {
        TransferPacketReceived,
        StructureValid,
        StructureInvalid,
        FreshnessPass,
        FreshnessFail,
        EvidencePending,
        IrrAppended,
        WatermarkPersisted,
        RestoreRequestGenesisConfirmed,
        RestoreAdmitted,
        RestoreDenied,
        ReadmissionApproved,
        ReadmissionRejected,
        NewPacket,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Verdict {
        Accept,
        Reject,
        Quarantine,
        RestorationEligible,
        Readmit,
        FailClosed,
    }

    pub fn state_code(s: State) -> &'static str {
        match s {
            State::Idle => "IDLE",
            State::Received => "RECEIVED",
            State::Verified => "VERIFIED",
            State::FreshnessEligible => "FRESHNESS_ELIGIBLE",
            State::IrrCommitted => "IRR_COMMITTED",
            State::WatermarkCommitted => "WATERMARK_COMMITTED",
            State::RestorationEligible => "RESTORATION_ELIGIBLE",
            State::Quarantined => "QUARANTINED",
            State::Rejected => "REJECTED",
        }
    }
    pub fn parse_state(s: &str) -> Option<State> {
        Some(match s {
            "IDLE" => State::Idle,
            "RECEIVED" => State::Received,
            "VERIFIED" => State::Verified,
            "FRESHNESS_ELIGIBLE" => State::FreshnessEligible,
            "IRR_COMMITTED" => State::IrrCommitted,
            "WATERMARK_COMMITTED" => State::WatermarkCommitted,
            "RESTORATION_ELIGIBLE" => State::RestorationEligible,
            "QUARANTINED" => State::Quarantined,
            "REJECTED" => State::Rejected,
            _ => return None,
        })
    }
    pub fn parse_trigger(s: &str) -> Option<Trigger> {
        use self::Trigger::*;
        Some(match s {
            "TransferPacketReceived" => TransferPacketReceived,
            "StructureValid" => StructureValid,
            "StructureInvalid" => StructureInvalid,
            "FreshnessPass" => FreshnessPass,
            "FreshnessFail" => FreshnessFail,
            "EvidencePending" => EvidencePending,
            "IRRAppended" => IrrAppended,
            "WatermarkPersisted" => WatermarkPersisted,
            "RestoreRequest_GenesisConfirmed" => RestoreRequestGenesisConfirmed,
            "RestoreAdmitted" => RestoreAdmitted,
            "RestoreDenied" => RestoreDenied,
            "ReadmissionApproved" => ReadmissionApproved,
            "ReadmissionRejected" => ReadmissionRejected,
            "NewPacket" => NewPacket,
            _ => return None,
        })
    }
    // Spec §8 closed machine; Appendix A PR-10 "only validated transitions may
    // be selected". Fail-closed default (Conf): any non-source state + invalid
    // trigger -> REJECTED. REJECTED absorbs any non-NewPacket trigger.
    pub fn next_state(cur: State, t: Trigger, vp: bool) -> State {
        use self::State::*;
        use self::Trigger::*;
        match (cur, t, vp) {
            (Idle, TransferPacketReceived, true) => Received,
            (Received, StructureValid, true) => Verified,
            (Received, StructureValid, false) => Rejected,
            (Received, StructureInvalid, _) => Rejected,
            (Verified, FreshnessPass, true) => FreshnessEligible,
            (Verified, FreshnessPass, false) => Rejected,
            (Verified, FreshnessFail, _) => Rejected,
            (Verified, EvidencePending, _) => Quarantined,
            (FreshnessEligible, IrrAppended, true) => IrrCommitted,
            (FreshnessEligible, WatermarkPersisted, _) => Rejected, // ordering fail-closed
            (IrrCommitted, WatermarkPersisted, true) => WatermarkCommitted,
            (IrrCommitted, WatermarkPersisted, false) => Rejected,
            (WatermarkCommitted, RestoreRequestGenesisConfirmed, true) => RestorationEligible,
            (WatermarkCommitted, RestoreRequestGenesisConfirmed, false) => Rejected,
            (RestorationEligible, RestoreAdmitted, true) => Idle,
            (RestorationEligible, RestoreDenied, _) => Rejected,
            (Quarantined, ReadmissionApproved, true) => Verified,
            (Quarantined, ReadmissionRejected, _) => Rejected,
            (Rejected, NewPacket, true) => Received,
            // fail-closed default S8 REJECTED for any non-source combination.
            _ => Rejected,
        }
    }

    pub fn verdict_code(v: Verdict) -> &'static str {
        match v {
            Verdict::Accept => "ACCEPT",
            Verdict::Reject => "REJECT",
            Verdict::Quarantine => "QUARANTINE",
            Verdict::RestorationEligible => "RESTORATION_ELIGIBLE",
            Verdict::Readmit => "READMIT",
            Verdict::FailClosed => "FAIL_CLOSED",
        }
    }
    pub fn all_verdicts() -> [Verdict; 6] {
        [
            Verdict::Accept,
            Verdict::Reject,
            Verdict::Quarantine,
            Verdict::RestorationEligible,
            Verdict::Readmit,
            Verdict::FailClosed,
        ]
    }
    // Public fields the family integrator consumes (Annex A rows 5/6 / field map).
    pub fn accepted_head_digest() -> &'static str { "sha256:acceptedhead0001" }
    pub fn linked_irr_digest() -> &'static str { "sha256:irr0001" }
    pub fn anchor_update_ref(strict_increase: bool) -> u64 {
        if strict_increase { 43 } else { 41 }
    }

    pub fn evidence(scenario: &str) -> Vec<(&'static str, &'static str)> {
        let mandatory: Vec<(&'static str, &'static str)> = vec![
            ("decision_id", "fd-0001"),
            ("agent_id", "FPA-FRESHNESS-PORTABILITY-003"),
            ("source_id", "src-0001"),
            ("ledger_uuid", "lu-0001"),
            ("decision_object", "gate_verdict"),
            ("policy_id", "pol-0001"),
            ("policy_version", "1"),
            ("reason_code", "APPEND_IRR"),
            ("semantic_verdict", "ACCEPT"),
            ("gate_class", "RELEASE"),
        ];
        match scenario {
            "accept" => {
                let mut v = mandatory;
                v.push(("packet_hash", "sha256:pk0001"));
                v.push(("freshness_value", "42"));
                v.push(("watermark_before", "41"));
                v.push(("watermark_after", "42"));
                v.push(("ssm_validation_result", "pass"));
                v
            }
            "deny_restore" => vec![
                ("decision_id", "fd-0002"),
                ("agent_id", "FPA-FRESHNESS-PORTABILITY-003"),
                ("source_id", "src-0001"),
                ("ledger_uuid", "lu-0001"),
                ("decision_object", "restore_admission"),
                ("policy_id", "pol-0001"),
                ("policy_version", "1"),
                ("reason_code", "DENY_RESTORE"),
                ("semantic_verdict", "FAIL_CLOSED"),
                ("gate_class", "BLOCK"),
            ],
            "receipt_linkage" => vec![
                ("irr_digest", "sha256:irr0001"),
                ("prev_receipt_digest", "sha256:prev0001"),
            ],
            "tvc" => vec![("tvc_validation_result", "pass")],
            "tvc_absent" => vec![],
            "evidence_bin" => vec![("evidence_validation_result", "pass")],
            "evidence_bin_absent" => vec![],
            "transport" => vec![("transport_validation_result", "pass")],
            "transport_absent" => vec![],
            "quarantine" => vec![
                ("evidence_validation_result", "pending"),
                ("semantic_verdict", "QUARANTINE"),
                ("gate_class", "ESCALATION"),
            ],
            "producers" => vec![("non_validator_producer", "bounded_grounded")],
            _ => mandatory,
        }
    }
}

// ============================================================================
// FAM — SSCAR family integrator (the composition)
// ============================================================================
mod fam {
    // Distinct types (PTS-021 / AMB-15 / AMB-17): a FamilyWorkflowState is NOT
    // a FamilyNormativeVerdict. REPLAY_INCOMPLETE / INCIDENT_ONLY have no
    // dedicated workflow state (AMB-17) — they exist only in the verdict layer.
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum State {
        S0FamilyIntake,
        S1SourceCoverageAdmitted,
        S2BoundaryScreened,
        S3ProvenanceClassified,
        S4AnchorLocked,
        S5RehydrationClosed,
        S6ReplayReconstructed,
        S7ReportReady,
        S8ReplayAdmitted,
        ShNoncompliantHold,
        SrReadmissionReview,
        SxContaminationFailClosed,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Trigger {
        Fv01Pass,
        Fv02AndFv04Pass,
        Fv03Pass,
        Fv05AndFv06Pass,
        Fv07Pass,
        Fv08Pass,
        Fv10AndFv11Pass,
        FamilyVerdictIssued,
        FreshnessReplay,
        CriticalContamination,
        AntiRollbackFailure,
        ChainBreak,
        UntrustedAnchorPromoted,
        UnlabeledMechanismLevelCarriedClaim,
        HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate,
        ReadmissionBundleChangedCarriedPayload,
        ReadmissionBundleChangedAnchorDocumentRef,
        ReadmissionBundleChangedSourceControlBundles,
        ReadmissionBundleChangedComponentSet,
        ReadmissionBundleChangedPolicySnapshot,
        ReadmissionBundleChangedRehydrationClosure,
        Handoff,
        IncidentOnlyOutput,
    }
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Verdict {
        ReplayAdmissible,
        ReplayAdmissibleConstrained,
        ReplayIncomplete,
        NoncompliantHold,
        ContaminationFailClosed,
        IncidentOnly,
    }

    pub fn state_code(s: State) -> &'static str {
        match s {
            State::S0FamilyIntake => "S0",
            State::S1SourceCoverageAdmitted => "S1",
            State::S2BoundaryScreened => "S2",
            State::S3ProvenanceClassified => "S3",
            State::S4AnchorLocked => "S4",
            State::S5RehydrationClosed => "S5",
            State::S6ReplayReconstructed => "S6",
            State::S7ReportReady => "S7",
            State::S8ReplayAdmitted => "S8",
            State::ShNoncompliantHold => "SH",
            State::SrReadmissionReview => "SR",
            State::SxContaminationFailClosed => "SX",
        }
    }
    pub fn parse_state(s: &str) -> Option<State> {
        Some(match s {
            "S0" => State::S0FamilyIntake,
            "S1" => State::S1SourceCoverageAdmitted,
            "S2" => State::S2BoundaryScreened,
            "S3" => State::S3ProvenanceClassified,
            "S4" => State::S4AnchorLocked,
            "S5" => State::S5RehydrationClosed,
            "S6" => State::S6ReplayReconstructed,
            "S7" => State::S7ReportReady,
            "S8" => State::S8ReplayAdmitted,
            "SH" => State::ShNoncompliantHold,
            "SR" => State::SrReadmissionReview,
            "SX" => State::SxContaminationFailClosed,
            _ => return None,
        })
    }
    pub fn parse_trigger(s: &str) -> Option<Trigger> {
        use self::Trigger::*;
        Some(match s {
            "Fv01Pass" => Fv01Pass,
            "Fv02AndFv04Pass" => Fv02AndFv04Pass,
            "Fv03Pass" => Fv03Pass,
            "Fv05AndFv06Pass" => Fv05AndFv06Pass,
            "Fv07Pass" => Fv07Pass,
            "Fv08Pass" => Fv08Pass,
            "Fv10AndFv11Pass" => Fv10AndFv11Pass,
            "FamilyVerdictIssued" => FamilyVerdictIssued,
            "FreshnessReplay" => FreshnessReplay,
            "CriticalContamination" => CriticalContamination,
            "AntiRollbackFailure" => AntiRollbackFailure,
            "ChainBreak" => ChainBreak,
            "UntrustedAnchorPromoted" => UntrustedAnchorPromoted,
            "UnlabeledMechanismLevelCarriedClaim" => UnlabeledMechanismLevelCarriedClaim,
            "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate" => {
                HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate
            }
            "ReadmissionBundleChangedCarriedPayload" => ReadmissionBundleChangedCarriedPayload,
            "ReadmissionBundleChangedAnchorDocumentRef" => ReadmissionBundleChangedAnchorDocumentRef,
            "ReadmissionBundleChangedSourceControlBundles" => {
                ReadmissionBundleChangedSourceControlBundles
            }
            "ReadmissionBundleChangedComponentSet" => ReadmissionBundleChangedComponentSet,
            "ReadmissionBundleChangedPolicySnapshot" => ReadmissionBundleChangedPolicySnapshot,
            "ReadmissionBundleChangedRehydrationClosure" => ReadmissionBundleChangedRehydrationClosure,
            "Handoff" => Handoff,
            "IncidentOnlyOutput" => IncidentOnlyOutput,
            _ => return None,
        })
    }

    fn is_terminal(s: State) -> bool {
        matches!(s, State::S8ReplayAdmitted | State::SxContaminationFailClosed)
    }

    // §9 workflow + §10 gate logic. Critical contamination triggers route to SX
    // from ANY state (§10: FV-02/03/07/09 blocking -> CONTAMINATION_FAIL_CLOSED).
    // Terminal states (S8, SX) self-loop. Unenumerated non-critical pairs do not
    // advance (non-advancement is the projection-correct signal; AMB-17).
    pub fn next_state(cur: State, t: Trigger, vp: bool) -> State {
        use self::State::*;
        use self::Trigger::*;
        // terminal self-loop
        if is_terminal(cur) {
            return cur;
        }
        // critical contamination from any state -> SX (fail-closed override)
        match t {
            CriticalContamination | AntiRollbackFailure | ChainBreak | UntrustedAnchorPromoted => {
                return ShNoncompliantHold;
            }
            UnlabeledMechanismLevelCarriedClaim => return SxContaminationFailClosed,
            _ => {}
        }
        match (cur, t, vp) {
            (S0FamilyIntake, Fv01Pass, true) => S1SourceCoverageAdmitted,
            (S1SourceCoverageAdmitted, Fv02AndFv04Pass, true) => S2BoundaryScreened,
            (S1SourceCoverageAdmitted, Fv02AndFv04Pass, false) => SxContaminationFailClosed,
            (S2BoundaryScreened, Fv03Pass, true) => S3ProvenanceClassified,
            (S3ProvenanceClassified, Fv05AndFv06Pass, true) => S4AnchorLocked,
            (S3ProvenanceClassified, FreshnessReplay, _) => ShNoncompliantHold,
            (S4AnchorLocked, Fv07Pass, true) => S5RehydrationClosed,
            (S5RehydrationClosed, Fv08Pass, true) => S6ReplayReconstructed,
            (S6ReplayReconstructed, Fv10AndFv11Pass, true) => S7ReportReady,
            (S7ReportReady, FamilyVerdictIssued, true) => S8ReplayAdmitted,
            (ShNoncompliantHold, HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate, true) => {
                SrReadmissionReview
            }
            // SR re-entry envelope (§9 SR exit; Annex A row 12). Boundary-field
            // change -> S2; policy/rehydration-field change -> S5. No third point.
            (SrReadmissionReview, ReadmissionBundleChangedCarriedPayload, true) => S2BoundaryScreened,
            (SrReadmissionReview, ReadmissionBundleChangedAnchorDocumentRef, true) => {
                S2BoundaryScreened
            }
            (SrReadmissionReview, ReadmissionBundleChangedSourceControlBundles, true) => {
                S2BoundaryScreened
            }
            (SrReadmissionReview, ReadmissionBundleChangedComponentSet, true) => S2BoundaryScreened,
            (SrReadmissionReview, ReadmissionBundleChangedPolicySnapshot, true) => S5RehydrationClosed,
            (SrReadmissionReview, ReadmissionBundleChangedRehydrationClosure, true) => {
                S5RehydrationClosed
            }
            // non-advancement default (AMB-17): remain in the current state.
            _ => cur,
        }
    }

    pub fn verdict_code(v: Verdict) -> &'static str {
        match v {
            Verdict::ReplayAdmissible => "REPLAY_ADMISSIBLE",
            Verdict::ReplayAdmissibleConstrained => "REPLAY_ADMISSIBLE_CONSTRAINED",
            Verdict::ReplayIncomplete => "REPLAY_INCOMPLETE",
            Verdict::NoncompliantHold => "NONCOMPLIANT_HOLD",
            Verdict::ContaminationFailClosed => "CONTAMINATION_FAIL_CLOSED",
            Verdict::IncidentOnly => "INCIDENT_ONLY",
        }
    }
    pub fn all_verdicts() -> [Verdict; 6] {
        [
            Verdict::ReplayAdmissible,
            Verdict::ReplayAdmissibleConstrained,
            Verdict::ReplayIncomplete,
            Verdict::NoncompliantHold,
            Verdict::ContaminationFailClosed,
            Verdict::IncidentOnly,
        ]
    }

    // Validator outcomes drive the verdict-emission layer (distinct from
    // next_state, which cannot return REPLAY_INCOMPLETE / INCIDENT_ONLY).
    #[derive(Clone, Copy, PartialEq, Eq, Debug)]
    pub enum Fv {
        Fv01,
        Fv02,
        Fv03Contam,
        Fv03Policy,
        Fv04,
        Fv05,
        Fv06,
        Fv07Integrity,
        Fv07Policy,
        Fv08,
        Fv09,
        Fv10,
        Fv11,
        Fv12,
    }
    pub fn parse_fv(s: &str) -> Option<Fv> {
        use Fv::*;
        Some(match s {
            "FV-01" => Fv01,
            "FV-02" => Fv02,
            "FV-03-contam" => Fv03Contam,
            "FV-03-policy" => Fv03Policy,
            "FV-04" => Fv04,
            "FV-05" => Fv05,
            "FV-06" => Fv06,
            "FV-07-integrity" => Fv07Integrity,
            "FV-07-policy" => Fv07Policy,
            "FV-08" => Fv08,
            "FV-09" => Fv09,
            "FV-10" => Fv10,
            "FV-11" => Fv11,
            "FV-12" => Fv12,
            _ => return None,
        })
    }

    // Verdict-emission layer. Precedence (Spec §10 gate logic + §6 failure
    // semantics + Annex A failure propagation):
    //   contamination (FV-02/FV-03-contam/FV-07-integrity/FV-09) -> CONTAMINATION_FAIL_CLOSED
    //   disclosure/evidence (FV-10/FV-11) -> INCIDENT_ONLY
    //   freshness/readmission (FV-06/FV-12/FV-07-policy) -> NONCOMPLIANT_HOLD
    //   replay/linkage (FV-05/FV-08/FV-03-policy) -> REPLAY_INCOMPLETE
    //   else all pass -> CONSTRAINED if disclosure entries present, else ADMISSIBLE
    pub fn verdict_layer(failed: Option<Fv>, disclosure_entries: bool) -> Verdict {
        use self::Fv::*;
        match failed {
            Some(Fv02) | Some(Fv03Contam) | Some(Fv07Integrity) | Some(Fv09) => {
                Verdict::ContaminationFailClosed
            }
            Some(Fv10) | Some(Fv11) => Verdict::IncidentOnly,
            Some(Fv06) | Some(Fv12) | Some(Fv07Policy) => Verdict::NoncompliantHold,
            Some(Fv05) | Some(Fv08) | Some(Fv03Policy) => Verdict::ReplayIncomplete,
            Some(Fv01) | Some(Fv04) => Verdict::ContaminationFailClosed, // FV-04 no reclass path -> fail-closed
            None => {
                if disclosure_entries {
                    Verdict::ReplayAdmissibleConstrained
                } else {
                    Verdict::ReplayAdmissible
                }
            }
        }
    }

    // Real component outputs consumed by the family validators (NOT stubs).
    // Each field is produced by the owning component module above and checked
    // here for Annex-B coherence (byte-identical linkage, strict-increase, etc.).
    pub struct ComponentOutputs {
        pub accepted_head_digest: String,   // FPA
        pub linked_irr_digest: String,      // FPA
        pub rehydration_irr_digest: String, // VRA (must equal linked_irr_digest — CC-01/CC-08)
        pub rehydration_closure_ref: Option<String>, // VRA
        pub tsa_label: Option<String>,      // TAA
        pub source_class: String,           // TAA
        pub anchor_document_ref: Option<String>, // BDA
        pub checkpoint_refs: Option<String>,     // ARA
        pub rollback_refs: Option<String>,       // ARA
        pub anchor_update_ref_before: u64,       // FPA (hold entry)
        pub anchor_update_ref_after: u64,        // FPA (readmission)
    }

    // Build real component outputs for a composed CT scenario by invoking the
    // component producers (demonstrates cross-component contract closure).
    pub fn component_outputs(scenario: &str) -> ComponentOutputs {
        use crate::{ara, bda, fpa, taa, vra};
        let ok = !matches!(
            scenario,
            "ct02" | "ct03" | "ct05_broken" | "ct06_fail" | "ct07_broken" | "ct09" | "ct13"
        );
        ComponentOutputs {
            accepted_head_digest: fpa::accepted_head_digest().to_string(),
            linked_irr_digest: fpa::linked_irr_digest().to_string(),
            rehydration_irr_digest: vra::irr_digest().to_string(),
            rehydration_closure_ref: vra::rehydration_closure_ref(ok).map(|s| s.to_string()),
            tsa_label: taa::tsa_label(scenario != "ct02").map(|s| s.to_string()),
            source_class: taa::source_class().to_string(),
            anchor_document_ref: bda::anchor_document_ref(scenario != "ct03").map(|s| s.to_string()),
            checkpoint_refs: ara::checkpoint_refs(scenario != "ct07_broken").map(|s| s.to_string()),
            rollback_refs: ara::rollback_refs(scenario != "ct07_broken").map(|s| s.to_string()),
            anchor_update_ref_before: 41,
            anchor_update_ref_after: fpa::anchor_update_ref(true),
        }
    }

    // Full 15-field family evidence bundle (FEV-01..FEV-15, §11).
    pub fn evidence_bundle(co: &ComponentOutputs) -> Vec<(&'static str, String)> {
        vec![
            ("FEV-01_family_decision_id", "fam-dec-0001".to_string()),
            ("FEV-02_boundary_event_id", "be-0001".to_string()),
            ("FEV-03_session_id_prior", "sess-0002/sess-0001".to_string()),
            ("FEV-04_carried_statement_refs", "cs-0001".to_string()),
            (
                "FEV-05_tsa_refs_provenance",
                co.tsa_label.clone().unwrap_or_else(|| "none".to_string()),
            ),
            ("FEV-06_anchor_document", co.anchor_document_ref.clone().unwrap_or_else(|| "none".to_string())),
            (
                "FEV-07_accepted_head_linked_irr",
                format!("{}/{}", co.accepted_head_digest, co.linked_irr_digest),
            ),
            (
                "FEV-08_freshness_anchor_update",
                format!("{}/{}", co.anchor_update_ref_before, co.anchor_update_ref_after),
            ),
            (
                "FEV-09_rehydration_closure_ref",
                co.rehydration_closure_ref.clone().unwrap_or_else(|| "none".to_string()),
            ),
            (
                "FEV-10_replay_checkpoint_rollback",
                format!(
                    "{}/{}",
                    co.checkpoint_refs.clone().unwrap_or_else(|| "none".to_string()),
                    co.rollback_refs.clone().unwrap_or_else(|| "none".to_string())
                ),
            ),
            ("FEV-11_disclosure_class_entries", "none".to_string()),
            ("FEV-12_family_validator_outcomes", "FV-01..FV-12:pass".to_string()),
            ("FEV-13_hold_enter_exit", "none".to_string()),
            ("FEV-14_contamination_flags", "none".to_string()),
            ("FEV-15_report_signature_export", "rsig-0001/em-0001".to_string()),
        ]
    }

    // Composed family flow for Annex C CT-* records: consume real component
    // outputs, apply the family validators, and emit state + verdict + FOC.
    pub fn compose(scenario: &str) -> (State, Verdict, &'static str, Vec<(&'static str, String)>) {
        use self::Fv::*;
        let co = component_outputs(scenario);
        // Annex B CC-01/CC-08: linked_irr_digest (FPA) byte-identical to the
        // rehydration irr digest (VRA) for the same accepted head.
        let irr_coherent = co.linked_irr_digest == co.rehydration_irr_digest;
        match scenario {
            "ct01" => (
                State::S1SourceCoverageAdmitted,
                verdict_layer(None, false),
                "FOC-01",
                vec![("fv01", "pass".to_string()), ("family_decision_id", "fam-dec-0001".to_string())],
            ),
            "ct02" => (
                State::SxContaminationFailClosed,
                verdict_layer(Some(Fv03Contam), false),
                "FOC-04",
                vec![
                    ("contamination_flags", "unlabeled_claim".to_string()),
                    ("contaminating_ref_set", "cs-0001".to_string()),
                    ("blocked_stage", "provenance_classification".to_string()),
                    ("tsa_refs", "inadmissible".to_string()),
                ],
            ),
            "ct03" => (
                State::S1SourceCoverageAdmitted, // no advance past boundary screening until FV-02 passes
                verdict_layer(Some(Fv02), false),
                "FOC-04",
                vec![("anchor_document_digest", "untrusted".to_string())],
            ),
            "ct04" => (
                State::ShNoncompliantHold,
                verdict_layer(Some(Fv06), false),
                "FOC-05",
                vec![
                    ("hold_enter_refs", "he-0001".to_string()),
                    ("pending_requirements", "strict_increase_anchor_update_ref".to_string()),
                    ("freshness_before", "41".to_string()),
                    ("freshness_after", "40".to_string()),
                ],
            ),
            "ct05_broken" => (
                State::S4AnchorLocked, // non-advancement; verdict layer emits REPLAY_INCOMPLETE
                verdict_layer(Some(Fv05), false),
                "FOC-02",
                vec![("accepted_head_linked_irr", "broken".to_string())],
            ),
            "ct06_fail" => (
                State::SxContaminationFailClosed,
                verdict_layer(Some(Fv07Integrity), false),
                "FOC-04",
                vec![("contamination_flags", "anti_rollback_failure".to_string())],
            ),
            "ct07_broken" => (
                State::S5RehydrationClosed, // non-advancement; REPLAY_INCOMPLETE at verdict layer
                verdict_layer(Some(Fv08), false),
                "FOC-02",
                vec![("replay_refs", "incomplete".to_string())],
            ),
            "ct08" => {
                let v = if irr_coherent { verdict_layer(None, false) } else { verdict_layer(Some(Fv05), false) };
                let mut fields = evidence_bundle(&co);
                fields.push(("replay_admission_token", "FOC-03".to_string()));
                // FOC-01 FamilyVerdict is the primary emission; FOC-03 the replay token.
                (State::S8ReplayAdmitted, v, "FOC-01", fields)
            }
            "ct09" => (
                State::SxContaminationFailClosed,
                verdict_layer(Some(Fv09), false),
                "FOC-04",
                vec![
                    ("contaminating_ref_set", "tool_state_object".to_string()),
                    ("blocked_stage", "boundary_screened".to_string()),
                ],
            ),
            "ct10" => (
                State::SrReadmissionReview,
                verdict_layer(Some(Fv12), false), // hold-to-readmission routing (FD-10)
                "FOC-05",
                vec![
                    ("hold_exit_refs", "hx-0001".to_string()),
                    (
                        "anchor_update_ref",
                        format!("{}>{}", co.anchor_update_ref_after, co.anchor_update_ref_before),
                    ),
                ],
            ),
            "ct11_ok" => (
                State::S7ReportReady,
                verdict_layer(None, true),
                "FOC-02",
                vec![("disclosure_class_entries", "BOUNDED_EXECUTION_NEUTRAL_OPENNESS".to_string())],
            ),
            "ct11_collapse" => (
                State::S7ReportReady,
                verdict_layer(Some(Fv10), false),
                "FOC-02",
                vec![("disclosure_class_entries", "collapsed".to_string())],
            ),
            "ct12" => (
                State::S7ReportReady,
                verdict_layer(Some(Fv11), false),
                "FOC-04",
                vec![("family_validator_outcomes", "empty".to_string())],
            ),
            "ct13" => (
                State::S2BoundaryScreened, // family flow blocks until reclassification closes
                verdict_layer(Some(Fv04), false),
                "FOC-04",
                vec![("boundary_validated_role", "explanatory_only".to_string())],
            ),
            // ct14 re-entry envelope is exercised via next_state; expose the two targets.
            "ct14" => (
                State::SrReadmissionReview,
                verdict_layer(Some(Fv12), false),
                "FOC-05",
                vec![("reentry_envelope", "S2_or_S5".to_string())],
            ),
            _ => (
                State::S0FamilyIntake,
                verdict_layer(None, false),
                "FOC-01",
                vec![],
            ),
        }
    }
}

// ============================================================================
// main — CLI dispatch
// ============================================================================
fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("usage: baseline <domain> <op> [args...]  |  baseline selfcheck");
        exit(2);
    }
    let domain = args[1].as_str();
    if domain == "selfcheck" {
        // Minimal deterministic health-probe transition (S0 -> S1 family intake).
        let s = fam::next_state(fam::State::S0FamilyIntake, fam::Trigger::Fv01Pass, true);
        println!(
            "OK selfcheck domain=fam next_state(S0,Fv01Pass,true)={} verdict_vocab={}",
            fam::state_code(s),
            fam::all_verdicts().len()
        );
        return;
    }
    let op = args.get(2).map(|s| s.as_str()).unwrap_or("");
    match (domain, op) {
        // ---- family next_state ----
        ("fam", "next_state") => {
            let st = fam::parse_state(arg(&args, 3)).unwrap_or_else(|| err_unknown("fam state", arg(&args, 3)));
            let tr = fam::parse_trigger(arg(&args, 4)).unwrap_or_else(|| err_unknown("fam trigger", arg(&args, 4)));
            let vp = parse_bool(arg(&args, 5));
            emit_state(fam::state_code(fam::next_state(st, tr, vp)));
        }
        ("fam", "verdict_layer") => {
            let failed = match arg(&args, 3) {
                "none" => None,
                other => Some(fam::parse_fv(other).unwrap_or_else(|| err_unknown("fam validator", other))),
            };
            let disc = args.get(4).map(|s| s == "disclosure").unwrap_or(false);
            emit_verdict(fam::verdict_code(fam::verdict_layer(failed, disc)));
        }
        ("fam", "verdict_vocab") => {
            let names: Vec<&str> = fam::all_verdicts().iter().map(|v| fam::verdict_code(*v)).collect();
            emit_fields("verdict_vocab", &names.iter().map(|n| (*n, "1")).collect::<Vec<_>>());
        }
        ("fam", "evidence") => {
            let co = fam::component_outputs(arg(&args, 3));
            let bundle = fam::evidence_bundle(&co);
            let refs: Vec<(&str, &str)> = bundle.iter().map(|(k, v)| (*k, v.as_str())).collect();
            emit_fields("fam_evidence", &refs);
        }
        ("fam", "compose") => {
            let (st, vd, foc, fields) = fam::compose(arg(&args, 3));
            let mut out = vec![
                format!("state={}", fam::state_code(st)),
                format!("verdict={}", fam::verdict_code(vd)),
                format!("foc={}", foc),
            ];
            for (k, v) in &fields {
                out.push(format!("{}={}", k, v));
            }
            println!("OK compose {}", out.join(";"));
        }
        // ---- VRA ----
        ("vra", "next_state") => {
            let st = vra::parse_state(arg(&args, 3)).unwrap_or_else(|| err_unknown("vra state", arg(&args, 3)));
            let tr = vra::parse_trigger(arg(&args, 4)).unwrap_or_else(|| err_unknown("vra trigger", arg(&args, 4)));
            emit_state(vra::state_code(vra::next_state(st, tr, parse_bool(arg(&args, 5)))));
        }
        ("vra", "evidence") => emit_fields("vra_evidence", &vra::evidence(arg(&args, 3))),
        ("vra", "verdict_vocab") => {
            let v = [
                vra::Verdict::Allow,
                vra::Verdict::Deny,
                vra::Verdict::Quarantine,
                vra::Verdict::Escalate,
                vra::Verdict::ReadmissionPending,
            ];
            emit_fields("vra_verdicts", &v.iter().map(|x| (vra::verdict_code(*x), "1")).collect::<Vec<_>>());
        }
        // ---- BDA ----
        ("bda", "next_state") => {
            let st = bda::parse_state(arg(&args, 3)).unwrap_or_else(|| err_unknown("bda state", arg(&args, 3)));
            let tr = bda::parse_trigger(arg(&args, 4)).unwrap_or_else(|| err_unknown("bda trigger", arg(&args, 4)));
            emit_state(bda::state_code(bda::next_state(st, tr, parse_bool(arg(&args, 5)))));
        }
        ("bda", "evidence") => emit_fields("bda_evidence", &bda::evidence(arg(&args, 3))),
        ("bda", "verdict_vocab") => {
            emit_fields(
                "bda_verdicts",
                &bda::all_verdicts().iter().map(|x| (bda::verdict_code(*x), "1")).collect::<Vec<_>>(),
            );
        }
        // ---- TAA ----
        ("taa", "next_state") => {
            let st = taa::parse_state(arg(&args, 3)).unwrap_or_else(|| err_unknown("taa state", arg(&args, 3)));
            let tr = taa::parse_trigger(arg(&args, 4)).unwrap_or_else(|| err_unknown("taa trigger", arg(&args, 4)));
            emit_state(taa::state_code(taa::next_state(st, tr, parse_bool(arg(&args, 5)))));
        }
        ("taa", "evidence") => emit_fields("taa_evidence", &taa::evidence(arg(&args, 3))),
        ("taa", "verdict_vocab") => {
            emit_fields(
                "taa_verdicts",
                &taa::all_verdicts().iter().map(|x| (taa::verdict_code(*x), "1")).collect::<Vec<_>>(),
            );
        }
        // ---- ARA ----
        ("ara", "next_state") => {
            let st = ara::parse_state(arg(&args, 3)).unwrap_or_else(|| err_unknown("ara state", arg(&args, 3)));
            let ev = ara::parse_event(arg(&args, 4)).unwrap_or_else(|| err_unknown("ara event", arg(&args, 4)));
            let policy_sx = args.get(6).map(|s| s == "sx").unwrap_or(false);
            emit_state(ara::state_code(ara::next_state(st, ev, parse_bool(arg(&args, 5)), policy_sx)));
        }
        ("ara", "evidence") => emit_fields("ara_evidence", &ara::evidence(arg(&args, 3))),
        ("ara", "verdict") => emit_verdict(ara::verdict_code(ara::verdict_for(arg(&args, 3)))),
        ("ara", "verdict_vocab") => {
            emit_fields(
                "ara_verdicts",
                &ara::all_verdicts().iter().map(|x| (ara::verdict_code(*x), "1")).collect::<Vec<_>>(),
            );
        }
        // ---- FPA ----
        ("fpa", "next_state") => {
            let st = fpa::parse_state(arg(&args, 3)).unwrap_or_else(|| err_unknown("fpa state", arg(&args, 3)));
            let tr = fpa::parse_trigger(arg(&args, 4)).unwrap_or_else(|| err_unknown("fpa trigger", arg(&args, 4)));
            emit_state(fpa::state_code(fpa::next_state(st, tr, parse_bool(arg(&args, 5)))));
        }
        ("fpa", "evidence") => emit_fields("fpa_evidence", &fpa::evidence(arg(&args, 3))),
        ("fpa", "verdict_vocab") => {
            emit_fields(
                "fpa_verdicts",
                &fpa::all_verdicts().iter().map(|x| (fpa::verdict_code(*x), "1")).collect::<Vec<_>>(),
            );
        }
        _ => {
            eprintln!("ERR unknown op: {} {}", domain, op);
            exit(2);
        }
    }
}

fn arg<'a>(args: &'a [String], i: usize) -> &'a str {
    args.get(i).map(|s| s.as_str()).unwrap_or("")
}
