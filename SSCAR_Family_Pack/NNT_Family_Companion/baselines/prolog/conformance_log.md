# Conformance Log — FAM-SSCAR-FI-001 (prolog)

Buyer-conformance protocol. One complete family acceptance run over all SEVEN suites
(231 pinned canonical records). Observed outcome: 216 `PASS`, 0 `FAIL`, 15 `SKIP`, 0 `ERROR`.
`execution_mode` = `live`; every non-`SKIP` record was exercised by a real captured
`swipl` invocation of `baseline.pl` logged in `pt_run_log.txt`.

## Envelopes

Parameterized records exercised, with the branch/envelope set run, per each owning pack's
own Minimal-Run-Note / parameterized rule:

- `PT-024` (VRA, authority-release branch) — envelope `{S0 STARTUP_READONLY, S1 SNAPSHOT_LOCKED}` per VRA Conformance Tests OR-20 + §4 Minimal Run Note (workflow-state membership). Branch run: `(S8, AuthorityRelease, true)` landing in `S0 STARTUP_READONLY`, inside the permitted set.
- `PTS-BDA-032` (BDA, delegated branch) — envelope D-02/D-03, D-08, D-09 per BDA §5 Minimal Run Note. Branches run: `schema_invalid` → `BLOCK`; `tool_state_no_approval` → `QUARANTINE`; `all_pass` → `ALLOW` (all within the canonical seven-verdict outcome set).
- `TAA-PT-023` / `VP-GEN-023` (TAA, severity threshold §6 DO-005) — both branches run: `conflict_checking_to_deny_decision` → `DECIDED`; `conflict_checking_to_fail_closed` → `FAIL_CLOSED`, not flattened to one branch, per TAA §4 Minimal run note parameterized accounting.
- `ARA-T023` (ARA, bounded delegated branch) — per ARA §8 Minimal Run Note bounded parameter envelope. Branches run: `ev_policy_unresolved` → `SX FAIL_CLOSED` (BLOCKED/SX branch); `S6 READMITTED` controlled resumption → `S2 VERIFIED` and → `S4 CHECKPOINT_RESOLVED`.
- `FPA-T-17A` / `17B` / `17C` (FPA, conditional-field activation) — per FPA §H parameterized both-branch rule. Each run on both `true` (field present) and `false` (field absent) of its policy flag `policy_requires_TVC` / `policy_requires_Evidence_bin` / `transport_required`.
- `FPA-T-23` (FPA, recoverable branch) — both branches run: `recoverable=true` → `S7 QUARANTINED` (EvidencePending); `recoverable=false` → `S8 REJECTED`.
- `FPA-T-25` (FPA, `policy_requires_Evidence_bin`) — activation branch run: quarantine-path evidence with `evidence_validation_result` present, `QUARANTINE` / `ESCALATION`.
- `PTS-007` (SSCAR, FV-04 local-reclassification policy hook) — per SSCAR §8 Minimal Run Note bounded external obligation (2). Branch run: `(S2, fv04_reclassification_pending, false)` → non-advancement, flow blocks at `S2 BOUNDARY_SCREENED` with no family-verdict change; the reclassification policy content itself is the deployment-side envelope.
- `PTS-023` (SSCAR, SR re-entry 5-branch envelope) — per SSCAR §8 Minimal Run Note bounded external obligation (3): no third re-entry point. Branches run: boundary-field change (`carried_payload`) → `S2`; policy/rehydration change (`policy_snapshot_id`) → `S5`. Re-entry target derived from §9 SR exit discriminator + PFX-RE-ENTRY fixtures (see Corrections note / inconsistencies.md CT-14 surface difference).

## Attestations

Pinned cited `SKIP` records (15), each reported `SKIP` with the owning-pack licensing clause
(same cite as its `pt_results.json` note):

- `FPA-D-01`..`FPA-D-06` — FPA Conformance Tests §F.D declarative-obligations section placement + §H Minimal Run Note documented-mode clause (each §F.D obligation is documented in the buyer conformance record as a non-runnable but required obligation).
- `PTS-BDA-027` — BDA §5 Minimal Run Note bounded-external list: authorized non-validator producer grounding (whole-assertion coverage, rule 2).
- `PTS-BDA-029` — BDA §5 Minimal Run Note bounded-external list: distributed enforcement legitimacy where not exposed by local transition function.
- `TAA-PT-020` / `VP-GEN-020` — TAA Conformance Tests dual-ID declarative record TAA-PT-020-DECL / VP-GEN-020 record-kind line ("Declarative conformance claim (not a buyer-runnable unit test)") + §4 Minimal run note bounded-external list (ordering enforcement distributed across §11 + §9). Reported under both pinned ids.
- `PTS-005` — SSCAR §5 closed-enumeration note: declarative record listed in §7 Public Oracles, not the §5 buyer-runnable table.
- `PTS-015` / `PTS-019` / `PTS-020` / `PTS-027` — SSCAR §5 closed-enumeration note: §7-relocated declarative records (ORC-CONSTRAINED-DELTA; ORC-FOC-PRODUCERS; ORC-DISTRIBUTED-LEGITIMACY; canonical verdict taxonomy).

Declarative obligations whose `PASS` is evidence-satisfied (Disposition anchor rule 4, first
branch), named at the layer the owning pack designates, each shown by a real captured
invocation of the implementing/attestation surface:

- `PT-028` (VRA `V_COMPAT`) — invoked surface: the policy-compatibility enforcement attestation (`attest vra v_compat`); VRA §4 Minimal Run Note counts both declarative bounded-external checks as satisfied by implementation evidence. Input tokens consumed: `V_COMPAT` / `import_admissibility`.
- `PT-029` (VRA `V_WRITER_LOCK`) — invoked surface: the persistence-control / deployment-conformance attestation (`attest vra v_writer_lock`); same Minimal Run Note clause. Input tokens consumed: `V_WRITER_LOCK` / writer-lock + contention evidence.
- `ARA-T019` / `ARA-T020` / `ARA-T027` (ARA `V-10` tool-state exclusion) — invoked surface: the gate-logic / verdict surface (`verdict ara tool_state` → `QUARANTINE`); ARA §8 Minimal Run Note PASS condition counts declarative obligations as implemented/documented in the bounded external/gate surface. These records carry an own-surface input (`V-10` tool-state artifact); the surface exposes it, so rule 4's first branch applies (real captured invocation), not the SKIP branch.
- `PTS-BDA-011` / `PTS-BDA-036` (BDA EXTRACT-DECLARATIVE, not pinned `SKIP`) — exercised via the verdict / taxonomy surface (`verdict bda unlabeled_statement` → `BLOCK`; `taxonomy bda` ALLOW vs ALLOW_CONSTRAINED distinct). Disposition rule 1: a category label alone is not a `SKIP` basis, and no whole-record covering clause marks them, so they are exercised.

## Corrections

All seven suites conformant at the first complete family acceptance pass; zero corrections derived.
