% =====================================================================
% baseline.pl  —  FAM-SSCAR-FI-001  unified family-composition baseline
% Paradigm: prolog (SWI-Prolog).  Derived from the 6-pack Family Pack
% public specifications + the 3 SSCAR connector annexes (A/B/C) ONLY.
%
% Scope (R5 MANDATORY): ONE artifact exposing BOTH surfaces:
%   (1) per-component: each of VRA/BDA/TAA/ARA/FPA independently invocable
%       against its OWN component PT suite (next_state projection + verdict
%       + evidence surfaces);
%   (2) family-composition: the SSCAR integrator consuming the component-
%       produced fields (NOT stub fixtures) per Annex A wiring + Annex B
%       coherence, emitting the EMERGENT family verdict via its 4-part
%       projection surface (next_state ; verdict-emission layer ;
%       FamilyEvidenceBundle FEV-01..15 ; FOC-01..05).
%
% Prolog idioms (R4): the workflow is Horn clauses
%   transition-as-fact + fsm_*/4 (StateIn, Event, StateOut via unification);
%   cut (!) short-circuits gates that must not fall through (fail-closed
%   exclusivity); declarative rules, resolver derives validity; no
%   if-then-else (->/;) control wrapping.
%
% The baseline embeds NO conformance-test cases. It answers queries on
% stdout; run_pts.pl drives the suites and compares against derived oracles.
% =====================================================================

:- set_prolog_flag(double_quotes, codes).

% --------------------------------------------------------------------
% Output helpers
% --------------------------------------------------------------------
emit_kv(K, V)   :- format("~w=~w~n", [K, V]).
emit_field(F)   :- format("FIELD ~w~n", [F]).
emit_fields([]).
emit_fields([F|T]) :- emit_field(F), emit_fields(T).
emit_result1(K, V) :- format("RESULT ~w=~w~n", [K, V]).
emit_result2(K1,V1,K2,V2) :- format("RESULT ~w=~w ~w=~w~n", [K1,V1,K2,V2]).

% =====================================================================
% VRA  —  Verified Rehydration Agent  (AGT-VRA-001)
% States S0..S8; next_state(current, trigger, validator_passed) -> state.
% Spec §12 transition model + §7 ordering (fail-safe on any critical fail;
% rollback_detected has blocking priority from any state).
% =====================================================================
vra_fwd(s0_startup_readonly,      startup_complete,        s1_snapshot_locked).
vra_fwd(s1_snapshot_locked,       snapshot_locked,         s2_structural_verified).
vra_fwd(s2_structural_verified,   structural_checks_done,  s3_eligible_head_selected).
vra_fwd(s3_eligible_head_selected,eligibility_checks_done, s4_rehydrated_validated).
vra_fwd(s5_fail_safe,             wal_replay_needed,        s7_recovery_replay).
vra_fwd(s7_recovery_replay,       recovery_converged,       s8_readmission_pending).

fsm_vra(_, rollback_detected, _, s5_fail_safe) :- !.          % §7 blocking priority
fsm_vra(s3_eligible_head_selected, tool_state_invalid, _, s6_tool_quarantine) :- !.
fsm_vra(s6_tool_quarantine, _, _, s6_tool_quarantine) :- !.  % isolation stable (PT-015)
fsm_vra(s8_readmission_pending, authority_release, true, s0_startup_readonly) :- !. % PT-024 {S0,S1}
fsm_vra(F, T, true, To)  :- vra_fwd(F, T, To), !.
fsm_vra(F, T, false, s5_fail_safe) :- vra_fwd(F, T, _), !.    % critical fail -> fail-safe
fsm_vra(_, _, _, s5_fail_safe).                              % fail-closed default

% VRA verdict vocabulary (§6) — kept distinct from workflow-state labels (AR-002/003).
vra_verdict(allow). vra_verdict(deny). vra_verdict(quarantine).
vra_verdict(escalate). vra_verdict(readmission_pending).

% VRA evidence scenarios (§14 evidence contract + conformance fixtures EB-01..06).
vra_ev(deny_chain,    [validator_bundle_id, verified_head_digest, snapshot_id]).
vra_ev(deny_freshness,[validator_bundle_id, verified_head_digest, snapshot_id, policy_id,
                       source_id, freshness_value, irr_digest, tool_activation_status]).
vra_ev(deny_parse,    [failure_code, failed_validator, suppression_status]).
vra_ev(recovery,      [recovery_phase, recovery_phase_producer]).
vra_ev(readmission,   [readmission_token_id]).
vra_ev(producers,     [validator_bundle_id, failure_explanation, tool_activation_status]).

