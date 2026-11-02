"""Finite family-workflow projection derived from the SSCAR family package."""

STATES = ["S0", "S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "SH", "SR", "SX"]
TRIGGERS = [
    "Fv01Pass", "Admission", "Fv02AndFv04Pass", "BoundaryScreening",
    "Fv03Pass", "ProvenanceClassification", "Fv05AndFv06Pass",
    "AcceptedHeadFreshnessLock", "Fv07Pass", "VerifiedRehydrationClosure",
    "Fv08Pass", "ReplayReconstruction", "ReplayAdmissibleClosure", "Fv10AndFv11Pass",
    "FamilyReportAssembly", "FamilyVerdictIssued", "EmitFamilyVerdict",
    "FreshnessReplay", "CriticalContamination", "AntiRollbackFailure",
    "ChainBreak", "UntrustedAnchorPromoted", "UnlabeledMechanismLevelCarriedClaim",
    "RemediableFailureOfFv06OrFv12", "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate",
    "ReadmissionReview", "ReadmissionBundleChangedCarriedPayload",
    "ReadmissionBundleChangedAnchorDocumentRef", "ReadmissionBundleChangedSourceControlBundles",
    "ReadmissionBundleChangedPolicySnapshotId", "ReadmissionBundleChangedRehydrationClosureRef",
    "Handoff", "IncidentOnlyOutput",
]

def next_state(current, trigger, passed):
    """Return a FamilyWorkflowState token; unspecified or failed guarded steps do not advance."""
    if trigger == "CriticalContamination":
        return "SX"
    if trigger == "UnlabeledMechanismLevelCarriedClaim" and current == "S2":
        return "SX"
    if trigger == "AntiRollbackFailure" and current == "S5":
        return "SX"
    if trigger in {"ChainBreak", "UntrustedAnchorPromoted"} and current == "S3":
        return "SX"
    if trigger == "FreshnessReplay" and current == "S3":
        return "SH"
    if trigger == "RemediableFailureOfFv06OrFv12" and current == "S3":
        return "SH"
    if trigger == "RemediableFailureOfFv06OrFv12" and current == "SH":
        return "SH"
    if trigger == "Fv02AndFv04Pass" and current == "S1" and not passed:
        return "SX"
    if trigger == "Fv03Pass" and current == "S2" and not passed:
        return "SX"
    if trigger == "Fv07Pass" and current == "S4" and not passed:
        return "SX"
    if not passed:
        return current
    edges = {
        ("S0", "Fv01Pass"): "S1", ("S0", "Admission"): "S1",
        ("S1", "Fv02AndFv04Pass"): "S2", ("S1", "BoundaryScreening"): "S2",
        ("S2", "Fv03Pass"): "S3", ("S2", "ProvenanceClassification"): "S3",
        ("S3", "Fv05AndFv06Pass"): "S4", ("S3", "AcceptedHeadFreshnessLock"): "S4",
        ("S4", "Fv07Pass"): "S5", ("S4", "VerifiedRehydrationClosure"): "S5",
        ("S5", "Fv08Pass"): "S6", ("S5", "ReplayReconstruction"): "S6",
        ("S5", "ReplayAdmissibleClosure"): "S8",
        ("S6", "Fv10AndFv11Pass"): "S7", ("S6", "FamilyReportAssembly"): "S7",
        ("S7", "FamilyVerdictIssued"): "S8", ("S7", "EmitFamilyVerdict"): "S8",
        ("SH", "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate"): "SR",
        ("SH", "ReadmissionReview"): "SR",
        ("SR", "ReadmissionBundleChangedCarriedPayload"): "S2",
        ("SR", "ReadmissionBundleChangedAnchorDocumentRef"): "S2",
        ("SR", "ReadmissionBundleChangedSourceControlBundles"): "S2",
        ("SR", "ReadmissionBundleChangedPolicySnapshotId"): "S5",
        ("SR", "ReadmissionBundleChangedRehydrationClosureRef"): "S5",
    }
    if (current, trigger) in edges:
        return edges[(current, trigger)]
    if current == "S8" and trigger == "Handoff":
        return "S8"
    if current == "SX" and trigger == "IncidentOnlyOutput":
        return "SX"
    return current

def sweep_rows():
    for state in STATES:
        for trigger in TRIGGERS:
            for passed in (False, True):
                yield state, trigger, passed, next_state(state, trigger, passed)

if __name__ == "__main__":
    import sys
    table = len(sys.argv) > 1 and sys.argv[1] == "--table"
    path = sys.argv[2] if len(sys.argv) > 2 and sys.argv[1] in {"--table", "--vector"} else None
    rows = sweep_rows()
    if path:
        with open(path, "w", encoding="utf-8", newline="\n") as out:
            for state, trigger, passed, result in rows:
                out.write(f"{state},{trigger},{str(passed).lower()},{result}\n" if table else result + "\n")
    else:
        for state, trigger, passed, result in rows:
            print(f"{state},{trigger},{str(passed).lower()},{result}" if table else result)
