# NNT — Mutation observations for FAM-SSCAR-FI-001

> Observational only. Raw status-change counts per `(paradigm, mutant category, PT id)`. **No aggregate kill rate, mutation score, survival rate, detection rate, or percentage of any kind is computed or implied.** See `INTERPRETATION_RULES_INFORMATIVE.md` §3 for the forbidden-vocabulary list.

## Methodology

- Each paradigm reconstruction applied 8 deterministic mutation operators to its baseline.
- Operators are mapped to 6 shared semantic categories (MS-01..MS-06).
- For every (mutant, PT) pair, the harness records the live-executed status. The counts below are the number of mutants in a given (paradigm, category) cell whose PT status differs from the unmutated baseline's status on the same PT.

## Per-paradigm mutant build statistics

| Paradigm | Mutants total | Mutants built | Categories observed |
|---|---|---|---|
| python | 8 | 6 | MS-01, MS-02, MS-03, MS-04, MS-05 |
| rust | 8 | 8 | MS-01, MS-02, MS-03, MS-04, MS-05, MS-06 |
| prolog | 8 | 4 | MS-04, MS-05 |
| c | 8 | 7 | MS-05, MS-06 |
| bash | 8 | 8 | MS-01, MS-02, MS-03, MS-04, MS-05, MS-06 |

## Cross-paradigm `(category, PT) -> per-paradigm status-change counts`

