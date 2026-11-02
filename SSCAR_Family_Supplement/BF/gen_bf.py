"""Generate the Brainfuck lookup rendering of the SSCAR family projection."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BF = Path(__file__).resolve().parent
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
TRIGGER_CODES = "abcdefghijklmnopqrstuvwxyzABCDEFG"
VERDICTS = ["REPLAY_ADMISSIBLE", "REPLAY_ADMISSIBLE_CONSTRAINED", "REPLAY_INCOMPLETE", "NONCOMPLIANT_HOLD", "CONTAMINATION_FAIL_CLOSED", "INCIDENT_ONLY"]
FIELDS = [
    "family_decision_id", "boundary_event_id", "session_id / prior_session_ref", "carried_statement_refs",
    "tsa_refs / provenance_refs", "anchor_document_digest / anchor_document_ref", "accepted_head_digest / linked_irr_digest",
    "freshness_before / freshness_after / anchor_update_ref", "rehydration_closure_ref",
    "replay_refs / checkpoint_refs / rollback_refs", "disclosure_class_entries", "family_validator_outcomes",
    "hold_enter_refs / hold_exit_refs", "contamination_flags / contaminating_ref_set", "report_signature / export_manifest_ref",
]
PROBES = {chr(ord("A")+i): value for i, value in enumerate(FIELDS)}
code = []
position = [0]

def go(cell):
    delta = cell-position[0]
    code.append(">"*delta if delta > 0 else "<"*(-delta))
    position[0] = cell

def copy_cell(source):
    go(5); code.append("[-]"); go(6); code.append("[-]"); go(source); code.append("[")
    go(5); code.append("+"); go(6); code.append("+"); go(source); code.append("-"); code.append("]")
    go(6); code.append("["); go(source); code.append("+"); go(6); code.append("-"); code.append("]")

def if_equal(cell, char, depth, body):
    flag = 7+depth
    copy_cell(cell); go(5); code.append("-"*ord(char)); go(flag); code.append("[-]+")
    go(5); code.append("["); go(flag); code.append("-"); go(5); code.append("[-]"); code.append("]")
    go(flag); code.append("["); body(); go(flag); code.append("[-]"); code.append("]")

def print_text(value):
    go(15)
    for char in value:
        code.append("[-]"+"+"*ord(char)+".")
    code.append("[-]")

def emit_case(record, result):
    def build(index):
        if index == len(record):
            return lambda: print_text(result+"\n")
        return lambda: if_equal(index, record[index], index, build(index+1))
    build(0)()

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
        ("SH", "HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate"): "SR", ("SH", "ReadmissionReview"): "SR",
        ("SR", "ReadmissionBundleChangedCarriedPayload"): "S2",
        ("SR", "ReadmissionBundleChangedAnchorDocumentRef"): "S2",
        ("SR", "ReadmissionBundleChangedSourceControlBundles"): "S2",
        ("SR", "ReadmissionBundleChangedPolicySnapshotId"): "S5",
        ("SR", "ReadmissionBundleChangedRehydrationClosureRef"): "S5",
    }
    if (state, trigger) in edges: return edges[(state, trigger)]
    if state == "S8" and trigger == "Handoff": return "S8"
    if state == "SX" and trigger == "IncidentOnlyOutput": return "SX"
    return state

def main():
    for cell in range(5):
        go(cell); code.append(",")
    for cell, state in enumerate(STATES): emit_case(f"s{cell:X}---", state)
    for cell, verdict in enumerate(VERDICTS): emit_case(f"v{cell:X}---", verdict)
    for key, value in PROBES.items(): emit_case(f"p{key}---", value)
    for state_index, state in enumerate(STATES):
        for trigger_index, trigger in enumerate(TRIGGERS):
            for passed in (False, True):
                record = f"n{chr(ord('A')+state_index)}{TRIGGER_CODES[trigger_index]}{'p' if passed else 'f'}-"
                emit_case(record, next_state(state, trigger, passed))
    (BF/"baseline.bf").write_bytes("".join(code).encode("ascii"))
    print(f"cases={len(STATES)*len(TRIGGERS)*2}; probes={len(STATES)+len(VERDICTS)+len(PROBES)}; bytes={(BF/'baseline.bf').stat().st_size}")

if __name__ == "__main__": main()
