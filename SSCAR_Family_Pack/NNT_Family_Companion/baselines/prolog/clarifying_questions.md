# Clarifying Questions — FAM-SSCAR-FI-001 (prolog)

Each interpretation choice made during R5, with its full 5-source search trail
(Specification → Conformance Tests → Semantic Index → Coverage Matrix → Ambiguity Register),
stopping at the first resolution. Citations use `<filename>:<int>`.

### Q1. For an SR readmission bundle that changes only `policy_snapshot_id`, does re-entry target `S2 BOUNDARY_SCREENED` or `S5 REHYDRATION_CLOSED`?

**Triggered by**: `SSCAR_Specification.md:476` — the SR exit discriminator had to be encoded in `fsm_fam/4`, and a subordinate surface (Annex A Row 12 / Annex C CT-14) places `policy_snapshot_id` at the boundary-screened re-entry while §9 places it at rehydration-closed.

**Searched in (in order, stop at first resolution)**:
1. Specification — §9 SR exit branches + §5 re-entry non-inheritance — `SSCAR_Specification.md:476` states "→ S5 REHYDRATION_CLOSED when the readmission bundle changes only policy_snapshot_id or the verified-rehydration closure"; `SSCAR_Specification.md:475` fixes the boundary-field branch → S2. **Resolved here.**
2. Conformance Tests — PTS-023 + PFX-RE-ENTRY-S2/S5 + ORC-NON-INHERITANCE — `SSCAR_Conformance_Tests.md:52` and `SSCAR_Conformance_Tests.md:70` confirm the §9 mapping (policy/rehydration change → S5); this is the controlling core apparatus.
3. Semantic Index — searched `SR`/`re-entry`/`REHYDRATION_CLOSED` in structured slots and prose — no `re-entry` preferred_label present; `SR READMISSION_REVIEW` indexes only to §9 (no independent resolution).
4. Coverage Matrix — `SR` term→section mapping — `SSCAR_Coverage_Matrix.md:123` maps `SR READMISSION_REVIEW` source_refs to `§9 Workflow and State Transitions` (points back to the Specification).
5. Ambiguity Register — AMB-12 (FamilyReadmissionReview vs READMISSION_REVIEW_GRANTED) governs input-vs-rule, not the field→target map; no AMB entry re-targets the branch.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:476`
**Resolution text**: §9 controls (the Oracle-authoring anchor: Annex A is non-additive/non-modificative, Annex C does not replace the public suite); `policy_snapshot_id`-only change → `S5 REHYDRATION_CLOSED`. (The Annex A Row 12 / CT-14 surface difference is recorded in `inconsistencies.md`.)

### Q2. Does an FV-07 failure route to `CONTAMINATION_FAIL_CLOSED` or `NONCOMPLIANT_HOLD`?

**Triggered by**: `SSCAR_Specification.md:281` — `fsm_fam/4` and `fam_vmap/2` needed the two-branch remediability discriminator for FV-07.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-07 catalogue prose — `SSCAR_Specification.md:282` fixes `CONTAMINATION_FAIL_CLOSED` (non-remediable) for anti-rollback / signature / chain / snapshot / read-only failure and `SSCAR_Specification.md:283` fixes `NONCOMPLIANT_HOLD` (remediable) for policy-prerequisite-only failure. **Resolved here.**
2. Conformance Tests — PFX-ANTIROLLBACK-S5 + §7 FV-07 non-remediable — `SSCAR_Conformance_Tests.md:66` confirms the non-remediable integrity branch.
3. Semantic Index — `FV-07` entry — indexes to §7 Validator Catalogue; no severity split carried as a term (indexes do not carry reason codes, per the contract rule).
4. Coverage Matrix — `SSCAR_Coverage_Matrix.md:48` + `:107` map CTRL-07 / FV-07 source_refs to `§7 / FV-07` (points back to the Specification prose).
5. Ambiguity Register — AMB-03 (NONCOMPLIANT_HOLD vs CONTAMINATION_FAIL_CLOSED) confirms the two are kept distinct (remediable vs fail-closed).

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:282`
**Resolution text**: integrity / anti-rollback / read-only failure → `CONTAMINATION_FAIL_CLOSED` (non-remediable); policy-prerequisite-only failure → `NONCOMPLIANT_HOLD` (remediable, readmissible via SH→SR). Annex A Row 7 (`SSCAR_Producer_Consumer_Manifest.md:39`) agrees.

