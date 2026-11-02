# R6 Conformance Log — FAM-SSCAR-FI-001 (bash paradigm)

Final acceptance run over all 7 suites + Annex-C connector suite: 231 pinned canonical records — 216 PASS, 0 FAIL, 15 cited SKIP, 0 ERROR. `execution_mode: live`. Every PASS is matched to captured stdout in `pt_run_log.txt`.

## Envelopes

Parameterized records exercised, with the branch/envelope set run, per each owning pack's own Minimal-Run-Note / parameterized rule (cited per record):

- **PT-024** (VRA, authority-release) — envelope `{S0 STARTUP_READONLY, S1 SNAPSHOT_LOCKED}`; this build lands in `S1_SNAPSHOT_LOCKED`. Basis: VRA Conformance Tests §4 Minimal Run Note "the parameterized authority-release branch lands only in the permitted state set" + OR-20 "Result ∈ {S0, S1}".
- **PTS-BDA-032** (BDA, bounded delegated choices) — branches run: `VALIDATION_FAIL→OUTPUT_BLOCKED` (D-01/D-02 BLOCK), `TOOL_STATE_DETECTED→TOOL_STATE_QUARANTINED` (D-03 QUARANTINE), `NO_ESCALATION→READY_FOR_RELEASE` (D-08 ALLOW path); all within the authorized canonical outcomes. Basis: BDA Conformance Tests §5 "all parameterized tests remain within the authorized parameter envelope" + OR-BDA-014 (D-02/D-03, D-08, D-09 only).
- **TAA-PT-023 / VP-GEN-023** (TAA, severity threshold) — both branches run: `CONFLICT_CHECKING_TO_DENY_DECISION→DECIDED` (DENY) and `CONFLICT_CHECKING_TO_FAIL_CLOSED→FAIL_CLOSED`. Basis: TAA Conformance Tests §4 "the 1 parameterized test … asserts both branches when the severity threshold parameter is bound" + TAA-OR-I (§6 DO-005 'according to severity').
- **ARA-T023** (ARA, delegated branch) — `EV_POLICY_UNRESOLVED` envelope `{BLOCKED, SX}` run as `SX_FAIL_CLOSED`; S6 resumption envelope `{S2, S4}` run as `S2_VERIFIED` (`controlled_resumption`). Basis: ARA Conformance Tests §8 Minimal Run Note "Parameterized tests remain inside the declared parameter envelope" + ORA-ARA-012 "policy BLOCKED or SX; S6 → S2/S4".
- **FPA-T-17A / 17B / 17C** (FPA, activation flags) — run on the true branch (`policy_requires_TVC`, `policy_requires_Evidence_bin`, `transport_required` = true → the conditional field is `Some(...)`); the false branch (`None` permissible) is the complementary envelope bound. Basis: FPA §F.P bounded parameter envelope + §H "Every parameterized test … passes for both branches of its bounded parameter envelope".
- **FPA-T-23** (FPA, recoverable) — both branches run: `recoverable=true → EvidencePending → QUARANTINED`; `recoverable=false → FreshnessPass+false → REJECTED`. Basis: FPA §F.P "recoverable: bool per failure event for VAL-004/007/008/009".
- **FPA-T-25** (FPA, Evidence.bin under quarantine) — `policy_requires_Evidence_bin=true` branch run → `evidence_validation_result` present, `semantic_verdict=QUARANTINE`, `gate_class=ESCALATION`. Basis: FPA §F.P + §7 VAL-009.
- **PTS-007** (SSCAR, FV-04 local-reclassification policy hook) — envelope is the reclassification policy; this build runs the no-admissible-reclassification-path branch → the family flow does not advance to a positive verdict (`CONTAMINATION_FAIL_CLOSED`, SX). Basis: SSCAR Conformance Tests §8 Minimal Run Note item (2) "FV-04 local-reclassification policy hook (parameterized)" + §7 FV-04.
- **PTS-023** (SSCAR, SR re-entry) — all 5 declared branches run: `carried_payload`, `anchor_document_ref`, `source_control_bundles` → `S2`; `policy_snapshot_id`, `rehydration_closure_ref` → `S5`. No third re-entry point. Basis: SSCAR §9 SR exit branches 1/2 + §8 Minimal Run Note item (3) "SR re-entry discriminator … a third re-entry point is FORBIDDEN".

## Attestations

### Cited SKIPs (15) — reported SKIP with the owning pack's disposition clause (verbatim, one line)

- **TAA-PT-020** / **VP-GEN-020** — TAA Conformance Tests record-kind line "Declarative conformance claim (not a buyer-runnable unit test)" + Minimal run note "the 1 declarative record (VP-GEN-020 / TAA-PT-020-DECL) is preserved as a buyer obligation rather than a runnable assertion". (reported under both pinned ids; buyer obligation attested at the runtime ordering layer per AMB-011)
- **FPA-D-01 .. FPA-D-06** — FPA Conformance Tests §F.D "Declarative obligations (not locally runnable on the published surface)" + §H Minimal Run Note "Bounded external obligations not locally runnable: FPA-D-01 through FPA-D-06". (attested at the gate-logic / authority-control / observability / journal layers the pack names)
- **PTS-BDA-027** — BDA Conformance Tests §5 Minimal Run Note "Bounded external obligations not locally runnable: … authorized non-validator producer grounding" (whole-assertion coverage).
- **PTS-BDA-029** — BDA Conformance Tests §5 Minimal Run Note "Bounded external obligations not locally runnable: … distributed enforcement legitimacy where not exposed by local transition function".
- **PTS-005, PTS-015, PTS-019, PTS-020, PTS-027** — SSCAR Conformance Tests §5 "7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here" (closed-enumeration relocation off the §5 buyer-runnable table).

### Evidence-satisfied declarative PASSes — attested by a real captured invocation of the surface the owning pack designates (Disposition anchor rule 4)

- **PT-028** (VRA V_COMPAT) / **PT-029** (VRA V_WRITER_LOCK) — VRA §4 Minimal Run Note "both declarative bounded external-enforcement checks are satisfied by implementation evidence"; attested via the baseline's `vra attest` surface (compat / writer-lock enforcement evidence captured).
- **PTS-BDA-011** (VAL-03 unlabeled-claim BLOCK + conflict evidence) — not pinned SKIP; the BLOCK verdict is locally exercised and conflict-evidence emission attested via `bda attest conflict_evidence` (partial-coverage rule 2: the bounded-external clause covers only the conflict-evidence sub-assertion).
- **PTS-BDA-036** (projection limitation ALLOW vs ALLOW_CONSTRAINED) — not pinned SKIP; exercised via verdict-token distinctness (`bda distinct ALLOW ALLOW_CONSTRAINED`).
- **ARA-T019** (V-10 QUARANTINE gate), **ARA-T020** (distributed enforcement legitimacy), **ARA-T027** (transparent classification) — ARA §4 per-record Status tokens PASS/UNTESTABLE-via-local-next_state + §8 Minimal Run Note "Declarative obligations are implemented or documented in the bounded external/gate surface"; attested via the baseline's `ara gate` surface.

## Corrections

All seven suites conformant at the first complete family acceptance pass; zero corrections derived.
