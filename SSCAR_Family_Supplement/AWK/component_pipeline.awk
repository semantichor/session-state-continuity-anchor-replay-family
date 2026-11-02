# Component outputs are formed from the CT fixture's component input records.
# Family validators and the verdict layer are evaluated only after composition.
function produce_bda(i,o) {
    o["producer_id"]="BDA"
    o["anchor_document_ref"]=i["anchor_document_ref"]; o["anchor_document_digest"]=i["anchor_document_digest"]; o["carried_payload"]=i["carried_payload"]
    o["tsa_label"]=i["tsa_label"]; o["source_class"]=i["source_class"]
    o["crash_proximity_warning_state"]=i["crash_proximity_warning_state"]
    o["accepted_anchor"]=(o["anchor_document_ref"]!="" && o["anchor_document_digest"]!="" && i["evidence_ok"]=="true")
    o["evidence_ok"]=(o["carried_payload"]!="" && i["evidence_ok"]=="true")
    o["verification_counter"]=i["verification_counter"]
    o["tool_state_activation"]=i["tool_state_activation"]; o["trust_assertion"]=i["trust_assertion"]
    o["source_control_bundles"]=i["source_control_bundles"]
    o["authority_model_assignment"]=i["authority_model_assignment"]
}
function produce_taa(i,o) {
    o["producer_id"]="TAA"
    o["statement_id"]=i["statement_id"]; o["tsa_label"]=i["tsa_label"]
    o["source_class"]=i["source_class"]; o["policy_snapshot_id"]=i["policy_snapshot_id"]
    o["boundary_validated_role"]=i["boundary_validated_role"]
    o["residual_risk_statement"]=i["residual_risk_statement"]
    o["escalation_request_ref"]=i["escalation_request_ref"]
    o["disclosure_class_entries"]=i["disclosure_class_entries"]
}
function produce_fpa(i,o) {
    o["producer_id"]="FPA"
    o["accepted_head_digest"]=i["accepted_head_digest"]; o["linked_irr_digest"]=i["linked_irr_digest"]
    o["freshness_before"]=i["freshness_before"]; o["freshness_after"]=i["freshness_after"]
    o["anchor_update_ref"]=i["anchor_update_ref"]; o["readmission_state_flag"]=i["readmission_state_flag"]
    o["hold_exit_refs"]=i["hold_exit_refs"]
}
function produce_vra(i,o) {
    o["producer_id"]="VRA"
    o["restoration_request"]=i["restoration_request"]; o["import_admissibility"]=i["import_admissibility"]
    o["verified_head_selection"]=i["verified_head_selection"]; o["validator_bundle_id"]=i["validator_bundle_id"]
    o["snapshot_id"]=i["snapshot_id"]; o["irr_digest"]=i["irr_digest"]
    o["failure_code"]=i["failure_code"]; o["readmission_request"]=i["readmission_request"]
    o["state"]=i["vra_state"]; o["rehydration_closure_ref"]=i["rehydration_closure_ref"]
    o["read_only_startup"]=i["read_only_startup"]; o["snapshot_stable"]=i["snapshot_stable"]
    o["anti_rollback_passed"]=(o["failure_code"]!="anti_rollback" && i["failure_code"]!="anti_rollback")
    o["signature_chain_passed"]=(i["failure_code"]!="chain_break" && o["import_admissibility"]=="admissible")
}
function produce_ara(i,o) {
    o["producer_id"]="ARA"
    o["checkpoint_refs"]=i["checkpoint_refs"]; o["rollback_refs"]=i["rollback_refs"]
    o["replay_refs"]=i["replay_refs"]; o["report_id"]=i["report_id"]
    o["report_signature"]=i["report_signature"]; o["disclosure_class_entries"]=i["disclosure_class_entries"]
    o["report_sufficiency"]=(o["report_id"]!="" && o["checkpoint_refs"]!="" && o["rollback_refs"]!="" && o["replay_refs"]!="")
}
function outcome_text(f, include_fv11,    n,s) {
    s=""
    for(n=1;n<=12;n++) {
        if(n==11 && !include_fv11) continue
        s=s (s==""?"":";") sprintf("FV-%02d=%s",n,(f[sprintf("FV-%02d",n)]?"PASS":"FAIL"))
    }
    return s
}
function compose_family(fixture_data, f,    b,t,p,v,a,k) {
    delete f
    produce_bda(fixture_data,b); produce_taa(fixture_data,t); produce_fpa(fixture_data,p); produce_vra(fixture_data,v); produce_ara(fixture_data,a)
    for(k in b) f[k]=b[k]; for(k in t) f[k]=t[k]; for(k in p) f[k]=p[k]; for(k in v) f[k]=v[k]; for(k in a) f[k]=a[k]
    f["component_set_count"]=(b["producer_id"]!="")+(t["producer_id"]!="")+(p["producer_id"]!="")+(v["producer_id"]!="")+(a["producer_id"]!="")
    f["report_signature"]=a["report_signature"]; f["export_manifest_ref"]=fixture_data["export_manifest_ref"]
    f["FV-01"]=(f["component_set_count"]==5)
    f["family_decision_id"]=fixture_data["family_decision_id"]
    f["tsa_refs"]=fixture_data["tsa_refs"]; f["provenance_refs"]=fixture_data["provenance_refs"]
    f["boundary_event_id"]=fixture_data["boundary_event_id"]
    f["session_id"]=fixture_data["session_id"]
    f["prior_session_ref"]=fixture_data["prior_session_ref"]
    f["FV-02"]=(f["anchor_document_ref"]!="" && f["anchor_document_digest"]!="" && f["carried_payload"]!="" && f["tool_state_activation"]=="false" && f["accepted_anchor"]==1 && f["evidence_ok"]==1)
    f["FV-03"]=(f["statement_id"]!="" && f["tsa_label"]!="" && f["source_class"]!="" && f["policy_snapshot_id"]!="")
    f["FV-04"]=!(f["boundary_validated_role"]=="explanatory-only" && f["tsa_label"]=="mechanism-level" && fixture_data["explicit_reclassification"]!="true") && f["authority_model_assignment"]!="untrusted"
    f["FV-05"]=(f["accepted_head_digest"]!="" && f["linked_irr_digest"]==f["irr_digest"] && f["verified_head_selection"]==f["accepted_head_digest"])
    f["FV-06"]=(f["freshness_before"]!="" && f["freshness_after"]!="" && f["freshness_after"]>f["freshness_before"] && f["anchor_update_ref"]!="" && fixture_data["prior_record" SUBSEP "anchor_update_ref"]!="" && f["anchor_update_ref"]>fixture_data["prior_record" SUBSEP "anchor_update_ref"])
    f["freshness_hold"]=!f["FV-06"]
    f["FV-07"]=(f["rehydration_closure_ref"]!="" && f["snapshot_id"]!="" && f["read_only_startup"]=="true" && f["snapshot_stable"]=="true" && f["anti_rollback_passed"] && f["signature_chain_passed"] && f["policy_snapshot_id"]!="")
    f["FV-08"]=(f["replay_refs"]!="" && f["checkpoint_refs"]!="" && f["rollback_refs"]!="" && f["report_id"]!="" && f["report_sufficiency"]==1)
    f["FV-09"]=(f["tool_state_activation"]!="true" && f["trust_assertion"]!="accepted" && f["boundary_validated_role"]!="untrusted" && f["FV-04"] && f["FV-03"] && f["anti_rollback_passed"] && f["signature_chain_passed"])
    f["critical_contamination"]=!f["FV-09"]
    f["FV-10"]=(f["disclosure_class_entries"]!="collapsed")
    f["FV-12"]=(f["hold_exit_refs"]!="" && f["anchor_update_ref"]!="" && fixture_data["prior_record" SUBSEP "anchor_update_ref"]!="" && f["anchor_update_ref"]>fixture_data["prior_record" SUBSEP "anchor_update_ref"] && f["readmission_state_flag"]!="blocked")
    f["family_validator_outcomes_pre"]=outcome_text(f,0)
    f["boundary_event_evidence_report"]=(f["boundary_event_id"]!="" && f["report_signature"]!="") ? f["boundary_event_id"] ":" f["report_signature"] : ""
    f["FV-11"]=(f["family_validator_outcomes_pre"]!="" && f["boundary_event_evidence_report"]!="" && f["report_signature"]!="" && f["export_manifest_ref"]!="" && f["family_decision_id"]!="" && f["boundary_event_id"]!="")
    f["component_set_complete"]=(f["FV-02"] && f["FV-03"] && f["FV-05"] && f["FV-07"] && f["FV-08"])
    f["boundary_fields_changed"]=(f["carried_payload"]!=fixture_data["prior_record" SUBSEP "carried_payload"] || f["anchor_document_ref"]!=fixture_data["prior_record" SUBSEP "anchor_document_ref"] || f["source_control_bundles"]!=fixture_data["prior_record" SUBSEP "source_control_bundles"])
    f["rehydration_fields_changed"]=(f["policy_snapshot_id"]!=fixture_data["prior_record" SUBSEP "policy_snapshot_id"] || f["rehydration_closure_ref"]!=fixture_data["prior_record" SUBSEP "rehydration_closure_ref"])
    f["readmission_target"]=(f["boundary_fields_changed"] && !f["rehydration_fields_changed"] ? "S2" : (!f["boundary_fields_changed"] && f["rehydration_fields_changed"] ? "S5" : ""))
    f["readmission_closed"]=f["FV-12"]
    f["family_validator_outcomes"]=outcome_text(f,1)
    f["validator_outcomes_complete"]=f["FV-11"]
    f["hold_enter_refs"]=fixture_data["hold_enter_refs"]
    f["contamination_flags"]=f["critical_contamination"]?"contamination":""
    f["contaminating_ref_set"]=f["critical_contamination"]?(f["tool_state_activation"]=="true"||f["trust_assertion"]=="accepted"?f["anchor_document_ref"]:!f["FV-03"]?f["statement_id"]:!f["FV-04"]?f["carried_payload"]:f["failure_code"]):""
    f["blocked_stage"]=!f["FV-02"]?"boundary_input_contract":!f["FV-03"]?"provenance_classification":!f["FV-04"]?"boundary_role_consistency":(!f["anti_rollback_passed"]||!f["signature_chain_passed"])?"verified_rehydration":f["critical_contamination"]?"family-gate":""
    f["FOC-04/tsa_refs"]=f["tsa_refs"]
    f["FEV-01"]=f["family_decision_id"]; f["FEV-02"]=f["boundary_event_id"]
    f["FEV-03"]=(f["session_id"]!="" && f["prior_session_ref"]!="") ? f["session_id"] ":" f["prior_session_ref"] : ""
    f["carried_statement_refs"]=f["statement_id"]; f["FEV-04"]=f["carried_statement_refs"]; f["FEV-05"]=(f["tsa_refs"]!="" && f["provenance_refs"]!="") ? f["tsa_refs"] ":" f["provenance_refs"] : ""
    f["FEV-06"]=(f["anchor_document_digest"]!="" && f["anchor_document_ref"]!="") ? f["anchor_document_digest"] ":" f["anchor_document_ref"] : ""
    f["FEV-07"]=(f["accepted_head_digest"]!="" && f["linked_irr_digest"]!="") ? f["accepted_head_digest"] ":" f["linked_irr_digest"] : ""
    f["FEV-08"]=(f["freshness_before"]!="" && f["freshness_after"]!="" && f["anchor_update_ref"]!="") ? f["freshness_before"] ":" f["freshness_after"] ":" f["anchor_update_ref"] : ""
    f["FEV-09"]=f["rehydration_closure_ref"]
    f["FEV-10"]=(f["replay_refs"]!="" && f["checkpoint_refs"]!="" && f["rollback_refs"]!="") ? f["replay_refs"] ":" f["checkpoint_refs"] ":" f["rollback_refs"] : ""
    f["FEV-11"]=f["disclosure_class_entries"]; f["FEV-12"]=f["family_validator_outcomes"]
    f["FEV-13"]=(f["hold_enter_refs"]!="" || f["hold_exit_refs"]!="") ? f["hold_enter_refs"] ":" f["hold_exit_refs"] : ""
    f["FEV-14"]=(f["contamination_flags"]!="" && f["contaminating_ref_set"]!="") ? f["contamination_flags"] ":" f["contaminating_ref_set"] : "[]"
    f["FEV-15"]=(f["report_signature"]!="" && f["export_manifest_ref"]!="") ? f["report_signature"] ":" f["export_manifest_ref"] : ""
    f["FOC-04/contaminating_ref_set"]=f["contaminating_ref_set"]; f["FOC-04/blocked_stage"]=f["blocked_stage"]
    f["FOC-05/hold_enter_refs"]=f["hold_enter_refs"]; f["FOC-05/pending_requirements"]=fixture_data["pending_requirements"]; f["FOC-05/freshness_before"]=f["freshness_before"]
    f["FOC-05/freshness_after"]=f["freshness_after"]; f["FOC-05/hold_exit_refs"]=f["hold_exit_refs"]
    f["FOC-05/anchor_update_ref"]=f["anchor_update_ref"]
}
function emit_verdict(f) {
    if(f["critical_contamination"]) return "CONTAMINATION_FAIL_CLOSED"
    if(f["freshness_hold"] || !f["readmission_closed"]) return "NONCOMPLIANT_HOLD"
    if(!f["FV-05"] || !f["FV-08"]) return "REPLAY_INCOMPLETE"
    if(!f["FV-10"] || !f["FV-11"] || !f["validator_outcomes_complete"]) return "INCIDENT_ONLY"
    if(f["disclosure_class_entries"]!="" && f["disclosure_class_entries"]!="[]") return "REPLAY_ADMISSIBLE_CONSTRAINED"
    if(f["component_set_complete"]) return "REPLAY_ADMISSIBLE"
    return "INCIDENT_ONLY"
}
function readmission_case(fixture_id,trigger,field,value,expected,    data,f,again,target,replay) {
    make_fixture(fixture_id,data); data[field]=value; compose_family(data,f)
    make_fixture(fixture_id,data); data[field]=value; compose_family(data,again)
    target=next_state("SR",trigger,1)
    replay=(expected=="S2" ? next_state("S2","ProvenanceClassification",1)=="S3" : next_state("S5","ReplayReconstruction",1)=="S6")
    return (f["hold_exit_refs"]!="" && f["anchor_update_ref"]>data["prior_record" SUBSEP "anchor_update_ref"] && f["readmission_target"]==expected && f["readmission_target"]==again["readmission_target"] && target==expected && (target=="S2" || target=="S5") && replay)
}
