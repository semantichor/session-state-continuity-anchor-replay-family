# R6 Conformance Log — FAM-SSCAR-FI-001 (python)

Buyer-conformance protocol. The final family acceptance pass ran all seven suites (231 pinned canonical records) against the unified baseline: 216 PASS, 15 cited SKIP, 0 FAIL, 0 ERROR. Observational language throughout; spec terms in backticks.

## Envelopes

For every parameterized record exercised, the branch/envelope set run, per the owning pack's own Minimal-Run-Note / parameterized rule.

- `PT-024` (VRA) — authority-release branch envelope `{S0 STARTUP_READONLY, S1 SNAPSHOT_LOCKED}`; exercised branch returns `S1 SNAPSHOT_LOCKED`, inside the set. Owning rule: VRA Conformance Tests §4 Minimal Run Note — "the parameterized authority-release branch lands only in the permitted state set".
- `PTS-BDA-032` (BDA) — bounded delegated branches `D-02/D-03` (BLOCK vs QUARANTINE), `D-08` (ALLOW vs ALLOW_CONSTRAINED), `D-09` (QUARANTINE vs NONCOMPLIANT_HOLD); exercised `VALIDATION_FAIL`→BLOCK and `TOOL_STATE_DETECTED`→QUARANTINE, both inside the canonical seven-verdict outcome set. Owning rule: BDA Conformance Tests §5 Minimal Run Note — "all parameterized tests remain within the authorized parameter envelope".
- `TAA-PT-023` / `VP-GEN-023` (TAA) — severity-threshold envelope from `DO-005` "DENY or FAIL_CLOSED according to severity"; BOTH branches exercised: `CONFLICT_CHECKING_TO_DENY_DECISION`→DECIDED+DENY and `CONFLICT_CHECKING_TO_FAIL_CLOSED`→FAIL_CLOSED. Owning rule: TAA Conformance Tests §4 Minimal run note — "the 1 parameterized test asserts both branches when the severity threshold parameter is bound".
- `ARA-T023` (ARA) — delegated branch envelope: `EV_POLICY_UNRESOLVED` → BLOCKED or SX, and `S6` resumes to `S2`/`S4`; exercised the unresolved-policy branch returning `SX FAIL_CLOSED` + BLOCKED. Owning rule: ARA Conformance Tests §8 Minimal Run Note — "Parameterized tests remain inside the declared parameter envelope".
- `FPA-T-17A` / `FPA-T-17B` / `FPA-T-17C` (FPA) — bounded boolean policy flags `policy_requires_TVC` / `policy_requires_Evidence_bin` / `transport_required`; exercised the activation branch (flag true → the conditional field is present). Owning rule: FPA Conformance Tests §H Minimal Run Note — "Every parameterized test in §F.P passes for both branches of its bounded parameter envelope".
- `FPA-T-23` (FPA) — `recoverable: bool` per failure event for `VAL-004/007/008/009`; BOTH branches exercised: recoverable → `EvidencePending`→QUARANTINED; non-recoverable → `FreshnessPass` with validator_passed=false → REJECTED. Owning rule: FPA §H Minimal Run Note.
- `FPA-T-25` (FPA) — `policy_requires_Evidence_bin: bool`; exercised the activation branch: on the `EvidencePending` quarantine path the bundle carries `evidence_validation_result`, semantic_verdict QUARANTINE, gate_class ESCALATION. Owning rule: FPA §H Minimal Run Note.
- `PTS-007` (SSCAR) — `FV-04` local-reclassification policy hook envelope (explanatory-only reclassification). Exercised: the family flow blocks at `S2 BOUNDARY_SCREENED` with no family-verdict change and the reclassification is explicit. Owning rule: SSCAR Conformance Tests §8 Minimal Run Note bounded external obligation (2) "FV-04 local-reclassification policy hook (parameterized)".
- `PTS-023` (SSCAR) — SR re-entry discriminator envelope: all five declared branches exercised — `carried_payload`/`anchor_document_ref`/`source_control_bundles` → `S2 BOUNDARY_SCREENED`; `policy_snapshot_id`/`rehydration_closure_ref` → `S5 REHYDRATION_CLOSED`; no third re-entry point. Owning rule: SSCAR §8 Minimal Run Note bounded external obligation (3) and §9 SR exit clause.

