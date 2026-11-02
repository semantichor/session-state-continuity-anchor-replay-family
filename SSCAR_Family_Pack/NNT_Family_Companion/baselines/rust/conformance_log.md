# Conformance Log — FAM-SSCAR-FI-001 (rust), buyer-conformance protocol

Final acceptance run over all seven family test suites: `total=231, pass=216, fail=0, skip=15, error=0`.
All seven suites converged (VRA 29 / BDA 36 / TAA-PT 27 / VP-GEN 27 / ARA 27 / FPA 41 / SSCAR-PTS 30 /
Annex-C CT 14) and the emergent family verdict converged. Execution was live against
`baseline.exe` driven by `run_pts.exe`.

## Envelopes

Every parameterized record was exercised across its owning-pack declared envelope.

- `PT-024` (VRA, parameterized) — authority-release branch; ran `(S8, AuthorityRelease, true)`; result lands in the permitted set `{S0, S1}` per the VRA Minimal Run Note "parameterized authority-release branch lands only in the permitted state set" (`Verified_Rehydration_Agent_Conformance_Tests.md:516`).
- `PTS-BDA-032` (BDA, EXTRACT-PARAMETERIZED) — bounded delegated branches D-02/D-03; ran the BLOCK branch `(INGEST_VALIDATE, VALIDATION_FAIL)` and the QUARANTINE branch `(FILTER_REVIEW, TOOL_STATE_DETECTED)`, both within the authorized canonical outcomes per `Boundary_Defense_Agent_Conformance_Tests.md:515` PASS condition.
- `TAA-PT-023` / `VP-GEN-023` (TAA, parameterized) — severity-threshold branch; ran both `CONFLICT_CHECKING_TO_DENY_DECISION → DECIDED` and `CONFLICT_CHECKING_TO_FAIL_CLOSED → FAIL_CLOSED` per the TAA Minimal Run Note both-branch rule (`Truth_Arbitration_Agent_Conformance_Tests.md:802`).
- `ARA-T023` (ARA, PARAMETERIZED-OPEN) — ran `EV_POLICY_UNRESOLVED` on both the fail-closed branch (`→ SX`) and the bounded-blocked branch (`→` non-advancement), per `Audit_Replay_Agent_Conformance_Tests.md:368` bounded-parameter PASS clause.
- `FPA-T-17A` / `FPA-T-17B` / `FPA-T-17C` (FPA, parametric) — ran both branches of each optionality flag (`policy_requires_TVC`, `policy_requires_Evidence_bin`, `transport_required`): the true branch populates the conditional evidence field; the false branch permits its absence, per the FPA Minimal Run Note both-branch rule (`Freshness_Portability_Agent_Conformance_Tests.md:554`).
- `FPA-T-23` (FPA, parametric) — ran both `recoverable=true` (`EvidencePending → QUARANTINED`) and `recoverable=false` (`FreshnessPass,false → REJECTED`) per §7 VAL-004/007/008/009.
- `FPA-T-25` (FPA, parametric) — ran the `policy_requires_Evidence_bin=true` quarantine branch (`QUARANTINE` / `ESCALATION`) per §19 OPT-002 / §11 EVD-012.
- `PTS-007` (SSCAR, parameterized) — FV-04 local-reclassification branch; ran the composed `ct13` flow, confirming the family flow blocks at `S2` with no family-verdict change per `SSCAR_Conformance_Tests.md:37` and Annex A Row 4.
- `PTS-023` (SSCAR, parameterized) — SR re-entry; ran all five declared branches (changed carried_payload / anchor_document_ref / source_control_bundles → `S2`; policy_snapshot_id / rehydration_closure_ref → `S5`); no third re-entry point introduced, per `SSCAR_Specification.md:475-477` §9 SR exit.

## Attestations

### Cited SKIPs (owning-pack disposition basis; 15 records)