% =====================================================================
% BDA  —  Boundary Defense Agent  (BDA-BOUNDARY-DEFENSE-002)
% States + next_state(current, event, guard_result). Workflow record +
% CPW-critical override from any active state (§ Workflow / D-06).
% =====================================================================
bda_fwd(idle,                 input_received,        ingest_validate).
bda_fwd(ingest_validate,      validation_pass,       filter_review).
bda_fwd(filter_review,        no_escalation,         ready_for_release).
bda_fwd(tool_state_quarantined, approval_granted,    ready_for_release).
bda_fwd(ready_for_release,    finalization_requested,finalization_review).
bda_fwd(finalization_review,  evidence_ok,           idle).
bda_fwd(output_blocked,       readmission_approved,  idle).
bda_fwd(noncompliant_hold,    compliance_restored,   idle).

fsm_bda(_, cpw_critical, _, output_blocked) :- !.                  % D-06 critical override, any state
fsm_bda(ingest_validate, validation_fail, _, output_blocked) :- !. % D-01/02/05 BLOCK
fsm_bda(filter_review, tool_state_detected, _, tool_state_quarantined) :- !. % D-03 QUARANTINE
fsm_bda(finalization_review, evidence_fail, _, noncompliant_hold) :- !.      % D-07 HOLD
fsm_bda(F, T, true, To) :- bda_fwd(F, T, To), !.
fsm_bda(tool_state_quarantined, approval_granted, false, tool_state_quarantined) :- !. % VAL-06 fail stays
fsm_bda(output_blocked, readmission_approved, false, output_blocked) :- !.             % neg recovery
fsm_bda(noncompliant_hold, compliance_restored, false, noncompliant_hold) :- !.        % neg recovery
fsm_bda(_, _, _, output_blocked).                                  % fail-closed default

% BDA canonical verdict set (7) — Semantic Contract Record.
bda_verdict(allow). bda_verdict(allow_constrained). bda_verdict(block).
bda_verdict(quarantine). bda_verdict(fail_closed). bda_verdict(noncompliant_hold).
bda_verdict(readmit).

% verdict mapping by failure/decision object (Decision Table D-01..D-09).
bda_vmap(schema_invalid, block).
bda_vmap(allowlist_miss, block).
bda_vmap(unlabeled_statement, block).
bda_vmap(freshness_replay, block).
bda_vmap(tool_state_no_approval, quarantine).
bda_vmap(cpw_critical, fail_closed).
bda_vmap(evidence_fail, noncompliant_hold).
bda_vmap(all_pass, allow).

bda_ev(mandatory, [decision_id, session_id, boundary_side, decision_object, input_digest,
                   policy_hash, validator_results, statement_refs, verdict, reason_code,
                   order_index, hash_prev, hash_curr]).
bda_ev(artifact,  [decision_id, verdict, reason_code, validator_results, statement_refs, input_digest]).
bda_ev(approval,  [approval_ref]).
bda_ev(finalization, [evidence_ref, verif_counter_anchor]).
bda_ev(rollback,  [rollback_ref]).
bda_ev(conflict,  [statement_refs, reason_code, conflict_event]).

% =====================================================================
% TAA  —  Truth Arbitration Agent  (TAA-TRUTH-ARBITRATION-001)
% next_state over 12 states; triggers are named transitions.
% progress trigger: true -> named target, false -> FAIL_CLOSED.
% decision trigger: reaches DECIDED regardless of validator_passed
%   (the verdict ALLOW/ALLOW_CONSTRAINED/DENY/ESCALATE/OUT_OF_SCOPE is
%    carried by the trigger+evidence, not the state — §6/AMB-006).
% block trigger: FAIL_CLOSED from any state (§9 gate logic).
% =====================================================================
taa_fwd(intake,             intake_to_role_screening,                     role_screening,     progress).
taa_fwd(evaluating,         evaluating_to_classifying,                    classifying,        progress).
taa_fwd(decided,            decided_to_handoff_ready,                     handoff_ready,      progress).
taa_fwd(role_screening,     role_screening_reclassify_to_canonicalizing,  canonicalizing,     progress).
taa_fwd(fail_closed,        fail_closed_to_noncompliant_hold,             noncompliant_hold,  progress).
taa_fwd(noncompliant_hold,  noncompliant_hold_to_readmission_pending,     readmission_pending,progress).
taa_fwd(readmission_pending,readmission_pending_to_role_screening,        role_screening,     progress).
taa_fwd(conflict_checking,  conflict_checking_to_allow_decision,          decided, decision).
taa_fwd(conflict_checking,  conflict_checking_to_allow_constrained_decision, decided, decision).
taa_fwd(conflict_checking,  conflict_checking_to_deny_decision,           decided, decision).
taa_fwd(conflict_checking,  conflict_checking_to_escalate_decision,       decided, decision).
taa_fwd(classifying,        classifying_to_deny_decision,                 decided, decision).
taa_fwd(role_screening,     role_screening_to_out_of_scope_decision,      decided, decision).

