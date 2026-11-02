# R3.5 — Anchor Attestation (FAM-SSCAR-FI-001 family composition)

Answers to the four buyer-contract questions, derived from the 68 buyer-facing files read under R3.1. Observational language throughout; spec terms carrying forbidden-vocabulary substrings are quoted in `inline code`.

## Q1. What the Family Pack promises as delivered, and the family verdict

The Family Pack delivers a composition surface, not six separable outputs. The five component packs (VRA, BDA, TAA, ARA, FPA) each deliver a self-contained normative single-agent specification: a closed state machine, a `validator` catalogue, a verdict vocabulary, an evidence contract, and a buyer-runnable conformance suite, producing the public output fields the integrator consumes (`SSCAR_Producer_Consumer_Manifest.md` Annex A §4 maps these: FPA `accepted_head_digest`/`linked_irr_digest`; TAA `tsa_label`/`statement_id`; BDA `anchor_document_ref`; ARA `checkpoint_refs`/`rollback_refs`; VRA `rehydration_closure_ref`/`snapshot_id`). The SSCAR integrator (`SSCAR_Specification.md` §§7–11) delivers the 12 family checks `FV-01..FV-12`, the decision table `FD-01..FD-10`, the 12-state workflow (S0–S8 plus SH/SR/SX), §10 gate logic, and the 15-field evidence contract `FEV-01..FEV-15`, plus the three connector annexes A/B/C that bind component outputs to the family checks.

The family verdict is the **EMERGENT** `session_replay_admissibility` decision, with exactly six canonical values (`SSCAR_Specification.md` §4.1): `REPLAY_ADMISSIBLE`, `REPLAY_ADMISSIBLE_CONSTRAINED`, `REPLAY_INCOMPLETE`, `NONCOMPLIANT_HOLD`, `CONTAMINATION_FAIL_CLOSED`, `INCIDENT_ONLY`. It is **NOT** an aggregation, average, majority-vote, or first-failing-wins of the five component verdicts: the components emit DATA FIELDS, the 12 family checks `FV-01..FV-12` consume them, and the verdict emerges per §10 gate logic. `SSCAR_Ambiguity_Register.md` AMB-01 forbids "Replacing the family verdict with an isolated local result."

## Q2. What the buyer-contract explicitly delegates to deployment

Per `SSCAR_README.md` §"What your team must produce" and §17, the integrator buyer builds six companion artifacts NOT in the pack and NOT implemented here: (1) the conforming executable family integrator; (2) component wiring/adapters for ARA/BDA/FPA/TAA/VRA using Annex A/B; (3) boundary intake, replay-request, readmission-review and output projections for `FIC-01..FIC-03` and `FOC-01..FOC-05`; (4) the evidence assembly/export pipeline producing `FEV-01..FEV-15` with `report_signature` and `export_manifest_ref`; (5) an operator-declared implementation profile (cryptographic suite, storage backend, serialization, operator workflow, optional assurance/attestation controls, downstream rollback action); (6) a conformance harness and release-acceptance record. Each component README adds its own delegated set (e.g. VRA's five deployment artifacts — stable snapshot facility, anti-rollback mechanism, local policy bundle, single-writer persistence control plane, readmission authority workflow). These are deployment-substrate obligations, outside the specification core.

## Q3. How the seven family test suites partition

The Family Pack ships SEVEN buyer-runnable suites plus one emergent observable:
1. VRA component `PT-*` (29 records; `Verified_Rehydration_Agent_Conformance_Tests.md` §4 Minimal Run Note).
2. BDA component `PTS-BDA-*` (36 records; `Boundary_Defense_Agent_Conformance_Tests.md` §5).
3. TAA component `TAA-PT-*` (27 records) plus the dual-ID `VP-GEN-*` sub-suite (27 records; `Truth_Arbitration_Agent_Conformance_Tests.md` §4), reported under both id namespaces.
4. ARA component `ARA-T*` (27 records; `Audit_Replay_Agent_Conformance_Tests.md` §8).
5. FPA component `FPA-T-*`/`FPA-D-*` (41 records; `Freshness_Portability_Agent_Conformance_Tests.md` §H).
6. The SSCAR integrator Public Test Suite `PTS-*` (30 pinned ids; 19 runnable / 2 parameterized / 7 declarative per `SSCAR_Conformance_Tests.md` §5 note).
7. The Annex C Family Connector Test Suite `CT-01..CT-14` (`SSCAR_Family_Connector_Tests.md`), consuming REAL cross-component outputs.

PLUS the emergent family-verdict observable, distilled from the SSCAR suites under composition — NOT a separate test set. Family conformance = convergence on ALL seven suites AND a convergent emergent family verdict.

## Q4. The boundary between spec-derivable and deployment-substrate records

Records whose expected value is fixed by a pack surface are spec-derivable even when the deployment orchestration around them is operator-owned. Records that depend on deployment-substrate values the pack does not provide are the deployment-substrate side. Examples read from the surfaces: the FV-04 local-reclassification policy hook is parameterized (`SSCAR_Conformance_Tests.md` §8, PTS-007) — the policy details are deployment-side, but Annex A Row 4's requirement that reclassification "must be explicit, never implicit" is pack-fixed and therefore spec-derivable. The verdict-emission-layer correctness checks for `REPLAY_INCOMPLETE`/`INCIDENT_ONLY`/`REPLAY_ADMISSIBLE_CONSTRAINED` differentiation are declarative (§8 bounded external obligation 1). The SR re-entry envelope (Annex A Row 12; §9 SR exit; PTS-023; `PFX-RE-ENTRY-S2`/`PFX-RE-ENTRY-S5`; `ORC-NON-INHERITANCE`) is pack-fixed as deterministic and NOT operator-decided — "operator discretion is not admitted" — so the determination (which re-entry target for which altered-field set) is spec-derivable, while its deployment-side orchestration is substrate. The boundary therefore runs both ways: a pack surface that fixes a determination as deterministic makes that determination spec-derivable even where adjacent policy detail stays deployment-side.
