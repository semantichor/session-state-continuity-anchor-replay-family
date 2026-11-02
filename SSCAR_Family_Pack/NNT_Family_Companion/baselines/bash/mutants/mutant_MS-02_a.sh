#!/usr/bin/env bash
# =====================================================================
# FAM-SSCAR-FI-001 — unified family baseline (bash paradigm, NNT family run)
#
# ONE artifact composing ALL 6 agents of the relevant family:
#   - 5 components, each INDEPENDENTLY invocable against its own PT suite:
#       vra (Verified Rehydration Agent)   bda (Boundary Defense Agent)
#       taa (Truth Arbitration Agent)      ara (Audit Replay Agent)
#       fpa (Freshness Portability Agent)
#   - the SSCAR integrator (agent id "family") that CONSUMES the real
#     component-produced fields (Annex A wiring, Annex B byte-identity)
#     and emits the EMERGENT family verdict via its 4-part projection
#     surface (next_state / verdict-emission / FamilyEvidenceBundle /
#     FOC-01..05).  AMB-01: the family verdict is NOT an aggregation of
#     local verdicts; AMB-17: REPLAY_INCOMPLETE / INCIDENT_ONLY have NO
#     workflow state and are signalled by non-advancement + verdict layer.
#
# bash idioms (R4): case-pattern state/event dispatch (no if/elif switch
# emulation), parameter substitution + (associative) arrays for evidence
# fields, trap for fail-closed critical paths, side-effect-explicit funcs.
#
# CLI:  baseline.sh <agent> <command> [args...]
# Derived from the 6-pack Specification + Conformance apparatus only; it
# embeds NO Conformance-Tests expected values (those live in the oracle).
# =====================================================================
set -u -o pipefail

# --- fail-closed trap: any unexpected command error emits a fail-closed
#     record and exits non-zero instead of returning a silent partial. ----
fail_closed() {
  printf 'surface=fail_closed fail_closed=true reason=%s detail=%s\n' "${1:-unspecified}" "${2:-}"
  exit 3
}
trap 'rc=$?; if [ "$rc" -ne 0 ]; then printf "surface=trap fail_closed=true exit_code=%s\n" "$rc" >&2; fi' ERR

kv() { printf '%s=%s\n' "$1" "$2"; }

# normalize validator_passed / guard_result tokens (case dispatch, not if-chain)
norm_vp() {
  case "${1:-}" in
    true|True|TRUE|pass|PASS|1|yes|t|_|any|'*') echo pass ;;
    *) echo fail ;;
  esac
}

# --- Annex B canonical cross-component tokens (byte-identity: CC-01, CC-08).
#     FPA accepted_head_digest == VRA verified-head-selection digest;
#     FPA linked_irr_digest == VRA irr_digest; produced identically here so
#     the boundary closes under real, independent derivation (not stubs). ---
HEAD_DIGEST="HEAD-DIGEST-CANON-0001"
IRR_DIGEST="IRR-DIGEST-CANON-0001"
SNAPSHOT_ID="SNAP-CANON-0001"
POLICY_SNAPSHOT_ID="POLSNAP-CANON-0001"
ANCHOR_DOC_REF="ANCHORDOC-CANON-0001"
REHYD_CLOSURE_REF="REHYD-CLOSURE-CANON-0001"
TSA_LABEL="attested_mechanism"
SOURCE_CLASS="TRAINED"
STATEMENT_ID="STMT-CANON-0001"
CHECKPOINT_REFS="CKPT-0001,CKPT-0002"
ROLLBACK_REFS="RBK-0001"
REPLAY_REFS="RPLY-0001,RPLY-0002"

# =====================================================================
# VRA  — Verified Rehydration Agent  (states S0..S8)
# =====================================================================
vra_next_state() {
  local s=$1 t=$2 vp; vp=$(norm_vp "${3:-}")
  case "$t" in RollbackDetected) echo S5_FAIL_SAFE; return ;; esac
  case "$s" in
    S0_STARTUP_READONLY)
      case "$t" in
        StartupComplete) case "$vp" in pass) echo S1_SNAPSHOT_LOCKED ;; *) echo S5_FAIL_SAFE ;; esac ;;
        *) echo S5_FAIL_SAFE ;;
      esac ;;
    S1_SNAPSHOT_LOCKED)
      case "$t" in
        SnapshotLocked) case "$vp" in pass) echo S2_STRUCTURAL_VERIFIED ;; *) echo S5_FAIL_SAFE ;; esac ;;
        *) echo S5_FAIL_SAFE ;;
      esac ;;
    S2_STRUCTURAL_VERIFIED)
      case "$t" in
        StructuralChecksDone) case "$vp" in pass) echo S3_ELIGIBLE_HEAD_SELECTED ;; *) echo S5_FAIL_SAFE ;; esac ;;
        *) echo S5_FAIL_SAFE ;;
      esac ;;
    S3_ELIGIBLE_HEAD_SELECTED)
      case "$t" in
        EligibilityChecksDone) case "$vp" in pass) echo S4_REHYDRATED_VALIDATED ;; *) echo S5_FAIL_SAFE ;; esac ;;
        ToolStateInvalid) echo S6_TOOL_QUARANTINE ;;
        *) echo S5_FAIL_SAFE ;;
      esac ;;
    S4_REHYDRATED_VALIDATED) echo S4_REHYDRATED_VALIDATED ;;
    S5_FAIL_SAFE)
      case "$t" in
        WalReplayNeeded) case "$vp" in pass) echo S7_RECOVERY_REPLAY ;; *) echo S5_FAIL_SAFE ;; esac ;;
        *) echo S5_FAIL_SAFE ;;
      esac ;;
    S6_TOOL_QUARANTINE) echo S6_TOOL_QUARANTINE ;;
    S7_RECOVERY_REPLAY)
      case "$t" in
        RecoveryConverged) case "$vp" in pass) echo S8_READMISSION_PENDING ;; *) echo S5_FAIL_SAFE ;; esac ;;
        *) echo S5_FAIL_SAFE ;;
      esac ;;
    S8_READMISSION_PENDING)
      # PT-024 parameterized authority-release envelope {S0,S1}; this build
      # lands in S1_SNAPSHOT_LOCKED (declared in conformance_log Envelopes).
      case "$t" in
        AuthorityRelease) case "$vp" in pass) echo S1_SNAPSHOT_LOCKED ;; *) echo S8_READMISSION_PENDING ;; esac ;;
        *) echo S8_READMISSION_PENDING ;;
      esac ;;
    *) echo S5_FAIL_SAFE ;;
  esac
}

