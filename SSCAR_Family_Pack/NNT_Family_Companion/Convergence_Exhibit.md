# Session State Continuity & Anchor Replay Family — Convergence Exhibit (Non Normative Tests)

> Buyer-facing synthesis of the cross-paradigm convergence evidence in this NNT companion.
> **Observational and demonstration-only; non-normative.** Read `INTERPRETATION_RULES_INFORMATIVE.md` first.
> Every figure below is bounded to this single NNT run on agent pack `FAM-SSCAR-FI-001`
> (manifest_ref `be319c25a82ffe4407fa8a91a51f283f1f50e524bfdb8af9845cd220b8903784`).

## What this exhibit shows

Five paradigm-isolated reconstruction contexts of the same model independently built the
Session State Continuity & Anchor Replay Family **from the buyer-facing specification pack alone** — in Python, Rust, Prolog, C, and Bash —
and ran the Conformance Tests records of the family's seven test suites against each reconstruction, under live
toolchains with hash-attested binary provenance. This exhibit summarizes where the reconstructions converged.
It is **evidence of derivability and self-sufficiency** of the specification, not a certification,
not a quality score, and not a set of implementations to follow.

## Convergence summary (this run)

- The companion partitions this run across **seven test suites** and states that **no combined number is computed across suites**, because each tests a distinct surface and a single ratio would conflate them. Copied from the companion: **231 full-convergent / 0 coverage-omission / 0 divergent** records across all suites.
- Convergent records by status, copied from the companion — convergent **PASS** (29 records): `PT-001`, `PT-002`, `PT-003`, `PT-004`, `PT-005`, `PT-006`, `PT-007`, `PT-008`, `PT-009`, `PT-010`, `PT-011`, `PT-012`, `PT-013`, `PT-014`, `PT-015`, `PT-016`, `PT-017`, `PT-018`, `PT-019`, `PT-020`, `PT-021`, `PT-022`, `PT-023`, `PT-024`, `PT-025`, `PT-026`, `PT-027`, `PT-028`, `PT-029`; convergent **PASS** (34 records): `PTS-BDA-001`, `PTS-BDA-002`, `PTS-BDA-003`, `PTS-BDA-004`, `PTS-BDA-005`, `PTS-BDA-006`, `PTS-BDA-007`, `PTS-BDA-008`, `PTS-BDA-009`, `PTS-BDA-010`, `PTS-BDA-011`, `PTS-BDA-012`, `PTS-BDA-013`, `PTS-BDA-014`, `PTS-BDA-015`, `PTS-BDA-016`, `PTS-BDA-017`, `PTS-BDA-018`, `PTS-BDA-019`, `PTS-BDA-020`, `PTS-BDA-021`, `PTS-BDA-022`, `PTS-BDA-023`, `PTS-BDA-024`, `PTS-BDA-025`, `PTS-BDA-026`, `PTS-BDA-028`, `PTS-BDA-030`, `PTS-BDA-031`, `PTS-BDA-032`, `PTS-BDA-033`, `PTS-BDA-034`, `PTS-BDA-035`, `PTS-BDA-036`; convergent **SKIP** (2 records): `PTS-BDA-027`, `PTS-BDA-029`; convergent **PASS** (52 records): `TAA-PT-001`, `TAA-PT-002`, `TAA-PT-003`, `TAA-PT-004`, `TAA-PT-005`, `TAA-PT-006`, `TAA-PT-007`, `TAA-PT-008`, `TAA-PT-009`, `TAA-PT-010`, `TAA-PT-011`, `TAA-PT-012`, `TAA-PT-013`, `TAA-PT-014`, `TAA-PT-015`, `TAA-PT-016`, `TAA-PT-017`, `TAA-PT-018`, `TAA-PT-019`, `TAA-PT-021`, `TAA-PT-022`, `TAA-PT-023`, `TAA-PT-024`, `TAA-PT-025`, `TAA-PT-026`, `TAA-PT-027`, `VP-GEN-001`, `VP-GEN-002`, `VP-GEN-003`, `VP-GEN-004`, `VP-GEN-005`, `VP-GEN-006`, `VP-GEN-007`, `VP-GEN-008`, `VP-GEN-009`, `VP-GEN-010`, `VP-GEN-011`, `VP-GEN-012`, `VP-GEN-013`, `VP-GEN-014`, `VP-GEN-015`, `VP-GEN-016`, `VP-GEN-017`, `VP-GEN-018`, `VP-GEN-019`, `VP-GEN-021`, `VP-GEN-022`, `VP-GEN-023`, `VP-GEN-024`, `VP-GEN-025`, `VP-GEN-026`, `VP-GEN-027`; convergent **SKIP** (2 records): `TAA-PT-020`, `VP-GEN-020`; convergent **PASS** (27 records): `ARA-T001`, `ARA-T002`, `ARA-T003`, `ARA-T004`, `ARA-T005`, `ARA-T006`, `ARA-T007`, `ARA-T008`, `ARA-T009`, `ARA-T010`, `ARA-T011`, `ARA-T012`, `ARA-T013`, `ARA-T014`, `ARA-T015`, `ARA-T016`, `ARA-T017`, `ARA-T018`, `ARA-T019`, `ARA-T020`, `ARA-T021`, `ARA-T022`, `ARA-T023`, `ARA-T024`, `ARA-T025`, `ARA-T026`, `ARA-T027`; convergent **PASS** (35 records): `FPA-T-01`, `FPA-T-02`, `FPA-T-03`, `FPA-T-04`, `FPA-T-06`, `FPA-T-08a`, `FPA-T-08b`, `FPA-T-08c`, `FPA-T-09`, `FPA-T-10`, `FPA-T-11`, `FPA-T-12`, `FPA-T-13a`, `FPA-T-13b`, `FPA-T-14`, `FPA-T-15`, `FPA-T-16`, `FPA-T-17A`, `FPA-T-17B`, `FPA-T-17C`, `FPA-T-17D`, `FPA-T-18`, `FPA-T-21`, `FPA-T-23`, `FPA-T-24`, `FPA-T-25`, `FPA-T-26`, `FPA-T-PR-01`, `FPA-T-PR-02`, `FPA-T-PR-03`, `FPA-T-PR-09`, `FPA-T-PR-10`, `FPA-T-PR-12`, `FPA-T-PR-13`, `FPA-T-PR-14`; convergent **SKIP** (6 records): `FPA-D-01`, `FPA-D-02`, `FPA-D-03`, `FPA-D-04`, `FPA-D-05`, `FPA-D-06`; convergent **PASS** (25 records): `PTS-001`, `PTS-002`, `PTS-003`, `PTS-004a`, `PTS-004b`, `PTS-006`, `PTS-007`, `PTS-008`, `PTS-009`, `PTS-010`, `PTS-011`, `PTS-012`, `PTS-013`, `PTS-014`, `PTS-016`, `PTS-017a`, `PTS-017b`, `PTS-017d`, `PTS-018`, `PTS-021`, `PTS-022`, `PTS-023`, `PTS-024`, `PTS-025`, `PTS-026`; convergent **SKIP** (5 records): `PTS-005`, `PTS-015`, `PTS-019`, `PTS-020`, `PTS-027`; convergent **PASS** (14 records): `CT-01`, `CT-02`, `CT-03`, `CT-04`, `CT-05`, `CT-06`, `CT-07`, `CT-08`, `CT-09`, `CT-10`, `CT-11`, `CT-12`, `CT-13`, `CT-14`.
- Per-suite breakdown, copied verbatim from the companion:

