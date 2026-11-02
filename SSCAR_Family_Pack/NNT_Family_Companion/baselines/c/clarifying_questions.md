# Clarifying Questions — NNT-FAM-SSCAR-FI-001 (paradigm c)

Each interpretation choice made during R5, with the full search trail through the pack's normative sources (searched in both structured and prose form). No `real_residual` observed: every question resolved in a pack surface, in D4 as a decision rule, as a deployment obligation, or as preserved paradigm-idiomatic openness.

### Q1. On FV-03 failure, does the family route to CONTAMINATION_FAIL_CLOSED or REPLAY_INCOMPLETE?

**Triggered by**: `SSCAR_Specification.md:243` — FV-03 declares a two-line fail effect; the verdict-emission layer needs the discriminator.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-03 fail-effect prose + §8 FD-02 + §10 gate logic — resolved: FV-03 prose states the discriminator explicitly.
2. Conformance Tests — PTS-004b + PFX-CONTAM-FV03 — confirms the contamination branch -> SX.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — not reached.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:246`
**Resolution text**: Presence of any contamination signal (FV-09 trigger condition or unlabeled mechanism-level claim) routes to `CONTAMINATION_FAIL_CLOSED`; absence of contamination plus policy-compatibility failure routes to `REPLAY_INCOMPLETE`. Implemented as the `o->contamination` discriminator in `fam_verdict`.

### Q2. On FV-07 failure, what distinguishes the non-remediable fail-closed branch from the remediable hold?

**Triggered by**: `SSCAR_Specification.md:281` — FV-07 carries two fail effects with a remediability discriminator.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-07 remediability test + §9 SH entry trigger — resolved.
2. Conformance Tests — PTS-010 (`PFX-ANTIROLLBACK-S5`) + CT-06 — confirms anti-rollback -> SX, not SH.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AMB-03 (hold vs fail-closed) consistent.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:284`
**Resolution text**: Any failure affecting integrity, anti-rollback, or read-only invariants is non-remediable -> `CONTAMINATION_FAIL_CLOSED`; a failure isolated to policy prerequisites is remediable -> `NONCOMPLIANT_HOLD` (readmission via SH -> SR). Annex A Row 7 restates it (`SSCAR_Producer_Consumer_Manifest.md:39`).

### Q3. For SR re-entry when only policy_snapshot_id changed, is the target S2 or S5?

**Triggered by**: `SSCAR_Family_Connector_Tests.md:212` — CT-14 case (c) lists policy_snapshot_id under boundary fields (-> S2), while §9 SR exit lists policy_snapshot_id under the branch -> S5. A relationship-asserting question (token X routes to state Y).