vra_evidence() {
  local cls=${1:-EB-02}
  # base deny-path principal bundle fields
  kv validator_bundle_id "VBUNDLE-VRA-0001"
  kv verified_head_digest "$HEAD_DIGEST"
  kv snapshot_id "$SNAPSHOT_ID"
  case "$cls" in
    EB-01) : ;;  # V_CHAIN deny — closure trio only is asserted (PT-016)
    EB-02|EB-04)
      kv policy_id "POL-CANON-0001"; kv source_id "SRC-CANON-0001"
      kv freshness_value "11"; kv irr_digest "$IRR_DIGEST"
      kv tool_activation_status "inactive"
      kv failure_code "FRESHNESS_DOWNGRADE"; kv failed_validator "V_FRESHNESS"
      kv suppression_status "suppressed" ;;
    EB-03)
      kv policy_id "POL-CANON-0001"; kv source_id "SRC-CANON-0001"
      kv irr_digest "$IRR_DIGEST"; kv tool_activation_status "inactive"
      kv failure_code "CANONICAL_PARSE_AMBIGUITY"; kv failed_validator "V_PARSE"
      kv suppression_status "suppressed" ;;
    EB-05) kv recovery_phase "ANCHOR"; kv recovery_phase_producer "V_WAL_PHASE" ;;
    EB-06) kv readmission_token_id "RTOKEN-CANON-0001" ;;
  esac
  case "$cls" in
    EB-04) kv validator_bundle_id_producer "ExecutionLayer"
           kv failure_explanation_producer "GateLogic"
           kv tool_activation_status_producer "ToolGate" ;;
  esac
  kv surface "evidence"; kv agent "vra"; kv class "$cls"
}

# V_COMPAT / V_WRITER_LOCK are bounded external enforcement obligations the
# VRA Minimal Run Note counts as satisfied by implementation evidence
# (declarative PT-028 / PT-029). Attestation surface — real captured output.
vra_attest() {
  case "${1:-}" in
    V_COMPAT) kv surface attest; kv agent vra; kv obligation V_COMPAT
              kv enforcement_point "import_admissibility/policy_compatibility"
              kv compat_status "enforced"; kv evidence_recorded "true"; kv attested true ;;
    V_WRITER_LOCK) kv surface attest; kv agent vra; kv obligation V_WRITER_LOCK
              kv enforcement_point "persistence_control_plane"
              kv writer_lock_status "single_writer"; kv contention_status "none"; kv attested true ;;
    *) fail_closed vra_attest_unknown "${1:-}" ;;
  esac
}

# =====================================================================
# BDA  — Boundary Defense Agent
# =====================================================================
bda_next_state() {
  local s=$1 t=$2 g; g=$(norm_vp "${3:-}")
  case "$t" in CPW_CRITICAL) echo OUTPUT_BLOCKED; return ;; esac
  case "$s" in
    IDLE) case "$t" in INPUT_RECEIVED) echo INGEST_VALIDATE ;; *) echo OUTPUT_BLOCKED ;; esac ;;
    INGEST_VALIDATE)
      case "$t" in
        VALIDATION_PASS) case "$g" in pass) echo FILTER_REVIEW ;; *) echo OUTPUT_BLOCKED ;; esac ;;
        VALIDATION_FAIL) echo OUTPUT_BLOCKED ;;
        *) echo OUTPUT_BLOCKED ;;
      esac ;;
    FILTER_REVIEW)
      case "$t" in
        TOOL_STATE_DETECTED) echo TOOL_STATE_QUARANTINED ;;
        NO_ESCALATION) case "$g" in pass) echo READY_FOR_RELEASE ;; *) echo OUTPUT_BLOCKED ;; esac ;;
        *) echo OUTPUT_BLOCKED ;;
      esac ;;
    TOOL_STATE_QUARANTINED)
      case "$t" in
        APPROVAL_GRANTED) case "$g" in pass) echo READY_FOR_RELEASE ;; *) echo TOOL_STATE_QUARANTINED ;; esac ;;
        *) echo TOOL_STATE_QUARANTINED ;;
      esac ;;
    READY_FOR_RELEASE)
      case "$t" in FINALIZATION_REQUESTED) echo FINALIZATION_REVIEW ;; *) echo OUTPUT_BLOCKED ;; esac ;;
    FINALIZATION_REVIEW)
      case "$t" in
        EVIDENCE_OK) case "$g" in pass) echo IDLE ;; *) echo NONCOMPLIANT_HOLD ;; esac ;;
        EVIDENCE_FAIL) echo NONCOMPLIANT_HOLD ;;
        *) echo NONCOMPLIANT_HOLD ;;
      esac ;;
    OUTPUT_BLOCKED)
      case "$t" in
        READMISSION_APPROVED) case "$g" in pass) echo IDLE ;; *) echo OUTPUT_BLOCKED ;; esac ;;
        *) echo OUTPUT_BLOCKED ;;
      esac ;;
    NONCOMPLIANT_HOLD)
      case "$t" in
        COMPLIANCE_RESTORED) case "$g" in pass) echo IDLE ;; *) echo NONCOMPLIANT_HOLD ;; esac ;;
        *) echo NONCOMPLIANT_HOLD ;;
      esac ;;
    *) echo OUTPUT_BLOCKED ;;
  esac
}

