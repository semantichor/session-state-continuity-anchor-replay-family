# R3.5 Anchor Attestation — FAM-SSCAR-FI-001 (rust paradigm)

Answered after reading all 6 packs (SSCAR integrator pack + 3 connector annexes read directly;
the 5 component packs read in full through delegated extraction over their own 11 files each),
without re-opening files.

## Q1. What does the Family Pack promise as delivered, and what is the family verdict?

The 6 packs together deliver a normative, execution-neutral **family integrator** that composes the five
local component agents (VRA, BDA, TAA, ARA, FPA) into one emergent family decision — the
`session_replay_admissibility` decision (`SSCAR_Specification.md` §2 Primary decision objects;
`SSCAR_README.md` §"What this package is"). The composition surface the 6 packs deliver is: FIC-01..FIC-03
intake/replay/readmission inputs, FV-01..FV-12 family validators consuming component-produced fields
(Annex A), a closed 12-state workflow S0–S8 + SH/SR/SX, a decision table FD-01..FD-10, gate logic §10, a
15-field evidence contract FEV-01..FEV-15, and the five output contracts FOC-01..FOC-05. The family verdict
is the **emergent** `family_verdict`, drawn from exactly six canonical values — `REPLAY_ADMISSIBLE`,
`REPLAY_ADMISSIBLE_CONSTRAINED`, `REPLAY_INCOMPLETE`, `NONCOMPLIANT_HOLD`, `CONTAMINATION_FAIL_CLOSED`,
`INCIDENT_ONLY` (§4.1). It is load-bearing that this is **not** an aggregation, average, majority-vote, or
first-failing-wins of the five component verdicts: the five components produce DATA FIELDS, the twelve family
validators consume those fields, and the verdict emerges only after cross-domain closure per the §10 gate logic;
AMB-01 forbids "replacing the family verdict with an isolated local result."

## Q2. What does the buyer-contract explicitly delegate to deployment?

Per `SSCAR_README.md` §"What your team must produce" and §17, the companion artifacts the buyer builds —
which are not in the pack and which I do not implement as part of the normative core — are: (1) the conforming
executable integrator binding; (2) component wiring and adapters for ARA/BDA/FPA/TAA/VRA using Annex A
producer-consumer wiring and Annex B canonical-token identity; (3) boundary intake, replay-request,
readmission-review and output projections for FIC-01..FIC-03 and FOC-01..FOC-05; (4) the evidence assembly
and export pipeline producing FEV-01..FEV-15 including `report_signature` and `export_manifest_ref`; (5) an
operator-declared implementation profile covering cryptographic suite, storage backend, serialization, operator
workflow, optional assurance/attestation controls, and any downstream rollback action; and (6) a conformance
harness. The parameterizable-without-semantic-change items of §17.4 (`reason_code` naming, concrete JSON field
names, operator role names, cryptographic-suite and storage-backend selection) and the optional parameters of
§17.2 are likewise deployment-owned.

## Q3. How do the seven family test suites partition?

The Family Pack ships SEVEN buyer-runnable test suites plus one emergent observable. The seven are: (1) VRA
component Conformance Tests `PT-*`; (2) BDA component Conformance Tests `PTS-BDA-*`; (3) TAA component
Conformance Tests `TAA-PT-*`, together with its `VP-GEN-*` verification-point sub-suite; (4) ARA component
Conformance Tests `ARA-T*`; (5) FPA component Conformance Tests `FPA-T-*`/`FPA-D-*`; (6) the SSCAR integrator
**Public Test Suite** `PTS-*` (28 records anchored 1:1 to the specification — 19 directly runnable, 2
parameterized, 7 declarative, per `SSCAR_README.md` §"How to verify" and `SSCAR_Conformance_Tests.md` §5/§7/§8);
and (7) the **Annex C Family Connector Test Suite** `CT-01..CT-14`. The eighth element is the emergent
family-verdict observable, distilled from the SSCAR suites under composition rather than a separate test set.
Family conformance is convergence on ALL seven suites plus a convergent emergent family verdict; failure at any
suite is a family conformance failure (`SSCAR_README.md` §"How to verify your implementation conforms").

## Q4. Where is the boundary between spec-derivable and deployment-substrate PTs?

The deployment-substrate records are those whose outcome depends on values the pack does not fix: the FV-04
local-reclassification policy hook, which `SSCAR_Conformance_Tests.md` §8 marks parameterized (PTS-007) and whose
reclassification-policy details Annex A Row 4 leaves to the implementer; and the verdict-emission-layer correctness
checks for `REPLAY_INCOMPLETE` / `INCIDENT_ONLY` / `REPLAY_ADMISSIBLE_CONSTRAINED` differentiation, which §8 and §7
ORC-VERDICT-LAYER-EMISSION record as declarative (no dedicated workflow state — AMB-17). The boundary runs both
ways: where a pack surface itself fixes a determination as deterministic and not operator-decided, that
determination is spec-derivable — for example Annex A Row 12's re-entry envelope (boundary-field change re-enters at
S2, rehydration-field change re-enters at S5, no third re-entry point, operator discretion not admitted) and Annex A
Row 4's requirement that reclassification be explicit and never implicit are pack-fixed even while the reclassification
policy content itself remains deployment-side. The SR re-entry discriminator beyond the five declared branches is
forbidden by §9 and §8's bounded-external note, so the two-branch target rule is spec-derivable, not operator-decided.
