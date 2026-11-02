# NNT — Aggregate observations for FAM-SSCAR-FI-001

> All entries below are **observations**, not findings. See `INTERPRETATION_RULES_INFORMATIVE.md` for permissible readings.

Paradigms observed in this run: python, rust, prolog, c, bash

## Canonical coverage (pinned test-id set)

This family run is pinned to a canonical test-id set (an automated step extraction from the frozen Conformance Tests + Annex-C connector pack files). The convergence matrix below is seeded with the full canonical set, so a pinned record that no paradigm reported appears explicitly as an all-missing coverage-omission row rather than being silently absent. Records reported that are NOT in the pinned set (off-canonical / wrong granularity): none.

## Family-conformance frame (7 suites + emergent verdict)

NNT-relevant exercises the relevant family COMPOSITION (6-pack Family Pack) under one unified baseline per paradigm. Convergence is partitioned across SEVEN test suites — the 5 component PT suites (VRA `PT-*` / BDA `PTS-BDA-*` / TAA `TAA-PT-*` / ARA `ARA-T*` / FPA `FPA-T-*`,`FPA-D-*`) plus the SSCAR integrator **Public Test Suite** (`PTS-*`) and **Annex C Family Connector Test Suite** (`CT-*`). **Family conformance = convergence on ALL seven suites** plus a convergent EMERGENT family verdict (`session_replay_admissibility` per AMB-01 — NOT an aggregation / majority / first-failing-wins of the 5 component verdicts). No combined number is computed across suites: each tests a distinct surface and a single ratio would conflate them.

## VRA Conformance Tests (`PT-*`)

- In this NNT test run, 29 of 29 records of this suite had FULL convergence (every observed paradigm reported the same status).
- 0 of 29 records had a COVERAGE OMISSION (≥ 1 observed paradigm did not report the record; this is NOT full convergence).
- 0 of 29 records had divergent outcomes across the observed paradigms.

### Full-convergence records — VRA Conformance Tests (`PT-*`) (29)

- **PASS** across all observed paradigms (29 records): `PT-001`, `PT-002`, `PT-003`, `PT-004`, `PT-005`, `PT-006`, `PT-007`, `PT-008`, `PT-009`, `PT-010`, `PT-011`, `PT-012`, `PT-013`, `PT-014`, `PT-015`, `PT-016`, `PT-017`, `PT-018`, `PT-019`, `PT-020`, `PT-021`, `PT-022`, `PT-023`, `PT-024`, `PT-025`, `PT-026`, `PT-027`, `PT-028`, `PT-029`

## BDA Conformance Tests (`PTS-BDA-*`)

- In this NNT test run, 36 of 36 records of this suite had FULL convergence (every observed paradigm reported the same status).
- 0 of 36 records had a COVERAGE OMISSION (≥ 1 observed paradigm did not report the record; this is NOT full convergence).
- 0 of 36 records had divergent outcomes across the observed paradigms.

### Full-convergence records — BDA Conformance Tests (`PTS-BDA-*`) (36)

- **PASS** across all observed paradigms (34 records): `PTS-BDA-001`, `PTS-BDA-002`, `PTS-BDA-003`, `PTS-BDA-004`, `PTS-BDA-005`, `PTS-BDA-006`, `PTS-BDA-007`, `PTS-BDA-008`, `PTS-BDA-009`, `PTS-BDA-010`, `PTS-BDA-011`, `PTS-BDA-012`, `PTS-BDA-013`, `PTS-BDA-014`, `PTS-BDA-015`, `PTS-BDA-016`, `PTS-BDA-017`, `PTS-BDA-018`, `PTS-BDA-019`, `PTS-BDA-020`, `PTS-BDA-021`, `PTS-BDA-022`, `PTS-BDA-023`, `PTS-BDA-024`, `PTS-BDA-025`, `PTS-BDA-026`, `PTS-BDA-028`, `PTS-BDA-030`, `PTS-BDA-031`, `PTS-BDA-032`, `PTS-BDA-033`, `PTS-BDA-034`, `PTS-BDA-035`, `PTS-BDA-036`
- **SKIP** across all observed paradigms (2 records): `PTS-BDA-027`, `PTS-BDA-029`

## TAA Conformance Tests (`TAA-PT-*` + `VP-GEN-*` sub-suite)

