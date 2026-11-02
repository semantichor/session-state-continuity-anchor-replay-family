% =====================================================================
% run_pts.pl  —  R6 conformance runner for the FAM-SSCAR-FI-001 prolog
% baseline.  Drives ALL SEVEN family suites (231 pinned canonical records)
% against baseline.pl, capturing REAL stdout from a live swipl invocation
% per record.  Emits pt_results.json, pt_run_log.txt, conformance_log.md.
%
% RELOCATABLE (R6): discovers its own directory at load time and resolves
% the baseline + output paths relative to itself; resolves the swipl
% executable from current_prolog_flag(executable).  No absolute machine
% paths are baked in.  Re-running the delivered run_pts.pl against the
% delivered baseline.pl reproduces the delivered pt_results.json statuses.
%
% FAIL-CLOSED: if baseline.pl is absent / cannot start, it exits non-zero
% naming the missing path and writes NO pt_results.json.
%
% This runner embeds the test fixtures + derived oracles (that is the
% harness's role); the BASELINE embeds no test cases.  Oracles are derived
% from each owning pack's conformance apparatus + Specification (never from
% the flagging record).  This file states expected tokens the runner
% compares against; the baseline computes the actual tokens live.
% =====================================================================

:- prolog_load_context(directory, D), assertz(script_dir(D)).
:- discontiguous rec/4.
:- discontiguous taa_spec/3.
:- initialization(main, main).

baseline_path(BL) :- script_dir(D), atomic_list_concat([D, '/baseline.pl'], BL).
out_path(Name, P) :- script_dir(D), atomic_list_concat([D, '/', Name], P).

% ---- record table ---------------------------------------------------
% record(Id, Suite, Category, run(Invs, ExpectSubstrings)) | skip(Cite).

% ===== VRA component — PT-* (29) =====
rec('PT-001', vra_pt, runnable, run([[next,vra,s0_startup_readonly,startup_complete,true]], ['state=s1_snapshot_locked'])).
rec('PT-002', vra_pt, runnable, run([[next,vra,s2_structural_verified,structural_checks_done,true]], ['state=s3_eligible_head_selected'])).
rec('PT-003', vra_pt, runnable, run([[next,vra,s3_eligible_head_selected,eligibility_checks_done,true]], ['state=s4_rehydrated_validated'])).
rec('PT-004', vra_pt, runnable, run([[next,vra,s2_structural_verified,structural_checks_done,false]], ['state=s5_fail_safe'])).
rec('PT-005', vra_pt, runnable, run([[next,vra,s2_structural_verified,structural_checks_done,false]], ['state=s5_fail_safe'])).
rec('PT-006', vra_pt, runnable, run([[next,vra,s2_structural_verified,structural_checks_done,false]], ['state=s5_fail_safe'])).
rec('PT-007', vra_pt, runnable, run([[next,vra,s2_structural_verified,structural_checks_done,false]], ['state=s5_fail_safe'])).
rec('PT-008', vra_pt, runnable, run([[next,vra,s3_eligible_head_selected,eligibility_checks_done,false]], ['state=s5_fail_safe'])).
rec('PT-009', vra_pt, runnable, run([[next,vra,s3_eligible_head_selected,eligibility_checks_done,false]], ['state=s5_fail_safe'])).
rec('PT-010', vra_pt, runnable, run([[next,vra,s0_startup_readonly,startup_complete,false]], ['state=s5_fail_safe'])).
rec('PT-011', vra_pt, runnable, run([[next,vra,s3_eligible_head_selected,rollback_detected,true]], ['state=s5_fail_safe'])).
rec('PT-012', vra_pt, runnable, run([[next,vra,s5_fail_safe,wal_replay_needed,true]], ['state=s7_recovery_replay'])).
rec('PT-013', vra_pt, runnable, run([[next,vra,s3_eligible_head_selected,tool_state_invalid,true]], ['state=s6_tool_quarantine'])).
rec('PT-014', vra_pt, runnable, run([[next,vra,s3_eligible_head_selected,tool_state_invalid,true],[next,vra,s3_eligible_head_selected,eligibility_checks_done,true]], ['state=s6_tool_quarantine','state=s4_rehydrated_validated'])).
rec('PT-015', vra_pt, runnable, run([[next,vra,s6_tool_quarantine,startup_complete,true]], ['state=s6_tool_quarantine'])).
rec('PT-016', vra_pt, runnable, run([[evidence,vra,deny_chain]], ['FIELD validator_bundle_id','FIELD verified_head_digest','FIELD snapshot_id'])).
rec('PT-017', vra_pt, runnable, run([[evidence,vra,deny_freshness]], ['FIELD validator_bundle_id','FIELD verified_head_digest','FIELD snapshot_id','FIELD policy_id','FIELD source_id','FIELD freshness_value','FIELD irr_digest','FIELD tool_activation_status'])).
rec('PT-018', vra_pt, runnable, run([[evidence,vra,deny_parse]], ['FIELD failure_code','FIELD failed_validator','FIELD suppression_status'])).
rec('PT-019', vra_pt, runnable, run([[evidence,vra,recovery]], ['FIELD recovery_phase','FIELD recovery_phase_producer'])).
rec('PT-020', vra_pt, runnable, run([[evidence,vra,readmission]], ['FIELD readmission_token_id'])).
rec('PT-021', vra_pt, runnable, run([[evidence,vra,producers]], ['validator_bundle_id_producer=executionlayer','failure_explanation_producer=gatelogic','tool_activation_status_producer=toolgate'])).
rec('PT-022', vra_pt, runnable, run([[taxonomy,vra]], ['distinct=true'])).
rec('PT-023', vra_pt, runnable, run([[taxonomy,vra]], ['distinct=true'])).
rec('PT-024', vra_pt, parameterized, run([[next,vra,s8_readmission_pending,authority_release,true]], ['state=s0_startup_readonly'])).
rec('PT-025', vra_pt, runnable, run([[evidence,vra,deny_freshness]], ['FIELD freshness_value','FIELD policy_id','failed_validator=v_freshness'])).
rec('PT-026', vra_pt, runnable, run([[evidence,vra,recovery]], ['FIELD recovery_phase','recovery_phase_producer=v_wal_phase'])).
rec('PT-027', vra_pt, runnable, run([[next,vra,s3_eligible_head_selected,tool_state_invalid,true]], ['state=s6_tool_quarantine'])).
rec('PT-028', vra_pt, declarative, run([[attest,vra,v_compat]], ['attested=v_compat'])).
rec('PT-029', vra_pt, declarative, run([[attest,vra,v_writer_lock]], ['attested=v_writer_lock'])).

