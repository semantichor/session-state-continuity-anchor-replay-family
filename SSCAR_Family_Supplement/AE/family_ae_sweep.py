"""Run the family projection through the documented Analytical Engine emulator."""
from pathlib import Path
import contextlib, io, sys

ROOT = Path(__file__).resolve().parent
RUNTIME = ROOT / "py-ae"
if RUNTIME.is_dir(): sys.path.insert(0, str(RUNTIME))
from analytical_engine import AnalyticalEngine

STATES = ["S0", "S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "SH", "SR", "SX"]
TRIGGERS = [
    "Fv01Pass", "Admission", "Fv02AndFv04Pass", "BoundaryScreening", "Fv03Pass",
    "ProvenanceClassification", "Fv05AndFv06Pass", "AcceptedHeadFreshnessLock",
    "Fv07Pass", "VerifiedRehydrationClosure", "Fv08Pass", "ReplayReconstruction",
    "ReplayAdmissibleClosure", "Fv10AndFv11Pass", "FamilyReportAssembly", "FamilyVerdictIssued",
    "EmitFamilyVerdict", "FreshnessReplay", "CriticalContamination", "AntiRollbackFailure",
    "ChainBreak", "UntrustedAnchorPromoted", "UnlabeledMechanismLevelCarriedClaim",
    "RemediableFailureOfFv06OrFv12", "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate",
    "ReadmissionReview", "ReadmissionBundleChangedCarriedPayload", "ReadmissionBundleChangedAnchorDocumentRef",
    "ReadmissionBundleChangedSourceControlBundles", "ReadmissionBundleChangedPolicySnapshotId",
    "ReadmissionBundleChangedRehydrationClosureRef", "Handoff", "IncidentOnlyOutput",
]
def next_state(state, trigger, passed):
    if trigger == "CriticalContamination": return "SX"
    if trigger == "UnlabeledMechanismLevelCarriedClaim" and state == "S2": return "SX"
    if trigger == "AntiRollbackFailure" and state == "S5": return "SX"
    if trigger in {"ChainBreak", "UntrustedAnchorPromoted"} and state == "S3": return "SX"
    if trigger == "FreshnessReplay" and state == "S3": return "SH"
    if trigger == "RemediableFailureOfFv06OrFv12" and state == "S3": return "SH"
    if trigger == "RemediableFailureOfFv06OrFv12" and state == "SH": return "SH"
    if trigger == "Fv02AndFv04Pass" and state == "S1" and not passed: return "SX"
    if trigger == "Fv03Pass" and state == "S2" and not passed: return "SX"
    if trigger == "Fv07Pass" and state == "S4" and not passed: return "SX"
    if not passed: return state
    edge = {
        ("S0", "Fv01Pass"): "S1", ("S0", "Admission"): "S1",
        ("S1", "Fv02AndFv04Pass"): "S2", ("S1", "BoundaryScreening"): "S2",
        ("S2", "Fv03Pass"): "S3", ("S2", "ProvenanceClassification"): "S3",
        ("S3", "Fv05AndFv06Pass"): "S4", ("S3", "AcceptedHeadFreshnessLock"): "S4",
        ("S4", "Fv07Pass"): "S5", ("S4", "VerifiedRehydrationClosure"): "S5",
        ("S5", "Fv08Pass"): "S6", ("S5", "ReplayReconstruction"): "S6",
        ("S5", "ReplayAdmissibleClosure"): "S8",
        ("S6", "Fv10AndFv11Pass"): "S7", ("S6", "FamilyReportAssembly"): "S7",
        ("S7", "FamilyVerdictIssued"): "S8", ("S7", "EmitFamilyVerdict"): "S8",
        ("SH", "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate"): "SR", ("SH", "ReadmissionReview"): "SR",
        ("SR", "ReadmissionBundleChangedCarriedPayload"): "S2",
        ("SR", "ReadmissionBundleChangedAnchorDocumentRef"): "S2",
        ("SR", "ReadmissionBundleChangedSourceControlBundles"): "S2",
        ("SR", "ReadmissionBundleChangedPolicySnapshotId"): "S5",
        ("SR", "ReadmissionBundleChangedRehydrationClosureRef"): "S5",
    }
    if (state, trigger) in edge: return edge[(state, trigger)]
    if state == "S8" and trigger == "Handoff": return "S8"
    if state == "SX" and trigger == "IncidentOnlyOutput": return "SX"
    return state

def make_program():
    scale = len(TRIGGERS)*2
    lines = [f"SET 8 {scale}", "SET 9 0", "SET 4 2", "MUL v0 v8 v3", "MUL v1 v4 v4", "ADD v3 v4 v3", "ADD v2 v3 v3"]
    for index in range(len(STATES)*len(TRIGGERS)*2):
        lines += [f"SET 5 {index}", "SUB v3 v5", f"BRZ CASE{index}", f"SET 5 {index}", "ADD v3 v5"]
    lines += ["BRA DEFAULT"]
    for si, state in enumerate(STATES):
        for ti, trigger in enumerate(TRIGGERS):
            for bi, passed in enumerate((False, True)):
                index=(si*len(TRIGGERS)+ti)*2+bi
                out=next_state(state,trigger,passed)
                lines += [f":CASE{index}",f"SET 6 {STATES.index(out)}","ADD v6 v9","PRINT","HALT"]
    lines += [":DEFAULT", "SET 6 0", "ADD v6 v9", "PRINT", "HALT"]
    return "\n".join(lines)

def main():
    program, _ = AnalyticalEngine(number=int, vars=16).assemble(make_program())
    output=[]
    for si,state in enumerate(STATES):
        for ti,trigger in enumerate(TRIGGERS):
            for bi,passed in enumerate((False,True)):
                engine=AnalyticalEngine(number=int,vars=16); engine.load_program(program)
                engine.v[0]=si; engine.v[1]=ti; engine.v[2]=bi
                with contextlib.redirect_stdout(io.StringIO()): engine.run()
                output.append(STATES[int(engine.output[-1])])
    if len(output)!=len(STATES)*len(TRIGGERS)*2: raise RuntimeError(f"expected 792, got {len(output)}")
    (ROOT/"ae_792.txt").write_bytes(("\n".join(output)+"\n").encode("ascii"))

if __name__ == "__main__": main()