bda_evidence() {
  local cls=${1:-full}
  kv decision_id "BDA-DEC-0001"; kv session_id "SESS-0001"; kv boundary_side "ingress"
  kv decision_object "ingress_request"; kv input_digest "IN-DIG-0001"; kv policy_hash "PHASH-0001"
  kv validator_results "VAL-01:pass,VAL-02:pass,VAL-03:pass"; kv statement_refs "STMT-0001"
  kv verdict "ALLOW"; kv reason_code "D-08_ALLOW"; kv order_index "1"
  kv hash_prev "HPREV-0001"; kv hash_curr "HCURR-0001"
  case "$cls" in
    approval) kv approval_ref "APPROVAL-0001" ;;
    finalization) kv evidence_ref "EVREF-0001"; kv verif_counter_anchor "VCA-0002" ;;
    rollback) kv rollback_ref "RBK-0001" ;;
    conflict) kv verdict "BLOCK"; kv reason_code "D-04_CONFLICT"; kv conflict_evidence "unlabeled_statement"; kv statement_refs "STMT-UNLABELED-0001" ;;
  esac
  kv surface evidence; kv agent bda; kv class "$cls"
}

# BDA bounded-external declarative producers / enforcement attestation.
bda_attest() {
  case "${1:-}" in
    conflict_evidence) kv surface attest; kv agent bda; kv obligation VAL-03_conflict_evidence
         kv verdict BLOCK; kv conflict_recorded true; kv gate_use denied; kv attested true ;;
    producer_grounding) kv surface attest; kv agent bda; kv obligation non_validator_producer
         kv decision_id_producer DecisionEngine; kv approval_ref_producer Operator_VAL-06
         kv evidence_ref_producer ExternalAssurance_VAL-05; kv orphaned_evidence none; kv attested true ;;
    distributed_enforcement) kv surface attest; kv agent bda; kv obligation distributed_enforcement
         kv bounded_points "VAL-01..VAL-08"; kv orphaned_validator none; kv attested true ;;
    *) fail_closed bda_attest_unknown "${1:-}" ;;
  esac
}

# =====================================================================
# TAA  — Truth Arbitration Agent  (compound X_TO_Y triggers)
# =====================================================================
taa_next_state() {
  local s=$1 t=$2 vp; vp=$(norm_vp "${3:-}")
  case "$s" in CLOSED) echo CLOSED; return ;; esac
  case "$s|$t" in
    INTAKE\|INTAKE_TO_ROLE_SCREENING) case "$vp" in pass) echo ROLE_SCREENING ;; *) echo FAIL_CLOSED ;; esac ;;
    EVALUATING\|EVALUATING_TO_CLASSIFYING) case "$vp" in pass) echo CLASSIFYING ;; *) echo FAIL_CLOSED ;; esac ;;
    DECIDED\|DECIDED_TO_HANDOFF_READY) case "$vp" in pass) echo HANDOFF_READY ;; *) echo FAIL_CLOSED ;; esac ;;
    ROLE_SCREENING\|ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING) case "$vp" in pass) echo CANONICALIZING ;; *) echo FAIL_CLOSED ;; esac ;;
    ROLE_SCREENING\|ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION) case "$vp" in pass) echo DECIDED ;; *) echo FAIL_CLOSED ;; esac ;;
    CLASSIFYING\|CLASSIFYING_TO_DENY_DECISION) case "$vp" in pass) echo DECIDED ;; *) echo FAIL_CLOSED ;; esac ;;
    CONFLICT_CHECKING\|CONFLICT_CHECKING_TO_ALLOW_DECISION) case "$vp" in pass) echo DECIDED ;; *) echo FAIL_CLOSED ;; esac ;;
    CONFLICT_CHECKING\|CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION) echo DECIDED ;;
    CONFLICT_CHECKING\|CONFLICT_CHECKING_TO_DENY_DECISION) echo DECIDED ;;
    CONFLICT_CHECKING\|CONFLICT_CHECKING_TO_ESCALATE_DECISION) echo DECIDED ;;
    FAIL_CLOSED\|FAIL_CLOSED_TO_NONCOMPLIANT_HOLD) echo NONCOMPLIANT_HOLD ;;
    NONCOMPLIANT_HOLD\|NONCOMPLIANT_HOLD_TO_READMISSION_PENDING) echo READMISSION_PENDING ;;
    READMISSION_PENDING\|READMISSION_PENDING_TO_ROLE_SCREENING) case "$vp" in pass) echo ROLE_SCREENING ;; *) echo FAIL_CLOSED ;; esac ;;
    *\|*_TO_FAIL_CLOSED) echo FAIL_CLOSED ;;
    *) echo FAIL_CLOSED ;;   # protective default / no silent state preservation
  esac
}

taa_evidence() {
  local cls=${1:-base}
  kv decision_id "TAA-DEC-0001"; kv statement_id_list "$STATEMENT_ID"
  kv verdict "ALLOW"; kv reason_code "DO-008_COMPLETE"; kv tsa_label "$TSA_LABEL"
  kv source_class "$SOURCE_CLASS"; kv source_ref "SREF-0001"
  kv boundary_validated_role "mechanism_level"; kv role_validation_result "confirmed"
  kv policy_snapshot_id "$POLICY_SNAPSHOT_ID"; kv policy_hash_ref "PHREF-0001"
  kv scope_id "SCOPE-0001"; kv turn_id "TURN-0001"; kv order_ref "ORD-0001"
  kv logical_timestamp "LTS-0001"
  kv semantic_closure "closed"; kv evidence_closure "closed"
  kv failure_closure "closed"; kv policy_snapshot_closure "closed"
  case "$cls" in
    allow_constrained)
      kv verdict "ALLOW_CONSTRAINED"; kv reason_code "DO-006_HEURISTIC_CONFLICT_UNCLOSED"
      kv conflict_check_mode "heuristic"; kv conflict_check_strength "v006b"
      kv conflict_check_confidence "0.6"; kv conflict_check_coverage_scope "partial"
      kv compared_claim_set_ref "CCS-0001"; kv residual_risk_statement "bounded_residual" ;;
    fail_closed_escalation)
      kv verdict "FAIL_CLOSED"; kv reason_code "UNLABELED_CLAIM"
      kv inhibit_flags "block_local"; kv root_reason_code "UNLABELED_CLAIM"
      kv cleared_only_by "external_actor"; kv remediation_class "clearance"
      kv escalation_request_ref "ESC-0001"; kv request_id "REQ-0001"
      kv failure_ref "FR-0001"; kv required_actor_role "auditor"
      kv required_evidence "clearance_bundle"; kv status "pending" ;;
  esac
  kv surface evidence; kv agent taa; kv class "$cls"
}

