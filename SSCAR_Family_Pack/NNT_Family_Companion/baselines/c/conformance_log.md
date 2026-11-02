# Conformance Log — NNT-FAM-SSCAR-FI-001 (paradigm c)

Buyer-conformance protocol. Final acceptance run: 231 pinned records — 216 PASS, 15 cited SKIP, 0 FAIL, 0 ERROR. Seven suites converge; the emergent family verdict converges (verdict-emission layer exercised independently of `next_state` per AMB-17).

## Envelopes

Parameterized records, with the branch / envelope set exercised, per each owning pack's own Minimal-Run-Note / parameterized rule (cited per record):

- `PT-024` (VRA) — bounded authority-release branch. VRA Conformance Tests OR-20 pass condition is set membership `Result in {S0 STARTUP_READONLY, S1 SNAPSHOT_LOCKED}` (`Verified_Rehydration_Agent_Conformance_Tests.md:502`). Branch exercised: S1 (a member of the permitted set).
- `PTS-BDA-032` (BDA) — bounded delegated choices. BDA Minimal Run Note: parameterized tests stay "within the authorized parameter envelope" (`Boundary_Defense_Agent_Conformance_Tests.md:515`). Branches exercised: D-02 -> BLOCK, D-03 -> QUARANTINE, D-08 -> ALLOW, D-09 -> QUARANTINE (all within the canonical outcome set).
- `TAA-PT-023` / `VP-GEN-023` (TAA) — V-006A severity threshold. TAA Minimal run note binds both branches (`Truth_Arbitration_Agent_Conformance_Tests.md:802`). Branches exercised: DENY and FAIL_CLOSED.
- `ARA-T023` (ARA) — bounded delegated branch. ARA record Status `PARAMETERIZED-OPEN`; Minimal Run Note "remain inside the declared parameter envelope" (`Audit_Replay_Agent_Conformance_Tests.md:368`). Branches exercised: EV_POLICY_UNRESOLVED -> {BLOCKED, SX}; S6 resume -> {S2, S4}.
- `FPA-T-17A` / `FPA-T-17B` / `FPA-T-17C` (FPA) — policy_requires_TVC / policy_requires_Evidence_bin / transport_required. FPA §H: "Every parameterized test in §F.P passes for both branches" (`Freshness_Portability_Agent_Conformance_Tests.md:556`). Branches exercised: true -> Some(...), false -> None.
- `FPA-T-23` (FPA) — recoverable:bool. Branches exercised: true -> EvidencePending -> S7 QUARANTINED; false -> FreshnessPass+fail -> S8 REJECTED.
- `FPA-T-25` (FPA) — policy_requires_Evidence_bin on the EvidencePending path. Branch exercised: true -> evidence_validation_result=Some, verdict QUARANTINE, gate_class ESCALATION.
- `PTS-007` (SSCAR) — FV-04 local-reclassification policy hook. SSCAR §8 bounded obligation 2 (`SSCAR_Conformance_Tests.md:213`). Branch exercised: family flow blocks at S2, no verdict change, reclassification explicit + policy-bound.
- `PTS-023` (SSCAR) — SR re-entry (5 declared branches). SSCAR §8 bounded obligation 3 forbids a third re-entry point (`SSCAR_Conformance_Tests.md:213`). Branches exercised: carried_payload / anchor_document_ref / source_control_bundles -> S2; policy_snapshot_id / rehydration_closure_ref -> S5 (per §9 SR exit, which controls over the Annex-C surface).

## Attestations

Obligations attested rather than run.

Pinned cited-SKIPs (each reported SKIP with the owning-pack basis; same cite as the `pt_results.json` note):
- `TAA-PT-020`, `VP-GEN-020` — TAA Conformance Tests declarative record-kind line ("Declarative conformance claim (not a buyer-runnable unit test)") + Minimal run note preserving it "as a buyer obligation rather than a runnable assertion" (`Truth_Arbitration_Agent_Conformance_Tests.md:495`, `:802`).
- `FPA-D-01`..`FPA-D-06` — FPA §F.D "Declarative obligations (not locally runnable on the published surface)" + §H "Bounded external obligations not locally runnable: FPA-D-01 through FPA-D-06" (`Freshness_Portability_Agent_Conformance_Tests.md:495`, `:558`).
- `PTS-BDA-027` — BDA §5 Minimal Run Note bounded-external entry "authorized non-validator producer grounding" (`Boundary_Defense_Agent_Conformance_Tests.md:516`).
- `PTS-BDA-029` — BDA §5 Minimal Run Note bounded-external entry "distributed enforcement legitimacy where not exposed by local transition function" (`Boundary_Defense_Agent_Conformance_Tests.md:516`).
- `PTS-005`, `PTS-015`, `PTS-019`, `PTS-020`, `PTS-027` — SSCAR §5 closed enumeration listing them as declarative records "in §7 Public Oracles rather than here" (`SSCAR_Conformance_Tests.md:27`).