## Attestations

### Cited SKIPs (pinned partition; owning-pack licensing clause quoted)

- `FPA-D-01` … `FPA-D-06` — Freshness_Portability_Agent_Conformance_Tests.md §F.D Declarative obligations + §H Minimal Run Note: "Every declarative obligation in §F.D is documented in the buyer's conformance record as a non-runnable but required obligation." Action-token granularity / tool-state authority edge / watermark security-finding / append-only journal effectivity are enforced at the gate-logic / authority-control / observability / journal layers the pack names, attested there, not promoted to a runnable PASS.
- `TAA-PT-020` / `VP-GEN-020` — Truth_Arbitration_Agent_Conformance_Tests.md §1 Declarative public conformance record: "Record kind: Declarative conformance claim (not a buyer-runnable unit test)"; §4 Minimal run note bounded-external list (V-008 ordering enforcement via serialization or snapshot-at-intake + compare-and-commit at the runtime layer).
- `PTS-BDA-027` — Boundary_Defense_Agent_Conformance_Tests.md §5 Minimal Run Note "Bounded external obligations not locally runnable": authorized non-validator producer grounding (whole-assertion coverage).
- `PTS-BDA-029` — Boundary_Defense_Agent_Conformance_Tests.md §5 Minimal Run Note "Bounded external obligations not locally runnable": distributed enforcement legitimacy where not exposed by local transition function.
- `PTS-005`, `PTS-015`, `PTS-019`, `PTS-020`, `PTS-027` — SSCAR_Conformance_Tests.md §5 note closed enumeration: these are the §7-relocated declarative records (listed in §7 Public Oracles — ORC-VERDICT-SET / ORC-CONSTRAINED-DELTA verdict-layer subset / ORC-FOC-PRODUCERS / ORC-DISTRIBUTED-LEGITIMACY / canonical verdict taxonomy), not on the §5 buyer-runnable table.

### Declarative obligations reported PASS by evidence satisfaction (named at the owning pack's layer)

- `PT-028` (VRA `V_COMPAT`) and `PT-029` (VRA `V_WRITER_LOCK`) — the VRA Conformance Tests §4 Minimal Run Note Suite PASS condition counts both bounded external-enforcement checks as "satisfied by implementation evidence". Each is reported PASS by a real captured invocation of its attestation surface: `V_COMPAT` at the import_admissibility / policy-compatibility enforcement point (compat_status + evidence preserved); `V_WRITER_LOCK` at the persistence control plane (writer-lock + contention state). Rule-4 first branch; the record's named input tokens are consumed at that surface.
- `PTS-BDA-011` (BDA) — exercised, not skipped: the record's whole normative assertion (verdict BLOCK and gate use denied for an unlabeled gate claim) is a real captured invocation of the statement-provenance gate; the bounded-external list entry "Conflict-evidence emission for VAL-03" covers only the conflict-evidence sub-assertion, so under rule 2 the covered sub-assertion is bounded and the BLOCK assertion is exercised.
- `PTS-BDA-036` (BDA) — exercised: the record's assertion (ALLOW and ALLOW_CONSTRAINED keep distinct verdict semantics although the state route may coincide) is a real captured invocation of the verdict-taxonomy surface.
- `ARA-T019`, `ARA-T020`, `ARA-T027` (ARA) — reported PASS by a real captured invocation of the gate-logic surface for QUARANTINE, which the ARA Conformance Tests §8 Minimal Run Note names as a required projection surface and whose PASS condition states "Declarative obligations are implemented or documented in the bounded external/gate surface". `V-10` tool-state exclusion routes to QUARANTINE at that surface; `ARA-T027` additionally exercises the `EV_POLICY_UNRESOLVED` parameterized surface.

## Corrections

All seven suites conformant at the first complete family acceptance pass; zero corrections derived.