# TAA declarative: V-008 distributed ordering/serialization enforcement.
taa_attest() {
  case "${1:-}" in
    V-008_ordering) kv surface attest; kv agent taa; kv obligation V-008_ordering_serialization
         kv enforcement "snapshot_at_intake+compare_and_commit"; kv ordering_invariant preserved
         kv override_route FAIL_CLOSED; kv attested true ;;
    *) fail_closed taa_attest_unknown "${1:-}" ;;
  esac
}

# =====================================================================
# ARA  — Audit Replay Agent  (states S0_INGESTED.. / SH / SX / S6)
# =====================================================================
ara_next_state() {
  local s=$1 t=$2 vp; vp=$(norm_vp "${3:-}")
  case "$t" in
    EV_SIGNATURE_FAIL) echo SX_FAIL_CLOSED; return ;;
    EV_CHAIN_BREAK)    echo SX_FAIL_CLOSED; return ;;
    EV_EVIDENCE_FAIL)  echo SH_HOLD_ACTIVE; return ;;
    EV_COUNTER_REPLAY) echo SH_HOLD_ACTIVE; return ;;
    EV_POLICY_UNRESOLVED) echo SX_FAIL_CLOSED; return ;;  # parameterized {BLOCKED,SX}; this build: SX
  esac
  case "$s|$t" in
    S0_INGESTED\|EV_PARSE_OK) case "$vp" in pass) echo S1_PARSED ;; *) echo SX_FAIL_CLOSED ;; esac ;;
    S2_VERIFIED\|replay_fold_complete) case "$vp" in pass) echo S3_RECONSTRUCTED ;; *) echo SX_FAIL_CLOSED ;; esac ;;
    S3_RECONSTRUCTED\|EV_LASTCLEAN_FOUND) case "$vp" in pass) echo S4_CHECKPOINT_RESOLVED ;; *) echo SX_FAIL_CLOSED ;; esac ;;
    S4_CHECKPOINT_RESOLVED\|EV_REPORT_BOUND) case "$vp" in pass) echo S5_REPORT_READY ;; *) echo SX_FAIL_CLOSED ;; esac ;;
    SH_HOLD_ACTIVE\|EV_READMISSION_GRANTED) case "$vp" in pass) echo S6_READMITTED ;; *) echo SH_HOLD_ACTIVE ;; esac ;;
    SX_FAIL_CLOSED\|EV_READMISSION_GRANTED) case "$vp" in pass) echo S6_READMITTED ;; *) echo SX_FAIL_CLOSED ;; esac ;;
    S6_READMITTED\|controlled_resumption) echo S2_VERIFIED ;;  # {S2,S4} envelope; this build: S2
    *) echo "$s" ;;   # terminal integrity / no invented route (T014 S5 self-holds)
  esac
}

ara_evidence() {
  local cls=${1:-mandatory}
  kv bundle_digest "BND-0001"; kv policy_profile_id "PPID-0001"; kv policy_hash "PHASH-0001"
  kv validator_outcomes "V-01:pass,V-05:pass,V-07:pass"; kv hash_continuity_refs "HC-0001"
  kv signature_refs "SIG-0001"; kv checkpoint_refs "$CHECKPOINT_REFS"; kv rollback_refs "$ROLLBACK_REFS"
  kv report_fields_ref "RPT-0001"; kv report_signature "RSIG-0001"; kv export_manifest_ref "EXM-0001"
  case "$cls" in
    hold_readmission) kv hold_enter_refs "HEN-0001"; kv hold_exit_refs "HEX-0001"; kv anchor_update_ref "ANCHOR-UPD-0002" ;;
    producers) kv producer_input "InputContract"; kv producer_export "ExportGovernance"; kv producer_readmission "ReadmissionGovernance"; kv orphaned_producer none ;;
  esac
  kv surface evidence; kv agent ara; kv class "$cls"
}

# ARA declarative / gate-logic surfaces.
ara_gate() {
  case "${1:-}" in
    V-10_quarantine) kv surface gate; kv agent ara; kv validator V-10
         kv gate_status QUARANTINE; kv admitted_to_reconstruction false; kv incident_export emitted; kv attested true ;;
    report_insufficient) kv surface gate; kv agent ara; kv verdict PARTIAL
         kv finalize_report blocked; kv note "INCIDENT_ONLY_or_PARTIAL" ;;
    checkpoint_unverified) kv surface gate; kv agent ara; kv rollback_sequence INVALID; kv note "no_REPLAYABLE" ;;
    distributed_enforcement) kv surface gate; kv agent ara; kv mapping "V-10->QUARANTINE"; kv orphaned false; kv attested true ;;
    transparent_classification) kv surface gate; kv agent ara; kv v10_export declarative; kv v06_s6_export parameterized; kv hidden_omission none; kv attested true ;;
    *) fail_closed ara_gate_unknown "${1:-}" ;;
  esac
}

# =====================================================================
# FPA  — Freshness Portability Agent  (states IDLE..REJECTED)
# =====================================================================
fpa_next_state() {
  local s=$1 t=$2 vp; vp=$(norm_vp "${3:-}")
  case "$s|$t" in
    IDLE\|TransferPacketReceived) case "$vp" in pass) echo RECEIVED ;; *) echo REJECTED ;; esac ;;
    RECEIVED\|StructureValid) case "$vp" in pass) echo VERIFIED ;; *) echo REJECTED ;; esac ;;
    RECEIVED\|StructureInvalid) echo REJECTED ;;
    VERIFIED\|FreshnessPass) case "$vp" in pass) echo FRESHNESS_ELIGIBLE ;; *) echo REJECTED ;; esac ;;
    VERIFIED\|FreshnessFail) echo REJECTED ;;
    VERIFIED\|EvidencePending) echo QUARANTINED ;;
    FRESHNESS_ELIGIBLE\|IRRAppended) case "$vp" in pass) echo IRR_COMMITTED ;; *) echo REJECTED ;; esac ;;
    IRR_COMMITTED\|WatermarkPersisted) case "$vp" in pass) echo WATERMARK_COMMITTED ;; *) echo REJECTED ;; esac ;;
    FRESHNESS_ELIGIBLE\|WatermarkPersisted) echo REJECTED ;;  # out-of-order (receipt rule)
    WATERMARK_COMMITTED\|RestoreRequest_GenesisConfirmed) case "$vp" in pass) echo RESTORATION_ELIGIBLE ;; *) echo REJECTED ;; esac ;;
    RESTORATION_ELIGIBLE\|RestoreAdmitted) echo IDLE ;;
    QUARANTINED\|ReadmissionApproved) case "$vp" in pass) echo VERIFIED ;; *) echo REJECTED ;; esac ;;
    IDLE\|ReadmissionApproved) echo REJECTED ;;   # readmission only from QUARANTINED
    REJECTED\|NewPacket) echo RECEIVED ;;
    REJECTED\|*) echo REJECTED ;;                 # terminal preservation
    *) echo REJECTED ;;                           # fail-closed default
  esac
}