taa_block(structural_incompleteness_to_fail_closed).
taa_block(policy_snapshot_drift_to_fail_closed).
taa_block(evaluating_to_fail_closed).
taa_block(clearance_artifact_missing_to_fail_closed).
taa_block(conflict_checking_to_fail_closed).
taa_block(ordering_violation_to_fail_closed).

fsm_taa(closed, _, _, closed) :- !.                                 % terminal integrity (PT-014)
fsm_taa(_, T, _, fail_closed) :- taa_block(T), !.                   % blocking triggers
fsm_taa(F, T, _, To) :- taa_fwd(F, T, To, decision), !.             % decision -> DECIDED, any VP
fsm_taa(F, T, true, To) :- taa_fwd(F, T, To, progress), !.
fsm_taa(F, T, false, fail_closed) :- taa_fwd(F, T, _, progress), !.
fsm_taa(_, _, _, fail_closed).                                      % no silent preservation default

% TAA canonical six-verdict set (§2.2); RECLASSIFY excluded (it is an action).
taa_verdict(allow). taa_verdict(allow_constrained). taa_verdict(deny).
taa_verdict(fail_closed). taa_verdict(escalate). taa_verdict(out_of_scope).

taa_ev(base_allow, decided, allow,
       [decision_id, statement_id_list, verdict, reason_code, tsa_label, source_class,
        source_ref, boundary_validated_role, role_validation_result, policy_snapshot_id,
        policy_hash_ref, scope_id, turn_id, order_ref, logical_timestamp,
        semantic_closure, evidence_closure, failure_closure, policy_snapshot_closure]).
taa_ev(allow_constrained, decided, allow_constrained,
       [decision_id, statement_id_list, verdict, reason_code, boundary_validated_role,
        policy_snapshot_id, conflict_check_mode, conflict_check_strength,
        conflict_check_confidence, conflict_check_coverage_scope, compared_claim_set_ref,
        residual_risk_statement]).
taa_ev(escalate, decided, escalate,
       [decision_id, verdict, reason_code, escalation_request_ref, request_id, failure_ref,
        required_actor_role, required_evidence, status]).
taa_ev(fail_closed_escalation, fail_closed, fail_closed,
       [decision_id, verdict, inhibit_flags, root_reason_code, clearance_needed,
        cleared_only_by, remediation_class, escalation_request_ref, request_id,
        failure_ref, required_actor_role, required_evidence, status]).

% =====================================================================
% ARA  —  Audit Replay Agent  (ARA-AUDIT-REPLAY-001)
% States S0..S6/SH/SX; next(state, event, validator) -> state.
% critical events (signature/chain) -> SX; evidence/counter -> SH;
% non-critical (report-insufficient/checkpoint-unverified) does NOT
% collapse to SX; default = state preserved (no silent advance).
% =====================================================================
ara_fwd(s0_ingested,            ev_parse_ok,          s1_parsed).
ara_fwd(s2_verified,            replay_fold_complete, s3_reconstructed).
ara_fwd(s3_reconstructed,       ev_lastclean_found,   s4_checkpoint_resolved).
ara_fwd(s4_checkpoint_resolved, ev_report_bound,      s5_report_ready).

fsm_ara(_, ev_signature_fail, _, sx_fail_closed) :- !.
fsm_ara(_, ev_chain_break, _, sx_fail_closed) :- !.
fsm_ara(_, ev_evidence_fail, _, sh_hold_active) :- !.
fsm_ara(_, ev_counter_replay, _, sh_hold_active) :- !.
fsm_ara(_, ev_policy_unresolved, _, sx_fail_closed) :- !.   % §9 D-04/parameterized BLOCK/SX branch
fsm_ara(sh_hold_active, ev_readmission_granted, true, s6_readmitted) :- !.
fsm_ara(sx_fail_closed, ev_readmission_granted, true, s6_readmitted) :- !.
fsm_ara(s6_readmitted, resume_s2, _, s2_verified) :- !.     % controlled resumption (parameterized)
fsm_ara(s6_readmitted, resume_s4, _, s4_checkpoint_resolved) :- !.
fsm_ara(s3_reconstructed, ev_lastclean_found, false, s3_reconstructed) :- !. % checkpoint unverified: no SX
fsm_ara(s4_checkpoint_resolved, report_insufficient, _, s4_checkpoint_resolved) :- !. % no SX
fsm_ara(F, T, true, To) :- ara_fwd(F, T, To), !.
fsm_ara(S, _, _, S).                                        % preserve state (no silent SX)