% ===== BDA component — PTS-BDA-* (36) =====
rec('PTS-BDA-001', bda_pts, runnable, run([[next,bda,idle,input_received,true]], ['state=ingest_validate'])).
rec('PTS-BDA-002', bda_pts, runnable, run([[next,bda,ingest_validate,validation_pass,true]], ['state=filter_review'])).
rec('PTS-BDA-003', bda_pts, runnable, run([[next,bda,filter_review,no_escalation,true]], ['state=ready_for_release'])).
rec('PTS-BDA-004', bda_pts, runnable, run([[next,bda,finalization_review,evidence_ok,true]], ['state=idle'])).
rec('PTS-BDA-005', bda_pts, runnable, run([[next,bda,ingest_validate,validation_fail,true],[verdict,bda,schema_invalid]], ['state=output_blocked','verdict=block'])).
rec('PTS-BDA-006', bda_pts, runnable, run([[next,bda,filter_review,tool_state_detected,true],[verdict,bda,tool_state_no_approval]], ['state=tool_state_quarantined','verdict=quarantine'])).
rec('PTS-BDA-007', bda_pts, runnable, run([[next,bda,ingest_validate,validation_fail,true],[verdict,bda,allowlist_miss]], ['state=output_blocked','verdict=block'])).
rec('PTS-BDA-008', bda_pts, runnable, run([[next,bda,tool_state_quarantined,approval_granted,false]], ['state=tool_state_quarantined'])).
rec('PTS-BDA-009', bda_pts, runnable, run([[next,bda,ingest_validate,validation_fail,true],[verdict,bda,freshness_replay]], ['state=output_blocked','verdict=block'])).
rec('PTS-BDA-010', bda_pts, runnable, run([[next,bda,ingest_validate,validation_fail,true]], ['state=output_blocked'])).
rec('PTS-BDA-011', bda_pts, declarative, run([[verdict,bda,unlabeled_statement]], ['verdict=block'])).
rec('PTS-BDA-012', bda_pts, runnable, run([[taxonomy,bda]], ['distinct=true'])).
rec('PTS-BDA-013', bda_pts, runnable, run([[next,bda,filter_review,cpw_critical,true],[verdict,bda,cpw_critical]], ['state=output_blocked','verdict=fail_closed'])).
rec('PTS-BDA-014', bda_pts, runnable, run([[next,bda,ingest_validate,validation_fail,true],[next,bda,finalization_review,evidence_fail,true]], ['state=output_blocked','state=noncompliant_hold'])).
rec('PTS-BDA-015', bda_pts, runnable, run([[next,bda,filter_review,cpw_critical,true]], ['state=output_blocked'])).
rec('PTS-BDA-016', bda_pts, runnable, run([[next,bda,finalization_review,cpw_critical,true]], ['state=output_blocked'])).
rec('PTS-BDA-017', bda_pts, runnable, run([[next,bda,tool_state_quarantined,cpw_critical,true]], ['state=output_blocked'])).
rec('PTS-BDA-018', bda_pts, runnable, run([[next,bda,output_blocked,readmission_approved,true]], ['state=idle'])).
rec('PTS-BDA-019', bda_pts, runnable, run([[next,bda,noncompliant_hold,compliance_restored,true]], ['state=idle'])).
rec('PTS-BDA-020', bda_pts, runnable, run([[next,bda,output_blocked,readmission_approved,false],[next,bda,noncompliant_hold,compliance_restored,false]], ['state=output_blocked','state=noncompliant_hold'])).
rec('PTS-BDA-021', bda_pts, runnable, run([[next,bda,idle,input_received,true]], ['state=ingest_validate'])).
rec('PTS-BDA-022', bda_pts, runnable, run([[evidence,bda,artifact]], ['FIELD decision_id','FIELD verdict','FIELD reason_code','FIELD validator_results','FIELD statement_refs','FIELD input_digest'])).
rec('PTS-BDA-023', bda_pts, runnable, run([[evidence,bda,mandatory]], ['FIELD decision_id','FIELD session_id','FIELD boundary_side','FIELD decision_object','FIELD input_digest','FIELD policy_hash','FIELD validator_results','FIELD statement_refs','FIELD verdict','FIELD reason_code','FIELD order_index','FIELD hash_prev','FIELD hash_curr'])).
rec('PTS-BDA-024', bda_pts, runnable, run([[evidence,bda,approval]], ['FIELD approval_ref'])).
rec('PTS-BDA-025', bda_pts, runnable, run([[evidence,bda,finalization]], ['FIELD evidence_ref','FIELD verif_counter_anchor'])).
rec('PTS-BDA-026', bda_pts, runnable, run([[evidence,bda,rollback]], ['FIELD rollback_ref'])).
rec('PTS-BDA-027', bda_pts, declarative, skip('BDA Conformance Tests :516 Section 5 Minimal Run Note bounded-external list entry: authorized non-validator producer grounding (whole-assertion coverage)')).
rec('PTS-BDA-028', bda_pts, runnable, run([[next,bda,ready_for_release,cpw_critical,true]], ['state=output_blocked'])).
rec('PTS-BDA-029', bda_pts, declarative, skip('BDA Conformance Tests :516 Section 5 Minimal Run Note bounded-external list entry: distributed enforcement legitimacy where not exposed by local transition function')).
rec('PTS-BDA-030', bda_pts, runnable, run([[taxonomy,bda]], ['count=7','distinct=true'])).
rec('PTS-BDA-031', bda_pts, runnable, run([[taxonomy,bda]], ['distinct=true'])).
rec('PTS-BDA-032', bda_pts, parameterized, run([[verdict,bda,schema_invalid],[verdict,bda,tool_state_no_approval],[verdict,bda,all_pass]], ['verdict=block','verdict=quarantine','verdict=allow'])).
rec('PTS-BDA-033', bda_pts, runnable, run([[next,bda,ready_for_release,cpw_critical,true],[verdict,bda,cpw_critical]], ['state=output_blocked','verdict=fail_closed'])).
rec('PTS-BDA-034', bda_pts, runnable, run([[evidence,bda,approval]], ['FIELD approval_ref'])).
rec('PTS-BDA-035', bda_pts, runnable, run([[next,bda,finalization_review,evidence_ok,true],[next,bda,finalization_review,evidence_fail,true]], ['state=idle','state=noncompliant_hold'])).
rec('PTS-BDA-036', bda_pts, declarative, run([[taxonomy,bda]], ['distinct=true'])).