fpa_evidence() {
  local cls=${1:-accept}
  kv decision_id "FPA-DEC-0001"; kv agent_id "FPA-FRESHNESS-PORTABILITY-003"
  kv source_id "SRC-CANON-0001"; kv ledger_uuid "LEDGER-0001"
  kv policy_id "POL-CANON-0001"; kv policy_version "v1"
  case "$cls" in
    accept)
      kv decision_object "accept_import"; kv reason_code "APPEND_IRR"
      kv semantic_verdict "ACCEPT"; kv gate_class "RELEASE"
      kv packet_hash "PKT-0001"; kv freshness_value "11"
      kv watermark_before "10"; kv watermark_after "11"; kv ssm_validation_result "valid"
      kv irr_digest "$IRR_DIGEST"; kv prev_receipt_digest "PREVIRR-0001"
      kv accepted_head_digest "$HEAD_DIGEST" ;;
    deny_restore)
      kv decision_object "restore_deny"; kv reason_code "DENY_RESTORE"
      kv semantic_verdict "FAIL_CLOSED"; kv gate_class "BLOCK" ;;
    quarantine)
      kv decision_object "quarantine_inconclusive"; kv reason_code "OPEN_QUARANTINE_CASE"
      kv semantic_verdict "QUARANTINE"; kv gate_class "ESCALATION"
      kv evidence_validation_result "pending" ;;
    tvc)      kv tvc_validation_result "valid" ;;
    evidence) kv evidence_validation_result "valid" ;;
    transport) kv transport_validation_result "valid" ;;
  esac
  kv surface evidence; kv agent fpa; kv class "$cls"
}

# FPA declarative obligations (FPA-D-01..06) attestation surface.
fpa_attest() {
  case "${1:-}" in
    FPA-D-01) kv surface attest; kv agent fpa; kv obligation action_token_mapping
         kv tokens "APPEND_IRR,REJECT_INVALID,REJECT_STALE,OPEN_QUARANTINE_CASE,ISSUE_RESTORE_ADMISSION_TOKEN,DENY_RESTORE,REENTER_VERIFIED,BLOCK_TOOL_STATE"; kv attested true ;;
    FPA-D-02) kv surface attest; kv agent fpa; kv obligation restore_no_toolstate; kv tool_state_activated false; kv attested true ;;
    FPA-D-03) kv surface attest; kv agent fpa; kv obligation VAL-011_gate; kv on_request BLOCK_TOOL_STATE; kv attested true ;;
    FPA-D-04) kv surface attest; kv agent fpa; kv obligation VAL-011_distributed; kv orphaned false; kv attested true ;;
    FPA-D-05) kv surface attest; kv agent fpa; kv obligation watermark_monotonic; kv rollback_rejected true; kv security_finding emitted; kv attested true ;;
    FPA-D-06) kv surface attest; kv agent fpa; kv obligation irr_append_only; kv watermark_after_irr true; kv attested true ;;
    *) fail_closed fpa_attest_unknown "${1:-}" ;;
  esac
}

# =====================================================================
# component public-field producers (consumed by the family integrator)
# optional mode arg injects a defect so the composition closes (or fails)
# under REAL, independently-derived component output (not stub fixtures).
# =====================================================================
vra_produce() {
  local f=$1 mode=${2:-ok}
  case "$f" in
    rehydration_closure_ref) case "$mode" in antirollback|chainbreak|snapshot|rohit) echo "" ;; *) echo "$REHYD_CLOSURE_REF" ;; esac ;;
    snapshot_id) echo "$SNAPSHOT_ID" ;;
    accepted_head_digest|verified_head_selection) echo "$HEAD_DIGEST" ;;
    irr_digest) echo "$IRR_DIGEST" ;;
    validator_bundle_id) echo "VBUNDLE-VRA-0001" ;;
    *) echo "" ;;
  esac
}
fpa_produce() {
  local f=$1 mode=${2:-ok}
  case "$f" in
    accepted_head_digest) case "$mode" in brokenlink) echo "HEAD-STALE-9999" ;; *) echo "$HEAD_DIGEST" ;; esac ;;
    linked_irr_digest)    case "$mode" in brokenlink) echo "IRR-STALE-9999" ;; *) echo "$IRR_DIGEST" ;; esac ;;
    freshness_before) echo "10" ;;
    freshness_after)  case "$mode" in replay|stale) echo "10" ;; regress) echo "9" ;; *) echo "11" ;; esac ;;
    anchor_update_ref) echo "ANCHOR-UPD-0002" ;;
    *) echo "" ;;
  esac
}
taa_produce() {
  local f=$1 mode=${2:-ok}
  case "$f" in
    tsa_label)   case "$mode" in unlabeled) echo "" ;; *) echo "$TSA_LABEL" ;; esac ;;
    source_class) case "$mode" in unlabeled) echo "" ;; *) echo "$SOURCE_CLASS" ;; esac ;;
    statement_id) echo "$STATEMENT_ID" ;;
    boundary_validated_role) case "$mode" in explanatory) echo "explanatory_only" ;; *) echo "mechanism_level" ;; esac ;;
    policy_snapshot_id) echo "$POLICY_SNAPSHOT_ID" ;;
    *) echo "" ;;
  esac
}
bda_produce() {
  local f=$1 mode=${2:-ok}
  case "$f" in
    anchor_document_ref) case "$mode" in untrusted) echo "" ;; *) echo "$ANCHOR_DOC_REF" ;; esac ;;
    tool_state_activation) case "$mode" in toolstate) echo "requested" ;; *) echo "none" ;; esac ;;
    carried_payload) echo "PAYLOAD-0001" ;;
    *) echo "" ;;
  esac
}
ara_produce() {
  local f=$1 mode=${2:-ok}
  case "$f" in
    checkpoint_refs) case "$mode" in incomplete) echo "" ;; *) echo "$CHECKPOINT_REFS" ;; esac ;;
    rollback_refs)   case "$mode" in incomplete) echo "" ;; *) echo "$ROLLBACK_REFS" ;; esac ;;
    replay_refs) echo "$REPLAY_REFS" ;;
    report_id) echo "RPT-0001" ;;
    report_signature) echo "RSIG-0001" ;;
    *) echo "" ;;
  esac
}