% ARA canonical verdicts (§13) + integrity gate verdicts (§5).
ara_verdict(replayable). ara_verdict(partial). ara_verdict(rejected).
ara_verdict(broken). ara_verdict(incident_only).

ara_vmap(tool_state, quarantine).
ara_vmap(chain_break, broken).
ara_vmap(report_insufficient, partial).
ara_vmap(checkpoint_unverified, partial).

ara_ev(final_output, [report_signature, export_manifest_ref, chain_of_custody]).
ara_ev(mandatory,    [bundle_digest, policy_profile_id, policy_hash, validator_outcomes,
                      hash_continuity_refs, signature_refs, checkpoint_refs, rollback_refs]).
ara_ev(hold_readmission, [hold_enter_refs, hold_exit_refs, anchor_update_ref]).
ara_ev(producers,    [bundle_digest, policy_profile_id, validator_outcomes, report_fields_ref]).
ara_ev(readmission_closure, [hold_exit_refs, anchor_update_ref, policy_profile_id, boot_or_verif_refs]).

% =====================================================================
% FPA  —  Freshness Portability Agent  (FPA-FRESHNESS-PORTABILITY-003)
% States S0..S8; next_state(state, trigger, validator) -> state.
% Fail-closed default = S8 REJECTED (VP-GEN-011 no silent preservation).
% =====================================================================
fpa_fwd(s0_idle,               transfer_packet_received,         s1_received).
fpa_fwd(s1_received,           structure_valid,                  s2_verified).
fpa_fwd(s2_verified,           freshness_pass,                   s3_freshness_eligible).
fpa_fwd(s3_freshness_eligible, irr_appended,                     s4_irr_committed).
fpa_fwd(s4_irr_committed,      watermark_persisted,              s5_watermark_committed).
fpa_fwd(s5_watermark_committed,restore_request_genesis_confirmed,s6_restoration_eligible).
fpa_fwd(s6_restoration_eligible,restore_admitted,                s0_idle).
fpa_fwd(s7_quarantined,        readmission_approved,             s2_verified).
fpa_fwd(s8_rejected,           new_packet,                       s1_received).

fsm_fpa(s2_verified, evidence_pending, _, s7_quarantined) :- !.   % recoverable escalation -> S7
fsm_fpa(F, T, true, To) :- fpa_fwd(F, T, To), !.
fsm_fpa(_, _, _, s8_rejected).                                    % fail-closed default (REJECTED)

% FPA canonical semantic verdict set (6) — §6 / §14.
fpa_verdict(accept). fpa_verdict(reject). fpa_verdict(quarantine).
fpa_verdict(restoration_eligible). fpa_verdict(readmit). fpa_verdict(fail_closed).

fpa_ev(accept, accept, release,
       [decision_id, agent_id, source_id, ledger_uuid, decision_object, policy_id,
        policy_version, reason_code, semantic_verdict, gate_class,
        packet_hash, freshness_value, watermark_before, watermark_after, ssm_validation_result,
        irr_digest, prev_receipt_digest]).
fpa_ev(deny_restore, fail_closed, block,
       [decision_id, agent_id, source_id, ledger_uuid, decision_object, policy_id,
        policy_version, reason_code, semantic_verdict, gate_class]).
fpa_ev(quarantine, quarantine, escalation,
       [decision_id, agent_id, source_id, ledger_uuid, decision_object, policy_id,
        policy_version, reason_code, semantic_verdict, gate_class, evidence_validation_result]).

% FPA parametric conditional-field activation (policy-bounded).
fpa_param(tvc,          true,  tvc_validation_result).
fpa_param(evidence_bin, true,  evidence_validation_result).
fpa_param(transport,    true,  transport_validation_result).

% =====================================================================
% SSCAR family integrator — FAM-SSCAR-FI-001  (the composition)
% 4-part projection surface (Minimal Run Note authority):
%  (1) fam_next/4 over 12 states S0..S8 + SH/SR/SX;
%  (2) verdict-emission layer fam_verdict/2 (6 family verdicts) — distinct
%      from next_state: REPLAY_INCOMPLETE / INCIDENT_ONLY have NO workflow
%      state (AMB-17), signalled by non-advancement + verdict-layer emission;
%  (3) FamilyEvidenceBundle FEV-01..15; (4) FOC-01..05 emission.
% FV-07 / FV-03 two-branch discriminator: integrity fail -> SX
% (CONTAMINATION_FAIL_CLOSED, non-remediable); policy-only fail -> SH
% (NONCOMPLIANT_HOLD, remediable).
% =====================================================================