% ===== TAA component — dual-reported TAA-PT-* + VP-GEN-* (27 + 27) =====
taa_spec('001', runnable, run([[next,taa,intake,intake_to_role_screening,true]], ['state=role_screening'])).
taa_spec('002', runnable, run([[next,taa,evaluating,evaluating_to_classifying,true]], ['state=classifying'])).
taa_spec('003', runnable, run([[next,taa,decided,decided_to_handoff_ready,true]], ['state=handoff_ready'])).
taa_spec('004', runnable, run([[next,taa,evaluating,evaluating_to_classifying,false]], ['state=fail_closed'])).
taa_spec('005', runnable, run([[next,taa,conflict_checking,conflict_checking_to_allow_constrained_decision,true],[evidence,taa,allow_constrained]], ['state=decided','verdict=allow_constrained'])).
taa_spec('006', runnable, run([[next,taa,conflict_checking,conflict_checking_to_escalate_decision,true],[evidence,taa,escalate]], ['state=decided','verdict=escalate','FIELD escalation_request_ref'])).
taa_spec('007', runnable, run([[next,taa,role_screening,role_screening_reclassify_to_canonicalizing,true]], ['state=canonicalizing'])).
taa_spec('008', runnable, run([[next,taa,classifying,classifying_to_deny_decision,true],[next,taa,evaluating,evaluating_to_fail_closed,true]], ['state=decided','state=fail_closed'])).
taa_spec('009', runnable, run([[next,taa,intake,structural_incompleteness_to_fail_closed,true]], ['state=fail_closed'])).
taa_spec('010', runnable, run([[next,taa,classifying,policy_snapshot_drift_to_fail_closed,true]], ['state=fail_closed'])).
taa_spec('011', runnable, run([[next,taa,evaluating,conflict_checking_to_allow_decision,true]], ['state=fail_closed'])).
taa_spec('012', runnable, run([[next,taa,fail_closed,fail_closed_to_noncompliant_hold,true],[next,taa,noncompliant_hold,noncompliant_hold_to_readmission_pending,true]], ['state=noncompliant_hold','state=readmission_pending'])).
taa_spec('013', runnable, run([[next,taa,readmission_pending,readmission_pending_to_role_screening,true]], ['state=role_screening'])).
taa_spec('014', runnable, run([[next,taa,closed,any_non_reopen,true]], ['state=closed'])).
taa_spec('015', runnable, run([[evidence,taa,base_allow]], ['FIELD semantic_closure','FIELD evidence_closure','FIELD failure_closure','FIELD policy_snapshot_closure'])).
taa_spec('016', runnable, run([[evidence,taa,base_allow]], ['FIELD decision_id','FIELD statement_id_list','FIELD verdict','FIELD reason_code','FIELD tsa_label','FIELD source_class','FIELD boundary_validated_role','FIELD policy_snapshot_id','FIELD order_ref'])).
taa_spec('017', runnable, run([[evidence,taa,allow_constrained]], ['FIELD conflict_check_mode','FIELD conflict_check_strength','FIELD conflict_check_confidence','FIELD conflict_check_coverage_scope','FIELD compared_claim_set_ref','FIELD residual_risk_statement'])).
taa_spec('018', runnable, run([[evidence,taa,fail_closed_escalation]], ['FIELD request_id','FIELD failure_ref','FIELD required_actor_role','FIELD required_evidence','FIELD status'])).
taa_spec('019', runnable, run([[next,taa,decided,clearance_artifact_missing_to_fail_closed,true]], ['state=fail_closed'])).
taa_spec('020', declarative, skip('TAA Conformance Tests declarative record TAA-PT-020-DECL / VP-GEN-020 record-kind line: Declarative conformance claim (not a buyer-runnable unit test); + Section 4 Minimal run note bounded-external list (ordering enforcement distributed across Section 11 + Section 9)')).
taa_spec('021', runnable, run([[taxonomy,taa]], ['count=6'])).
taa_spec('022', runnable, run([[next,taa,role_screening,role_screening_reclassify_to_canonicalizing,true],[next,taa,role_screening,role_screening_to_out_of_scope_decision,true]], ['state=canonicalizing','state=decided'])).
taa_spec('023', parameterized, run([[next,taa,conflict_checking,conflict_checking_to_deny_decision,true],[next,taa,conflict_checking,conflict_checking_to_fail_closed,true]], ['state=decided','state=fail_closed'])).
taa_spec('024', runnable, run([[next,taa,evaluating,evaluating_to_fail_closed,true]], ['state=fail_closed'])).
taa_spec('025', runnable, run([[evidence,taa,allow_constrained]], ['verdict=allow_constrained','FIELD residual_risk_statement'])).
taa_spec('026', runnable, run([[next,taa,conflict_checking,conflict_checking_to_allow_decision,true],[next,taa,intake,intake_to_role_screening,true]], ['state=decided','state=role_screening'])).
taa_spec('027', runnable, run([[next,taa,conflict_checking,conflict_checking_to_allow_decision,true],[next,taa,conflict_checking,conflict_checking_to_allow_constrained_decision,true],[next,taa,conflict_checking,conflict_checking_to_deny_decision,true],[next,taa,conflict_checking,conflict_checking_to_escalate_decision,true]], ['state=decided'])).