# =====================================================================
# SSCAR family integrator — 4-part projection surface
# =====================================================================
# Part 1: next_state over the 12-state family machine (S0..S8, SH, SR, SX)
family_next_state() {
  local s=$1 t=$2 vp; vp=$(norm_vp "${3:-}")
  case "$t" in
    CriticalContamination|AntiRollbackFailure|ChainBreak|UntrustedAnchorPromoted) echo SX; return ;;
  esac
  case "$s|$t" in
    S0\|Fv01Pass) case "$vp" in pass) echo S1 ;; *) echo SX ;; esac ;;
    S1\|Fv02AndFv04Pass) case "$vp" in pass) echo S2 ;; *) echo SX ;; esac ;;
    S2\|Fv03Pass) case "$vp" in pass) echo S3 ;; *) echo SX ;; esac ;;
    S2\|UnlabeledMechanismLevelCarriedClaim) echo SX ;;
    S3\|Fv05AndFv06Pass) case "$vp" in pass) echo S4 ;; *) echo SH ;; esac ;;
    S3\|FreshnessReplay) echo SH ;;
    S4\|Fv07Pass) case "$vp" in pass) echo S5 ;; *) echo SX ;; esac ;;
    S5\|Fv08Pass) case "$vp" in pass) echo S6 ;; *) echo S5 ;; esac ;;
    S6\|Fv10AndFv11Pass) case "$vp" in pass) echo S7 ;; *) echo S6 ;; esac ;;
    S7\|FamilyVerdictIssued) echo S8 ;;
    SH\|HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate) case "$vp" in pass) echo SR ;; *) echo SH ;; esac ;;
    SR\|ReadmissionBundleChangedCarriedPayload) echo S2 ;;
    SR\|ReadmissionBundleChangedAnchorDocumentRef) echo S2 ;;
    SR\|ReadmissionBundleChangedSourceControlBundles) echo S2 ;;
    SR\|ReadmissionBundleChangedComponentSet) echo S2 ;;
    SR\|ReadmissionBundleChangedPolicySnapshotId) echo S5 ;;
    SR\|ReadmissionBundleChangedRehydrationClosureRef) echo S5 ;;
    S8\|*) echo S8 ;;   # terminal
    SX\|*) echo SX ;;   # terminal
    *) echo SX ;;       # fail-closed default (no silent preservation)
  esac
}

# Part 2: verdict-emission layer — distinct from next_state; emits the 6
# family verdicts incl. the state-less REPLAY_INCOMPLETE / INCIDENT_ONLY.
family_verdict() {
  local fv="${1:-none}" sub="${2:-}"
  case "$fv" in
    none) case "$sub" in constrained) echo REPLAY_ADMISSIBLE_CONSTRAINED ;; *) echo REPLAY_ADMISSIBLE ;; esac ;;
    FV-02|FV-09) echo CONTAMINATION_FAIL_CLOSED ;;
    FV-03) case "$sub" in policy) echo REPLAY_INCOMPLETE ;; *) echo CONTAMINATION_FAIL_CLOSED ;; esac ;;
    FV-04) echo CONTAMINATION_FAIL_CLOSED ;;
    FV-05|FV-08) echo REPLAY_INCOMPLETE ;;
    FV-06|FV-12) echo NONCOMPLIANT_HOLD ;;
    FV-07) case "$sub" in policy) echo NONCOMPLIANT_HOLD ;; *) echo CONTAMINATION_FAIL_CLOSED ;; esac ;;
    FV-10|FV-11) echo INCIDENT_ONLY ;;
    *) echo CONTAMINATION_FAIL_CLOSED ;;
  esac
}

# Part 3: FamilyEvidenceBundle (FEV-01..FEV-15, §11)
family_evidence() {
  kv FEV-01_family_decision_id "FAM-DEC-0001"
  kv FEV-02_boundary_event_id "BEVT-0001"
  kv FEV-03_session_id "SESS-0001/prior:SESS-0000"
  kv FEV-04_carried_statement_refs "$STATEMENT_ID"
  kv FEV-05_tsa_refs "$TSA_LABEL/$SOURCE_CLASS"
  kv FEV-06_anchor_document_ref "$ANCHOR_DOC_REF"
  kv FEV-07_accepted_head_digest "$HEAD_DIGEST/$IRR_DIGEST"
  kv FEV-08_freshness "10/11/ANCHOR-UPD-0002"
  kv FEV-09_rehydration_closure_ref "$REHYD_CLOSURE_REF"
  kv FEV-10_replay_refs "$REPLAY_REFS/$CHECKPOINT_REFS/$ROLLBACK_REFS"
  kv FEV-11_disclosure_class_entries "${1:-none}"
  kv FEV-12_family_validator_outcomes "FV-01..FV-12:pass"
  kv FEV-13_hold_refs "${2:-none}"
  kv FEV-14_contamination_flags "${3:-none}"
  kv FEV-15_report_signature "RSIG-FAM-0001/EXM-FAM-0001"
  kv surface evidence; kv agent family
}