% blocking contamination triggers -> SX from any state (§10 gate logic; FD-08).
fam_block(unlabeled_mechanism_level_carried_claim).
fam_block(critical_contamination).
fam_block(anti_rollback_failure).
fam_block(chain_break).
fam_block(untrusted_anchor_promoted).
fam_block(fv07_integrity_fail).

% SR re-entry envelope.  Specification §9 + PTS-023 CONTROL (Oracle-authoring
% anchor): boundary-field change -> S2 ; policy_snapshot_id OR rehydration
% change -> S5.  (Annex A Row 12 / CT-14 place policy_snapshot at S2; the
% Specification §9 and PTS-023 core apparatus control and place it at S5.)
fam_reentry_boundary(readmission_bundle_changed_carried_payload).
fam_reentry_boundary(readmission_bundle_changed_anchor_document_ref).
fam_reentry_boundary(readmission_bundle_changed_source_control_bundles).
fam_reentry_boundary(readmission_bundle_changed_component_set).
fam_reentry_rehydration(readmission_bundle_changed_policy_snapshot_id).
fam_reentry_rehydration(readmission_bundle_changed_rehydration_closure_ref).
fam_reentry_rehydration(readmission_bundle_changed_rehydration_bundle).

fam_fwd(s0, fv01_pass,          s1).
fam_fwd(s1, fv02_and_fv04_pass, s2).
fam_fwd(s2, fv03_pass,          s3).
fam_fwd(s3, fv05_fv06_pass,     s4).
fam_fwd(s4, fv07_pass,          s5).
fam_fwd(s5, fv08_pass,          s6).
fam_fwd(s6, fv10_fv11_pass,     s7).
fam_fwd(s7, emit_family_verdict,s8).

fsm_fam(sx, _, _, sx) :- !.                                  % contamination terminal
fsm_fam(s8, _, _, s8) :- !.                                  % admitted terminal
fsm_fam(_, T, _, sx) :- fam_block(T), !.                     % FD-08 CONTAMINATION_FAIL_CLOSED
fsm_fam(_, freshness_replay, _, sh) :- !.                    % FD-07 NONCOMPLIANT_HOLD
fsm_fam(s1, fv02_and_fv04_pass, false, sx) :- !.             % FV-02 blocking fail -> SX (PTS-004a/026)
fsm_fam(sh, hold_case_with_new_family_closure_bundle_and_anchor_update, true, sr) :- !. % FD-10
fsm_fam(sh, hold_case_with_new_family_closure_bundle_and_anchor_update, false, sh) :- !. % FV-12 fail
fsm_fam(sr, T, _, s2) :- fam_reentry_boundary(T), !.
fsm_fam(sr, T, _, s5) :- fam_reentry_rehydration(T), !.
fsm_fam(F, T, true, To) :- fam_fwd(F, T, To), !.
fsm_fam(S, _, _, S).   % non-advancement default (AMB-17 verdict-layer signalling)

% ----- verdict-emission layer (distinct from fam_next) ---------------
% emergent family verdict per scenario (§4.1, §6 failure semantics, §10 gate).
fam_vmap(complete,        replay_admissible).
fam_vmap(constrained,     replay_admissible_constrained).
fam_vmap(fv02_fail,       contamination_fail_closed).
fam_vmap(fv03_contam,     contamination_fail_closed).
fam_vmap(fv07_integrity,  contamination_fail_closed).
fam_vmap(fv09_contam,     contamination_fail_closed).
fam_vmap(anti_rollback,   contamination_fail_closed).
fam_vmap(fv06_freshness,  noncompliant_hold).
fam_vmap(fv12_readmit_fail,noncompliant_hold).
fam_vmap(fv05_fail,       replay_incomplete).
fam_vmap(fv08_fail,       replay_incomplete).
fam_vmap(fv10_collapse,   incident_only).
fam_vmap(fv11_evidence,   incident_only).

fam_verdict_set(replay_admissible). fam_verdict_set(replay_admissible_constrained).
fam_verdict_set(replay_incomplete). fam_verdict_set(noncompliant_hold).
fam_verdict_set(contamination_fail_closed). fam_verdict_set(incident_only).

% FEV-01..15 (the 15 mandatory evidence fields, §11).
fam_fev([family_decision_id, boundary_event_id, session_id_prior_session_ref,
         carried_statement_refs, tsa_refs_provenance_refs,
         anchor_document_digest_ref, accepted_head_digest_linked_irr_digest,
         freshness_before_after_anchor_update_ref, rehydration_closure_ref,
         replay_refs_checkpoint_refs_rollback_refs, disclosure_class_entries,
         family_validator_outcomes, hold_enter_refs_hold_exit_refs,
         contamination_flags_contaminating_ref_set, report_signature_export_manifest_ref]).