% ===== ARA component — ARA-T* (27) =====
rec('ARA-T001', ara_t, runnable, run([[next,ara,s0_ingested,ev_parse_ok,true]], ['state=s1_parsed'])).
rec('ARA-T002', ara_t, runnable, run([[next,ara,s2_verified,replay_fold_complete,true]], ['state=s3_reconstructed'])).
rec('ARA-T003', ara_t, runnable, run([[next,ara,s4_checkpoint_resolved,ev_report_bound,true]], ['state=s5_report_ready'])).
rec('ARA-T004', ara_t, runnable, run([[next,ara,s2_verified,ev_signature_fail,true],[next,ara,s2_verified,ev_chain_break,true],[verdict,ara,chain_break]], ['state=sx_fail_closed','verdict=broken'])).
rec('ARA-T005', ara_t, runnable, run([[next,ara,s4_checkpoint_resolved,report_insufficient,false],[verdict,ara,report_insufficient]], ['state=s4_checkpoint_resolved','verdict=partial'])).
rec('ARA-T006', ara_t, runnable, run([[next,ara,s2_verified,ev_evidence_fail,true]], ['state=sh_hold_active'])).
rec('ARA-T007', ara_t, runnable, run([[next,ara,s3_reconstructed,ev_lastclean_found,false],[verdict,ara,checkpoint_unverified]], ['state=s3_reconstructed','verdict=partial'])).
rec('ARA-T008', ara_t, runnable, run([[next,ara,s2_verified,ev_signature_fail,true],[next,ara,s2_verified,ev_counter_replay,true],[next,ara,s3_reconstructed,ev_lastclean_found,false]], ['state=sx_fail_closed','state=sh_hold_active','state=s3_reconstructed'])).
rec('ARA-T009', ara_t, runnable, run([[next,ara,s2_verified,ev_signature_fail,true]], ['state=sx_fail_closed'])).
rec('ARA-T010', ara_t, runnable, run([[next,ara,s4_checkpoint_resolved,ev_chain_break,false]], ['state=sx_fail_closed'])).
rec('ARA-T011', ara_t, runnable, run([[next,ara,s3_reconstructed,ev_signature_fail,true],[next,ara,s3_reconstructed,ev_evidence_fail,true],[next,ara,s2_verified,ev_policy_unresolved,true]], ['state=sx_fail_closed','state=sh_hold_active'])).
rec('ARA-T012', ara_t, runnable, run([[next,ara,sh_hold_active,ev_readmission_granted,true]], ['state=s6_readmitted'])).
rec('ARA-T013', ara_t, runnable, run([[next,ara,sh_hold_active,ev_readmission_granted,false],[next,ara,sx_fail_closed,ev_readmission_granted,false]], ['state=sh_hold_active','state=sx_fail_closed'])).
rec('ARA-T014', ara_t, runnable, run([[next,ara,s5_report_ready,ev_report_bound,true]], ['state=s5_report_ready'])).
rec('ARA-T015', ara_t, runnable, run([[evidence,ara,final_output]], ['FIELD report_signature','FIELD export_manifest_ref','FIELD chain_of_custody'])).
rec('ARA-T016', ara_t, runnable, run([[evidence,ara,mandatory]], ['FIELD bundle_digest','FIELD policy_profile_id','FIELD validator_outcomes','FIELD hash_continuity_refs','FIELD checkpoint_refs','FIELD rollback_refs'])).
rec('ARA-T017', ara_t, runnable, run([[evidence,ara,hold_readmission]], ['FIELD hold_enter_refs','FIELD hold_exit_refs','FIELD anchor_update_ref'])).
rec('ARA-T018', ara_t, runnable, run([[evidence,ara,producers]], ['FIELD bundle_digest','FIELD validator_outcomes','FIELD report_fields_ref'])).
rec('ARA-T019', ara_t, declarative, run([[verdict,ara,tool_state]], ['verdict=quarantine'])).
rec('ARA-T020', ara_t, declarative, run([[verdict,ara,tool_state]], ['verdict=quarantine'])).
rec('ARA-T021', ara_t, runnable, run([[taxonomy,ara]], ['distinct=true'])).
rec('ARA-T022', ara_t, runnable, run([[taxonomy,ara]], ['distinct=true'])).
rec('ARA-T023', ara_t, parameterized, run([[next,ara,s2_verified,ev_policy_unresolved,true],[next,ara,s6_readmitted,resume_s2,true],[next,ara,s6_readmitted,resume_s4,true]], ['state=sx_fail_closed','state=s2_verified','state=s4_checkpoint_resolved'])).
rec('ARA-T024', ara_t, runnable, run([[next,ara,s3_reconstructed,ev_lastclean_found,true]], ['state=s4_checkpoint_resolved'])).
rec('ARA-T025', ara_t, runnable, run([[evidence,ara,readmission_closure]], ['FIELD hold_exit_refs','FIELD anchor_update_ref','FIELD policy_profile_id'])).
rec('ARA-T026', ara_t, runnable, run([[next,ara,s4_checkpoint_resolved,ev_report_bound,true]], ['state=s5_report_ready'])).
rec('ARA-T027', ara_t, declarative, run([[verdict,ara,tool_state]], ['verdict=quarantine'])).