| Suite | Records observed | Full convergence | Coverage omission | Divergent |
|---|---|---|---|---|
| VRA Conformance Tests (`PT-*`) | 29 | 29 | 0 | 0 |
| BDA Conformance Tests (`PTS-BDA-*`) | 36 | 36 | 0 | 0 |
| TAA Conformance Tests (`TAA-PT-*` + `VP-GEN-*` sub-suite) | 54 | 54 | 0 | 0 |
| ARA Conformance Tests (`ARA-T*`) | 27 | 27 | 0 | 0 |
| FPA Conformance Tests (`FPA-T-*` / `FPA-D-*`) | 41 | 41 | 0 | 0 |
| SSCAR Integrator Public Test Suite (`PTS-*`) | 30 | 30 | 0 | 0 |
| SSCAR Annex C Family Connector Test Suite (`CT-*`) | 14 | 14 | 0 | 0 |

## Per-paradigm outcome (execution_mode = live)

| Paradigm | pass | fail | skip | error |
|---|---|---|---|---|
| python | 216 | 0 | 15 | 0 |
| rust   | 216 | 0 | 15 | 0 |
| prolog | 216 | 0 | 15 | 0 |
| c      | 216 | 0 | 15 | 0 |
| bash   | 216 | 0 | 15 | 0 |

All five reconstructions completed (none halted).

## Mutation sensitivity (observational — raw counts only)

Six shared semantic categories (`MS-01`..`MS-06`); each paradigm applied 8 deterministic mutation
operators to its baseline. The cross-paradigm matrix of `(category, PT) → per-paradigm status-change
counts` is in `mutation_observations.md`. **No kill rate, mutation score, survival rate, or detection
rate is computed or implied** (see `INTERPRETATION_RULES_INFORMATIVE.md` §3).

## Auto-disclosure (this run)

In this NNT test run, the reconstructions raised 43 clarifying questions; resolution partition:
`deployment_obligation`=3, `implementation_flexibility`=8, `resolved_in_ct`=3, `resolved_in_d4`=9, `resolved_in_spec`=20. Detail in `auto_disclosure_audit.md`.

## Coverage trace (this run)

28 PTS records partitioned as 19 runnable / 2 parameterized / 7 declarative, plus 14 Annex C `CT-*` wiring tests; bidirectional
keyword-overlap trace between buyer-facing guarantees and PT prose is in `coverage_trace.md`
(coarse-matcher counts, not normative coverage scores).

## Reproducibility

Sources, run scripts, binaries, and their hashes are included so the run can be re-verified two ways:
(a) `sha256sum -c` against the package Manifest on the delivered artifacts (all paradigms); and
(b) rebuild from source with the documented flags. See `baselines/{lang}/toolchain_selfcheck.txt`
for the per-paradigm rebuild story and the documented reproducibility mode (byte-exact where the
toolchain is deterministic; behavioral equivalence otherwise).

## How to read this exhibit

This exhibit is **evidence of derivability**, NOT an obligation, a recommendation, a certification,
or a measure of quality. The `baselines/` are study artifacts produced under restricted conditions;
they are **not reference implementations** and must not be used as implementation patterns.
Implementation is performed solely from the Zone A specification in the agent pack.