**Searched in (in order, stop at first resolution)**:
1. Specification — §9 SR exit branch 2 — resolved: policy_snapshot_id or rehydration_closure_ref -> S5.
2. Conformance Tests — PTS-023 + `PFX-RE-ENTRY-S5` (Source authority "§9 SR exit branch 2") + `ORC-NON-INHERITANCE` — confirms the core apparatus fixes the target.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — not reached.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:476`
**Resolution text**: The Specification controls over the subordinate Annex-C surface (Annex C states its tests "do not replace the public test suite", `SSCAR_Family_Connector_Tests.md:262`; the Oracle-authoring anchor fixes the SR envelope from §9 + PTS-023). policy_snapshot_id -> S5. The implementation and the CT-14 oracle both take S5.

### Q4. What outcome governs a (state, trigger) combination not enumerated in the family transition table?

**Triggered by**: `SSCAR_Specification.md:394` — §9 enumerates entry/exit triggers but not every (state, trigger) pair; `fam_next` needs a default.

**Searched in (in order, stop at first resolution)**:
1. Specification — §10 gate logic (fail-closed invariant) + §9 terminal states — partial.
2. Conformance Tests — PTS-011 (`result == SX (NOT current state)` for contamination triggers) + PTS-014 (terminal self-loop) — resolved for the enumerated critical triggers.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AMB-17 — resolved for the general case.

**Resolution status**: `resolved_in_d4`
**Resolution citation**: `SSCAR_Ambiguity_Register.md:27`
**Resolution text**: Contamination-class triggers route to SX from any state; terminal S8/SX self-loop; otherwise the state machine does not advance (non-advancement is AMB-17's projection-correct signal, with the state-less verdict emitted by the verdict layer). Implemented in `fam_next` as contamination -> SX, terminal self-loop, else current-state preservation.

### Q5. Can a `FamilyWorkflowState`-returning projection ever return REPLAY_INCOMPLETE or INCIDENT_ONLY?

**Triggered by**: `SSCAR_Conformance_Tests.md:208` — Minimal Run Note requires a `next_state -> FamilyWorkflowState` AND a separate verdict-emission layer.

**Searched in (in order, stop at first resolution)**:
1. Specification — §4.1 verdict vocabulary + §9 states (no state for these two verdicts) — partial.
2. Conformance Tests — ORC-VERDICT-LAYER-EMISSION ("no dedicated workflow state") — confirms.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AMB-17 (decision rule on verdict-vs-state kinds) — resolved: the presupposition that these verdicts have states does not hold.

**Resolution status**: `resolved_in_d4`
**Resolution citation**: `SSCAR_Ambiguity_Register.md:27`
**Resolution text**: `REPLAY_INCOMPLETE` and `INCIDENT_ONLY` are family verdicts with no workflow state; `next_state` cannot return them. The baseline keeps `enum FamState` and `enum FamVerdict` as two disjoint types and emits these via `fam_verdict` only (PTS-021 type-disjointness).

### Q6. Which of {S0, S1} does the VRA authority-release branch return?

**Triggered by**: `Verified_Rehydration_Agent_Conformance_Tests.md:376` — PT-024 is parameterized; the return is bounded, not fixed.

**Searched in (in order, stop at first resolution)**:
1. Specification — §12 transition `S8 | authority_release | ... | S0 or S1` — leaves the branch open.
2. Conformance Tests — OR-20 pass condition is set membership `Result in {S0, S1}` — resolved as a bounded envelope.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AR-002 (verdict vs state) consistent.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `Verified_Rehydration_Agent_Conformance_Tests.md:502`
**Resolution text**: The pack fixes the semantics (membership of the permitted state set) and leaves the concrete branch to the operator envelope; prescribing a single value would force one deployment's readmission route on all. The baseline returns S1, a member of the permitted set.

### Q7. What value / shape should `next_state` return, and how is a verdict carried when it is not a state?

**Triggered by**: `SSCAR_Conformance_Tests.md:208` — the projection surface signature is required but the concrete return mechanism is not.

**Searched in (in order, stop at first resolution)**:
1. Specification — §9 / §12 fix the state enumeration and the JSON handoff shape, not a language return type — the mechanism is open.
2. Conformance Tests — Minimal Run Note asserts state equality + verdict equality as separate result types — confirms two surfaces.
3. Semantic Index — structured slots name the enums, not a return mechanism.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AMB-16 (decision-rule labels are not verdicts) consistent.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `SSCAR_Specification.md:208`
**Resolution text**: The pack constrains the SEMANTICS (a closed `FamilyWorkflowState`, a separate `FamilyNormativeVerdict`, verdict identity carried out-of-band) but not the MECHANISM. Prescribing a C return type would force a paradigm idiom. The baseline uses an `enum` return for `next_state` and a separate `fam_verdict` function over a `fv_outcomes_t` struct.

### Q8. Why does FPA EvidencePending with `validator_passed=false` route to QUARANTINED rather than REJECTED?

**Triggered by**: `Freshness_Portability_Agent_Conformance_Tests.md:458` — FPA-T-06 asserts `next_state(VERIFIED, EvidencePending, false) == QUARANTINED`, which differs from the other `validator_passed=false -> REJECTED` rows.

**Searched in (in order, stop at first resolution)**:
1. Specification — §8 S2 allowed outbound `EvidencePending -> S7` + §7 VAL-004/007/008/009 recoverable failure -> OPEN_QUARANTINE_CASE — resolved.
2. Conformance Tests — VP-GEN-006 + FPA-T-23 recoverable branch — confirms EvidencePending is the recoverable-escalation trigger.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AMB-002 (QUARANTINE cluster) / AMB-003 (REJECT != FAIL_CLOSED) consistent.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `Freshness_Portability_Agent_Specification.md:253`
**Resolution text**: EvidencePending is itself the recoverable-escalation trigger to S7 QUARANTINED; the `validator_passed` boolean marks the recoverable policy/evidence/transport failure, so the route is QUARANTINED, not the fail-closed REJECTED. Implemented as a dedicated `{S2, EvidencePending, -> S7}` row.

### Q9. Is BDA's verdict recoverable from the workflow state alone?

**Triggered by**: `Boundary_Defense_Agent_Specification.md:41` — OUTPUT_BLOCKED is a state while BLOCK is a verdict; several PTs assert a verdict.

**Searched in (in order, stop at first resolution)**:
1. Specification — PR-WF rows attach verdicts to transitions; PR-SCR verdict meanings — partial.
2. Conformance Tests — OR-BDA-015 / PTS-BDA-036 (state route may be shared; verdict semantics distinct) — confirms verdict carried alongside state.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AMB-011 (OUTPUT_BLOCKED state vs BLOCK verdict) — resolved: kept distinct.

**Resolution status**: `resolved_in_d4`
**Resolution citation**: `Boundary_Defense_Agent_Ambiguity_Register.md:25`
**Resolution text**: The state label is not the verdict token. The baseline prints both `state=` and `verdict=` from the BDA transition / decision surfaces so the distinction is observable downstream.

### Q10. Do the four CONFLICT_CHECKING verdict routes collapse into distinct TAA states?

**Triggered by**: `Truth_Arbitration_Agent_Conformance_Tests.md:481` — PT-027 asserts all four verdict-producing routes share DECIDED.

**Searched in (in order, stop at first resolution)**:
1. Specification — §5 CONFLICT_CHECKING normative output -> DECIDED/ESCALATE/FAIL_CLOSED — partial.
2. Conformance Tests — TAA-OR-K-PROJECTION ("verdict identity carried in trigger and evidence bundle, not state alone") — resolved.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register — AMB-006 (RECLASSIFY is an action, not a verdict) consistent.

**Resolution status**: `resolved_in_ct`
**Resolution citation**: `Truth_Arbitration_Agent_Conformance_Tests.md:788`
**Resolution text**: ALLOW / ALLOW_CONSTRAINED / DENY / ESCALATE all route to DECIDED; verdict identity is carried by the trigger (and evidence bundle), never by the state alone. `taa_next` returns DECIDED for all four while `taa_verdict_for` carries the verdict token from the trigger.