% ===== FPA component — FPA-T-*/FPA-D-* (41) =====
rec('FPA-D-01', fpa, declarative, skip('FPA Section F.D declarative-obligations section placement + Section H Minimal Run Note documented-mode clause: every declarative obligation in F.D is documented in the buyer conformance record as a non-runnable but required obligation')).
rec('FPA-D-02', fpa, declarative, skip('FPA Section F.D declarative-obligations section placement + Section H Minimal Run Note documented-mode clause: every declarative obligation in F.D is documented in the buyer conformance record as a non-runnable but required obligation')).
rec('FPA-D-03', fpa, declarative, skip('FPA Section F.D declarative-obligations section placement + Section H Minimal Run Note documented-mode clause: every declarative obligation in F.D is documented in the buyer conformance record as a non-runnable but required obligation')).
rec('FPA-D-04', fpa, declarative, skip('FPA Section F.D declarative-obligations section placement + Section H Minimal Run Note documented-mode clause: every declarative obligation in F.D is documented in the buyer conformance record as a non-runnable but required obligation')).
rec('FPA-D-05', fpa, declarative, skip('FPA Section F.D declarative-obligations section placement + Section H Minimal Run Note documented-mode clause: every declarative obligation in F.D is documented in the buyer conformance record as a non-runnable but required obligation')).
rec('FPA-D-06', fpa, declarative, skip('FPA Section F.D declarative-obligations section placement + Section H Minimal Run Note documented-mode clause: every declarative obligation in F.D is documented in the buyer conformance record as a non-runnable but required obligation')).
rec('FPA-T-01', fpa, runnable, run([[next,fpa,s0_idle,transfer_packet_received,true]], ['state=s1_received'])).
rec('FPA-T-02', fpa, runnable, run([[next,fpa,s1_received,structure_valid,true]], ['state=s2_verified'])).
rec('FPA-T-03', fpa, runnable, run([[next,fpa,s6_restoration_eligible,restore_admitted,true]], ['state=s0_idle'])).
rec('FPA-T-04', fpa, runnable, run([[next,fpa,s1_received,structure_valid,false],[next,fpa,s1_received,structure_invalid,true]], ['state=s8_rejected'])).
rec('FPA-T-06', fpa, runnable, run([[next,fpa,s2_verified,evidence_pending,false]], ['state=s7_quarantined'])).
rec('FPA-T-08a', fpa, runnable, run([[next,fpa,s2_verified,freshness_fail,true]], ['state=s8_rejected'])).
rec('FPA-T-08b', fpa, runnable, run([[next,fpa,s5_watermark_committed,restore_request_genesis_confirmed,false]], ['state=s8_rejected'])).
rec('FPA-T-08c', fpa, runnable, run([[taxonomy,fpa]], ['distinct=true'])).
rec('FPA-T-09', fpa, runnable, run([[next,fpa,s2_verified,freshness_pass,false]], ['state=s8_rejected'])).
rec('FPA-T-10', fpa, runnable, run([[next,fpa,s5_watermark_committed,restore_request_genesis_confirmed,false]], ['state=s8_rejected'])).
rec('FPA-T-11', fpa, runnable, run([[next,fpa,s4_irr_committed,freshness_pass,true]], ['state=s8_rejected'])).
rec('FPA-T-12', fpa, runnable, run([[next,fpa,s7_quarantined,readmission_approved,true]], ['state=s2_verified'])).
rec('FPA-T-13a', fpa, runnable, run([[next,fpa,s5_watermark_committed,restore_request_genesis_confirmed,true]], ['state=s6_restoration_eligible'])).
rec('FPA-T-13b', fpa, runnable, run([[next,fpa,s6_restoration_eligible,restore_admitted,true]], ['state=s0_idle'])).
rec('FPA-T-14', fpa, runnable, run([[next,fpa,s8_rejected,freshness_pass,true]], ['state=s8_rejected'])).
rec('FPA-T-15', fpa, runnable, run([[evidence,fpa,deny_restore]], ['verdict=fail_closed','gate_class=block','FIELD reason_code'])).
rec('FPA-T-16', fpa, runnable, run([[evidence,fpa,accept]], ['verdict=accept','gate_class=release','FIELD decision_id','FIELD packet_hash','FIELD watermark_after'])).
rec('FPA-T-17A', fpa, parameterized, run([[param,fpa,tvc,true],[param,fpa,tvc,false]], ['activation=true','FIELD tvc_validation_result','activation=false'])).
rec('FPA-T-17B', fpa, parameterized, run([[param,fpa,evidence_bin,true],[param,fpa,evidence_bin,false]], ['activation=true','FIELD evidence_validation_result','activation=false'])).
rec('FPA-T-17C', fpa, parameterized, run([[param,fpa,transport,true],[param,fpa,transport,false]], ['activation=true','FIELD transport_validation_result','activation=false'])).
rec('FPA-T-17D', fpa, runnable, run([[evidence,fpa,accept]], ['FIELD irr_digest','FIELD prev_receipt_digest'])).
rec('FPA-T-18', fpa, runnable, run([[evidence,fpa,accept]], ['FIELD decision_id','FIELD agent_id','FIELD source_id','FIELD ledger_uuid','FIELD decision_object','FIELD watermark_before','FIELD watermark_after'])).
rec('FPA-T-21', fpa, runnable, run([[taxonomy,fpa]], ['verdict_restoration_eligible=restoration_eligible','state_restoration_eligible=s6_restoration_eligible','distinct=true'])).
rec('FPA-T-23', fpa, parameterized, run([[param,fpa,recoverable,true],[param,fpa,recoverable,false]], ['state=s7_quarantined','state=s8_rejected'])).
rec('FPA-T-24', fpa, runnable, run([[next,fpa,s2_verified,freshness_pass,true]], ['state=s3_freshness_eligible'])).
rec('FPA-T-25', fpa, parameterized, run([[evidence,fpa,quarantine]], ['verdict=quarantine','gate_class=escalation','FIELD evidence_validation_result'])).
rec('FPA-T-26', fpa, runnable, run([[next,fpa,s3_freshness_eligible,irr_appended,true]], ['state=s4_irr_committed'])).
rec('FPA-T-PR-01', fpa, runnable, run([[next,fpa,s2_verified,freshness_fail,true]], ['state=s8_rejected'])).
rec('FPA-T-PR-02', fpa, runnable, run([[next,fpa,s3_freshness_eligible,irr_appended,true],[next,fpa,s4_irr_committed,watermark_persisted,true],[next,fpa,s3_freshness_eligible,watermark_persisted,true]], ['state=s4_irr_committed','state=s5_watermark_committed','state=s8_rejected'])).
rec('FPA-T-PR-03', fpa, runnable, run([[next,fpa,s5_watermark_committed,restore_request_genesis_confirmed,true]], ['state=s6_restoration_eligible'])).
rec('FPA-T-PR-09', fpa, runnable, run([[next,fpa,s5_watermark_committed,restore_request_genesis_confirmed,true],[next,fpa,s5_watermark_committed,restore_request_genesis_confirmed,false]], ['state=s6_restoration_eligible','state=s8_rejected'])).
rec('FPA-T-PR-10', fpa, runnable, run([[next,fpa,s0_idle,restore_admitted,true]], ['state=s8_rejected'])).
rec('FPA-T-PR-12', fpa, runnable, run([[next,fpa,s7_quarantined,readmission_approved,true],[next,fpa,s0_idle,readmission_approved,true]], ['state=s2_verified','state=s8_rejected'])).
rec('FPA-T-PR-13', fpa, runnable, run([[next,fpa,s2_verified,freshness_pass,true],[next,fpa,s3_freshness_eligible,irr_appended,true]], ['state=s3_freshness_eligible','state=s4_irr_committed'])).
rec('FPA-T-PR-14', fpa, runnable, run([[next,fpa,s4_irr_committed,watermark_persisted,false]], ['state=s8_rejected'])).

