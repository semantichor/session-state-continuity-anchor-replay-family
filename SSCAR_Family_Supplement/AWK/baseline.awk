function member(x, a,    i) { for (i=1; i<=length(a); i++) if (a[i]==x) return 1; return 0 }
function next_state(s, t, p) {
    if (t=="CriticalContamination") return "SX"
    if (t=="UnlabeledMechanismLevelCarriedClaim" && s=="S2") return "SX"
    if (t=="AntiRollbackFailure" && s=="S5") return "SX"
    if ((t=="ChainBreak" || t=="UntrustedAnchorPromoted") && s=="S3") return "SX"
    if (t=="FreshnessReplay" && s=="S3") return "SH"
    if (t=="RemediableFailureOfFv06OrFv12" && s=="S3") return "SH"
    if (t=="RemediableFailureOfFv06OrFv12" && s=="SH") return "SH"
    if (t=="Fv02AndFv04Pass" && s=="S1" && p==0) return "SX"
    if (t=="Fv03Pass" && s=="S2" && p==0) return "SX"
    if (t=="Fv07Pass" && s=="S4" && p==0) return "SX"
    if (p==0) return s
    if (s=="S0" && (t=="Fv01Pass" || t=="Admission")) return "S1"
    if (s=="S1" && (t=="Fv02AndFv04Pass" || t=="BoundaryScreening")) return "S2"
    if (s=="S2" && (t=="Fv03Pass" || t=="ProvenanceClassification")) return "S3"
    if (s=="S3" && (t=="Fv05AndFv06Pass" || t=="AcceptedHeadFreshnessLock")) return "S4"
    if (s=="S4" && (t=="Fv07Pass" || t=="VerifiedRehydrationClosure")) return "S5"
    if (s=="S5" && (t=="Fv08Pass" || t=="ReplayReconstruction")) return "S6"
    if (s=="S5" && t=="ReplayAdmissibleClosure") return "S8"
    if (s=="S6" && (t=="Fv10AndFv11Pass" || t=="FamilyReportAssembly")) return "S7"
    if (s=="S7" && (t=="FamilyVerdictIssued" || t=="EmitFamilyVerdict")) return "S8"
    if (s=="SH" && (t=="HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate" || t=="ReadmissionReview")) return "SR"
    if (s=="SR" && (t=="ReadmissionBundleChangedCarriedPayload" || t=="ReadmissionBundleChangedAnchorDocumentRef" || t=="ReadmissionBundleChangedSourceControlBundles")) return "S2"
    if (s=="SR" && (t=="ReadmissionBundleChangedPolicySnapshotId" || t=="ReadmissionBundleChangedRehydrationClosureRef")) return "S5"
    if (s=="S8" && t=="Handoff") return "S8"
    if (s=="SX" && t=="IncidentOnlyOutput") return "SX"
    return s
}
BEGIN {
    states[1]="S0"; states[2]="S1"; states[3]="S2"; states[4]="S3"; states[5]="S4"; states[6]="S5"
    states[7]="S6"; states[8]="S7"; states[9]="S8"; states[10]="SH"; states[11]="SR"; states[12]="SX"
    triggers[1]="Fv01Pass"; triggers[2]="Admission"; triggers[3]="Fv02AndFv04Pass"; triggers[4]="BoundaryScreening"
    triggers[5]="Fv03Pass"; triggers[6]="ProvenanceClassification"; triggers[7]="Fv05AndFv06Pass"; triggers[8]="AcceptedHeadFreshnessLock"
    triggers[9]="Fv07Pass"; triggers[10]="VerifiedRehydrationClosure"; triggers[11]="Fv08Pass"; triggers[12]="ReplayReconstruction"
    triggers[13]="ReplayAdmissibleClosure"; triggers[14]="Fv10AndFv11Pass"; triggers[15]="FamilyReportAssembly"; triggers[16]="FamilyVerdictIssued"; triggers[17]="EmitFamilyVerdict"
    triggers[18]="FreshnessReplay"; triggers[19]="CriticalContamination"; triggers[20]="AntiRollbackFailure"; triggers[21]="ChainBreak"
    triggers[22]="UntrustedAnchorPromoted"; triggers[23]="UnlabeledMechanismLevelCarriedClaim"; triggers[24]="RemediableFailureOfFv06OrFv12"
    triggers[25]="HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate"; triggers[26]="ReadmissionReview"; triggers[27]="ReadmissionBundleChangedCarriedPayload"
    triggers[28]="ReadmissionBundleChangedAnchorDocumentRef"; triggers[29]="ReadmissionBundleChangedSourceControlBundles"
    triggers[30]="ReadmissionBundleChangedPolicySnapshotId"; triggers[31]="ReadmissionBundleChangedRehydrationClosureRef"
    triggers[32]="Handoff"; triggers[33]="IncidentOnlyOutput"
    if (MODE=="sweep") {
        for (i=1; i<=12; i++) for (j=1; j<=33; j++) for (p=0; p<=1; p++) print next_state(states[i],triggers[j],p)
    } else if (MODE=="state") {
        for (i=1; i<=12; i++) print states[i]
    } else if (MODE=="verdict") {
        print "REPLAY_ADMISSIBLE"; print "REPLAY_ADMISSIBLE_CONSTRAINED"; print "REPLAY_INCOMPLETE"
        print "NONCOMPLIANT_HOLD"; print "CONTAMINATION_FAIL_CLOSED"; print "INCIDENT_ONLY"
    } else if (MODE=="field") {
        for (i=1; i<=15; i++) printf "FEV-%02d\n",i
    }
}
