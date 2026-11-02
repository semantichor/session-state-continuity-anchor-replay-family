# R7 Clarifying Questions — FAM-SSCAR-FI-001 (bash paradigm)

Interpretation choices made during R5, each with the full 5-source search trail before a resolution status is declared. The SSCAR Semantic Index (D1/D2) and Coverage Matrix (D3) are, by the README's semantic-closure statement, derived views 1:1 with the Specification, so they index a term to its sections without adding a resolving enumeration beyond the Specification body; that is recorded as each trail's step 3/4 result.

### Q1. How does a state-machine projection signal `REPLAY_INCOMPLETE` / `INCIDENT_ONLY`, which have no workflow state?

**Triggered by**: `SSCAR_Conformance_Tests.md:208` — the Minimal Run Note requires both a `next_state -> FamilyWorkflowState` surface and a verdict-emission layer; a `case` returning a state string cannot return these two verdict tokens.

**Searched in (in order, stop at first resolution)**:
1. Specification — §4.1 verdict vocabulary + §10 Gate Logic + §9 workflow (no S-state named for either token) — partial (names the verdicts, assigns no state).
2. Conformance Tests — ORC-VERDICT-LAYER-EMISSION (`SSCAR_Conformance_Tests.md:132`) "FV-08 fail → REPLAY_INCOMPLETE at verdict layer … no dedicated workflow state" — resolving oracle prose.
3. Semantic Index — tokens indexed to §4.1; no added enumeration — not the resolving surface.
4. Coverage Matrix — maps verdict terms to §4.1/§10 — not the resolving surface.
5. Ambiguity Register (D4) — AMB-17 (`SSCAR_Ambiguity_Register.md:27`) decision rule: these are verdicts emitted by the verdict-emission layer; state machines "signal these outcomes via non-advancement plus verdict-layer emission".

**Resolution status**: `resolved_in_d4`
**Resolution citation**: `SSCAR_Ambiguity_Register.md:27`
**Resolution text**: `next_state` never returns these; a separate verdict-emission function emits them while the state machine does not advance (baseline: `family_verdict` + non-advancement).

### Q2. On FV-07 failure, is the family verdict `CONTAMINATION_FAIL_CLOSED` or `NONCOMPLIANT_HOLD`?

**Triggered by**: `SSCAR_Specification.md:275` — FV-07 carries two fail effects; the branch must be chosen by a discriminator, not flattened.

**Searched in**:
1. Specification — §7 FV-07 (`SSCAR_Specification.md:281-284`): "Remediability test: any failure that affects integrity, anti-rollback, or read-only invariants is non-remediable and routes to CONTAMINATION_FAIL_CLOSED. Failures isolated to policy prerequisites are remediable and route to NONCOMPLIANT_HOLD." — resolving clause.
2. Conformance Tests — PFX-ANTIROLLBACK-S5 / CT-06 confirm anti-rollback → fail-closed, not hold — confirmatory.
3. Semantic Index — FV-07 indexed to §7 — not resolving.
4. Coverage Matrix — not resolving.
5. Ambiguity Register — AMB-03 keeps `NONCOMPLIANT_HOLD` (remediable) distinct from `CONTAMINATION_FAIL_CLOSED` (contamination) — supports the split.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:281`
**Resolution text**: integrity/anti-rollback/read-only failure → `CONTAMINATION_FAIL_CLOSED` (`sub=integrity`); policy-only prerequisite failure → `NONCOMPLIANT_HOLD` (`sub=policy`). Baseline encodes both branches in `family_verdict`/`family_compose`.

### Q3. FD-05 gives gate-impact `S5 → S8`; §9 sequences `S5 → S6 → S7 → S8`. Which governs `next_state`?

**Triggered by**: `SSCAR_Specification.md:358` (FD-05) vs `SSCAR_Specification.md:444-458` (§9 S6/S7) — the two tables share state identifiers S5 and S8 with different intermediate paths.

**Searched in**:
1. Specification — §9 workflow entry/exit triggers give the fine-grained S5→S6 (FV-08), S6→S7 (FV-10/11), S7→S8 sequence; §8 FD rows are decision-rule gate-impacts, coarser — resolving by role separation.
2. Conformance Tests — PTS-* drive state transitions at §9 granularity (e.g. terminal S8) — confirmatory.
3. Semantic Index — states indexed to §9 — not resolving.
4. Coverage Matrix — not resolving.
5. Ambiguity Register — AMB-16 (`SSCAR_Ambiguity_Register.md:26`): an `FD-NN` label names a decision rule whose gate impact produces a verdict, not a workflow state; do not treat it as a transition authority over §9.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:444`
**Resolution text**: the §9 workflow is the authoritative closed state machine (S5→S6→S7→S8); the FD-05 "S5 → S8" is the decision-rule gate-impact summarising the positive-closure path, reconciled via AMB-16. Baseline implements the §9 sequence.