- In this NNT test run, 54 of 54 records of this suite had FULL convergence (every observed paradigm reported the same status).
- 0 of 54 records had a COVERAGE OMISSION (≥ 1 observed paradigm did not report the record; this is NOT full convergence).
- 0 of 54 records had divergent outcomes across the observed paradigms.

### Full-convergence records — TAA Conformance Tests (`TAA-PT-*` + `VP-GEN-*` sub-suite) (54)

- **PASS** across all observed paradigms (52 records): `TAA-PT-001`, `TAA-PT-002`, `TAA-PT-003`, `TAA-PT-004`, `TAA-PT-005`, `TAA-PT-006`, `TAA-PT-007`, `TAA-PT-008`, `TAA-PT-009`, `TAA-PT-010`, `TAA-PT-011`, `TAA-PT-012`, `TAA-PT-013`, `TAA-PT-014`, `TAA-PT-015`, `TAA-PT-016`, `TAA-PT-017`, `TAA-PT-018`, `TAA-PT-019`, `TAA-PT-021`, `TAA-PT-022`, `TAA-PT-023`, `TAA-PT-024`, `TAA-PT-025`, `TAA-PT-026`, `TAA-PT-027`, `VP-GEN-001`, `VP-GEN-002`, `VP-GEN-003`, `VP-GEN-004`, `VP-GEN-005`, `VP-GEN-006`, `VP-GEN-007`, `VP-GEN-008`, `VP-GEN-009`, `VP-GEN-010`, `VP-GEN-011`, `VP-GEN-012`, `VP-GEN-013`, `VP-GEN-014`, `VP-GEN-015`, `VP-GEN-016`, `VP-GEN-017`, `VP-GEN-018`, `VP-GEN-019`, `VP-GEN-021`, `VP-GEN-022`, `VP-GEN-023`, `VP-GEN-024`, `VP-GEN-025`, `VP-GEN-026`, `VP-GEN-027`
- **SKIP** across all observed paradigms (2 records): `TAA-PT-020`, `VP-GEN-020`

## ARA Conformance Tests (`ARA-T*`)

- In this NNT test run, 27 of 27 records of this suite had FULL convergence (every observed paradigm reported the same status).
- 0 of 27 records had a COVERAGE OMISSION (≥ 1 observed paradigm did not report the record; this is NOT full convergence).
- 0 of 27 records had divergent outcomes across the observed paradigms.

### Full-convergence records — ARA Conformance Tests (`ARA-T*`) (27)

- **PASS** across all observed paradigms (27 records): `ARA-T001`, `ARA-T002`, `ARA-T003`, `ARA-T004`, `ARA-T005`, `ARA-T006`, `ARA-T007`, `ARA-T008`, `ARA-T009`, `ARA-T010`, `ARA-T011`, `ARA-T012`, `ARA-T013`, `ARA-T014`, `ARA-T015`, `ARA-T016`, `ARA-T017`, `ARA-T018`, `ARA-T019`, `ARA-T020`, `ARA-T021`, `ARA-T022`, `ARA-T023`, `ARA-T024`, `ARA-T025`, `ARA-T026`, `ARA-T027`

## FPA Conformance Tests (`FPA-T-*` / `FPA-D-*`)

- In this NNT test run, 41 of 41 records of this suite had FULL convergence (every observed paradigm reported the same status).
- 0 of 41 records had a COVERAGE OMISSION (≥ 1 observed paradigm did not report the record; this is NOT full convergence).
- 0 of 41 records had divergent outcomes across the observed paradigms.

### Full-convergence records — FPA Conformance Tests (`FPA-T-*` / `FPA-D-*`) (41)

- **PASS** across all observed paradigms (35 records): `FPA-T-01`, `FPA-T-02`, `FPA-T-03`, `FPA-T-04`, `FPA-T-06`, `FPA-T-08a`, `FPA-T-08b`, `FPA-T-08c`, `FPA-T-09`, `FPA-T-10`, `FPA-T-11`, `FPA-T-12`, `FPA-T-13a`, `FPA-T-13b`, `FPA-T-14`, `FPA-T-15`, `FPA-T-16`, `FPA-T-17A`, `FPA-T-17B`, `FPA-T-17C`, `FPA-T-17D`, `FPA-T-18`, `FPA-T-21`, `FPA-T-23`, `FPA-T-24`, `FPA-T-25`, `FPA-T-26`, `FPA-T-PR-01`, `FPA-T-PR-02`, `FPA-T-PR-03`, `FPA-T-PR-09`, `FPA-T-PR-10`, `FPA-T-PR-12`, `FPA-T-PR-13`, `FPA-T-PR-14`
- **SKIP** across all observed paradigms (6 records): `FPA-D-01`, `FPA-D-02`, `FPA-D-03`, `FPA-D-04`, `FPA-D-05`, `FPA-D-06`

