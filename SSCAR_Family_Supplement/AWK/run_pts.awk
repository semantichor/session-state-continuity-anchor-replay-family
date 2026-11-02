@include "baseline.awk"
@include "component_pipeline.awk"
@include "test_fixtures.awk"
@include "ct_oracles.awk"

function record(id, ok, basis) {
    count++
    if (ok) { pass++; printf "%s PASS %s\n", id, basis }
    else { fail++; printf "%s FAIL %s\n", id, basis }
}
function skip_record(id, basis) { count++; skip++; printf "%s SKIP %s\n", id, basis }
BEGIN {
    if (ENVIRON["AWK_CMD"]=="") { print "ERROR runner requires AWK_CMD"; errors++; exit 1 }

    record("PTS-001", next_state("S0","Fv01Pass",1)=="S1", "CT PTS-001; Specification §9 S1 entry")
    record("PTS-002", next_state("S2","Fv03Pass",1)=="S3", "CT PTS-002; Specification §9 S3 entry")
    compose_fixture("PFX-COMPLETE-CLOSURE",f)
    record("PTS-003", next_state("S5","ReplayAdmissibleClosure",1)=="S8" && emit_verdict(f)=="REPLAY_ADMISSIBLE" && f["family_decision_id"]!="", "CT PTS-003; Specification §8 FD-05; CT ORC-CONSTRAINED-DELTA")
    record("PTS-004a", next_state("S1","Fv02AndFv04Pass",0)=="SX", "CT PTS-004a; CT ORC-FAIL-CLOSED-MATRIX")
    compose_fixture("PFX-CONTAM-FV03",f)
    record("PTS-004b", next_state("S2","UnlabeledMechanismLevelCarriedClaim",0)=="SX" && emit_verdict(f)=="CONTAMINATION_FAIL_CLOSED", "CT PTS-004b; CT ORC-FAIL-CLOSED-MATRIX")
    compose_fixture_override("PFX-COMPLETE-CLOSURE","replay_refs","",f)
    record("PTS-005", emit_verdict(f)=="REPLAY_INCOMPLETE" && next_state("S5","Fv08Pass",0)=="S5", "CT §7 ORC-VERDICT-LAYER-EMISSION; AMB-17")
    compose_fixture("PFX-FRESHNESS-REPLAY",f)
    record("PTS-006", next_state("S3","FreshnessReplay",0)=="SH" && emit_verdict(f)=="NONCOMPLIANT_HOLD" && f["FOC-05/hold_enter_refs"]!="" && f["FOC-05/pending_requirements"]!="", "CT PTS-006; CT ORC-HOLD-VS-FAIL-CLOSED")
    skip_record("PTS-007", "CT §8 bounded external obligation: FV-04 local-reclassification policy hook")
    record("PTS-008", next_state("S3","FreshnessReplay",1)=="SH" && next_state("S3","CriticalContamination",1)=="SX" && next_state("S3","FreshnessReplay",1)!=next_state("S3","CriticalContamination",1), "CT PTS-008; CT ORC-HOLD-VS-FAIL-CLOSED")
    uniform=1; for(i=1;i<=12;i++) if(next_state(states[i],"CriticalContamination",0)!="SX") uniform=0
    record("PTS-009", uniform, "CT PTS-009; CT ORC-FAIL-CLOSED-MATRIX")
    compose_fixture("PFX-ANTIROLLBACK-S5",f)
    record("PTS-010", next_state("S5","AntiRollbackFailure",1)=="SX" && emit_verdict(f)=="CONTAMINATION_FAIL_CLOSED", "CT PTS-010; CT PFX-ANTIROLLBACK-S5")
    record("PTS-011", next_state("S3","ChainBreak",0)=="SX" && next_state("S3","UntrustedAnchorPromoted",1)=="SX", "CT PTS-011; CT PFX-CHAINBREAK-S3")
    record("PTS-012", next_state("SH","HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate",1)=="SR" && next_state("SH","HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate",0)=="SH", "CT PTS-012; Specification §8 FD-10")
    record("PTS-013", readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedCarriedPayload","carried_payload","payload-2","S2"), "CT PTS-013; CT ORC-NON-INHERITANCE")
    record("PTS-014", next_state("S8","Handoff",0)=="S8" && next_state("SX","IncidentOnlyOutput",1)=="SX", "CT PTS-014; CT ORC-TERMINAL-INTEGRITY")
    compose_fixture("PFX-CONSTRAINED-CLOSURE",f)
    record("PTS-015", emit_verdict(f)=="REPLAY_ADMISSIBLE_CONSTRAINED", "CT §7 ORC-CONSTRAINED-DELTA; Specification §4.2")
    compose_fixture("PFX-INTAKE-PASS-1",f); full=1
    split("FEV-01 FEV-02 FEV-03 FEV-04 FEV-05 FEV-06 FEV-07 FEV-08 FEV-09 FEV-10 FEV-11 FEV-12 FEV-13 FEV-14 FEV-15", names, " ")
    for(i=1;i<=15;i++) if(f[names[i]]=="") full=0
    record("PTS-016", full, "CT PTS-016; Specification §11; FEV-01..FEV-15")
    compose_fixture("PFX-CONTAM-FV03",f)
    record("PTS-017a", f["FOC-04/tsa_refs"]!="" && f["FOC-04/blocked_stage"]!="" && f["FOC-04/contaminating_ref_set"]!="", "CT PTS-017a; CT ORC-CONDITIONAL-EVIDENCE")
    compose_fixture("PFX-FRESHNESS-REPLAY",f)
    record("PTS-017b", f["FOC-05/freshness_before"]!="" && f["FOC-05/freshness_after"]!="" && f["FOC-05/hold_enter_refs"]!="", "CT PTS-017b; CT ORC-CONDITIONAL-EVIDENCE")
    make_fixture("PFX-HOLD-CASE",h); compose_family(h,f)
    record("PTS-017d", f["hold_exit_refs"]!="" && f["anchor_update_ref"]>h["prior_record" SUBSEP "anchor_update_ref"] && f["readmission_closed"], "CT PTS-017d; CT ORC-CONDITIONAL-EVIDENCE")
    compose_fixture("PFX-CONTAM-FV03",f); contam_fields=(f["FOC-04/tsa_refs"]!="" && f["FOC-04/blocked_stage"]!="" && f["FOC-04/contaminating_ref_set"]!="")
    make_fixture("PFX-HOLD-CASE",hold_input); compose_family(hold_input,h)
    hold_fields=(h["FOC-05/hold_enter_refs"]!="" && h["FOC-05/pending_requirements"]!="" && h["FOC-05/hold_exit_refs"]!="" && h["FOC-05/anchor_update_ref"]!="" && h["disclosure_class_entries"]!="")
    record("PTS-018", contam_fields && hold_fields && h["boundary_event_id"]!="" && h["FEV-12"]!="" && h["FEV-13"]!="", "CT PTS-018; CT ORC-FOC-PRODUCERS; Specification §13 FOR-01..FOR-06")
    compose_fixture("PFX-CONTAM-FV03",f); f04=(f["FOC-04/tsa_refs"]!="" && f["FOC-04/contaminating_ref_set"]!="" && f["FOC-04/blocked_stage"]!="")
    make_fixture("PFX-HOLD-CASE",hold_input); compose_family(hold_input,g); f05=(g["FOC-05/hold_enter_refs"]!="" && g["FOC-05/pending_requirements"]!="" && g["FOC-05/hold_exit_refs"]!="" && g["FOC-05/anchor_update_ref"]!="" && g["FEV-13"]!="" && g["FEV-12"]!="" && g["FEV-11"]!="")
    record("PTS-019", f04 && f05, "CT §7 ORC-FOC-PRODUCERS; Annex A §§2,4")
    record("PTS-020", next_state("SH","ReadmissionReview",1)=="SR" && readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedCarriedPayload","carried_payload","payload-2","S2") && readmission_case("PFX-RE-ENTRY-S5","ReadmissionBundleChangedPolicySnapshotId","policy_snapshot_id","policy-2","S5"), "CT §7 ORC-DISTRIBUTED-LEGITIMACY; Specification §9")
    compose_fixture("PFX-COMPLETE-CLOSURE",typecase)
    state_value=next_state("S5","ReplayAdmissibleClosure",1)
    verdict_value=emit_verdict(typecase)
    load_ct_oracles()
    overlap=0
    for(i=1;i<=12;i++) if(states[i]==verdict_value) overlap=1
    for(i=1;i<=6;i++) if(ct_verdicts[i]==state_value) overlap=1
    record("PTS-021", state_value=="S8" && ct_verdict_allowed(verdict_value) && verdict_value=="REPLAY_ADMISSIBLE" && !overlap && next_state("SX","IncidentOnlyOutput",1)=="SX", "CT PTS-021; CT ORC-VERDICT-SET; AMB-15")
    compose_fixture("PFX-FRESHNESS-REPLAY",f); hold_verdict=emit_verdict(f)
    compose_fixture("PFX-CRITICAL-CONTAM",g); contamination_verdict=emit_verdict(g)
    record("PTS-022", next_state("S3","FreshnessReplay",0)=="SH" && hold_verdict=="NONCOMPLIANT_HOLD" && next_state("S3","CriticalContamination",0)=="SX" && contamination_verdict=="CONTAMINATION_FAIL_CLOSED" && hold_verdict!=contamination_verdict, "CT PTS-022; CT ORC-HOLD-VS-FAIL-CLOSED")
    branches=(readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedCarriedPayload","carried_payload","payload-2","S2") && readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedAnchorDocumentRef","anchor_document_ref","anchor-ref-2","S2") && readmission_case("PFX-RE-ENTRY-S2","ReadmissionBundleChangedSourceControlBundles","source_control_bundles","components-2","S2") && readmission_case("PFX-RE-ENTRY-S5","ReadmissionBundleChangedPolicySnapshotId","policy_snapshot_id","policy-2","S5") && readmission_case("PFX-RE-ENTRY-S5","ReadmissionBundleChangedRehydrationClosureRef","rehydration_closure_ref","rehydration-2","S5"))
    record("PTS-023", branches, "CT PTS-023; CT ORC-NON-INHERITANCE; Specification §9")
    compose_fixture("PFX-COMPLETE-CLOSURE",f)
    record("PTS-024", next_state("S4","VerifiedRehydrationClosure",1)=="S5" && f["FV-07"]==1 && f["rehydration_closure_ref"]!="", "CT PTS-024; Specification §9 S4 entry and §7 FV-07")
    compose_fixture("PFX-ANTIROLLBACK-S5",f)
    record("PTS-025", next_state("S5","AntiRollbackFailure",0)=="SX" && f["rehydration_closure_ref"]!="" && f["anchor_document_ref"]!="" && f["family_validator_outcomes"]!="" && emit_verdict(f)=="CONTAMINATION_FAIL_CLOSED", "CT PTS-025; CT PFX-ANTIROLLBACK-S5; Annex A §2")
    record("PTS-026", next_state("S1","Fv02AndFv04Pass",0)=="SX", "CT PTS-026; CT ORC-FAIL-CLOSED-MATRIX")
    record("PTS-027", next_state("S8","Handoff",1)=="S8" && next_state("SX","IncidentOnlyOutput",0)=="SX", "CT §7 ORC-TERMINAL-INTEGRITY; Specification §9")

    printf "SUMMARY total=%d pass=%d fail=%d skip=%d error=%d\n",count,pass,fail,skip,errors
    if (fail || errors) exit 1
}