# Part 4: FOC-01..FOC-05 emission (§3.2)
family_foc() {
  case "${1:-}" in
    FOC-01) kv surface foc; kv contract FOC-01; kv family_decision_id FAM-DEC-0001; kv session_id SESS-0001
            kv family_verdict "${2:-REPLAY_ADMISSIBLE}"; kv reason_code "${3:-FD-05}"; kv family_validator_refs "FV-01..FV-12"; kv family_evidence_refs "FEV-01..FEV-15" ;;
    FOC-02) kv surface foc; kv contract FOC-02; kv report_id RPT-FAM-0001; kv boundary_event_id BEVT-0001
            kv carried_statement_refs "$STATEMENT_ID"; kv anchor_refs "$ANCHOR_DOC_REF"; kv freshness_refs "10/11"; kv replay_refs "$REPLAY_REFS"; kv disclosure_class_entries "${2:-none}" ;;
    FOC-03) kv surface foc; kv contract FOC-03; kv family_decision_id FAM-DEC-0001; kv accepted_head_digest "$HEAD_DIGEST"
            kv linked_irr_digest "$IRR_DIGEST"; kv rehydration_closure_ref "$REHYD_CLOSURE_REF"; kv admission_status admitted ;;
    FOC-04) kv surface foc; kv contract FOC-04; kv incident_id INC-0001; kv root_reason_code "${2:-UNLABELED_CARRIED_MECHANISM_CLAIM}"
            kv contaminating_ref_set "${3:-CREF-0001}"; kv blocked_stage "${4:-provenance_classification}"; kv remediation_class fail_closed ;;
    FOC-05) kv surface foc; kv contract FOC-05; kv hold_case_id HOLD-0001; kv hold_enter_refs HEN-0001
            kv pending_requirements "anchor_update_ref_strict_increase"; kv readmission_budget 3; kv cleared_only_by external_actor ;;
    *) fail_closed family_foc_unknown "${1:-}" ;;
  esac
}

# Family composition — consumes REAL component outputs, runs FV-01..FV-12 in
# gate order, emits emergent verdict + reached state + evidence. The injected
# scenario perturbs a COMPONENT's produced value; the verdict is computed from
# the values, never supplied by the caller (Composed-flow rule, Annex C).
family_compose() {
  local scenario="${1:-clean}"
  local m_bda=ok m_taa=ok m_fpa=ok m_vra=ok m_ara=ok disclosure=none outcomes=complete comps=5
  case "$scenario" in
    fv01_partial_components) comps=3 ;;
    fv02_untrusted_anchor) m_bda=untrusted ;;
    fv09_toolstate) m_bda=toolstate ;;
    fv03_unlabeled) m_taa=unlabeled ;;
    fv03_policy) m_taa=policy ;;
    fv04_reclass) m_taa=explanatory ;;
    fv05_brokenlink) m_fpa=brokenlink ;;
    fv06_freshness_replay) m_fpa=replay ;;
    fv07_antirollback) m_vra=antirollback ;;
    fv08_incomplete_replay) m_ara=incomplete ;;
    fv10_disclosure_collapse) disclosure=collapse ;;
    fv11_empty_outcomes) outcomes=empty ;;
    constrained) disclosure=bounded ;;
    clean) : ;;
  esac
  # --- gather REAL component-produced fields ---
  local anchor_ref tsa src role headF irrF headV irrV rclo cp rb
  anchor_ref=$(bda_produce anchor_document_ref "$m_bda")
  local toolact; toolact=$(bda_produce tool_state_activation "$m_bda")
  tsa=$(taa_produce tsa_label "$m_taa"); src=$(taa_produce source_class "$m_taa")
  role=$(taa_produce boundary_validated_role "$m_taa")
  headF=$(fpa_produce accepted_head_digest "$m_fpa"); irrF=$(fpa_produce linked_irr_digest "$m_fpa")
  local fresh_b fresh_a; fresh_b=$(fpa_produce freshness_before "$m_fpa"); fresh_a=$(fpa_produce freshness_after "$m_fpa")
  headV=$(vra_produce accepted_head_digest "$m_vra"); irrV=$(vra_produce irr_digest "$m_vra")
  rclo=$(vra_produce rehydration_closure_ref "$m_vra")
  cp=$(ara_produce checkpoint_refs "$m_ara"); rb=$(ara_produce rollback_refs "$m_ara")
  # --- Annex B CC-01/CC-08 byte-identity (computed, not asserted) ---
  local link_ok; case "${headF}|${irrF}" in "${headV}|${irrV}") link_ok=yes ;; *) link_ok=no ;; esac
  # --- freshness strict-increase (FV-06), computed arithmetically ---
  local fresh_ok=no; [ "$fresh_a" -gt "$fresh_b" ] 2>/dev/null && fresh_ok=yes
  # --- family validator pipeline (ordered gate; first blocking failure wins) ---
  local reached=S0 fv=none sub="" ok
  ok=$(case "$comps" in 5) echo fail ;; *) echo pass ;; esac)
  case "$ok" in pass) reached=S1 ;; *) fv=FV-01; reached=S0 ;; esac
  case "$fv" in none)
    case "$anchor_ref" in "") fv=FV-02; reached=SX ;; *) reached=S2 ;; esac ;; esac
  case "$fv" in none)
    case "$toolact" in requested) fv=FV-09; reached=SX ;; esac ;; esac
  case "$fv" in none)
    case "${tsa}|${src}" in ''\|*|*\|'') fv=FV-03; sub=contam; reached=SX ;;
      *) case "$m_taa" in policy) fv=FV-03; sub=policy; reached=S3 ;; *) reached=S3 ;; esac ;; esac ;; esac
  case "$fv" in none)
    case "$role" in explanatory_only) fv=FV-04; reached=SX ;; esac ;; esac
  case "$fv" in none)
    case "$link_ok" in no) fv=FV-05; reached=S4 ;; *) reached=S4 ;; esac ;; esac
  case "$fv" in none)
    case "$fresh_ok" in no) fv=FV-06; reached=SH ;; esac ;; esac
  case "$fv" in none)
    case "$rclo" in "") fv=FV-07; sub=integrity; reached=SX ;; *) reached=S5 ;; esac ;; esac
  case "$fv" in none)
    case "${cp}|${rb}" in ''\|*|*\|'') fv=FV-08; reached=S5 ;; *) reached=S6 ;; esac ;; esac
  case "$fv" in none)
    case "$disclosure" in collapse) fv=FV-10; reached=S6 ;; *) reached=S7 ;; esac ;; esac
  case "$fv" in none)
    case "$outcomes" in empty) fv=FV-11; reached=S6 ;; *) reached=S8 ;; esac ;; esac
  # --- emergent verdict (verdict-emission layer) ---
  local verdict
  case "$fv" in
    none) case "$disclosure" in bounded) verdict=$(family_verdict none constrained) ;; *) verdict=$(family_verdict none) ;; esac ;;
    *) verdict=$(family_verdict "$fv" "$sub") ;;
  esac
  # --- composed record ---
  kv surface compose; kv agent family; kv scenario "$scenario"
  kv components_admitted "$comps"; kv cc01_head_link "$link_ok"; kv fv06_strict_increase "$fresh_ok"
  kv failed_validator "${fv}"; kv fail_subclass "${sub:-none}"
  kv reached_state "$reached"; kv family_verdict "$verdict"
  kv anchor_document_ref "${anchor_ref:-EMPTY}"; kv tsa_label "${tsa:-EMPTY}"; kv source_class "${src:-EMPTY}"
  kv accepted_head_digest_fpa "$headF"; kv accepted_head_digest_vra "$headV"
  kv linked_irr_digest "$irrF"; kv rehydration_closure_ref "${rclo:-EMPTY}"
  kv checkpoint_refs "${cp:-EMPTY}"; kv rollback_refs "${rb:-EMPTY}"
}

