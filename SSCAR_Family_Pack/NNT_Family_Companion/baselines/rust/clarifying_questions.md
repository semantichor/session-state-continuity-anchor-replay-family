# Clarifying Questions — FAM-SSCAR-FI-001 (rust), 5-source search cascade

Each question records an interpretation choice made during R5, with the full search trail across the
SSCAR integrator pack's normative sources before a resolution status is declared.

### Q1. Can the `next_state` projection return `REPLAY_INCOMPLETE` or `INCIDENT_ONLY`?

**Triggered by**: `SSCAR_Conformance_Tests.md:208` — the Minimal Run Note splits the projection surface into `next_state -> FamilyWorkflowState` and a separate verdict-emission layer, raising whether the state machine itself can emit these two verdicts.

**Searched in (in order, stop at first resolution)**:
1. Specification — §4.1 verdict vocabulary + §9 workflow states — both verdicts present in §4.1 but no `SH`/`SX`-style state carries them in §9.
2. Conformance Tests — `ORC-VERDICT-LAYER-EMISSION` (`SSCAR_Conformance_Tests.md:136`) — states FV-08 fail → `REPLAY_INCOMPLETE` and FV-10/FV-11 fail → `INCIDENT_ONLY` "at verdict layer (no dedicated workflow state)".
3. Semantic Index — State Terms list (12) — not found as states.
4. Coverage Matrix — `SSCAR_Coverage_Matrix.md:73-78` lists both only under Family Verdict Terms, not State Terms — confirms.
5. Ambiguity Register (D4) — `SSCAR_Ambiguity_Register.md:27` AMB-17 — decisive.

**Resolution status**: `resolved_in_d4`
**Resolution citation**: `SSCAR_Ambiguity_Register.md:27`
**Resolution text**: AMB-17 declares `INCIDENT_ONLY` and `REPLAY_INCOMPLETE` are verdicts with no workflow state; the presupposition that `next_state` returns them does not hold — the state machine signals them by non-advancement while the verdict-emission layer emits them. The baseline keeps `FamilyWorkflowState` and `FamilyNormativeVerdict` as distinct types accordingly.

### Q2. When FV-07 fails, does the family verdict route to `CONTAMINATION_FAIL_CLOSED` or `NONCOMPLIANT_HOLD`?

**Triggered by**: `SSCAR_Specification.md:281` — FV-07 declares a two-branch fail effect with a remediability discriminator.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-07 (`SSCAR_Specification.md:282-284`) — integrity / anti-rollback / read-only failure → `CONTAMINATION_FAIL_CLOSED` (non-remediable); policy-prerequisite-only failure → `NONCOMPLIANT_HOLD` (remediable). Resolved here.
2. Conformance Tests — not needed.
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register (D4) — AMB-03 corroborates the hold-vs-fail-closed distinction.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:282`
**Resolution text**: Any failure affecting integrity, anti-rollback, or read-only invariants is non-remediable → `CONTAMINATION_FAIL_CLOSED`; failures isolated to policy prerequisites are remediable → `NONCOMPLIANT_HOLD` (readmissible via SH→SR). The baseline encodes `Fv07Integrity` and `Fv07Policy` as distinct outcomes.

### Q3. When FV-03 fails, `CONTAMINATION_FAIL_CLOSED` or `REPLAY_INCOMPLETE`?

**Triggered by**: `SSCAR_Specification.md:243` — FV-03 carries a two-branch fail effect.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-03 discriminator (`SSCAR_Specification.md:244-246`) — contamination signal (unlabeled mechanism-level claim or FV-09 trigger) → `CONTAMINATION_FAIL_CLOSED`; labeled-but-policy-incompatible with no contamination → `REPLAY_INCOMPLETE`. Resolved here.
2–5. Not needed; Annex A Row 3 (`SSCAR_Producer_Consumer_Manifest.md:35`) corroborates the two-branch routing `depending on the labeling defect class`.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:246`
**Resolution text**: Presence of any contamination signal routes to `CONTAMINATION_FAIL_CLOSED`; absence plus policy-compatibility failure routes to `REPLAY_INCOMPLETE`. The baseline encodes `Fv03Contam` and `Fv03Policy`.

### Q4. What determines the SR readmission re-entry target (`S2` vs `S5`)?

**Triggered by**: `SSCAR_Specification.md:468` — SR READMISSION_REVIEW exit trigger has two branches.