## SSCAR Integrator Public Test Suite (`PTS-*`)

- In this NNT test run, 30 of 30 records of this suite had FULL convergence (every observed paradigm reported the same status).
- 0 of 30 records had a COVERAGE OMISSION (≥ 1 observed paradigm did not report the record; this is NOT full convergence).
- 0 of 30 records had divergent outcomes across the observed paradigms.

### Full-convergence records — SSCAR Integrator Public Test Suite (`PTS-*`) (30)

- **PASS** across all observed paradigms (25 records): `PTS-001`, `PTS-002`, `PTS-003`, `PTS-004a`, `PTS-004b`, `PTS-006`, `PTS-007`, `PTS-008`, `PTS-009`, `PTS-010`, `PTS-011`, `PTS-012`, `PTS-013`, `PTS-014`, `PTS-016`, `PTS-017a`, `PTS-017b`, `PTS-017d`, `PTS-018`, `PTS-021`, `PTS-022`, `PTS-023`, `PTS-024`, `PTS-025`, `PTS-026`
- **SKIP** across all observed paradigms (5 records): `PTS-005`, `PTS-015`, `PTS-019`, `PTS-020`, `PTS-027`

## SSCAR Annex C Family Connector Test Suite (`CT-*`)

- In this NNT test run, 14 of 14 records of this suite had FULL convergence (every observed paradigm reported the same status).
- 0 of 14 records had a COVERAGE OMISSION (≥ 1 observed paradigm did not report the record; this is NOT full convergence).
- 0 of 14 records had divergent outcomes across the observed paradigms.

### Full-convergence records — SSCAR Annex C Family Connector Test Suite (`CT-*`) (14)

- **PASS** across all observed paradigms (14 records): `CT-01`, `CT-02`, `CT-03`, `CT-04`, `CT-05`, `CT-06`, `CT-07`, `CT-08`, `CT-09`, `CT-10`, `CT-11`, `CT-12`, `CT-13`, `CT-14`

## Cross-suite family-composition observations

Patterns observed ACROSS suites under each paradigm's unified baseline. A divergence isolated to a single component PT suite indicates a component-portion derivation margin; one that co-occurs in the SSCAR `PTS-*`/`CT-*` suites (especially Annex C connector tests, which consume real cross-component outputs) indicates a family-composition-layer margin. Convergence on a component suite AND the connector tests that consume that component's output (e.g. FPA `accepted_head_digest` → CT identity/rehydration tests) is positive evidence the cross-component contract closes under live derivation.

## Family conformance summary

| Suite | Records observed | Full convergence | Coverage omission | Divergent |
|---|---|---|---|---|
| VRA Conformance Tests (`PT-*`) | 29 | 29 | 0 | 0 |
| BDA Conformance Tests (`PTS-BDA-*`) | 36 | 36 | 0 | 0 |
| TAA Conformance Tests (`TAA-PT-*` + `VP-GEN-*` sub-suite) | 54 | 54 | 0 | 0 |
| ARA Conformance Tests (`ARA-T*`) | 27 | 27 | 0 | 0 |
| FPA Conformance Tests (`FPA-T-*` / `FPA-D-*`) | 41 | 41 | 0 | 0 |
| SSCAR Integrator Public Test Suite (`PTS-*`) | 30 | 30 | 0 | 0 |
| SSCAR Annex C Family Connector Test Suite (`CT-*`) | 14 | 14 | 0 | 0 |

**Family conformance = PASS only if all 7 suites FULLY converge with zero coverage omissions** — this table is the per-suite observation, not a combined verdict (NNT emits observations, never verdicts). Observed this run: 231 full-convergent / 0 coverage-omission / 0 divergent records across all suites.