| Category | PT | bash | c | prolog | python | rust |
|---|---|---|---|---|---|---|
| MS-01 | CT-03 | 1 | 0 | 0 | 1 | 0 |
| MS-01 | PTS-004a | 0 | 0 | 0 | 1 | 0 |
| MS-01 | PTS-008 | 1 | 0 | 0 | 0 | 2 |
| MS-01 | PTS-009 | 1 | 0 | 0 | 0 | 2 |
| MS-01 | PTS-010 | 1 | 0 | 0 | 0 | 2 |
| MS-01 | PTS-011 | 1 | 0 | 0 | 0 | 2 |
| MS-01 | PTS-022 | 1 | 0 | 0 | 0 | 2 |
| MS-01 | PTS-025 | 0 | 0 | 0 | 0 | 2 |
| MS-01 | PTS-026 | 0 | 0 | 0 | 1 | 0 |
| MS-02 | CT-01 | 1 | 0 | 0 | 1 | 0 |
| MS-02 | CT-02 | 1 | 0 | 0 | 0 | 0 |
| MS-02 | CT-03 | 1 | 0 | 0 | 1 | 0 |
| MS-02 | CT-04 | 1 | 0 | 0 | 0 | 0 |
| MS-02 | CT-05 | 1 | 0 | 0 | 0 | 1 |
| MS-02 | CT-07 | 1 | 0 | 0 | 0 | 0 |
| MS-02 | CT-08 | 1 | 0 | 0 | 1 | 1 |
| MS-02 | CT-09 | 1 | 0 | 0 | 0 | 0 |
| MS-02 | CT-11 | 1 | 0 | 0 | 0 | 0 |
| MS-02 | CT-12 | 1 | 0 | 0 | 0 | 0 |
| MS-02 | CT-13 | 1 | 0 | 0 | 0 | 0 |
| MS-02 | PTS-003 | 1 | 0 | 0 | 1 | 1 |
| MS-02 | PTS-007 | 1 | 0 | 0 | 0 | 0 |
| MS-03 | CT-02 | 0 | 0 | 0 | 1 | 1 |
| MS-03 | CT-03 | 0 | 0 | 0 | 1 | 1 |
| MS-03 | CT-06 | 0 | 0 | 0 | 1 | 1 |
| MS-03 | CT-09 | 1 | 0 | 0 | 1 | 1 |
| MS-03 | CT-13 | 0 | 0 | 0 | 1 | 0 |
| MS-03 | PTS-017a | 0 | 0 | 0 | 1 | 0 |
| MS-03 | PTS-018 | 0 | 0 | 0 | 1 | 0 |
| MS-03 | PTS-022 | 0 | 0 | 0 | 1 | 1 |
| MS-03 | PTS-025 | 0 | 0 | 0 | 1 | 1 |
| MS-04 | CT-02 | 0 | 0 | 0 | 1 | 0 |
| MS-04 | CT-03 | 1 | 0 | 0 | 1 | 0 |
| MS-04 | CT-06 | 0 | 0 | 0 | 1 | 0 |
| MS-04 | CT-09 | 0 | 0 | 0 | 1 | 0 |
| MS-04 | CT-13 | 0 | 0 | 0 | 1 | 0 |
| MS-04 | PTS-004b | 0 | 0 | 1 | 0 | 1 |
| MS-04 | PTS-008 | 0 | 0 | 1 | 0 | 1 |
| MS-04 | PTS-009 | 0 | 0 | 1 | 0 | 1 |
| MS-04 | PTS-010 | 0 | 0 | 1 | 0 | 1 |
| MS-04 | PTS-011 | 0 | 0 | 1 | 0 | 1 |
| MS-04 | PTS-017a | 0 | 0 | 0 | 1 | 0 |
| MS-04 | PTS-018 | 0 | 0 | 0 | 1 | 0 |
| MS-04 | PTS-022 | 0 | 0 | 1 | 1 | 1 |
| MS-04 | PTS-025 | 0 | 0 | 1 | 1 | 1 |
| MS-05 | ARA-T001 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T002 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T003 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T004 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T005 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T006 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T007 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T008 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T009 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T010 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T011 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T012 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T013 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T014 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T015 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T016 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T017 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T018 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T019 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T020 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T021 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T022 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T023 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T024 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T025 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T026 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | ARA-T027 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-01 | 1 | 1 | 0 | 0 | 0 |
| MS-05 | CT-02 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-03 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-04 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-05 | 0 | 1 | 0 | 0 | 1 |
| MS-05 | CT-06 | 0 | 1 | 0 | 1 | 0 |
| MS-05 | CT-07 | 0 | 1 | 0 | 1 | 0 |
| MS-05 | CT-08 | 1 | 1 | 1 | 1 | 1 |
| MS-05 | CT-09 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-10 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-11 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-12 | 1 | 1 | 0 | 0 | 0 |
| MS-05 | CT-13 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | CT-14 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-01 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-02 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-03 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-04 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-06 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-08a | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-08b | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-08c | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-09 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-10 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-11 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-12 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-13a | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-13b | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-14 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-15 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-16 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-17A | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-17B | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-17C | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-17D | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-18 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-21 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-23 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-24 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-25 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-26 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-01 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-02 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-03 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-09 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-10 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-12 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-13 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | FPA-T-PR-14 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-001 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-002 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-003 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-004 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-005 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-006 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-007 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-008 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-009 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-010 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-011 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-012 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-013 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-014 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-015 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-016 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-017 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-018 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-019 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-020 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-021 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-022 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-023 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-024 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-025 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-026 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-027 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-028 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PT-029 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-001 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-002 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-003 | 1 | 1 | 1 | 1 | 1 |
| MS-05 | PTS-004a | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-004b | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-006 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-007 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-008 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-009 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-010 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-011 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-012 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-013 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-014 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-016 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-017a | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-017b | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-017d | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-018 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-021 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-022 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-023 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-024 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-025 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-026 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-001 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-002 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-003 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-004 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-005 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-006 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-007 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-008 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-009 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-010 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-011 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-012 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-013 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-014 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-015 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-016 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-017 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-018 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-019 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-020 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-021 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-022 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-023 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-024 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-025 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-026 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-028 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-030 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-031 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-032 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-033 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-034 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-035 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | PTS-BDA-036 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-001 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-002 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-003 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-004 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-005 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-006 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-007 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-008 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-009 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-010 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-011 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-012 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-013 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-014 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-015 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-016 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-017 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-018 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-019 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-021 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-022 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-023 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-024 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-025 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-026 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | TAA-PT-027 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-001 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-002 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-003 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-004 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-005 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-006 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-007 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-008 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-009 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-010 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-011 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-012 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-013 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-014 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-015 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-016 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-017 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-018 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-019 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-021 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-022 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-023 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-024 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-025 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-026 | 0 | 1 | 0 | 0 | 0 |
| MS-05 | VP-GEN-027 | 0 | 1 | 0 | 0 | 0 |
| MS-06 | CT-05 | 1 | 0 | 0 | 0 | 0 |
| MS-06 | CT-12 | 1 | 1 | 0 | 0 | 1 |

## Reader's frame (REQUIRED)

- A count of `N` in cell `(lang, category, PT)` means: in this NNT run, `N` of the mutants in category `<cat>` for paradigm `<lang>` produced a PT status on `<PT>` that differs from the unmutated baseline's status on the same PT.
- The count is not a quality measure. It says nothing about the spec, the test suite, or any implementation. It is purely an observation about the relationship between (paradigm, mutation operator, PT) under one specific protocol.
- Counts across rows are not comparable as ratios. The denominator (mutants built per category) varies per paradigm. The reader who wants the denominator reads the per-paradigm table above; the harness does not compute ratios.