Declarative obligations whose PASS is evidence-satisfied (reported PASS, demonstrated by a real captured invocation of the implementing / attestation surface, per Disposition-anchor rule 4), named at the layer the owning pack designates:
- `PT-028` / `PT-029` (VRA) — VRA Suite PASS condition counts both declarative bounded external-enforcement checks "satisfied by implementation evidence" (`Verified_Rehydration_Agent_Conformance_Tests.md:516`); attested at the policy-compatibility enforcement surface and the persistence-control / writer-lock surface respectively.
- `PTS-BDA-011` (BDA) — unlabeled-claim BLOCK + conflict-evidence, exercised at the statement-provenance decision surface (D-04).
- `PTS-BDA-036` (BDA) — projection limitation, exercised at the verdict-taxonomy surface (state route shared, verdict semantics distinct downstream).
- `ARA-T019` (ARA) — Status `UNTESTABLE via local next_state`; exercised at the gate-logic surface (V-10 -> QUARANTINE), the layer ARA §12 designates.
- `ARA-T020`, `ARA-T027` (ARA) — Status PASS Declarative; attested at the distributed-enforcement / transparent-classification surface.

## Corrections

### CORRECTION FPA-T-* (FPA next_state state-label projection)

- Records that localized it: `FPA-T-01, FPA-T-02, FPA-T-03, FPA-T-04, FPA-T-06, FPA-T-08a, FPA-T-08b, FPA-T-09, FPA-T-10, FPA-T-11, FPA-T-12, FPA-T-13a, FPA-T-13b, FPA-T-14, FPA-T-24, FPA-T-26, FPA-T-PR-01, FPA-T-PR-02, FPA-T-PR-03, FPA-T-PR-09, FPA-T-PR-10, FPA-T-PR-12, FPA-T-PR-13, FPA-T-PR-14` (first acceptance pass: the FPA `next_state` surface emitted the `S#` index alias, e.g. `state=S1`, where the oracle token is the §8 state name, e.g. `state=RECEIVED`).
- Owning-pack normative citation that RESOLVED it (never the flagging record): FPA Specification §8 Workflow / State-Transition Record labels each state with its name — "S1 | RECEIVED", "S2 | VERIFIED", "S3 | FRESHNESS_ELIGIBLE", "S6 | RESTORATION_ELIGIBLE", "S8 | REJECTED" (`Freshness_Portability_Agent_Specification.md:252`-`:259`) — and the §F.R assertions take the named form as the transition target, e.g. `next_state(IDLE, TransferPacketReceived, true) == RECEIVED` (`Freshness_Portability_Agent_Conformance_Tests.md:454`). The correction is keyed to the §8 state-label clause, not to any fixture value (anti-overfit).
- Change: list the §8 named form first in `FPA_STATES[]` so the enum->name projection returns the spec label; the `S#` aliases remain accepted on input. Unified diff:

```diff
--- baseline.c  (FPA_STATES, before)
+++ baseline.c  (FPA_STATES, after)
-static const name_val_t FPA_STATES[] = {
-    {"S0", FPA_S0}, {"IDLE", FPA_S0}, {"S1", FPA_S1}, {"RECEIVED", FPA_S1},
-    {"S2", FPA_S2}, {"VERIFIED", FPA_S2}, {"S3", FPA_S3}, {"FRESHNESS_ELIGIBLE", FPA_S3},
-    {"S4", FPA_S4}, {"IRR_COMMITTED", FPA_S4}, {"S5", FPA_S5}, {"WATERMARK_COMMITTED", FPA_S5},
-    {"S6", FPA_S6}, {"RESTORATION_ELIGIBLE", FPA_S6}, {"S7", FPA_S7}, {"QUARANTINED", FPA_S7},
-    {"S8", FPA_S8}, {"REJECTED", FPA_S8}, {0, 0}
-};
+static const name_val_t FPA_STATES[] = {
+    {"IDLE", FPA_S0}, {"S0", FPA_S0}, {"RECEIVED", FPA_S1}, {"S1", FPA_S1},
+    {"VERIFIED", FPA_S2}, {"S2", FPA_S2}, {"FRESHNESS_ELIGIBLE", FPA_S3}, {"S3", FPA_S3},
+    {"IRR_COMMITTED", FPA_S4}, {"S4", FPA_S4}, {"WATERMARK_COMMITTED", FPA_S5}, {"S5", FPA_S5},
+    {"RESTORATION_ELIGIBLE", FPA_S6}, {"S6", FPA_S6}, {"QUARANTINED", FPA_S7}, {"S7", FPA_S7},
+    {"REJECTED", FPA_S8}, {"S8", FPA_S8}, {0, 0}
+};
```

After this single correction, the final acceptance run over every non-SKIP record of all seven suites recorded 0 FAIL and 0 ERROR. No clarifying-question resolution was invalidated by it (the correction changes the state-label projection, not any decision rule).