### Q3. What should the projection surface return for a (state, trigger) combination not enumerated in the transition table?

**Triggered by**: `SSCAR_Specification.md:497` — every `fsm_*/4` needed a total function; the mechanism for the fall-through was a paradigm choice.

**Searched in (in order, stop at first resolution)**:
1. Specification — §10 Gate Logic fail-closed invariant + §4.1 — `SSCAR_Specification.md:64` fixes the fail-closed invariant; `SSCAR_Specification.md:497` fixes blocking routing. The SEMANTICS are fixed (fail-closed / non-advancement) but no return MECHANISM is prescribed.
2. Conformance Tests — `SSCAR_Conformance_Tests.md:44` (PTS-014 terminal) + component suites (FPA `Freshness_Portability_Agent_Conformance_Tests.md:213` fail-closed default) fix the observable, not the mechanism.
3. Semantic Index — searched `fail-closed` / default — present as a semantic property, no mechanism term.
4. Coverage Matrix — fail-closed terms map to §10 / §6 (Specification).
5. Ambiguity Register — AMB-17 governs that `REPLAY_INCOMPLETE` / `INCIDENT_ONLY` are signalled by non-advancement, not an invented state.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `SSCAR_Specification.md:64`
**Resolution text**: the pack fixes the semantics (component fail-closed default; family non-advancement per AMB-17) but leaves the mechanism to the paradigm. This baseline encodes component fall-through as a terminal clause to the fail-safe/rejected state and the family fall-through as an identity (non-advancement) clause; prescribing a single return shape would force one paradigm idiom and contradict execution-neutrality.

### Q4. Do `REPLAY_INCOMPLETE` and `INCIDENT_ONLY` have dedicated workflow states?

**Triggered by**: `SSCAR_Specification.md:279` (prompt R5 part 2) — the verdict-emission layer had to be kept distinct from `fam_next/4`; this question presupposes a verdict↔state relationship.

**Searched in (in order, stop at first resolution)**:
1. Specification — §9 state list + §4.1 verdict list — `SSCAR_Specification.md:142`–`:159` list six verdicts; §9 lists twelve states; neither names a `REPLAY_INCOMPLETE`/`INCIDENT_ONLY` state. Relationship not fixed by a single §9 clause alone.
2. Conformance Tests — ORC-VERDICT-LAYER-EMISSION — `SSCAR_Conformance_Tests.md:136` fixes emission at the verdict layer with no dedicated workflow state.
3. Semantic Index — searched `REPLAY_INCOMPLETE` preferred_label / prose — carried as a verdict term only (indexes do not carry it as a state term).
4. Coverage Matrix — verdict terms map to §4.1 / §10; no state mapping for these two.
5. Ambiguity Register — **AMB-17** (`SSCAR_Ambiguity_Register.md:27`) is the decision rule: the two are verdicts with no workflow state, signalled by non-advancement plus verdict-layer emission; inventing a state is a forbidden collapse. **Resolved here.**

**Resolution status**: `resolved_in_d4`
**Resolution citation**: `SSCAR_Ambiguity_Register.md:27`
**Resolution text**: the presupposed verdict↔state relationship does not hold; AMB-17 keeps them in distinct categorical kinds. The baseline emits them only through `fam_vmap/2` (verdict layer); `fsm_fam/4` signals via non-advancement (identity clause).

### Q5. How should the verdict-emission layer return the family verdict, as a value distinct from the workflow state?

**Triggered by**: `SSCAR_Conformance_Tests.md:208` (Minimal Run Note 4-part surface) — a `FamilyNormativeVerdict` distinct from `FamilyWorkflowState` was required; the representation was a paradigm choice.