**Searched in (in order, stop at first resolution)**:
1. Specification — §9 SR exit (`SSCAR_Specification.md:475-477`) — boundary-relevant field change (`carried_payload` / `anchor_document_ref` / `source_control_bundles`) → `S2`; policy/rehydration-field-only change → `S5`; no third re-entry point. Resolved here.
2. Conformance Tests — `ORC-NON-INHERITANCE` (`SSCAR_Conformance_Tests.md:144`) + PTS-023 — corroborates (exhaustive, mutually exclusive).
3. Semantic Index — not needed.
4. Coverage Matrix — not needed.
5. Ambiguity Register (D4) — not applicable.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:475`
**Resolution text**: The altered-field set deterministically fixes the re-entry target; operator discretion is not admitted and no third point may be introduced (Annex A Row 12 corroborates, `SSCAR_Producer_Consumer_Manifest.md:44`). The baseline routes the five triggers accordingly.

### Q5. What concrete return value / mechanism should `next_state` yield for an unenumerated `(state, trigger)` pair?

**Triggered by**: `SSCAR_Specification.md:394` — §9 enumerates forward transitions but states no literal default/else row.

**Searched in (in order, stop at first resolution)**:
1. Specification — §2 Fail-closed invariant (`SSCAR_Specification.md:64`) + §10 gate logic — the semantics are fixed (fail-closed; no positive advancement), but no mechanism is prescribed.
2. Conformance Tests — PTS-011 (`SSCAR_Conformance_Tests.md:41`) — critical triggers force `SX` from any state, not current-state preservation; non-critical unenumerated is non-advancement.
3. Semantic Index — not applicable.
4. Coverage Matrix — not applicable.
5. Ambiguity Register (D4) — AMB-17 — non-advancement is the projection-correct signal.

**Resolution status**: `implementation_flexibility`
**Resolution citation**: `SSCAR_Specification.md:64`
**Resolution text**: The pack fixes the semantics (critical → `SX`; otherwise non-advancement, never a positive verdict) but leaves the mechanism open. The rust baseline returns the current state value (non-advancement) for unenumerated non-critical pairs and `SX` for the critical-contamination triggers; a Rust `enum` return is the paradigm-idiomatic mechanism and prescribing one specific return shape would force an idiom on all paradigms.

### Q6. Which component produces `accepted_head_digest`, and how must it relate to the VRA rehydration IRR digest?

**Triggered by**: `SSCAR_Specification.md:124` — FOC-03 lists `accepted_head_digest` and `linked_irr_digest` but the integrator does not itself produce them.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-05 (`SSCAR_Specification.md:259-265`) names the field but not the producer.
2. Conformance Tests — CT-05 coverage map (Annex C) names the producer indirectly.
3. Semantic Index — not decisive.
4. Coverage Matrix — not decisive.
5. Annex A / Annex B (wiring references, read during design) — Annex A Row 5 (`SSCAR_Producer_Consumer_Manifest.md:37`): FPA produces `accepted_head_digest` / `linked_irr_digest`; Annex B CC-01/CC-08 (`SSCAR_Concept_Identity_Register.md:94,101`): `linked_irr_digest` (FPA) is byte-identical to `irr_digest` (VRA) for the same accepted head.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Producer_Consumer_Manifest.md:37`
**Resolution text**: FPA is the producing authority; the baseline's `fam::component_outputs` consumes the real FPA-produced `accepted_head_digest` / `linked_irr_digest` and checks byte-identity against the VRA rehydration IRR digest (CC-01/CC-08) in the composed `ct08` flow — the cross-component contract closes under independent derivation in one paradigm.

### Q7. What is the concrete cryptographic representation of the digest fields?

**Triggered by**: `SSCAR_Specification.md:124` — digest field shapes are referenced but not fixed.

**Searched in (in order, stop at first resolution)**:
1. Specification — §17.1 implementation boundaries (`SSCAR_Specification.md:652`) — "The concrete cryptographic suite belongs to the execution layer and is not fixed by this specification."
2–5. Not needed.

**Resolution status**: `deployment_obligation`
**Resolution citation**: `SSCAR_Specification.md:652`
**Resolution text**: Buyer-side; the pack delegates cryptographic suite, digest encoding, and storage backend to deployment (§17.1, README §"What your team must produce" item 5). The baseline uses placeholder `sha256:...` tokens for byte-identity checks only.

### Q8. What token value should `reason_code` carry?

**Triggered by**: `SSCAR_Specification.md:112` — FOC-01 requires `reason_code` but does not enumerate its values.

**Searched in (in order, stop at first resolution)**:
1. Specification — §17.4 parameterizable-without-semantic-change (`SSCAR_Specification.md:674`) — "reason_code naming" is explicitly parameterizable.
2–5. Not needed.

**Resolution status**: `deployment_obligation`
**Resolution citation**: `SSCAR_Specification.md:674`
**Resolution text**: Buyer-side naming; the semantic core is unchanged by the chosen names. The baseline uses stable placeholder reason codes.

### Q9. Does FV-04 "local reclassification" produce a family verdict?

**Triggered by**: `SSCAR_Specification.md:254` — FV-04 fail effect lists a "local reclassification" branch alongside a `FAIL_CLOSED` branch.

**Searched in (in order, stop at first resolution)**:
1. Specification — §7 FV-04 bounded note (`SSCAR_Specification.md:257`) — "Local reclassification is not a family verdict; it is a bounded handoff obligation ... The family flow does not advance until reclassification closes." Resolved here.
2. Conformance Tests — PTS-007 + CT-13 corroborate (flow blocks at `S2`, no family-verdict change).
3–5. AMB-11 (D4) corroborates that a bounded handoff obligation is kept distinct from a correctness-affecting classification.

**Resolution status**: `resolved_in_spec`
**Resolution citation**: `SSCAR_Specification.md:257`
**Resolution text**: `local reclassification` is a `BOUNDED_HANDOFF_OBLIGATION`, not a family verdict; when no admissible reclassification path exists the family level is `CONTAMINATION_FAIL_CLOSED`. The baseline blocks at `S2` and does not advance the family verdict for the reclassification branch (`ct13`).
