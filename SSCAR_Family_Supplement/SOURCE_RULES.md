# Projection rules

## Boundary

Part A projects only the family integrator's `next_state(current_state, trigger, validator_passed) -> FamilyWorkflowState` surface declared by Conformance Tests §8. The state vocabulary is the twelve `FamilyWorkflowState` variants in Conformance Tests §3. The trigger vocabulary is the union of the §9 state-entry/exit events and the atomic decision conditions in Specification §8, retaining the spellings named in Conformance Tests §5 where supplied. `validator_passed` is the Boolean input named by the projection signature; it is not an aggregate over the twelve family validators.

Family verdict emission is a separate projection surface. The six family verdicts in Specification §4.1 do not become states. In particular, AMB-17 directs verdict-layer outcomes `INCIDENT_ONLY` and `REPLAY_INCOMPLETE` to be signaled by non-advancement of the workflow state; neither is returned as a state or substituted by `SX` or `SH`.

## Sweep order

States, then triggers, then Boolean values are enumerated in the order declared by `family_projection.py`. The reference vector contains one LF-terminated state token for each input tuple. The finite input vocabulary and order are rendered in `SOURCE_RULES.md` and consumed by every Part A renderer.

The 33 projection labels, in sweep order, are: `Fv01Pass`, `Admission`, `Fv02AndFv04Pass`, `BoundaryScreening`, `Fv03Pass`, `ProvenanceClassification`, `Fv05AndFv06Pass`, `AcceptedHeadFreshnessLock`, `Fv07Pass`, `VerifiedRehydrationClosure`, `Fv08Pass`, `ReplayReconstruction`, `ReplayAdmissibleClosure`, `Fv10AndFv11Pass`, `FamilyReportAssembly`, `FamilyVerdictIssued`, `EmitFamilyVerdict`, `FreshnessReplay`, `CriticalContamination`, `AntiRollbackFailure`, `ChainBreak`, `UntrustedAnchorPromoted`, `UnlabeledMechanismLevelCarriedClaim`, `RemediableFailureOfFv06OrFv12`, `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate`, `ReadmissionReview`, `ReadmissionBundleChangedCarriedPayload`, `ReadmissionBundleChangedAnchorDocumentRef`, `ReadmissionBundleChangedSourceControlBundles`, `ReadmissionBundleChangedPolicySnapshotId`, `ReadmissionBundleChangedRehydrationClosureRef`, `Handoff`, and `IncidentOnlyOutput`. The ordered list is the declared union of CT spellings and §8–§9 atomic event labels.

## Projection criterion

A target is emitted only where the integrated family package fixes that state transition. CT assertions supply executable state-transition outcomes; Specification §§8–§9 supply the decision and workflow transitions; §6 and §10 supply failure routing; and AMB-15–AMB-17 keep workflow-state outputs separate from family-verdict outputs. Where the source fixes a transition without conditioning it on the Boolean guard, both Boolean inputs receive that target. Where a transition is explicitly guarded, the stated branch is applied and the other branch preserves the current state. A state/trigger pair with no source-defined transition preserves the current state; this is non-advancement, not a family verdict. The projection does not infer a new state from a verdict label or infer a third SR re-entry point.

## Rules and source traces