**Searched in (in order, stop at first resolution)**:
1. Specification — §4.1 verdict vocabulary + §12 machine-readable form — `SSCAR_Specification.md:532` fixes the six-value enumeration as strict but adapts field names where parameterization is allowed; no return TYPE prescribed.
2. Conformance Tests — PTS-021 type-system fidelity — `SSCAR_Conformance_Tests.md:50` requires the two types to be non-implicitly-convertible, not a specific representation.
3. Semantic Index — verdict terms carried as closed enumeration; no representation mechanism.
4. Coverage Matrix — maps verdict terms to §4.1; no mechanism.
5. Ambiguity Register — AMB-15/16/17 fix that verdict tokens, state labels and decision-rule labels stay distinct, independent of representation.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `SSCAR_Specification.md:543`
**Resolution text**: the pack fixes verdict/state disjointness (semantics) but leaves the representation to the paradigm. This baseline keeps `fam_verdict_set/1` (six verdicts) and the twelve workflow-state atoms as separate predicates/relations, emitted on separate output keys (`verdict=` vs `state=`); prescribing one encoding would force a paradigm idiom.

### Q6. What governs the content of the FV-04 local-reclassification policy at `S2`?

**Triggered by**: `SSCAR_Specification.md:256` — PTS-007 exercises the reclassification hook; the policy content had to be sourced.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-04 fail effect + §4.1/§17 — `SSCAR_Specification.md:257` fixes that local reclassification is a `BOUNDED_HANDOFF_OBLIGATION` and the family flow blocks at S2 until closure (pack-fixed), while the policy details are left open.
2. Conformance Tests — `SSCAR_Conformance_Tests.md:213` Minimal Run Note bounded external obligation (2): "FV-04 local-reclassification policy hook (parameterized)". **Resolved as delegated here.**
3. Semantic Index — FV-04 term maps to §7; no policy content.
4. Coverage Matrix — FV-04 source_refs → §7 (Specification).
5. Ambiguity Register — AMB-11 (`BOUNDED_HANDOFF_OBLIGATION` vs `TRUE_DEFECT`) confirms the handoff classification.

**Resolution status**: `deployment_obligation`
**Resolution citation**: `SSCAR_Conformance_Tests.md:213`
**Resolution text**: the reclassification policy content is buyer-side (parameterized bounded external obligation); the pack fixes the deterministic part (explicit reclassification required, block at S2, no family-verdict change), which the baseline implements as non-advancement at `S2`.

### Q7. Do the TAA verdict-producing routes (`ALLOW`/`ALLOW_CONSTRAINED`/`DENY`/`ESCALATE`) each have a distinct workflow state, or do they share `DECIDED`?

**Triggered by**: `Truth_Arbitration_Agent_Conformance_Tests.md:485` — `fsm_taa/4` needed to decide whether a verdict trigger advances to a verdict-specific state or to `DECIDED`.

**Searched in (in order, stop at first resolution)**:
1. Specification — §5 State Model + §6 Decision Table — `Truth_Arbitration_Agent_Specification.md:92` shows `CONFLICT_CHECKING → DECIDED` emits verdict+evidence; the verdict is carried by the decision record, not a per-verdict state.
2. Conformance Tests — VP-GEN-027 — `Truth_Arbitration_Agent_Conformance_Tests.md:485` fixes that all four verdict-producing routes share `DECIDED`, with verdict identity carried by trigger/evidence. **Resolved here.**
3. Semantic Index — `DECIDED` carried as a single state term.
4. Coverage Matrix — verdict terms map to §2.2; `DECIDED` to §5.
5. Ambiguity Register — AMB-006 (`Truth_Arbitration_Agent_Ambiguity_Register.md:24`): `RECLASSIFY` is a `role-validation action`, not a verdict — confirming routing-action vs verdict separation.

**Resolution status**: `resolved_in_ct`
**Resolution citation**: `Truth_Arbitration_Agent_Conformance_Tests.md:485`
**Resolution text**: the four verdict-producing routes share `DECIDED`; verdict identity is carried by the trigger + evidence bundle. The baseline encodes `taa_fwd/4` decision-kind clauses that reach `DECIDED` regardless of the `validator_passed` flag, with the verdict exposed through `taa_ev/4`.