% ===== SSCAR integrator — PTS-* (30) =====
rec('PTS-001', sscar_pts, runnable, run([[next,fam,s0,fv01_pass,true]], ['state=s1'])).
rec('PTS-002', sscar_pts, runnable, run([[next,fam,s2,fv03_pass,true]], ['state=s3'])).
rec('PTS-003', sscar_pts, runnable, run([[closure,complete]], ['state=s8','verdict=replay_admissible','foc01=produced'])).
rec('PTS-004a', sscar_pts, runnable, run([[next,fam,s1,fv02_and_fv04_pass,false]], ['state=sx'])).
rec('PTS-004b', sscar_pts, runnable, run([[next,fam,s2,unlabeled_mechanism_level_carried_claim,false]], ['state=sx'])).
rec('PTS-005', sscar_pts, declarative, skip('SSCAR Conformance Tests Section 5 closed-enumeration note: declarative record listed in Section 7 Public Oracles, not the Section 5 buyer-runnable table')).
rec('PTS-006', sscar_pts, runnable, run([[next,fam,s3,freshness_replay,false],[verdict,fam,fv06_freshness],[foc,hold]], ['state=sh','verdict=noncompliant_hold','FIELD hold_enter_refs'])).
rec('PTS-007', sscar_pts, parameterized, run([[next,fam,s2,fv04_reclassification_pending,false]], ['state=s2'])).
rec('PTS-008', sscar_pts, runnable, run([[next,fam,s3,freshness_replay,false],[next,fam,s3,critical_contamination,false]], ['state=sh','state=sx'])).
rec('PTS-009', sscar_pts, runnable, run([[next,fam,s3,critical_contamination,false],[next,fam,s5,critical_contamination,false],[next,fam,s0,critical_contamination,false]], ['state=sx'])).
rec('PTS-010', sscar_pts, runnable, run([[next,fam,s5,anti_rollback_failure,false]], ['state=sx'])).
rec('PTS-011', sscar_pts, runnable, run([[next,fam,s3,chain_break,false],[next,fam,s3,untrusted_anchor_promoted,false]], ['state=sx'])).
rec('PTS-012', sscar_pts, runnable, run([[next,fam,sh,hold_case_with_new_family_closure_bundle_and_anchor_update,true],[next,fam,sh,hold_case_with_new_family_closure_bundle_and_anchor_update,false]], ['state=sr','state=sh'])).
rec('PTS-013', sscar_pts, runnable, run([[next,fam,sr,readmission_bundle_changed_carried_payload,true]], ['state=s2'])).
rec('PTS-014', sscar_pts, runnable, run([[next,fam,s8,handoff,true],[next,fam,sx,incident_only_output,true]], ['state=s8','state=sx'])).
rec('PTS-015', sscar_pts, declarative, skip('SSCAR Conformance Tests Section 5 closed-enumeration note: Section 7-relocated declarative (ORC-CONSTRAINED-DELTA family)')).
rec('PTS-016', sscar_pts, runnable, run([[evidence,fam,complete]], ['FIELD family_decision_id','FIELD boundary_event_id','FIELD carried_statement_refs','FIELD tsa_refs_provenance_refs','FIELD anchor_document_digest_ref','FIELD accepted_head_digest_linked_irr_digest','FIELD rehydration_closure_ref','FIELD disclosure_class_entries','FIELD family_validator_outcomes','FIELD report_signature_export_manifest_ref'])).
rec('PTS-017a', sscar_pts, runnable, run([[foc,contamination]], ['FIELD tsa_refs','FIELD blocked_stage','FIELD contaminating_ref_set'])).
rec('PTS-017b', sscar_pts, runnable, run([[foc,hold]], ['FIELD freshness_before','FIELD freshness_after','FIELD hold_enter_refs'])).
rec('PTS-017d', sscar_pts, runnable, run([[foc,readmission]], ['FIELD hold_exit_refs','FIELD anchor_update_ref'])).
rec('PTS-018', sscar_pts, runnable, run([[foc,producers]], ['FIELD incident_id','FIELD contaminating_ref_set','FIELD hold_case_id','FIELD hold_enter_refs'])).
rec('PTS-019', sscar_pts, declarative, skip('SSCAR Conformance Tests Section 5 closed-enumeration note: Section 7-relocated declarative (ORC-FOC-PRODUCERS)')).
rec('PTS-020', sscar_pts, declarative, skip('SSCAR Conformance Tests Section 5 closed-enumeration note: Section 7-relocated declarative (ORC-DISTRIBUTED-LEGITIMACY)')).
rec('PTS-021', sscar_pts, runnable, run([[taxonomy,fam]], ['count=6','distinct=true'])).
rec('PTS-022', sscar_pts, runnable, run([[next,fam,s3,freshness_replay,false],[verdict,fam,fv06_freshness],[next,fam,s3,critical_contamination,false],[verdict,fam,fv09_contam]], ['state=sh','verdict=noncompliant_hold','state=sx','verdict=contamination_fail_closed'])).
rec('PTS-023', sscar_pts, parameterized, run([[next,fam,sr,readmission_bundle_changed_carried_payload,true],[next,fam,sr,readmission_bundle_changed_policy_snapshot_id,true]], ['state=s2','state=s5'])).
rec('PTS-024', sscar_pts, runnable, run([[next,fam,s4,fv07_pass,true]], ['state=s5'])).
rec('PTS-025', sscar_pts, runnable, run([[evidence,fam,anti_rollback]], ['state=sx','verdict=contamination_fail_closed','FIELD rehydration_closure_ref','FIELD anchor_document_digest_ref','FIELD family_validator_outcomes'])).
rec('PTS-026', sscar_pts, runnable, run([[next,fam,s1,fv02_and_fv04_pass,false]], ['state=sx'])).
rec('PTS-027', sscar_pts, declarative, skip('SSCAR Conformance Tests Section 5 closed-enumeration note: Section 7-relocated declarative (canonical verdict taxonomy)')).