### Q4. PT-024 authority-release result must be in `{S0, S1}` — which does the implementation return?

**Triggered by**: `Verified_Rehydration_Agent_Conformance_Tests.md:378` — OR-20 admits either S0 or S1; the implementation must pick within the envelope.

**Searched in**:
1. Specification — §12 transition `S8 | authority_release | Readmission approved | S0 or S1` (`Verified_Rehydration_Agent_Specification.md:236`) — leaves both admissible.
2. Conformance Tests — PT-024 Kind=Parameterized; OR-20 "Result ∈ {S0, S1}; no other result is admissible" — bounds the branch, not the choice.
3. Semantic Index — states indexed to §12 — not resolving.
4. Coverage Matrix — not resolving.
5. Ambiguity Register — AR-002 keeps the verdict and the S8 state distinct — unrelated to the choice.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `Verified_Rehydration_Agent_Specification.md:236`
**Resolution text**: the pack fixes the semantics (post-release re-entry lands only in the startup/snapshot-locked set) and leaves the exact member to the implementation; prescribing one would force a paradigm choice. Baseline returns `S1_SNAPSHOT_LOCKED`; the envelope `{S0,S1}` is declared in `conformance_log.md` and PT-024 is scored by membership.

### Q5. From SR READMISSION_REVIEW, which re-entry target does a readmission bundle select?

**Triggered by**: `SSCAR_Specification.md:474` — SR has two exit branches selected by the altered-field set.

**Searched in**:
1. Specification — §9 SR exit (`SSCAR_Specification.md:475-477`): changed `carried_payload`/`anchor_document_ref`/`source_control_bundles` → S2; changed only `policy_snapshot_id`/`rehydration_closure_ref` → S5; "Deployment may not introduce a third re-entry point." — resolving clause.
2. Conformance Tests — PTS-023, CT-14 enumerate the 5 branches and forbid a third — confirmatory.
3. Semantic Index — SR indexed to §9 — not resolving.
4. Coverage Matrix — not resolving.
5. Ambiguity Register — AMB-12 separates the input contract (FIC-03) from the decision rule (FD-10) — supports structure, not the target.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:475`
**Resolution text**: the altered-field set alone is the deterministic discriminator (boundary fields → S2, rehydration/policy fields → S5), reinforced by Annex A Row 12 ("operator discretion is not admitted", `SSCAR_Producer_Consumer_Manifest.md:44`). Baseline encodes all five branches in `family_next_state`.

### Q6. What value/representation should the projection surface return for a workflow state or verdict?

**Triggered by**: baseline `emit_ns` — the pack does not prescribe a wire format for `next_state` output.

**Searched in**:
1. Specification — §12 Machine-Readable Forms gives a JSON shape for handoff but marks field names adaptable (`SSCAR_Specification.md:525`) — semantics fixed, serialization open.
2. Conformance Tests — Minimal Run Note requires "WorkflowState equality" assertions, not a fixed encoding — mechanism open.
3. Semantic Index — enumerates the tokens, not a serialization — open.
4. Coverage Matrix — not resolving.
5. Ambiguity Register — no entry prescribes an output encoding.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `SSCAR_Specification.md:525`
**Resolution text**: the pack constrains the token set and equality semantics but not the mechanism; prescribing a return encoding would force one paradigm's idiom. Baseline emits a single structured `key=value` line per call (`result_state=<token>`), the `bash`-idiomatic surface.

### Q7. Must FPA `accepted_head_digest` equal the VRA head value the integrator consumes?

**Triggered by**: baseline cross-component wiring — FV-05 and FV-07 both reference the accepted head produced by different components.

**Searched in**:
1. Specification — §11 FEV-07 binds `accepted_head_digest / linked_irr_digest`; §7 FV-05/FV-07 consume them — names the fields, not the cross-component identity.
2. Conformance Tests — CT-05 assertion 5 "the integrity-receipt digest at the verified rehydration component equals linked_irr_digest at the freshness component for the same family event" (`SSCAR_Family_Connector_Tests.md:106`) — resolving at the connector surface.
3. Semantic Index — tokens indexed; no identity rule — not resolving.
4. Coverage Matrix — not resolving.
5. Ambiguity Register — AMB-06 keeps accepted head vs anchor document distinct — adjacent, not the identity.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Concept_Identity_Register.md:94`
**Resolution text**: Annex B CC-01 requires `accepted_head_digest` (FPA) and the VRA verified-head-selection to be byte-identical for the same family event, and `linked_irr_digest` byte-identical to VRA `irr_digest`. Baseline produces both from one canonical value so the boundary closes under real derivation; CT-05 observes `cc01_head_link=yes`.