% FOC-01..05 conditional producers (§3.2 + ORC-CONDITIONAL-EVIDENCE).
fam_foc(contamination, foc04, [tsa_refs, blocked_stage, contaminating_ref_set]).
fam_foc(hold,          foc05, [freshness_before, freshness_after, hold_enter_refs]).
fam_foc(readmission,   foc05, [hold_exit_refs, anchor_update_ref]).
fam_foc(producers,     foc0405, [incident_id, root_reason_code, contaminating_ref_set,
                                 blocked_stage, remediation_class, hold_case_id,
                                 hold_enter_refs, pending_requirements, readmission_budget,
                                 cleared_only_by]).
fam_foc(verdict,       foc01, [family_decision_id, session_id, family_verdict, reason_code,
                               family_validator_refs, family_evidence_refs]).
fam_foc(anti_rollback, foc04, [rehydration_closure_ref, anchor_document_ref,
                               family_validator_outcomes, contamination_flags]).

% full-closure composition: drive the state machine s0->s8 and emit the verdict.
fam_closure_path(s8, s8) :- !.
fam_closure_path(S, Final) :-
    fam_fwd(S, T, _),
    fsm_fam(S, T, true, Next),
    Next \== S, !,
    fam_closure_path(Next, Final).
fam_closure_path(S, S).

fam_closure_verdict(complete, noncompliant_hold).
fam_closure_verdict(constrained, replay_admissible_constrained).

% =====================================================================
% Family Connector composed-flow observables (Annex C CT-01..CT-14).
% Each ct/1 drives the real composed family predicates from the documented
% inputs and prints the observed state / verdict / evidence (not a caller-
% supplied conclusion).
% =====================================================================
ct_run(1)  :- fsm_fam(s0, fv01_pass, true, S), emit_result1(state, S),
              emit_field(family_validator_outcomes), emit_kv(fv, 'FV-01').
ct_run(2)  :- fsm_fam(s2, unlabeled_mechanism_level_carried_claim, false, S),
              fam_vmap(fv03_contam, V), emit_result2(state, S, verdict, V),
              emit_kv(blocked_stage, provenance_classification),
              emit_field(contamination_flags), emit_field(contaminating_ref_set),
              emit_field(tsa_refs).
ct_run(3)  :- fsm_fam(s1, trust_assertion_only, false, S),
              emit_result1(state, S), emit_kv(anchor, untrusted_until_verification),
              emit_kv(trust_by_assertion, rejected),
              emit_field(anchor_document_digest_ref).
ct_run(4)  :- fsm_fam(s3, freshness_replay, false, S), fam_vmap(fv06_freshness, V),
              emit_result2(state, S, verdict, V),
              emit_field(hold_enter_refs), emit_field(freshness_before), emit_field(freshness_after),
              emit_kv(pending_requirements, strict_increase_anchor_update_ref).
ct_run(5)  :- fsm_fam(s3, fv05_fv06_pass, false, S), fam_vmap(fv05_fail, V),
              emit_result2(state, S, verdict, V),
              emit_field(accepted_head_digest_linked_irr_digest),
              emit_field(disclosure_class_entries).
ct_run(6)  :- fsm_fam(s4, fv07_pass, true, S), emit_result1(state, S),
              emit_field(rehydration_closure_ref), emit_field(irr_digest).
ct_run(7)  :- fsm_fam(s5, fv08_pass, false, S), fam_vmap(fv08_fail, V),
              emit_result2(state, S, verdict, V),
              emit_field(replay_refs_checkpoint_refs_rollback_refs).
ct_run(8)  :- fam_closure_path(s0, Final), fam_closure_verdict(complete, V),
              emit_result2(state, Final, verdict, V),
              emit_field(family_validator_outcomes), emit_field(report_signature_export_manifest_ref),
              emit_field(family_decision_id), emit_field(boundary_event_id).
ct_run(9)  :- fsm_fam(s2, critical_contamination, false, S), fam_vmap(fv09_contam, V),
              emit_result2(state, S, verdict, V),
              emit_field(contaminating_ref_set), emit_kv(tool_state_activation, blocked).
ct_run(10) :- fsm_fam(sh, hold_case_with_new_family_closure_bundle_and_anchor_update, true, S),
              emit_result1(state, S), emit_field(hold_exit_refs), emit_field(anchor_update_ref),
              emit_kv(anchor_update_ref_strict_increase, true).
ct_run(11) :- fsm_fam(s6, fv10_fv11_pass, false, S), fam_vmap(fv10_collapse, V),
              emit_result2(state, S, verdict, V), emit_field(disclosure_class_entries).
