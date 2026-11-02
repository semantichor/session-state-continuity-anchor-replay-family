# R7 Clarifying Questions — FAM-SSCAR-FI-001 (python)

Each interpretation choice made during R5, with the full 5-source search trail before the resolution status. Citations are `<filename>:<int>`.

### Q1. Does the family verdict aggregate the five component verdicts, or is it emergent?

**Triggered by**: `SSCAR_Specification.md:23` — the baseline had to decide whether `session_replay_admissibility` is computed by combining component verdicts or by composing component DATA FIELDS through `FV-01..FV-12`.

**Searched in (in order, stop at first resolution)**:
1. Specification — §1 Operational Objective + §10 Gate Logic — found: the family verdict emerges from cross-domain closure over the family validators, not from local verdicts (`SSCAR_Specification.md:23`, `SSCAR_Specification.md:496`).
2. Conformance Tests — not reached as primary; `PTS-003` integration record consistent.
3. Semantic Index — `SSCAR_Semantic_Index.md` ID-07 `family verdict` prose "distinct from any local verdict" — consistent.
4. Coverage Matrix — not reached.
5. Ambiguity Register (D4) — `AMB-01` governs the relationship term `family verdict` vs `local verdict`.

**Resolution status**: `resolved_in_d4` (relationship-presupposition per the methodology rule: the presupposition "aggregation" does not hold).
**Resolution citation**: `SSCAR_Ambiguity_Register.md:11`
**Resolution text**: `AMB-01` forbids replacing the family verdict with an isolated local result; the baseline wires component fields into `FV-01..FV-12` and emits the verdict from their outcomes.

### Q2. On `FV-03` failure, when is the outcome CONTAMINATION_FAIL_CLOSED vs REPLAY_INCOMPLETE?

**Triggered by**: `SSCAR_Specification.md:243` — the `family_validator_outcomes` wiring needed a discriminator for the two `FV-03` fail effects.

**Searched in (in order)**:
1. Specification — §7 `FV-03` Fail effect prose carries the discriminator explicitly — resolved (`SSCAR_Specification.md:243`).
2. Conformance Tests — `PTS-004b` (unlabeled → SX) consistent.
3. Semantic Index — `FV-03` entry restates the two-effect fail — consistent.
4. Coverage Matrix — term→§7 only.
5. Ambiguity Register — `AMB-03` (hold vs fail-closed) supports.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:246`
**Resolution text**: a contamination signal (unlabeled mechanism-level claim / `FV-09` trigger) routes to CONTAMINATION_FAIL_CLOSED; labeled-but-policy-incompatible with no contamination routes to REPLAY_INCOMPLETE.

### Q3. On `FV-07` failure, what separates the non-remediable branch from the remediable hold?

**Triggered by**: `SSCAR_Specification.md:281` — the baseline's `FV-07` branch field needed the integrity-vs-policy test.

**Searched in (in order)**:
1. Specification — §7 `FV-07` Remediability test prose — resolved (`SSCAR_Specification.md:284`).
2. Conformance Tests — `PTS-010`/`PTS-025` (anti-rollback → SX) consistent.
3. Semantic Index — `FV-07` entry restates both effects.
4. Coverage Matrix — term→§7.
5. Ambiguity Register — `AMB-03` supports remediable/fail-closed split.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:284`
**Resolution text**: integrity, anti-rollback, or read-only failure is non-remediable → CONTAMINATION_FAIL_CLOSED; a failure isolated to policy prerequisites is remediable → NONCOMPLIANT_HOLD. Annex A Row 7 corroborates (`SSCAR_Producer_Consumer_Manifest.md:39`).

### Q4. How does a workflow-state projection signal REPLAY_INCOMPLETE and INCIDENT_ONLY?

**Triggered by**: `SSCAR_Conformance_Tests.md:208` — the Minimal Run Note mandates a `next_state -> FamilyWorkflowState` surface, but two verdicts have no state.

**Searched in (in order)**:
1. Specification — §9 state set has no INCIDENT_ONLY / REPLAY_INCOMPLETE state; §10 gate logic emits them at the verdict layer (`SSCAR_Specification.md:499`).
2. Conformance Tests — §8 Minimal Run Note part (b) verdict-emission layer (`SSCAR_Conformance_Tests.md:208`).
3. Semantic Index — verdict entries present; no state entries for them.
4. Coverage Matrix — State Terms list 12 states, none named INCIDENT_ONLY/REPLAY_INCOMPLETE.
5. Ambiguity Register — `AMB-17` governs the verdict-vs-state relationship.

**Resolution status**: `resolved_in_d4` (relationship-presupposition per the methodology rule).
**Resolution citation**: `SSCAR_Ambiguity_Register.md:27`
**Resolution text**: `AMB-17` fixes that these are verdicts emitted by the verdict-emission layer; the state machine signals them by non-advancement. The baseline's `next_state` never returns them; `emit_family_verdict` does.

### Q5. From `SR READMISSION_REVIEW`, which re-entry target applies?

**Triggered by**: `SSCAR_Specification.md:474` — `family_next_state` needed the SR exit discriminator.

