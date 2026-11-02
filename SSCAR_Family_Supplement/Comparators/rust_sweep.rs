const STATES: [&str; 12] = ["S0", "S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "SH", "SR", "SX"];
const TRIGGERS: [&str; 33] = [
    "Fv01Pass", "Admission", "Fv02AndFv04Pass", "BoundaryScreening", "Fv03Pass",
    "ProvenanceClassification", "Fv05AndFv06Pass", "AcceptedHeadFreshnessLock",
    "Fv07Pass", "VerifiedRehydrationClosure", "Fv08Pass", "ReplayReconstruction", "ReplayAdmissibleClosure",
    "Fv10AndFv11Pass", "FamilyReportAssembly", "FamilyVerdictIssued", "EmitFamilyVerdict",
    "FreshnessReplay", "CriticalContamination", "AntiRollbackFailure", "ChainBreak",
    "UntrustedAnchorPromoted", "UnlabeledMechanismLevelCarriedClaim",
    "RemediableFailureOfFv06OrFv12", "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate",
    "ReadmissionReview", "ReadmissionBundleChangedCarriedPayload",
    "ReadmissionBundleChangedAnchorDocumentRef", "ReadmissionBundleChangedSourceControlBundles",
    "ReadmissionBundleChangedPolicySnapshotId", "ReadmissionBundleChangedRehydrationClosureRef",
    "Handoff", "IncidentOnlyOutput",
];

fn next_state(state: &'static str, trigger: &'static str, passed: bool) -> &'static str {
    if trigger == "CriticalContamination" { return "SX"; }
    if trigger == "UnlabeledMechanismLevelCarriedClaim" && state == "S2" { return "SX"; }
    if trigger == "AntiRollbackFailure" && state == "S5" { return "SX"; }
    if matches!(trigger, "ChainBreak" | "UntrustedAnchorPromoted") && state == "S3" { return "SX"; }
    if trigger == "FreshnessReplay" && state == "S3" { return "SH"; }
    if trigger == "RemediableFailureOfFv06OrFv12" && state == "S3" { return "SH"; }
    if trigger == "RemediableFailureOfFv06OrFv12" && state == "SH" { return "SH"; }
    if trigger == "Fv02AndFv04Pass" && state == "S1" && !passed { return "SX"; }
    if trigger == "Fv03Pass" && state == "S2" && !passed { return "SX"; }
    if trigger == "Fv07Pass" && state == "S4" && !passed { return "SX"; }
    if !passed { return state; }
    match (state, trigger) {
        ("S0", "Fv01Pass" | "Admission") => "S1",
        ("S1", "Fv02AndFv04Pass" | "BoundaryScreening") => "S2",
        ("S2", "Fv03Pass" | "ProvenanceClassification") => "S3",
        ("S3", "Fv05AndFv06Pass" | "AcceptedHeadFreshnessLock") => "S4",
        ("S4", "Fv07Pass" | "VerifiedRehydrationClosure") => "S5",
        ("S5", "Fv08Pass" | "ReplayReconstruction") => "S6",
        ("S5", "ReplayAdmissibleClosure") => "S8",
        ("S6", "Fv10AndFv11Pass" | "FamilyReportAssembly") => "S7",
        ("S7", "FamilyVerdictIssued" | "EmitFamilyVerdict") => "S8",
        ("SH", "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate" | "ReadmissionReview") => "SR",
        ("SR", "ReadmissionBundleChangedCarriedPayload" | "ReadmissionBundleChangedAnchorDocumentRef" | "ReadmissionBundleChangedSourceControlBundles") => "S2",
        ("SR", "ReadmissionBundleChangedPolicySnapshotId" | "ReadmissionBundleChangedRehydrationClosureRef") => "S5",
        ("S8", "Handoff") => "S8",
        ("SX", "IncidentOnlyOutput") => "SX",
        _ => state,
    }
}

fn main() {
    for state in STATES {
        for trigger in TRIGGERS {
            for passed in [false, true] {
                println!("{}", next_state(state, trigger, passed));
            }
        }
    }
}