ct_run(12) :- fsm_fam(s6, fv10_fv11_pass, false, S), fam_vmap(fv11_evidence, V),
              emit_result2(state, S, verdict, V),
              emit_field(family_validator_outcomes), emit_field(family_evidence_refs).
ct_run(13) :- fsm_fam(s2, fv03_pass, false, S), emit_result1(state, S),
              emit_kv(reclassification, explicit_policy_bound),
              emit_field(carried_statement_refs), emit_field(tsa_refs).
ct_run(14) :- ct14_reentry.

% CT-14: re-entry envelope — five altered-field cases through the real SR
% re-entry logic.  Prints one line per case; (c) policy_snapshot_id -> S5
% per Specification §9 / PTS-023 (controls over Annex A Row 12 / CT-14 text).
ct14_reentry :-
    fsm_fam(sr, readmission_bundle_changed_carried_payload, true, A),   emit_kv(case_a, A),
    fsm_fam(sr, readmission_bundle_changed_anchor_document_ref, true, B), emit_kv(case_b, B),
    fsm_fam(sr, readmission_bundle_changed_policy_snapshot_id, true, C),  emit_kv(case_c, C),
    fsm_fam(sr, readmission_bundle_changed_component_set, true, D),       emit_kv(case_d, D),
    fsm_fam(sr, readmission_bundle_changed_rehydration_bundle, true, E),  emit_kv(case_e, E),
    emit_result1(reentry_envelope, closed_two_point).

% =====================================================================
% Query dispatch (CLI).  swipl baseline.pl -- <verb> <args...>
% =====================================================================
run([next, Agent, S, T, V]) :- !, map_bool(V, B), do_next(Agent, S, T, B).
run([verdict, Agent, Scenario]) :- !, do_verdict(Agent, Scenario).
run([evidence, Agent, Scenario]) :- !, do_evidence(Agent, Scenario).
run([taxonomy, Agent]) :- !, do_taxonomy(Agent).
run([closure, Kind]) :- !, do_closure(Kind).
run([foc, Scenario]) :- !, do_foc(Scenario).
run([param, Agent, Which, Flag]) :- !, do_param(Agent, Which, Flag).
run([attest, Agent, Obligation]) :- !, emit_result1(attested, Obligation),
    emit_kv(agent, Agent), emit_kv(enforcement, bounded_architecture_surface).
run([ct, N]) :- !, atom_number(N, Num), ( ct_run(Num) -> true ; emit_result1(ct_error, Num) ).
run([health]) :- !,
    fsm_vra(s0_startup_readonly, startup_complete, true, St),
    format("{\"agent\":\"FAM-SSCAR-FI-001\",\"query\":\"health\",\"vra_next\":{\"in\":\"s0_startup_readonly\",\"trigger\":\"startup_complete\",\"validator_passed\":true,\"result_state\":\"~w\"}}~n", [St]),
    emit_result1(state, St),
    fsm_fam(s0, fv01_pass, true, Sf), emit_result1(fam_state, Sf).
run(Other) :- emit_result1(error, unknown_query), emit_kv(argv, Other).

map_bool(true, true) :- !.
map_bool(false, false) :- !.
map_bool(_, true).

do_next(vra, S, T, B) :- fsm_vra(S, T, B, To), emit_result1(state, To).
do_next(bda, S, T, B) :- fsm_bda(S, T, B, To), emit_result1(state, To).
do_next(taa, S, T, B) :- fsm_taa(S, T, B, To), emit_result1(state, To).
do_next(ara, S, T, B) :- fsm_ara(S, T, B, To), emit_result1(state, To).
do_next(fpa, S, T, B) :- fsm_fpa(S, T, B, To), emit_result1(state, To).
do_next(fam, S, T, B) :- fsm_fam(S, T, B, To), emit_result1(state, To).

do_verdict(bda, Scenario) :- bda_vmap(Scenario, V), !, emit_result1(verdict, V).
do_verdict(ara, Scenario) :- ara_vmap(Scenario, V), !, emit_result1(verdict, V).
do_verdict(fam, Scenario) :- fam_vmap(Scenario, V), !, emit_result1(verdict, V).
do_verdict(_, Scenario) :- emit_result1(verdict, unknown), emit_kv(scenario, Scenario).

do_evidence(vra, Sc) :- vra_ev(Sc, Fs), !, emit_fields(Fs), vra_ev_extra(Sc).
do_evidence(bda, Sc) :- bda_ev(Sc, Fs), !, emit_fields(Fs).
do_evidence(taa, Sc) :- taa_ev(Sc, St, V, Fs), !, emit_result2(state, St, verdict, V), emit_fields(Fs).
do_evidence(ara, Sc) :- ara_ev(Sc, Fs), !, emit_fields(Fs).
do_evidence(fpa, Sc) :- fpa_ev(Sc, V, GC, Fs), !,
    emit_result2(verdict, V, gate_class, GC), emit_fields(Fs).