- `PTS-005`, `PTS-015`, `PTS-019`, `PTS-020`, `PTS-027` — SSCAR closed enumeration: `SSCAR_Conformance_Tests.md:27` — "7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here." The §7 oracle obligations (`ORC-CONSTRAINED-DELTA`, `ORC-VERDICT-LAYER-EMISSION`, `ORC-FOC-PRODUCERS`, `ORC-DISTRIBUTED-LEGITIMACY`, `ORC-VERDICT-SET`) are implemented in the baseline's verdict-emission layer (`fam::verdict_layer`) and exercised indirectly by the runnable `PTS-*` / `CT-*` records.
- `TAA-PT-020`, `VP-GEN-020` — TAA dual-ID declarative: `Truth_Arbitration_Agent_Conformance_Tests.md` record-kind "Declarative conformance claim (not a buyer-runnable unit test)"; Minimal Run Note bounded-external — V-008 ordering enforcement is distributed across §11 Temporal/Ordering Contract and §9 Gate Logic, satisfied at the runtime serialization layer (AMB-011). The baseline's TAA module keeps a single in-flight flow per scope; the `next_state` ordering-violation override to `FAIL_CLOSED` is present but is the permitted non-sufficient smoke surface, not the substantive obligation.
- `FPA-D-01` .. `FPA-D-06` — FPA §F.D: `Freshness_Portability_Agent_Conformance_Tests.md` — "Declarative obligations (not locally runnable on the published surface)"; §H — each is "documented in the buyer's conformance record as a non-runnable but required obligation." These bind the action-token granularity (FPA-D-01), tool-state non-authority (FPA-D-02/03/04), watermark monotonicity security finding (FPA-D-05), and append-only IRR two-step effectivity (FPA-D-06) at the gate-logic / authority-control / observability / journal layers.
- `PTS-BDA-027` — BDA Minimal Run Note bounded-external, `Boundary_Defense_Agent_Conformance_Tests.md:516` — "authorized non-validator producer grounding".
- `PTS-BDA-029` — BDA Minimal Run Note bounded-external, `Boundary_Defense_Agent_Conformance_Tests.md:516` — "distributed enforcement legitimacy where not exposed by local transition function".

### Evidence-satisfied declarative PASSes (named at the owning-pack attestation layer)

These declarative records are NOT in the pinned cited-SKIP partition, so they are exercised; each PASS
is demonstrated by a real captured invocation of the attestation surface the owning pack names
(Disposition-anchor rule 4):

- `PT-028`, `PT-029` (VRA) — V_COMPAT and V_WRITER_LOCK bounded external-enforcement; the VRA Minimal Run Note counts "both declarative bounded external-enforcement checks ... satisfied by implementation evidence" (`Verified_Rehydration_Agent_Conformance_Tests.md:516,518`). Attested via `vra evidence compat` / `vra evidence writer_lock`.
- `PTS-BDA-011` (BDA) — statement-provenance `BLOCK / CONFLICT` for an unlabeled statement-usage request, attested via `bda evidence conflict`; the BDA PASS condition counts declarative obligations "implemented in bounded architecture locations" (`Boundary_Defense_Agent_Conformance_Tests.md:515`).
- `PTS-BDA-012`, `PTS-BDA-036` (BDA) — verdict-taxonomy distinctness (`ALLOW` / `ALLOW_CONSTRAINED`) attested via `bda verdict_vocab` (distinct Rust enum variants).
- `ARA-T019`, `ARA-T020`, `ARA-T027` (ARA) — V-10 / QUARANTINE is gate-layer enforcement per the ARA Minimal Run Note "Declarative obligations are implemented or documented in the bounded external/gate surface" (`Audit_Replay_Agent_Conformance_Tests.md:368-369`). Attested via `ara evidence quarantine_gate`.
- `TAA-PT-015` (TAA) — four-closure handoff completeness attested via `taa evidence closure` (§10 MRF-HANDOFF-CHECK).

## Corrections

All seven suites conformant at the first complete family acceptance pass; zero corrections derived.