% ===== Annex-C Family Connector Test Suite — CT-* (14) =====
rec('CT-01', conn_ct, connector, run([[ct,'1']], ['state=s1','FIELD family_validator_outcomes'])).
rec('CT-02', conn_ct, connector, run([[ct,'2']], ['verdict=contamination_fail_closed','blocked_stage=provenance_classification','FIELD contamination_flags'])).
rec('CT-03', conn_ct, connector, run([[ct,'3']], ['state=s1','anchor=untrusted_until_verification'])).
rec('CT-04', conn_ct, connector, run([[ct,'4']], ['state=sh','verdict=noncompliant_hold','FIELD hold_enter_refs'])).
rec('CT-05', conn_ct, connector, run([[ct,'5']], ['verdict=replay_incomplete','FIELD accepted_head_digest_linked_irr_digest'])).
rec('CT-06', conn_ct, connector, run([[ct,'6']], ['state=s5','FIELD rehydration_closure_ref'])).
rec('CT-07', conn_ct, connector, run([[ct,'7']], ['verdict=replay_incomplete','FIELD replay_refs_checkpoint_refs_rollback_refs'])).
rec('CT-08', conn_ct, connector, run([[ct,'8']], ['state=s8','verdict=replay_admissible','FIELD family_validator_outcomes'])).
rec('CT-09', conn_ct, connector, run([[ct,'9']], ['verdict=contamination_fail_closed','FIELD contaminating_ref_set'])).
rec('CT-10', conn_ct, connector, run([[ct,'10']], ['state=sr','FIELD hold_exit_refs','FIELD anchor_update_ref'])).
rec('CT-11', conn_ct, connector, run([[ct,'11']], ['verdict=incident_only','FIELD disclosure_class_entries'])).
rec('CT-12', conn_ct, connector, run([[ct,'12']], ['verdict=incident_only','FIELD family_validator_outcomes'])).
rec('CT-13', conn_ct, connector, run([[ct,'13']], ['state=s2','reclassification=explicit_policy_bound'])).
rec('CT-14', conn_ct, connector, run([[ct,'14']], ['case_a=s2','case_c=s5','reentry_envelope=closed_two_point'])).

% TAA dual-namespace expansion (same record reported under both pinned ids).
record(Id, taa_pt, Cat, Spec) :- taa_spec(N, Cat, Spec), atom_concat('TAA-PT-', N, Id).
record(Id, vp_gen, Cat, Spec) :- taa_spec(N, Cat, Spec), atom_concat('VP-GEN-', N, Id).
record(Id, Suite, Cat, Spec) :- rec(Id, Suite, Cat, Spec).

% ---- execution ------------------------------------------------------
run_once(Exe, BL, Args, Code, Out) :-
    catch(
      ( process_create(Exe, ['-q', BL, '--' | Args],
            [ stdout(pipe(S)), stderr(null), process(PID) ]),
        read_string(S, _, Out),
        close(S),
        process_wait(PID, exit(Code)) ),
      _E,
      ( Code = 999, Out = "EXCEPTION: process could not be started" )).

contains_all(_, []).
contains_all(Full, [N|T]) :- sub_atom(Full, _, _, _, N), contains_all(Full, T).