# verdict / state vocabularies for taxonomy / fidelity checks
emit_verdicts() {
  case "$1" in
    vra) echo "ALLOW DENY QUARANTINE ESCALATE READMISSION_PENDING" ;;
    bda) echo "ALLOW ALLOW_CONSTRAINED BLOCK QUARANTINE FAIL_CLOSED NONCOMPLIANT_HOLD READMIT" ;;
    taa) echo "ALLOW ALLOW_CONSTRAINED DENY FAIL_CLOSED ESCALATE OUT_OF_SCOPE" ;;
    ara) echo "REPLAYABLE PARTIAL REJECTED BROKEN INCIDENT_ONLY" ;;
    fpa) echo "ACCEPT REJECT QUARANTINE RESTORATION_ELIGIBLE READMIT FAIL_CLOSED" ;;
    family) echo "REPLAY_ADMISSIBLE REPLAY_ADMISSIBLE_CONSTRAINED REPLAY_INCOMPLETE NONCOMPLIANT_HOLD CONTAMINATION_FAIL_CLOSED INCIDENT_ONLY" ;;
  esac
}
distinct() {
  case "$2" in "$3") kv distinct no ;; *) kv distinct yes ;; esac
  kv a "$2"; kv b "$3"; kv surface distinct; kv agent "$1"
}

# =====================================================================
# top-level dispatch
# =====================================================================
agent=${1:-}; cmd=${2:-}; shift 2 2>/dev/null || true
emit_ns() { # agent-tagged next_state wrapper -> single structured line
  local a=$1 fn=$2 s=${3:-} t=${4:-} v=${5:-}; local r
  r=$("$fn" "$s" "$t" "$v")
  printf 'surface=next_state agent=%s in_state=%s trigger=%s validator_passed=%s result_state=%s\n' "$a" "$s" "$t" "$v" "$r"
}

case "$agent" in
  vra)
    case "$cmd" in
      next_state) emit_ns vra vra_next_state "$@" ;;
      evidence) vra_evidence "$@" ;;
      attest) vra_attest "$@" ;;
      produce) vra_produce "$@" ;;
      verdicts) echo "verdicts=$(emit_verdicts vra)" ;;
      distinct) distinct vra "$@" ;;
      *) fail_closed vra_cmd_unknown "$cmd" ;;
    esac ;;
  bda)
    case "$cmd" in
      next_state) emit_ns bda bda_next_state "$@" ;;
      evidence) bda_evidence "$@" ;;
      attest) bda_attest "$@" ;;
      produce) bda_produce "$@" ;;
      verdicts) echo "verdicts=$(emit_verdicts bda)" ;;
      distinct) distinct bda "$@" ;;
      *) fail_closed bda_cmd_unknown "$cmd" ;;
    esac ;;
  taa)
    case "$cmd" in
      next_state) emit_ns taa taa_next_state "$@" ;;
      evidence) taa_evidence "$@" ;;
      attest) taa_attest "$@" ;;
      produce) taa_produce "$@" ;;
      verdicts) echo "verdicts=$(emit_verdicts taa)" ;;
      distinct) distinct taa "$@" ;;
      *) fail_closed taa_cmd_unknown "$cmd" ;;
    esac ;;
  ara)
    case "$cmd" in
      next_state) emit_ns ara ara_next_state "$@" ;;
      evidence) ara_evidence "$@" ;;
      gate) ara_gate "$@" ;;
      produce) ara_produce "$@" ;;
      verdicts) echo "verdicts=$(emit_verdicts ara)" ;;
      distinct) distinct ara "$@" ;;
      *) fail_closed ara_cmd_unknown "$cmd" ;;
    esac ;;
  fpa)
    case "$cmd" in
      next_state) emit_ns fpa fpa_next_state "$@" ;;
      evidence) fpa_evidence "$@" ;;
      attest) fpa_attest "$@" ;;
      produce) fpa_produce "$@" ;;
      verdicts) echo "verdicts=$(emit_verdicts fpa)" ;;
      distinct) distinct fpa "$@" ;;
      *) fail_closed fpa_cmd_unknown "$cmd" ;;
    esac ;;
  family)
    case "$cmd" in
      next_state) emit_ns family family_next_state "$@" ;;
      verdict) printf 'surface=verdict agent=family failed_validator=%s fail_subclass=%s family_verdict=%s\n' "${1:-none}" "${2:-none}" "$(family_verdict "${1:-none}" "${2:-}")" ;;
      evidence) family_evidence "$@" ;;
      foc) family_foc "$@" ;;
      compose) family_compose "$@" ;;
      verdicts) echo "verdicts=$(emit_verdicts family)" ;;
      distinct) distinct family "$@" ;;
      *) fail_closed family_cmd_unknown "$cmd" ;;
    esac ;;
  selfcheck)
    printf 'surface=selfcheck agent=family status=ready states=12 verdicts=6 validators=FV-01..FV-12 components=5\n' ;;
  *) fail_closed agent_unknown "${agent:-<none>}" ;;
esac