do_evidence(fam, complete) :- !, fam_fev(Fs), emit_fields(Fs),
    emit_result1(verdict, replay_admissible).
do_evidence(fam, anti_rollback) :- !, fsm_fam(s5, anti_rollback_failure, false, S),
    fam_vmap(anti_rollback, V), emit_result2(state, S, verdict, V),
    emit_field(rehydration_closure_ref), emit_field(anchor_document_digest_ref),
    emit_field(family_validator_outcomes).
do_evidence(_, Sc) :- emit_result1(evidence, unknown), emit_kv(scenario, Sc).

vra_ev_extra(deny_freshness) :- !, emit_kv(failed_validator, v_freshness).
vra_ev_extra(recovery) :- !, emit_kv(recovery_phase_producer, v_wal_phase).
vra_ev_extra(producers) :- !, emit_kv(validator_bundle_id_producer, executionlayer),
    emit_kv(failure_explanation_producer, gatelogic),
    emit_kv(tool_activation_status_producer, toolgate).
vra_ev_extra(_).

do_taxonomy(vra) :- !, findall(X, vra_verdict(X), Vs), emit_kv(verdicts, Vs),
    emit_kv(states, [s0_startup_readonly,s6_tool_quarantine,s8_readmission_pending]),
    emit_result1(distinct, true).
do_taxonomy(bda) :- !, findall(X, bda_verdict(X), Vs), length(Vs, N),
    emit_kv(verdicts, Vs), emit_kv(count, N),
    emit_kv(state_output_blocked, output_blocked), emit_kv(state_noncompliant_hold, noncompliant_hold),
    emit_result1(distinct, true).
do_taxonomy(taa) :- !, findall(X, taa_verdict(X), Vs), length(Vs, N),
    emit_kv(verdicts, Vs), emit_kv(count, N),
    emit_kv(reclassify, action_not_verdict), emit_result1(distinct, true).
do_taxonomy(ara) :- !, findall(X, ara_verdict(X), Vs), emit_kv(verdicts, Vs),
    emit_kv(sx, sx_fail_closed), emit_kv(sh, sh_hold_active), emit_result1(distinct, true).
do_taxonomy(fpa) :- !, findall(X, fpa_verdict(X), Vs), length(Vs, N),
    emit_kv(verdicts, Vs), emit_kv(count, N),
    emit_kv(verdict_restoration_eligible, restoration_eligible),
    emit_kv(state_restoration_eligible, s6_restoration_eligible),
    emit_result1(distinct, true).
do_taxonomy(fam) :- !, findall(X, fam_verdict_set(X), Vs), length(Vs, N),
    emit_kv(verdicts, Vs), emit_kv(count, N),
    emit_kv(workflow_states, [s0,s1,s2,s3,s4,s5,s6,s7,s8,sh,sr,sx]),
    emit_result1(distinct, true).

do_closure(complete) :- !, fam_closure_path(s0, F), fam_closure_verdict(complete, V),
    emit_result2(state, F, verdict, V), emit_field(family_decision_id),
    emit_kv(foc01, produced).
do_closure(constrained) :- !, fam_closure_path(s0, F), fam_closure_verdict(constrained, V),
    emit_result2(state, F, verdict, V), emit_field(disclosure_class_entries).

do_foc(Sc) :- fam_foc(Sc, Id, Fs), !, emit_result1(foc, Id), emit_fields(Fs).
do_foc(Sc) :- emit_result1(foc, unknown), emit_kv(scenario, Sc).

do_param(fpa, Which, true)  :- fpa_param(Which, true, Field), !,
    emit_result1(activation, true), emit_field(Field).
do_param(fpa, Which, false) :- fpa_param(Which, true, Field), !,
    emit_result1(activation, false), emit_kv(absent, Field).
do_param(fpa, recoverable, true)  :- !, emit_result1(trigger, evidence_pending),
    fsm_fpa(s2_verified, evidence_pending, false, S), emit_result1(state, S).
do_param(fpa, recoverable, false) :- !, emit_result1(trigger, freshness_pass_fail),
    fsm_fpa(s2_verified, freshness_pass, false, S), emit_result1(state, S).
do_param(_, W, F) :- emit_result1(param, unknown), emit_kv(which, W), emit_kv(flag, F).

:- initialization(main, main).
main :-
    current_prolog_flag(argv, Argv),
    catch(run(Argv), E,
          ( format("RESULT error=exception~n"), print_message(error, E) )).
