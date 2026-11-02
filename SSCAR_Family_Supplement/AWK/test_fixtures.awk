# CT §6 fixture records, keyed only by their canonical PFX identifiers.
function make_fixture(fixture_id, fields,    prior) {
    delete fields
    fields["anchor_document_ref"]="anchor-ref-1"; fields["anchor_document_digest"]="anchor-digest-1"
    fields["carried_payload"]="payload-1"; fields["source_control_bundles"]="components-1"
    fields["evidence_ok"]="true"; fields["tool_state_activation"]="false"; fields["trust_assertion"]="unverified"
    fields["crash_proximity_warning_state"]="clear"; fields["authority_model_assignment"]="authorized"
    fields["tsa_label"]="mechanism-level"; fields["source_class"]="admitted"; fields["statement_id"]="statement-1"; fields["tsa_refs"]="tsa-1"; fields["provenance_refs"]="provenance-1"
    fields["boundary_validated_role"]="mechanism-level"; fields["explicit_reclassification"]="false"
    fields["policy_snapshot_id"]="policy-1"; fields["residual_risk_statement"]="none"; fields["escalation_request_ref"]=""
    fields["accepted_head_digest"]="head-1"; fields["linked_irr_digest"]="irr-1"; fields["irr_digest"]="irr-1"
    fields["freshness_before"]=10; fields["freshness_after"]=11; fields["anchor_update_ref"]=11
    fields["readmission_state_flag"]="not_pending"; fields["hold_exit_refs"]="hold-exit-1"; fields["hold_enter_refs"]="hold-enter-1"
    fields["pending_requirements"]="FV-06"
    fields["restoration_request"]="restore-1"; fields["import_admissibility"]="admissible"
    fields["verified_head_selection"]="head-1"; fields["validator_bundle_id"]="bundle-1"
    fields["snapshot_id"]="snapshot-1"; fields["failure_code"]="none"; fields["readmission_request"]="none"
    fields["vra_state"]="startup_readonly"; fields["rehydration_closure_ref"]="rehydration-1"
    fields["read_only_startup"]="true"; fields["snapshot_stable"]="true"
    fields["checkpoint_refs"]="checkpoint-1"; fields["rollback_refs"]="rollback-1"; fields["replay_refs"]="replay-1"
    fields["report_id"]="report-1"; fields["report_signature"]="signature-1"; fields["export_manifest_ref"]="export-1"
    fields["disclosure_class_entries"]="[]"; fields["family_decision_id"]="decision-1"
    fields["boundary_event_id"]="boundary-event-1"; fields["session_id"]="session-1"; fields["prior_session_ref"]="session-prior-1"
    fields["verification_counter"]=0
    fields["prior_record" SUBSEP "anchor_update_ref"]=10
    fields["prior_record" SUBSEP "carried_payload"]="payload-1"
    fields["prior_record" SUBSEP "anchor_document_ref"]="anchor-ref-1"
    fields["prior_record" SUBSEP "source_control_bundles"]="components-1"
    fields["prior_record" SUBSEP "policy_snapshot_id"]="policy-1"
    fields["prior_record" SUBSEP "rehydration_closure_ref"]="rehydration-1"
    if (fixture_id=="PFX-CONTAM-FV02") { fields["anchor_document_ref"]=""; fields["evidence_ok"]="false" }
    if (fixture_id=="PFX-CONTAM-FV03") { fields["tsa_label"]="" }
    if (fixture_id=="PFX-FRESHNESS-REPLAY") { fields["freshness_after"]=fields["freshness_before"]; fields["pending_requirements"]="FV-06" }
    if (fixture_id=="PFX-CRITICAL-CONTAM") { fields["tool_state_activation"]="true" }
    if (fixture_id=="PFX-ANTIROLLBACK-S5") { fields["failure_code"]="anti_rollback" }
    if (fixture_id=="PFX-CHAINBREAK-S3") { fields["failure_code"]="chain_break" }
    if (fixture_id=="PFX-HOLD-CASE") { fields["hold_exit_refs"]="hold-exit-2"; fields["anchor_update_ref"]=12; fields["prior_record" SUBSEP "anchor_update_ref"]=11; fields["readmission_state_flag"]="pending"; fields["disclosure_class_entries"]="BOUNDED_HANDOFF_OBLIGATION" }
    if (fixture_id=="PFX-RE-ENTRY-S2") { fields["carried_payload"]="payload-2"; fields["readmission_state_flag"]="pending"; fields["hold_exit_refs"]="hold-exit-2"; fields["anchor_update_ref"]=12; fields["prior_record" SUBSEP "anchor_update_ref"]=11 }
    if (fixture_id=="PFX-RE-ENTRY-S5") { fields["policy_snapshot_id"]="policy-2"; fields["readmission_state_flag"]="pending"; fields["hold_exit_refs"]="hold-exit-2"; fields["anchor_update_ref"]=12; fields["prior_record" SUBSEP "anchor_update_ref"]=11 }
    if (fixture_id=="PFX-CONSTRAINED-CLOSURE") fields["disclosure_class_entries"]="BOUNDED_EXECUTION_NEUTRAL_OPENNESS"
}
function compose_fixture(fixture_id, f,    fixture_data) { make_fixture(fixture_id,fixture_data); compose_family(fixture_data,f) }
function compose_fixture_override(fixture_id, field, value, f,    fixture_data) {
    make_fixture(fixture_id,fixture_data); fixture_data[field]=value; compose_family(fixture_data,f)
}