**Searched in (in order)**:
1. Specification — §9 SR exit branch 1 / branch 2 discriminator — resolved (`SSCAR_Specification.md:475`).
2. Conformance Tests — `PTS-023` / `CT-14` five-branch envelope consistent.
3. Semantic Index — `SR READMISSION_REVIEW` entry references §9.
4. Coverage Matrix — state term → §9.
5. Ambiguity Register — `AMB-12` (input contract vs decision rule) adjacent, not governing.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:476`
**Resolution text**: changed `carried_payload`/`anchor_document_ref`/`source_control_bundles` (or component set) → `S2 BOUNDARY_SCREENED`; changed only `policy_snapshot_id`/`rehydration_closure_ref` → `S5 REHYDRATION_CLOSED`; no third re-entry point (Annex A Row 12, `SSCAR_Producer_Consumer_Manifest.md:44`).

### Q6. What mechanism should a failed critical validator use (exception / Result / error code)?

**Triggered by**: `SSCAR_Specification.md:64` — fail-closed semantics are fixed, the mechanism is not.

**Searched in (in order)**:
1. Specification — §2 Fail-closed invariant fixes the SEMANTICS (no positive verdict under contamination/incompleteness) not the mechanism (`SSCAR_Specification.md:64`).
2. Conformance Tests — oracles assert states/verdicts, not a mechanism.
3. Semantic Index — Fail-closed invariant entry restates semantics.
4. Coverage Matrix — CTRL-19 → §2/§10.
5. Ambiguity Register — no entry prescribes a mechanism.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `SSCAR_Specification.md:64`
**Resolution text**: prescribing a return mechanism would force one paradigm idiom. The baseline expresses fail-closed as closed-enum terminal states/verdicts and reserves custom `Exception` subclasses for boundary contract faults only (unknown op/token), which is the python-idiomatic realization of the fixed semantics.

### Q7. For an unenumerated `(state, trigger)` in TAA, what governs the outcome?

**Triggered by**: `Truth_Arbitration_Agent_Conformance_Tests.md:209` — `taa_next_state` needed a default rule.

**Searched in (in order)**:
1. Specification — §9 Gate Logic "If no specialized branch applies and the decision path is structurally incomplete, the result shall be FAIL_CLOSED" — resolved (`Truth_Arbitration_Agent_Specification.md:182`).
2. Conformance Tests — `TAA-PT-011` purpose "Protective default outcome / no silent state preservation" (`Truth_Arbitration_Agent_Conformance_Tests.md:209`).
3. Semantic Index — Gate Logic Record entry references §9.
4. Coverage Matrix — TAA-CONTROL-001 → §9.
5. Ambiguity Register — no contrary entry.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `Truth_Arbitration_Agent_Specification.md:182`
**Resolution text**: an unenumerated / invalid combination routes to FAIL_CLOSED (protective default); `CLOSED` is terminal and absorbs non-reopen triggers.

### Q8. For an unenumerated combination in FPA, what governs the outcome?

**Triggered by**: `Freshness_Portability_Agent_Conformance_Tests.md:217` — `fpa_next_state` default rule.

**Searched in (in order)**:
1. Specification — Appendix A `PR-10` `Agent states are finite and closed, and only validated transitions may be selected externally` — resolved (`Freshness_Portability_Agent_Specification.md:450`).
2. Conformance Tests — `FPA-T-11` / `FPA-T-PR-10` assert invalid combination → REJECTED (`Freshness_Portability_Agent_Conformance_Tests.md:464`).
3. Semantic Index — `determinacy rule` CTL-005 supports one active path.
4. Coverage Matrix — CTL-005 → §13.
5. Ambiguity Register — no contrary entry.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `Freshness_Portability_Agent_Specification.md:450`
**Resolution text**: the closed state machine rejects an invalid combination to `S8 REJECTED` (fail-closed default).

### Q9. Are VRA `PT-028` / `PT-029` (bounded-external declarative) a SKIP or an evidence-satisfied PASS?

**Triggered by**: `Verified_Rehydration_Agent_Conformance_Tests.md:426` — the two declarative records are "not locally runnable" on the transition surface.

**Searched in (in order)**:
1. Specification — §16 deployment obligations name V_COMPAT / single-writer surfaces (`Verified_Rehydration_Agent_Specification.md:296`).
2. Conformance Tests — §4 Minimal Run Note Suite PASS condition counts both as "satisfied by implementation evidence" (`Verified_Rehydration_Agent_Conformance_Tests.md:516`).
3. Semantic Index — `V_COMPAT` / `V_WRITER_LOCK` entries restate the enforcement points.
4. Coverage Matrix — VA-008 / VA-017 → §10.
5. Ambiguity Register — no contrary entry.

**Resolution status**: `resolved_in_ct`
**Resolution citation**: `Verified_Rehydration_Agent_Conformance_Tests.md:516`
**Resolution text**: the suite PASS condition counts both checks evidence-satisfied, so each is PASS by a real captured invocation of its attestation surface (not a SKIP); the pinned partition does not list them as cited SKIPs.

### Q10. Does the §8 decision rule `FD-05` (S5 → S8) contradict the §9 workflow (S5 → S6 → S7 → S8)?

**Triggered by**: `SSCAR_Specification.md:362` — `FD-05` names gate impact "S5 → S8" while §9 enumerates two intermediate states.

**Searched in (in order)**:
1. Specification — §9 enumerates S5→S6 (`FV-08`), S6→S7 (`FV-10/FV-11`), S7→S8 (`SSCAR_Specification.md:444`); §8 `FD-05` is a decision rule whose coarse gate impact names the net positive outcome (`SSCAR_Specification.md:362`).
2. Conformance Tests — `PTS-024` derives S4→S5 from §9 + §7; no record treats FD-05 as skipping states.
3. Semantic Index — `FD-05` entry labels it a decision rule (not a transition).
4. Coverage Matrix — FD-05 → §8 Decision Table only.
5. Ambiguity Register — `AMB-16` fixes that an `FD-NN` label is a decision rule, not a verdict or a transition.

**Resolution status**: `resolved_in_d4`
**Resolution citation**: `SSCAR_Ambiguity_Register.md:26`
**Resolution text**: `AMB-16` keeps decision-rule labels distinct from the state machine; `FD-05` is the rule producing the positive verdict, while §9 carries the fine-grained S5→S6→S7→S8 path the baseline implements. No contradiction under complete reading.