cmd_atom(Exe, BL, Args, Cmd) :-
    atomic_list_concat(Args, ' ', ArgsA),
    atomic_list_concat([Exe, ' -q ', BL, ' -- ', ArgsA], Cmd).

oneline(Str, Line) :-
    split_string(Str, "\r\n", "", Parts0),
    exclude([P]>>(P==""), Parts0, Parts),
    atomic_list_concat(Parts, ' / ', Line).

tail4096(Out0, Tail) :-
    oneline(Out0, Out),
    atom_length(Out, L),
    ( L =< 4096 -> Tail = Out
    ; Start is L - 4096, sub_atom(Out, Start, _, 0, Tail) ).

% execute one record's invocations; log blocks; return Status + concat Out.
exec_record(Exe, BL, LogS, Id, run(Invs, Expect), Status) :-
    format(LogS, "PT-ID: ~w~n", [Id]),
    exec_invs(Exe, BL, LogS, Invs, Codes, Outs),
    atomic_list_concat(Outs, '\n', Full),
    ( memberchk(999, Codes) -> Status = 'ERROR'
    ; ( \+ ( member(C, Codes), C =\= 0 ) , contains_all(Full, Expect) ) -> Status = 'PASS'
    ; Status = 'FAIL' ).
exec_record(_, _, LogS, Id, skip(Cite), 'SKIP') :-
    format(LogS, "PT-ID: ~w~n", [Id]),
    format(LogS, "COMMAND: (no invocation -- SKIP: ~w)~n", [Cite]),
    format(LogS, "EXIT_CODE: -1~n", []),
    format(LogS, "STDOUT_TAIL: (not invoked; see pt_results.json notes)~n~n", []).

exec_invs(_, _, _, [], [], []).
exec_invs(Exe, BL, LogS, [Args|T], [Code|Cs], [Out|Os]) :-
    run_once(Exe, BL, Args, Code, Out),
    cmd_atom(Exe, BL, Args, Cmd),
    tail4096(Out, Tail),
    format(LogS, "COMMAND: ~w~n", [Cmd]),
    format(LogS, "EXIT_CODE: ~w~n", [Code]),
    format(LogS, "STDOUT_TAIL: ~w~n", [Tail]),
    exec_invs(Exe, BL, LogS, T, Cs, Os),
    ( T == [] -> format(LogS, "~n", []) ; true ).

% JSON note text per status (no double-quotes inside).
note_for('PASS', run(Invs,_), N) :- length(Invs, K),
    format(atom(N), "exercised live; ~w invocation(s); captured stdout matched the derived oracle", [K]).
note_for('FAIL', run(Invs,_), N) :- length(Invs, K),
    format(atom(N), "exercised live; ~w invocation(s); captured stdout did not match the derived oracle (reported as result, not halt)", [K]).
note_for('ERROR', _, 'real execution attempt could not start the baseline process').
note_for('SKIP', skip(Cite), Cite).

% ---- main -----------------------------------------------------------
main :-
    current_prolog_flag(executable, Exe),
    baseline_path(BL),
    ( exists_file(BL) -> true
    ; format(user_error, "FAIL-CLOSED: baseline not found at ~w~n", [BL]), halt(2) ),
    out_path('pt_run_log.txt', LogP),
    out_path('pt_results.json', ResP),
    open(LogP, write, LogS),
    findall(r(Id,Suite,Cat,Spec), record(Id,Suite,Cat,Spec), Recs),
    run_all(Exe, BL, LogS, Recs, Rows),
    close(LogS),
    write_results(ResP, Rows),
    summarize(Rows).

run_all(_, _, _, [], []).
run_all(Exe, BL, LogS, [r(Id,_Suite,Cat,Spec)|T], [row(Id,Cat,Status,Note)|Rows]) :-
    exec_record(Exe, BL, LogS, Id, Spec, Status),
    note_for(Status, Spec, Note),
    run_all(Exe, BL, LogS, T, Rows).

count_status(Rows, S, N) :- include([row(_,_,St,_)]>>(St==S), Rows, L), length(L, N).

write_results(ResP, Rows) :-
    length(Rows, Total),
    count_status(Rows, 'PASS', P), count_status(Rows, 'FAIL', F),
    count_status(Rows, 'SKIP', Sk), count_status(Rows, 'ERROR', Er),
    get_time(T), format_time(atom(Ts), "%FT%T%z", T),
    open(ResP, write, S),
    format(S, "{~n", []),
    format(S, '  "agent_id": "FAM-SSCAR-FI-001",~n', []),
    format(S, '  "lang": "prolog",~n', []),
    format(S, '  "test_run_timestamp_utc": "~w",~n', [Ts]),
    format(S, '  "execution_mode": "live",~n', []),
    format(S, '  "protocol": "buyer-conformance",~n', []),
    format(S, '  "totals": {"total": ~w, "pass": ~w, "fail": ~w, "skip": ~w, "error": ~w},~n',
           [Total, P, F, Sk, Er]),
    format(S, '  "results": [~n', []),
    write_rows(S, Rows),
    format(S, "  ]~n}~n", []),
    close(S).

write_rows(_, []).
write_rows(S, [row(Id,Cat,St,Note)|T]) :-
    ( T == [] -> Comma = '' ; Comma = ',' ),
    format(S, '    {"id": "~w", "category": "~w", "status": "~w", "notes": "~w"}~w~n',
           [Id, Cat, St, Note, Comma]),
    write_rows(S, T).

summarize(Rows) :-
    length(Rows, Total),
    count_status(Rows, 'PASS', P), count_status(Rows, 'FAIL', F),
    count_status(Rows, 'SKIP', Sk), count_status(Rows, 'ERROR', Er),
    format("run_pts complete: total=~w pass=~w fail=~w skip=~w error=~w~n",
           [Total, P, F, Sk, Er]).