| Rule | Projection rule | Canonical trace |
|---|---|---|
| R01 | S0 + Fv01Pass + true → S1 | CT PTS-001; Specification §9, S1 entry; §8 FD-01 |
| R01a | S0 + Admission + true → S1 | Specification §9, S0 exit; §8 FD-01 |
| R02 | S1 + Fv02AndFv04Pass + true → S2; false → SX | CT PTS-004a and PTS-026; Specification §6, blocking FV-02; §8 FD-01A; §9 SX entry |
| R02a | S1 + BoundaryScreening + true → S2; false → S1 | Specification §9, S2 entry; §8 FD-01A; §10 routes blocking FV-02/FV-03/FV-07/FV-09 failures, but does not identify this label with FV-02. The false Boolean therefore does not invoke R02's blocking route. |
| R03 | S2 + Fv03Pass + true → S3; false → SX | CT PTS-002; Specification §9, S3 entry; §§9–10, blocking FV-03 failure enters SX and routes CONTAMINATION_FAIL_CLOSED |
| R03a | S2 + ProvenanceClassification + true → S3 | Specification §9, S2 exit and S3 entry |
| R04 | S2 + UnlabeledMechanismLevelCarriedClaim + either Boolean → SX; the source describes this blocking event at S2 only; other source states preserve their current state | CT PTS-004b; Specification §6, UNLABELED_CARRIED_MECHANISM_CLAIM; §8 FD-02; §9 SX entry |
| R04a | S3 + Fv05AndFv06Pass or AcceptedHeadFreshnessLock + true → S4 | Specification §9, S4 entry; §8 FD-03 |
| R04b | S4 + Fv07Pass + true → S5; false → SX. S4 + VerifiedRehydrationClosure + true → S5 | Specification §9, S5 entry; §§9–10, blocking FV-07 failure enters SX and routes CONTAMINATION_FAIL_CLOSED; §8 FD-04 |
| R04c | S5 + Fv08Pass or ReplayReconstruction + true → S6 | Specification §9, S6 entry; CT §8 state-transition surface |
| R04d | S6 + Fv10AndFv11Pass or FamilyReportAssembly + true → S7 | Specification §9, S7 entry |
| R04e | S7 + FamilyVerdictIssued or EmitFamilyVerdict + true → S8 | Specification §9, S8 entry; §8 FD-05; CT PTS-003 |
| R04f | S5 + ReplayAdmissibleClosure + true → S8 | Specification §8 FD-05 fixes the S5 → S8 gate impact when checkpoint, rollback, and report closure pass |
| R05 | S3 + FreshnessReplay + either Boolean → SH | CT PTS-006, PTS-008, PTS-022; Specification §6, FRESHNESS_REPLAY_OR_STALE_ANCHOR; §8 FD-07; §9 SH entry |
| R06 | any state + CriticalContamination + either Boolean → SX | CT PTS-009; CT ORC-FAIL-CLOSED-MATRIX; Specification §8 FD-08; §9 SX entry |
| R07 | S5 + AntiRollbackFailure + either Boolean → SX; the source names the anti-rollback failure at the rehydration point S5; other source states preserve their current state | CT PTS-010 and PTS-025; CT PFX-ANTIROLLBACK-S5; Specification §6 and §8 FD-08 |
| R08 | S3 + ChainBreak or UntrustedAnchorPromoted + either Boolean → SX; CT PTS-011 and PFX-CHAINBREAK-S3 name S3 as the source state; other source states preserve their current state | CT PTS-011; CT PFX-CHAINBREAK-S3; Specification §6 and §8 FD-08 |
| R09 | SH + HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate + true → SR | CT PTS-012 and PTS-017d; Specification §8 FD-10; §9 SR entry |
| R09a | S3 + RemediableFailureOfFv06OrFv12 + either Boolean → SH; SH + RemediableFailureOfFv06OrFv12 + either Boolean remains SH; SH + ReadmissionReview + true → SR. R09a has no transition from terminal S8 or SX. | Specification §8, FD-07 enters SH; §9, SH entry / Readmission review exit; CT PTS-012 and PTS-014 terminal-state assertion |
| R10 | SR + a boundary-relevant field-change trigger + true → S2 | CT PTS-013 and PTS-023; CT ORC-NON-INHERITANCE; Specification §9, SR exit branch 1 |
| R11 | SR + policy_snapshot_id-only or rehydration_closure_ref-only change + true → S5 | CT PTS-023; CT ORC-NON-INHERITANCE; Specification §9, SR exit branch 2 |
| R12 | S8 + Handoff + either Boolean → S8; SX + IncidentOnlyOutput + either Boolean → SX | CT PTS-014; CT ORC-TERMINAL-INTEGRITY; Specification §9 terminal exits |
| R13 | A verdict-layer-only `INCIDENT_ONLY` or `REPLAY_INCOMPLETE` outcome does not advance the workflow state | CT ORC-VERDICT-LAYER-EMISSION; AMB-17; Specification §§4.1, 9–10 |
| R14 | Any state/trigger/Boolean tuple not covered by R01–R13 preserves the current state; no transition is inferred from a component result, verdict token, or tuple label alone | Projection criterion: only the transition surfaces identified by CT §8, Specification §§8–9 and their explicit failure routes in §§6, 10 determine a target; the package defines no transition for an uncovered tuple. |

The six family verdicts are a separate surface, not `FamilyWorkflowState` outputs. Their vocabulary and separation from states follow Specification §4.1, CT §3 and §8 ORC-VERDICT-SET, and AMB-15–AMB-17. The composed verdict observations use component-produced fields and are exercised by the public oracles in CT §7 and the Annex C connector records; their decision sources are Specification §§4.1–4.2, §6–§10 and the cited oracle rows. AWK evaluates the composed verdict surface in `component_pipeline.awk`; Brainfuck exposes the six-token verdict vocabulary as probes. The Part A transition function is in `family_projection.py`. The projection uses CT-named trigger labels where supplied; it does not claim that every tuple label is a canonical state-transition term in the Specification.
