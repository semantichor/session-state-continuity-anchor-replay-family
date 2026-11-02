@include "baseline.awk"
@include "component_pipeline.awk"
@include "test_fixtures.awk"

function connector(id, ok, basis) {
    total++
    if (ok) { pass++; printf "%s PASS %s\n", id, basis }
    else { fail++; printf "%s FAIL %s\n", id, basis }
}
function connector_skip(id,basis) { total++; skip++; printf "%s SKIP %s\n",id,basis }
BEGIN {
    if (ENVIRON["AWK_CMD"]=="") { print "ERROR connector runner requires AWK_CMD"; errors++; exit 1 }
    compose_fixture("PFX-COMPLETE-CLOSURE",f)
    connector("CT-01", f["component_set_count"]==5 && f["component_set_complete"] && next_state("S0","Admission",1)=="S1", "Annex C CT-01; Annex A row 1")
    compose_fixture("PFX-CONTAM-FV03",f)
    connector("CT-02", f["critical_contamination"] && f["blocked_stage"]=="provenance_classification" && f["FOC-04/tsa_refs"]!="", "Annex C CT-02; Annex A rows 3 and 9")
    compose_fixture("PFX-COMPLETE-CLOSURE",f); accepted=f["FV-02"]
    compose_fixture_override("PFX-COMPLETE-CLOSURE","trust_assertion","accepted",g)
    connector("CT-03", accepted && g["FV-02"] && g["critical_contamination"] && next_state("S1","BoundaryScreening",1)=="S2", "Annex C CT-03; Specification §6; Annex A row 2")
    compose_fixture("PFX-FRESHNESS-REPLAY",f)
    connector("CT-04", f["freshness_hold"] && emit_verdict(f)=="NONCOMPLIANT_HOLD" && f["FOC-05/hold_enter_refs"]!="", "Annex C CT-04; Specification §6/§8 FD-07; Annex A row 6")
    compose_fixture("PFX-COMPLETE-CLOSURE",f); good=f["FV-05"]
    compose_fixture_override("PFX-COMPLETE-CLOSURE","linked_irr_digest","irr-other",g)
    connector("CT-05", good && !g["FV-05"] && emit_verdict(g)=="REPLAY_INCOMPLETE" && g["irr_digest"]!=g["linked_irr_digest"], "Annex C CT-05; Annex B CC-01")
    compose_fixture("PFX-COMPLETE-CLOSURE",f); valid=f["FV-07"]
    compose_fixture("PFX-ANTIROLLBACK-S5",g)
    connector("CT-06", valid && !g["FV-07"] && g["critical_contamination"] && emit_verdict(g)=="CONTAMINATION_FAIL_CLOSED", "Annex C CT-06; Annex A row 7; Annex B CC-03/CC-08")
    compose_fixture("PFX-COMPLETE-CLOSURE",f); valid=f["FV-08"]
    compose_fixture_override("PFX-COMPLETE-CLOSURE","replay_refs","",g)
    connector("CT-07", valid && !g["FV-08"] && emit_verdict(g)=="REPLAY_INCOMPLETE" && next_state("S5","Fv08Pass",0)=="S5", "Annex C CT-07; Annex A row 8")
    compose_fixture("PFX-COMPLETE-CLOSURE",f); plain=emit_verdict(f)
    compose_fixture("PFX-CONSTRAINED-CLOSURE",g); bounded=emit_verdict(g)
    connector("CT-08", plain=="REPLAY_ADMISSIBLE" && bounded=="REPLAY_ADMISSIBLE_CONSTRAINED" && f["family_decision_id"]!="" && f["report_signature"]!="" && f["export_manifest_ref"]!="", "Annex C CT-08; Specification §4.1/§8 FD-05; Annex A row 11")
    compose_fixture("PFX-CRITICAL-CONTAM",f)
    connector("CT-09", f["critical_contamination"] && emit_verdict(f)=="CONTAMINATION_FAIL_CLOSED" && f["FOC-04/contaminating_ref_set"]!="" && f["blocked_stage"]!="", "Annex C CT-09; Annex A row 9; Annex B CC-06")
    compose_fixture("PFX-COMPLETE-CLOSURE",f); allowed=(f["readmission_closed"] && next_state("SH","ReadmissionReview",1)=="SR")
    compose_fixture_override("PFX-HOLD-CASE","hold_exit_refs","",g)
    connector("CT-10", allowed && !g["readmission_closed"] && emit_verdict(g)=="NONCOMPLIANT_HOLD" && g["hold_enter_refs"]!="", "Annex C CT-10; Specification §8 FD-10; Annex B CC-04/CC-09")
    compose_fixture("PFX-CONSTRAINED-CLOSURE",f)
    compose_fixture_override("PFX-CONSTRAINED-CLOSURE","disclosure_class_entries","collapsed",g)
    connector("CT-11", emit_verdict(f)=="REPLAY_ADMISSIBLE_CONSTRAINED" && emit_verdict(g)=="INCIDENT_ONLY" && f["disclosure_class_entries"]!="" && g["disclosure_class_entries"]=="collapsed", "Annex C CT-11; Specification §4.2/FD-09; Annex B CC-07")
    compose_fixture("PFX-COMPLETE-CLOSURE",f); full=f["validator_outcomes_complete"]
    compose_fixture_override("PFX-COMPLETE-CLOSURE","report_signature","",g)
    connector("CT-12", full && !g["validator_outcomes_complete"] && emit_verdict(g)=="INCIDENT_ONLY", "Annex C CT-12; Specification §10/§11/§13; Annex A row 11")
    compose_fixture_override("PFX-INTAKE-PASS-1","boundary_validated_role","explanatory-only",f)
    connector("CT-13", f["critical_contamination"] && f["blocked_stage"]=="boundary_role_consistency" && emit_verdict(f)=="CONTAMINATION_FAIL_CLOSED", "Annex C CT-13; Specification §6/§7 FV-04; Annex A row 4")
    ct14=(readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedCarriedPayload","carried_payload","payload-2","S2") && readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedAnchorDocumentRef","anchor_document_ref","anchor-ref-2","S2") && readmission_case("PFX-RE-ENTRY-S5","ReadmissionBundleChangedPolicySnapshotId","policy_snapshot_id","policy-2","S5") && readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedSourceControlBundles","source_control_bundles","components-2","S2") && readmission_case("PFX-RE-ENTRY-S5","ReadmissionBundleChangedRehydrationClosureRef","rehydration_closure_ref","rehydration-2","S5"))
    connector("CT-14", ct14, "Annex C CT-14 assertions 1-5; produced component fields; Specification §9; CT PTS-023")
    printf "SUMMARY total=%d pass=%d fail=%d skip=%d error=%d\n",total,pass,fail,skip,errors
    if (fail || errors) exit 1
}
