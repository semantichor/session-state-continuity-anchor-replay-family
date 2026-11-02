# SSCAR family supplementary derivations

This supplement records the FAM-SSCAR family derivation of the family integrator in composition. The family capability is emergent: none of its five component agents produces it alone. Each component is represented by a producer of fields consumed by the family validators; the integrator consumes those produced fields through the family workflow and verdict surfaces. The supplement is not a standalone implementation or a declaration of family conformance. The canonical family package remains authoritative.

## Demonstrated surfaces

### Part A — finite family workflow projection

The projection evaluates `next_state(current_state, trigger, validator_passed) -> FamilyWorkflowState` over the twelve `FamilyWorkflowState` variants, the 33 declared tuple labels, and both Boolean inputs, for 792 tuples. The sweep order and every projection rule with its canonical trace are in `SOURCE_RULES.md`. CT spellings are used where named; other tuple labels are declared projection labels derived from the integrated family package. They are not presented as canonical trigger names. `validator_passed` is the Boolean argument named by CT §8, not an inferred aggregate over the family validators.

Each tuple emits one state token. The family verdict layer is separate: its six verdicts are not workflow states, and a verdict-layer result such as `INCIDENT_ONLY` or `REPLAY_INCOMPLETE` is not substituted for a state. The source basis and rule-by-rule treatment are in `SOURCE_RULES.md`.

The reference output, Common Lisp, Brainfuck, Analytical Engine-style, AWK, and Rust comparator vectors are byte-identical. Each contains 792 LF-terminated state tokens and has SHA-256 `641fb932d85354120457dfe893ee8b24cc2b0005c6305b47ecc42d93ed0e7ba6`. The workbook contains formulas for the 792-case `Sweep` projection.

### Part B — public integrator suite and Annex C connector suite

The AWK implementation loads records under the canonical PFX fixture identifiers in CT §6; any parameterized case changes only the named fields of that CT fixture. Component producers derive their Annex A §4 public fields, and the family validators and verdict layer consume those produced fields. The public Conformance Tests suite contains 30 granular records. The GNU Awk run produced **29 PASS / 0 FAIL / 1 SKIP / 0 ERROR**. PTS-007 is SKIP because CT §8 identifies the FV-04 local-reclassification policy hook as a bounded external obligation. No component-agent conformance suite is included; those are covered by the component supplements.

The `PT` sheet contains all 30 public records. Its formulas evaluate the CT fixture cases against the `FixtureCalc` worksheet, which derives the family-validator results, evidence fields, FOC fields, and verdicts from fixture inputs. No AWK output is an input to these calculations. The formulas provide an independent spreadsheet rendering of the fixture evaluations.

Annex C is a separate set of 14 connector tests, not combined with the public suite. The AWK composition run produced **14 PASS / 0 FAIL / 0 SKIP / 0 ERROR**. CT-14 executes all five altered-field cases: `carried_payload`, `anchor_document_ref`, and `source_control_bundles` re-enter at S2; `policy_snapshot_id` and `rehydration_closure_ref` re-enter at S5. Targets follow Specification §9 and public CT PTS-023 field-set routing, consistent with the Specification-led transition routing and the public PTS-023 field-set outcomes.

### Part C — family data and vocabulary surfaces

The workbook renders the family vocabulary, evidence contract fields, decision-object values, gate surface, evidence applicability, component producer attribution, CT classifications, CT dispositions, and formula-evaluated fixture cases as data. The sheets are `Vocab`, `Evidence`, `ObjectValues`, `GateSurface`, `EvidenceSurface`, `ProducerSurface`, `Classifications`, `Disposition`, and `FixtureCalc`. AWK and Brainfuck expose state, `next_state`, evidence-field, and family-verdict vocabulary surfaces. The family verdict layer remains separate from the state projection.

## Paradigm coverage and toolchains

| Paradigm or role | Part A | Part B | Part C | Execution evidence and limits |
|---|---|---|---|---|
| Common Lisp | 792-case sweep | — | — | SBCL 2.6.6; vector matches the reference. |
| Brainfuck | 792-case sweep | — | State, `next_state`, evidence, and verdict probes | Brainfuck source executed by the included C interpreter compiled with GCC 15.2.0 (MSYS2 UCRT64); vector and probes captured. The interpreter is an execution harness, not the family derivation logic. Its executable is not included. |
| Spreadsheet formulas | 792-case sweep | 30-record PT sheet | Vocabulary, evidence, object values, gate, evidence applicability, producer, classification, disposition, and fixture-calculation surfaces | Formula-driven `Sweep` and `PT` surfaces were recalculated and saved in native Microsoft Excel 16.0 (`AppVersion 16.0300`) with `CalculateFullRebuild`; all 792 saved `Sweep` results match the reference vector, and the 30 `PT` outcomes match the AWK run (29 PASS / 0 FAIL / 1 SKIP / 0 ERROR). |
| Analytical Engine-style | 792-case sweep | — | — | Python 3.12.10 drove the `py-ae` emulator at revision `0881ed7dc59850aba7519b254b458fdb00b24abb`; the card program performs the projection. The emulator is not included. |
| AWK | 792-case sweep | 30 public CT records and 14 Annex C connector records | State, `next_state`, evidence, and verdict surfaces | GNU Awk 5.4.1 (ezwinports, MinGW 32-bit), run with `BINMODE=3`. Public suite: 29 PASS / 0 FAIL / 1 SKIP / 0 ERROR. Annex C: 14 PASS / 0 FAIL / 0 SKIP / 0 ERROR. |
| Comparator role | 792-case sweep | — | — | Rust 1.95.0; separate comparator, byte-identical to the reference. |

The Brainfuck interpreter was compiled with GCC 15.2.0. Its executable is not included. The Analytical Engine was not built; the captured output depends on the emulator's implementation of its documented cards. Python supplies inputs and captures results, while the card program encodes the projection decisions.

## Relationship to the SSCAR family NNT companion

After deriving the projection, all 792 tuples were compared with the five supplied NNT family transition baselines. These runs are comparison evidence only; the companion is not a source or oracle. In this NNT comparison run, `UNSUPPORTED` means a baseline rejected the supplied tuple label and returned no state result. The table includes each supported tuple whose result differs from the family projection in at least one NNT baseline; `UNSUPPORTED`-only rows are excluded. Rows group states only where the complete input tuple and all five observed outcomes are identical. `SOURCE_RULES.md` identifies the package basis for every projection row. Rows marked `R14` are uncovered tuples and preserve their current state under the defined non-advancement criterion.

| State(s) | Trigger | `validator_passed` | Family projection | Python | Rust | C | Prolog | Bash | Projection basis |
|---|---|---:|---|---|---|---|---|---|---|
| S0 | `AcceptedHeadFreshnessLock` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04a` |
| S0 | `AcceptedHeadFreshnessLock` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04a` |
| S1 | `AcceptedHeadFreshnessLock` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04a` |
| S1 | `AcceptedHeadFreshnessLock` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04a` |
| S2 | `AcceptedHeadFreshnessLock` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04a` |
| S2 | `AcceptedHeadFreshnessLock` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04a` |
| S3 | `AcceptedHeadFreshnessLock` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04a` |
| S3 | `AcceptedHeadFreshnessLock` | `true` | `S4` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04a` |
| S4 | `AcceptedHeadFreshnessLock` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04a` |
| S4 | `AcceptedHeadFreshnessLock` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04a` |
| S5 | `AcceptedHeadFreshnessLock` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04a` |
| S5 | `AcceptedHeadFreshnessLock` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04a` |
| S6 | `AcceptedHeadFreshnessLock` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04a` |
| S6 | `AcceptedHeadFreshnessLock` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04a` |
| S7 | `AcceptedHeadFreshnessLock` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04a` |
| S7 | `AcceptedHeadFreshnessLock` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04a` |
| SH | `AcceptedHeadFreshnessLock` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04a` |
| SH | `AcceptedHeadFreshnessLock` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04a` |
| SR | `AcceptedHeadFreshnessLock` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04a` |
| SR | `AcceptedHeadFreshnessLock` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04a` |
| S0 | `Admission` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R01a` |
| S0 | `Admission` | `true` | `S1` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R01a` |
| S1 | `Admission` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R01a` |
| S1 | `Admission` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R01a` |
| S2 | `Admission` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R01a` |
| S2 | `Admission` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R01a` |
| S3 | `Admission` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R01a` |
| S3 | `Admission` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R01a` |
| S4 | `Admission` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R01a` |
| S4 | `Admission` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R01a` |
| S5 | `Admission` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R01a` |
| S5 | `Admission` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R01a` |
| S6 | `Admission` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R01a` |
| S6 | `Admission` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R01a` |
| S7 | `Admission` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R01a` |
| S7 | `Admission` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R01a` |
| SH | `Admission` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R01a` |
| SH | `Admission` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R01a` |
| SR | `Admission` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R01a` |
| SR | `Admission` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R01a` |
| S0 | `BoundaryScreening` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R02a` |
| S0 | `BoundaryScreening` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R02a` |
| S1 | `BoundaryScreening` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R02a` |
| S1 | `BoundaryScreening` | `true` | `S2` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R02a` |
| S2 | `BoundaryScreening` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R02a` |
| S2 | `BoundaryScreening` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R02a` |
| S3 | `BoundaryScreening` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R02a` |
| S3 | `BoundaryScreening` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R02a` |
| S4 | `BoundaryScreening` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R02a` |
| S4 | `BoundaryScreening` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R02a` |
| S5 | `BoundaryScreening` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R02a` |
| S5 | `BoundaryScreening` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R02a` |
| S6 | `BoundaryScreening` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R02a` |
| S6 | `BoundaryScreening` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R02a` |
| S7 | `BoundaryScreening` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R02a` |
| S7 | `BoundaryScreening` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R02a` |
| SH | `BoundaryScreening` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R02a` |
| SH | `BoundaryScreening` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R02a` |
| SR | `BoundaryScreening` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R02a` |
| SR | `BoundaryScreening` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R02a` |
| S8 | `CriticalContamination` | `false` | `SX` | `S8` | `S8` | `SX` | `S8` | `SX` | `R06` |
| S8 | `CriticalContamination` | `true` | `SX` | `S8` | `S8` | `SX` | `S8` | `SX` | `R06` |
| S0 | `EmitFamilyVerdict` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04e` |
| S0 | `EmitFamilyVerdict` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04e` |
| S1 | `EmitFamilyVerdict` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04e` |
| S1 | `EmitFamilyVerdict` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04e` |
| S2 | `EmitFamilyVerdict` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04e` |
| S2 | `EmitFamilyVerdict` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04e` |
| S3 | `EmitFamilyVerdict` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04e` |
| S3 | `EmitFamilyVerdict` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04e` |
| S4 | `EmitFamilyVerdict` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04e` |
| S4 | `EmitFamilyVerdict` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04e` |
| S5 | `EmitFamilyVerdict` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04e` |
| S5 | `EmitFamilyVerdict` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04e` |
| S6 | `EmitFamilyVerdict` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04e` |
| S6 | `EmitFamilyVerdict` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04e` |
| S7 | `EmitFamilyVerdict` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04e` |
| S7 | `EmitFamilyVerdict` | `true` | `S8` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S8` | `SX` | `R04e` |
| SH | `EmitFamilyVerdict` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04e` |
| SH | `EmitFamilyVerdict` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04e` |
| SR | `EmitFamilyVerdict` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04e` |
| SR | `EmitFamilyVerdict` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04e` |
| S0 | `FamilyReportAssembly` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04d` |
| S0 | `FamilyReportAssembly` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04d` |
| S1 | `FamilyReportAssembly` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04d` |
| S1 | `FamilyReportAssembly` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04d` |
| S2 | `FamilyReportAssembly` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04d` |
| S2 | `FamilyReportAssembly` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04d` |
| S3 | `FamilyReportAssembly` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04d` |
| S3 | `FamilyReportAssembly` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04d` |
| S4 | `FamilyReportAssembly` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04d` |
| S4 | `FamilyReportAssembly` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04d` |
| S5 | `FamilyReportAssembly` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04d` |
| S5 | `FamilyReportAssembly` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04d` |
| S6 | `FamilyReportAssembly` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04d` |
| S6 | `FamilyReportAssembly` | `true` | `S7` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04d` |
| S7 | `FamilyReportAssembly` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04d` |
| S7 | `FamilyReportAssembly` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04d` |
| SH | `FamilyReportAssembly` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04d` |
| SH | `FamilyReportAssembly` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04d` |
| SR | `FamilyReportAssembly` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04d` |
| SR | `FamilyReportAssembly` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04d` |
| S0 | `FamilyVerdictIssued` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04e` |
| S0 | `FamilyVerdictIssued` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04e` |
| S1 | `FamilyVerdictIssued` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04e` |
| S1 | `FamilyVerdictIssued` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04e` |
| S2 | `FamilyVerdictIssued` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04e` |
| S2 | `FamilyVerdictIssued` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04e` |
| S3 | `FamilyVerdictIssued` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04e` |
| S3 | `FamilyVerdictIssued` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04e` |
| S4 | `FamilyVerdictIssued` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04e` |
| S4 | `FamilyVerdictIssued` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04e` |
| S5 | `FamilyVerdictIssued` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04e` |
| S5 | `FamilyVerdictIssued` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04e` |
| S6 | `FamilyVerdictIssued` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04e` |
| S6 | `FamilyVerdictIssued` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04e` |
| S7 | `FamilyVerdictIssued` | `false` | `S7` | `S8` | `S7` | `S8` | `S7` | `S8` | `R04e` |
| S7 | `FamilyVerdictIssued` | `true` | `S8` | `S8` | `S8` | `S8` | `S7` | `S8` | `R04e` |
| SH | `FamilyVerdictIssued` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04e` |
| SH | `FamilyVerdictIssued` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04e` |
| SR | `FamilyVerdictIssued` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04e` |
| SR | `FamilyVerdictIssued` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04e` |
| S0 | `FreshnessReplay` | `false` | `S0` | `SH` | `S0` | `SH` | `SH` | `SX` | `R05` |
| S0 | `FreshnessReplay` | `true` | `S0` | `SH` | `S0` | `SH` | `SH` | `SX` | `R05` |
| S1 | `FreshnessReplay` | `false` | `S1` | `SH` | `S1` | `SH` | `SH` | `SX` | `R05` |
| S1 | `FreshnessReplay` | `true` | `S1` | `SH` | `S1` | `SH` | `SH` | `SX` | `R05` |
| S2 | `FreshnessReplay` | `false` | `S2` | `SH` | `S2` | `SH` | `SH` | `SX` | `R05` |
| S2 | `FreshnessReplay` | `true` | `S2` | `SH` | `S2` | `SH` | `SH` | `SX` | `R05` |
| S4 | `FreshnessReplay` | `false` | `S4` | `SH` | `S4` | `SH` | `SH` | `SX` | `R05` |
| S4 | `FreshnessReplay` | `true` | `S4` | `SH` | `S4` | `SH` | `SH` | `SX` | `R05` |
| S5 | `FreshnessReplay` | `false` | `S5` | `SH` | `S5` | `SH` | `SH` | `SX` | `R05` |
| S5 | `FreshnessReplay` | `true` | `S5` | `SH` | `S5` | `SH` | `SH` | `SX` | `R05` |
| S6 | `FreshnessReplay` | `false` | `S6` | `SH` | `S6` | `SH` | `SH` | `SX` | `R05` |
| S6 | `FreshnessReplay` | `true` | `S6` | `SH` | `S6` | `SH` | `SH` | `SX` | `R05` |
| S7 | `FreshnessReplay` | `false` | `S7` | `SH` | `S7` | `SH` | `SH` | `SX` | `R05` |
| S7 | `FreshnessReplay` | `true` | `S7` | `SH` | `S7` | `SH` | `SH` | `SX` | `R05` |
| S8 | `FreshnessReplay` | `false` | `S8` | `S8` | `S8` | `SH` | `S8` | `S8` | `R05` |
| S8 | `FreshnessReplay` | `true` | `S8` | `S8` | `S8` | `SH` | `S8` | `S8` | `R05` |
| SH | `FreshnessReplay` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R05` |
| SH | `FreshnessReplay` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R05` |
| SR | `FreshnessReplay` | `false` | `SR` | `SH` | `SR` | `SH` | `SH` | `SX` | `R05` |
| SR | `FreshnessReplay` | `true` | `SR` | `SH` | `SR` | `SH` | `SH` | `SX` | `R05` |
| SX | `FreshnessReplay` | `false` | `SX` | `SX` | `SX` | `SH` | `SX` | `SX` | `R05` |
| SX | `FreshnessReplay` | `true` | `SX` | `SX` | `SX` | `SH` | `SX` | `SX` | `R05` |
| S0 | `Fv01Pass` | `false` | `S0` | `S0` | `S0` | `SX` | `S0` | `SX` | `R01` |
| S1 | `Fv01Pass` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R01` |
| S1 | `Fv01Pass` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R01` |
| S2 | `Fv01Pass` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R01` |
| S2 | `Fv01Pass` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R01` |
| S3 | `Fv01Pass` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R01` |
| S3 | `Fv01Pass` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R01` |
| S4 | `Fv01Pass` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R01` |
| S4 | `Fv01Pass` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R01` |
| S5 | `Fv01Pass` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R01` |
| S5 | `Fv01Pass` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R01` |
| S6 | `Fv01Pass` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R01` |
| S6 | `Fv01Pass` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R01` |
| S7 | `Fv01Pass` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R01` |
| S7 | `Fv01Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R01` |
| SH | `Fv01Pass` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R01` |
| SH | `Fv01Pass` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R01` |
| SR | `Fv01Pass` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R01` |
| SR | `Fv01Pass` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R01` |
| S0 | `Fv02AndFv04Pass` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R02` |
| S0 | `Fv02AndFv04Pass` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R02` |
| S2 | `Fv02AndFv04Pass` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R02` |
| S2 | `Fv02AndFv04Pass` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R02` |
| S3 | `Fv02AndFv04Pass` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R02` |
| S3 | `Fv02AndFv04Pass` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R02` |
| S4 | `Fv02AndFv04Pass` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R02` |
| S4 | `Fv02AndFv04Pass` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R02` |
| S5 | `Fv02AndFv04Pass` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R02` |
| S5 | `Fv02AndFv04Pass` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R02` |
| S6 | `Fv02AndFv04Pass` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R02` |
| S6 | `Fv02AndFv04Pass` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R02` |
| S7 | `Fv02AndFv04Pass` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R02` |
| S7 | `Fv02AndFv04Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R02` |
| SH | `Fv02AndFv04Pass` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R02` |
| SH | `Fv02AndFv04Pass` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R02` |
| SR | `Fv02AndFv04Pass` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R02` |
| SR | `Fv02AndFv04Pass` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R02` |
| S0 | `Fv03Pass` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R03` |
| S0 | `Fv03Pass` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R03` |
| S1 | `Fv03Pass` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R03` |
| S1 | `Fv03Pass` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R03` |
| S2 | `Fv03Pass` | `false` | `SX` | `SX` | `S2` | `SX` | `S2` | `SX` | `R03` |
| S3 | `Fv03Pass` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R03` |
| S3 | `Fv03Pass` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R03` |
| S4 | `Fv03Pass` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R03` |
| S4 | `Fv03Pass` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R03` |
| S5 | `Fv03Pass` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R03` |
| S5 | `Fv03Pass` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R03` |
| S6 | `Fv03Pass` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R03` |
| S6 | `Fv03Pass` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R03` |
| S7 | `Fv03Pass` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R03` |
| S7 | `Fv03Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R03` |
| SH | `Fv03Pass` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R03` |
| SH | `Fv03Pass` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R03` |
| SR | `Fv03Pass` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R03` |
| SR | `Fv03Pass` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R03` |
| S0 | `Fv05AndFv06Pass` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04a` |
| S0 | `Fv05AndFv06Pass` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04a` |
| S1 | `Fv05AndFv06Pass` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04a` |
| S1 | `Fv05AndFv06Pass` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04a` |
| S2 | `Fv05AndFv06Pass` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04a` |
| S2 | `Fv05AndFv06Pass` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04a` |
| S3 | `Fv05AndFv06Pass` | `false` | `S3` | `SH` | `S3` | `SH` | `S3` | `SH` | `R04a` |
| S3 | `Fv05AndFv06Pass` | `true` | `S4` | `S4` | `S4` | `S4` | `S3` | `S4` | `R04a` |
| S4 | `Fv05AndFv06Pass` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04a` |
| S4 | `Fv05AndFv06Pass` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04a` |
| S5 | `Fv05AndFv06Pass` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04a` |
| S5 | `Fv05AndFv06Pass` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04a` |
| S6 | `Fv05AndFv06Pass` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04a` |
| S6 | `Fv05AndFv06Pass` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04a` |
| S7 | `Fv05AndFv06Pass` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04a` |
| S7 | `Fv05AndFv06Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04a` |
| SH | `Fv05AndFv06Pass` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04a` |
| SH | `Fv05AndFv06Pass` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04a` |
| SR | `Fv05AndFv06Pass` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04a` |
| SR | `Fv05AndFv06Pass` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04a` |
| S0 | `Fv07Pass` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04b` |
| S0 | `Fv07Pass` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04b` |
| S1 | `Fv07Pass` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04b` |
| S1 | `Fv07Pass` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04b` |
| S2 | `Fv07Pass` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04b` |
| S2 | `Fv07Pass` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04b` |
| S3 | `Fv07Pass` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04b` |
| S3 | `Fv07Pass` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04b` |
| S4 | `Fv07Pass` | `false` | `SX` | `SX` | `S4` | `SX` | `S4` | `SX` | `R04b` |
| S5 | `Fv07Pass` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04b` |
| S5 | `Fv07Pass` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04b` |
| S6 | `Fv07Pass` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04b` |
| S6 | `Fv07Pass` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04b` |
| S7 | `Fv07Pass` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04b` |
| S7 | `Fv07Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04b` |
| SH | `Fv07Pass` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04b` |
| SH | `Fv07Pass` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04b` |
| SR | `Fv07Pass` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04b` |
| SR | `Fv07Pass` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04b` |
| S0 | `Fv08Pass` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04c` |
| S0 | `Fv08Pass` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04c` |
| S1 | `Fv08Pass` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04c` |
| S1 | `Fv08Pass` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04c` |
| S2 | `Fv08Pass` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04c` |
| S2 | `Fv08Pass` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04c` |
| S3 | `Fv08Pass` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04c` |
| S3 | `Fv08Pass` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04c` |
| S4 | `Fv08Pass` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04c` |
| S4 | `Fv08Pass` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04c` |
| S5 | `Fv08Pass` | `false` | `S5` | `S5` | `S5` | `SX` | `S5` | `S5` | `R04c` |
| S6 | `Fv08Pass` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04c` |
| S6 | `Fv08Pass` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R04c` |
| S7 | `Fv08Pass` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04c` |
| S7 | `Fv08Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04c` |
| SH | `Fv08Pass` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04c` |
| SH | `Fv08Pass` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04c` |
| SR | `Fv08Pass` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04c` |
| SR | `Fv08Pass` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04c` |
| S0 | `Fv10AndFv11Pass` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04d` |
| S0 | `Fv10AndFv11Pass` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R04d` |
| S1 | `Fv10AndFv11Pass` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04d` |
| S1 | `Fv10AndFv11Pass` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R04d` |
| S2 | `Fv10AndFv11Pass` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04d` |
| S2 | `Fv10AndFv11Pass` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R04d` |
| S3 | `Fv10AndFv11Pass` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04d` |
| S3 | `Fv10AndFv11Pass` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R04d` |
| S4 | `Fv10AndFv11Pass` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04d` |
| S4 | `Fv10AndFv11Pass` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R04d` |
| S5 | `Fv10AndFv11Pass` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04d` |
| S5 | `Fv10AndFv11Pass` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R04d` |
| S6 | `Fv10AndFv11Pass` | `false` | `S6` | `S7` | `S6` | `SX` | `S6` | `S6` | `R04d` |
| S6 | `Fv10AndFv11Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S6` | `S7` | `R04d` |
| S7 | `Fv10AndFv11Pass` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04d` |
| S7 | `Fv10AndFv11Pass` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R04d` |
| SH | `Fv10AndFv11Pass` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04d` |
| SH | `Fv10AndFv11Pass` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R04d` |
| SR | `Fv10AndFv11Pass` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04d` |
| SR | `Fv10AndFv11Pass` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R04d` |
| S0 | `Handoff` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R12` |
| S0 | `Handoff` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R12` |
| S1 | `Handoff` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R12` |
| S1 | `Handoff` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R12` |
| S2 | `Handoff` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R12` |
| S2 | `Handoff` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R12` |
| S3 | `Handoff` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R12` |
| S3 | `Handoff` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R12` |
| S4 | `Handoff` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R12` |
| S4 | `Handoff` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R12` |
| S5 | `Handoff` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R12` |
| S5 | `Handoff` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R12` |
| S6 | `Handoff` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R12` |
| S6 | `Handoff` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R12` |
| S7 | `Handoff` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R12` |
| S7 | `Handoff` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R12` |
| SH | `Handoff` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R12` |
| SH | `Handoff` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R12` |
| SR | `Handoff` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R12` |
| SR | `Handoff` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R12` |
| S0 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R09` |
| S0 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R09` |
| S1 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R09` |
| S1 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R09` |
| S2 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R09` |
| S2 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R09` |
| S3 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R09` |
| S3 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R09` |
| S4 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R09` |
| S4 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R09` |
| S5 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R09` |
| S5 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R09` |
| S6 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R09` |
| S6 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R09` |
| S7 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R09` |
| S7 | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R09` |
| SR | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R09` |
| SR | `HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R09` |
| S0 | `IncidentOnlyOutput` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R12` |
| S0 | `IncidentOnlyOutput` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R12` |
| S1 | `IncidentOnlyOutput` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R12` |
| S1 | `IncidentOnlyOutput` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R12` |
| S2 | `IncidentOnlyOutput` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R12` |
| S2 | `IncidentOnlyOutput` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R12` |
| S3 | `IncidentOnlyOutput` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R12` |
| S3 | `IncidentOnlyOutput` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R12` |
| S4 | `IncidentOnlyOutput` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R12` |
| S4 | `IncidentOnlyOutput` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R12` |
| S5 | `IncidentOnlyOutput` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R12` |
| S5 | `IncidentOnlyOutput` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R12` |
| S6 | `IncidentOnlyOutput` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R12` |
| S6 | `IncidentOnlyOutput` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R12` |
| S7 | `IncidentOnlyOutput` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R12` |
| S7 | `IncidentOnlyOutput` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R12` |
| SH | `IncidentOnlyOutput` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R12` |
| SH | `IncidentOnlyOutput` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R12` |
| SR | `IncidentOnlyOutput` | `false` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R12` |
| SR | `IncidentOnlyOutput` | `true` | `SR` | `SR` | `SR` | `SR` | `SR` | `SX` | `R12` |
| S0 | `ProvenanceClassification` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R03a` |
| S0 | `ProvenanceClassification` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R03a` |
| S1 | `ProvenanceClassification` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R03a` |
| S1 | `ProvenanceClassification` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R03a` |
| S2 | `ProvenanceClassification` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R03a` |
| S2 | `ProvenanceClassification` | `true` | `S3` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R03a` |
| S3 | `ProvenanceClassification` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R03a` |
| S3 | `ProvenanceClassification` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R03a` |
| S4 | `ProvenanceClassification` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R03a` |
| S4 | `ProvenanceClassification` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R03a` |
| S5 | `ProvenanceClassification` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R03a` |
| S5 | `ProvenanceClassification` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R03a` |
| S6 | `ProvenanceClassification` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R03a` |
| S6 | `ProvenanceClassification` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R03a` |
| S7 | `ProvenanceClassification` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R03a` |
| S7 | `ProvenanceClassification` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R03a` |
| SH | `ProvenanceClassification` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R03a` |
| SH | `ProvenanceClassification` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R03a` |
| SR | `ProvenanceClassification` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R03a` |
| SR | `ProvenanceClassification` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R03a` |
| S0 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S0` | `S0` | `S0` | `UNSUPPORTED` | `S0` | `SX` | `R10` |
| S0 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S0` | `S0` | `S0` | `UNSUPPORTED` | `S0` | `SX` | `R10` |
| S1 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S1` | `S1` | `S1` | `UNSUPPORTED` | `S1` | `SX` | `R10` |
| S1 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S1` | `S1` | `S1` | `UNSUPPORTED` | `S1` | `SX` | `R10` |
| S2 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S2` | `S2` | `S2` | `UNSUPPORTED` | `S2` | `SX` | `R10` |
| S2 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S2` | `S2` | `S2` | `UNSUPPORTED` | `S2` | `SX` | `R10` |
| S3 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S3` | `S3` | `S3` | `UNSUPPORTED` | `S3` | `SX` | `R10` |
| S3 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S3` | `S3` | `S3` | `UNSUPPORTED` | `S3` | `SX` | `R10` |
| S4 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S4` | `S4` | `S4` | `UNSUPPORTED` | `S4` | `SX` | `R10` |
| S4 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S4` | `S4` | `S4` | `UNSUPPORTED` | `S4` | `SX` | `R10` |
| S5 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S5` | `S5` | `S5` | `UNSUPPORTED` | `S5` | `SX` | `R10` |
| S5 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S5` | `S5` | `S5` | `UNSUPPORTED` | `S5` | `SX` | `R10` |
| S6 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S6` | `S6` | `S6` | `UNSUPPORTED` | `S6` | `SX` | `R10` |
| S6 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S6` | `S6` | `S6` | `UNSUPPORTED` | `S6` | `SX` | `R10` |
| S7 | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `S7` | `S7` | `S7` | `UNSUPPORTED` | `S7` | `SX` | `R10` |
| S7 | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `S7` | `S7` | `S7` | `UNSUPPORTED` | `S7` | `SX` | `R10` |
| SH | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `SH` | `SH` | `SH` | `UNSUPPORTED` | `SH` | `SX` | `R10` |
| SH | `ReadmissionBundleChangedAnchorDocumentRef` | `true` | `SH` | `SH` | `SH` | `UNSUPPORTED` | `SH` | `SX` | `R10` |
| SR | `ReadmissionBundleChangedAnchorDocumentRef` | `false` | `SR` | `S2` | `SR` | `UNSUPPORTED` | `S2` | `S2` | `R10` |
| S0 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R10` |
| S0 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R10` |
| S1 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R10` |
| S1 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R10` |
| S2 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R10` |
| S2 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R10` |
| S3 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R10` |
| S3 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R10` |
| S4 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R10` |
| S4 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R10` |
| S5 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R10` |
| S5 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R10` |
| S6 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R10` |
| S6 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R10` |
| S7 | `ReadmissionBundleChangedCarriedPayload` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R10` |
| S7 | `ReadmissionBundleChangedCarriedPayload` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R10` |
| SH | `ReadmissionBundleChangedCarriedPayload` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R10` |
| SH | `ReadmissionBundleChangedCarriedPayload` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R10` |
| SR | `ReadmissionBundleChangedCarriedPayload` | `false` | `SR` | `S2` | `SR` | `S2` | `S2` | `S2` | `R10` |
| S0 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R11` |
| S0 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R11` |
| S1 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R11` |
| S1 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R11` |
| S2 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R11` |
| S2 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R11` |
| S3 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R11` |
| S3 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R11` |
| S4 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R11` |
| S4 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R11` |
| S5 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R11` |
| S5 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R11` |
| S6 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R11` |
| S6 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R11` |
| S7 | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R11` |
| S7 | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R11` |
| SH | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R11` |
| SH | `ReadmissionBundleChangedPolicySnapshotId` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R11` |
| SR | `ReadmissionBundleChangedPolicySnapshotId` | `false` | `SR` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `S5` | `R11` |
| S0 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R11` |
| S0 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R11` |
| S1 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R11` |
| S1 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R11` |
| S2 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R11` |
| S2 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R11` |
| S3 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R11` |
| S3 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R11` |
| S4 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R11` |
| S4 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R11` |
| S5 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R11` |
| S5 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R11` |
| S6 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R11` |
| S6 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R11` |
| S7 | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R11` |
| S7 | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R11` |
| SH | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R11` |
| SH | `ReadmissionBundleChangedRehydrationClosureRef` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R11` |
| SR | `ReadmissionBundleChangedRehydrationClosureRef` | `false` | `SR` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `S5` | `R11` |
| S0 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R10` |
| S0 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S0` | `S0` | `S0` | `S0` | `S0` | `SX` | `R10` |
| S1 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R10` |
| S1 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S1` | `S1` | `S1` | `S1` | `S1` | `SX` | `R10` |
| S2 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R10` |
| S2 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S2` | `S2` | `S2` | `S2` | `S2` | `SX` | `R10` |
| S3 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R10` |
| S3 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S3` | `S3` | `S3` | `S3` | `S3` | `SX` | `R10` |
| S4 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R10` |
| S4 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S4` | `S4` | `S4` | `S4` | `S4` | `SX` | `R10` |
| S5 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R10` |
| S5 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S5` | `S5` | `S5` | `S5` | `S5` | `SX` | `R10` |
| S6 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R10` |
| S6 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S6` | `S6` | `S6` | `S6` | `S6` | `SX` | `R10` |
| S7 | `ReadmissionBundleChangedSourceControlBundles` | `false` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R10` |
| S7 | `ReadmissionBundleChangedSourceControlBundles` | `true` | `S7` | `S7` | `S7` | `S7` | `S7` | `SX` | `R10` |
| SH | `ReadmissionBundleChangedSourceControlBundles` | `false` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R10` |
| SH | `ReadmissionBundleChangedSourceControlBundles` | `true` | `SH` | `SH` | `SH` | `SH` | `SH` | `SX` | `R10` |
| SR | `ReadmissionBundleChangedSourceControlBundles` | `false` | `SR` | `S2` | `SR` | `S2` | `S2` | `S2` | `R10` |
| S0 | `ReadmissionReview` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R09a` |
| S0 | `ReadmissionReview` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R09a` |
| S1 | `ReadmissionReview` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R09a` |
| S1 | `ReadmissionReview` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R09a` |
| S2 | `ReadmissionReview` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R09a` |
| S2 | `ReadmissionReview` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R09a` |
| S3 | `ReadmissionReview` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R09a` |
| S3 | `ReadmissionReview` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R09a` |
| S4 | `ReadmissionReview` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R09a` |
| S4 | `ReadmissionReview` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R09a` |
| S5 | `ReadmissionReview` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R09a` |
| S5 | `ReadmissionReview` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R09a` |
| S6 | `ReadmissionReview` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R09a` |
| S6 | `ReadmissionReview` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R09a` |
| S7 | `ReadmissionReview` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R09a` |
| S7 | `ReadmissionReview` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R09a` |
| SH | `ReadmissionReview` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R09a` |
| SH | `ReadmissionReview` | `true` | `SR` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R09a` |
| SR | `ReadmissionReview` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R09a` |
| SR | `ReadmissionReview` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R09a` |
| S0 | `ReplayAdmissibleClosure` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04f` |
| S0 | `ReplayAdmissibleClosure` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04f` |
| S1 | `ReplayAdmissibleClosure` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04f` |
| S1 | `ReplayAdmissibleClosure` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04f` |
| S2 | `ReplayAdmissibleClosure` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04f` |
| S2 | `ReplayAdmissibleClosure` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04f` |
| S3 | `ReplayAdmissibleClosure` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04f` |
| S3 | `ReplayAdmissibleClosure` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04f` |
| S4 | `ReplayAdmissibleClosure` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04f` |
| S4 | `ReplayAdmissibleClosure` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04f` |
| S5 | `ReplayAdmissibleClosure` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04f` |
| S5 | `ReplayAdmissibleClosure` | `true` | `S8` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04f` |
| S6 | `ReplayAdmissibleClosure` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04f` |
| S6 | `ReplayAdmissibleClosure` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04f` |
| S7 | `ReplayAdmissibleClosure` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04f` |
| S7 | `ReplayAdmissibleClosure` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04f` |
| SH | `ReplayAdmissibleClosure` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04f` |
| SH | `ReplayAdmissibleClosure` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04f` |
| SR | `ReplayAdmissibleClosure` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04f` |
| SR | `ReplayAdmissibleClosure` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04f` |
| S0 | `ReplayReconstruction` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04c` |
| S0 | `ReplayReconstruction` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04c` |
| S1 | `ReplayReconstruction` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04c` |
| S1 | `ReplayReconstruction` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04c` |
| S2 | `ReplayReconstruction` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04c` |
| S2 | `ReplayReconstruction` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04c` |
| S3 | `ReplayReconstruction` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04c` |
| S3 | `ReplayReconstruction` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04c` |
| S4 | `ReplayReconstruction` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04c` |
| S4 | `ReplayReconstruction` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04c` |
| S5 | `ReplayReconstruction` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04c` |
| S5 | `ReplayReconstruction` | `true` | `S6` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04c` |
| S6 | `ReplayReconstruction` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04c` |
| S6 | `ReplayReconstruction` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04c` |
| S7 | `ReplayReconstruction` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04c` |
| S7 | `ReplayReconstruction` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04c` |
| SH | `ReplayReconstruction` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04c` |
| SH | `ReplayReconstruction` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04c` |
| SR | `ReplayReconstruction` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04c` |
| SR | `ReplayReconstruction` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04c` |
| S0 | `VerifiedRehydrationClosure` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04b` |
| S0 | `VerifiedRehydrationClosure` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R04b` |
| S1 | `VerifiedRehydrationClosure` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04b` |
| S1 | `VerifiedRehydrationClosure` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R04b` |
| S2 | `VerifiedRehydrationClosure` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04b` |
| S2 | `VerifiedRehydrationClosure` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R04b` |
| S3 | `VerifiedRehydrationClosure` | `false` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04b` |
| S3 | `VerifiedRehydrationClosure` | `true` | `S3` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R04b` |
| S4 | `VerifiedRehydrationClosure` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04b` |
| S4 | `VerifiedRehydrationClosure` | `true` | `S5` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R04b` |
| S5 | `VerifiedRehydrationClosure` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04b` |
| S5 | `VerifiedRehydrationClosure` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R04b` |
| S6 | `VerifiedRehydrationClosure` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04b` |
| S6 | `VerifiedRehydrationClosure` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R04b` |
| S7 | `VerifiedRehydrationClosure` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04b` |
| S7 | `VerifiedRehydrationClosure` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R04b` |
| SH | `VerifiedRehydrationClosure` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04b` |
| SH | `VerifiedRehydrationClosure` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R04b` |
| SR | `VerifiedRehydrationClosure` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04b` |
| SR | `VerifiedRehydrationClosure` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R04b` |
| S0 | `AntiRollbackFailure` | `false` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S0 | `AntiRollbackFailure` | `true` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S1 | `AntiRollbackFailure` | `false` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S1 | `AntiRollbackFailure` | `true` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S2 | `AntiRollbackFailure` | `false` | `S2` | `SX` | `SX` | `SX` | `S2` | `SX` | `R14` |
| S2 | `AntiRollbackFailure` | `true` | `S2` | `SX` | `SX` | `SX` | `S2` | `SX` | `R14` |
| S3 | `AntiRollbackFailure` | `false` | `S3` | `SX` | `SX` | `SX` | `S3` | `SX` | `R14` |
| S3 | `AntiRollbackFailure` | `true` | `S3` | `SX` | `SX` | `SX` | `S3` | `SX` | `R14` |
| S4 | `AntiRollbackFailure` | `false` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S4 | `AntiRollbackFailure` | `true` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S5 | `AntiRollbackFailure` | `false` | `SX` | `SX` | `SX` | `SX` | `S5` | `SX` | `R07` |
| S5 | `AntiRollbackFailure` | `true` | `SX` | `SX` | `SX` | `SX` | `S5` | `SX` | `R07` |
| S6 | `AntiRollbackFailure` | `false` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S6 | `AntiRollbackFailure` | `true` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S7 | `AntiRollbackFailure` | `false` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S7 | `AntiRollbackFailure` | `true` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S8 | `AntiRollbackFailure` | `false` | `S8` | `S8` | `S8` | `SX` | `S8` | `SX` | `R14` |
| S8 | `AntiRollbackFailure` | `true` | `S8` | `S8` | `S8` | `SX` | `S8` | `SX` | `R14` |
| SH | `AntiRollbackFailure` | `false` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SH | `AntiRollbackFailure` | `true` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SR | `AntiRollbackFailure` | `false` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |
| SR | `AntiRollbackFailure` | `true` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |
| S0 | `ChainBreak` | `false` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S0 | `ChainBreak` | `true` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S1 | `ChainBreak` | `false` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S1 | `ChainBreak` | `true` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S2 | `ChainBreak` | `false` | `S2` | `SX` | `SX` | `SX` | `S2` | `SX` | `R14` |
| S2 | `ChainBreak` | `true` | `S2` | `SX` | `SX` | `SX` | `S2` | `SX` | `R14` |
| S3 | `ChainBreak` | `false` | `SX` | `SX` | `SX` | `SX` | `S3` | `SX` | `R08` |
| S3 | `ChainBreak` | `true` | `SX` | `SX` | `SX` | `SX` | `S3` | `SX` | `R08` |
| S4 | `ChainBreak` | `false` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S4 | `ChainBreak` | `true` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S5 | `ChainBreak` | `false` | `S5` | `SX` | `SX` | `SX` | `S5` | `SX` | `R14` |
| S5 | `ChainBreak` | `true` | `S5` | `SX` | `SX` | `SX` | `S5` | `SX` | `R14` |
| S6 | `ChainBreak` | `false` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S6 | `ChainBreak` | `true` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S7 | `ChainBreak` | `false` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S7 | `ChainBreak` | `true` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S8 | `ChainBreak` | `false` | `S8` | `S8` | `S8` | `SX` | `S8` | `SX` | `R14` |
| S8 | `ChainBreak` | `true` | `S8` | `S8` | `S8` | `SX` | `S8` | `SX` | `R14` |
| SH | `ChainBreak` | `false` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SH | `ChainBreak` | `true` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SR | `ChainBreak` | `false` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |
| SR | `ChainBreak` | `true` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |
| S0 | `RemediableFailureOfFv06OrFv12` | `false` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R14` |
| S0 | `RemediableFailureOfFv06OrFv12` | `true` | `S0` | `S0` | `UNSUPPORTED` | `UNSUPPORTED` | `S0` | `SX` | `R14` |
| S1 | `RemediableFailureOfFv06OrFv12` | `false` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R14` |
| S1 | `RemediableFailureOfFv06OrFv12` | `true` | `S1` | `S1` | `UNSUPPORTED` | `UNSUPPORTED` | `S1` | `SX` | `R14` |
| S2 | `RemediableFailureOfFv06OrFv12` | `false` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R14` |
| S2 | `RemediableFailureOfFv06OrFv12` | `true` | `S2` | `S2` | `UNSUPPORTED` | `UNSUPPORTED` | `S2` | `SX` | `R14` |
| S3 | `RemediableFailureOfFv06OrFv12` | `false` | `SH` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R09a` |
| S3 | `RemediableFailureOfFv06OrFv12` | `true` | `SH` | `S3` | `UNSUPPORTED` | `UNSUPPORTED` | `S3` | `SX` | `R09a` |
| S4 | `RemediableFailureOfFv06OrFv12` | `false` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R14` |
| S4 | `RemediableFailureOfFv06OrFv12` | `true` | `S4` | `S4` | `UNSUPPORTED` | `UNSUPPORTED` | `S4` | `SX` | `R14` |
| S5 | `RemediableFailureOfFv06OrFv12` | `false` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R14` |
| S5 | `RemediableFailureOfFv06OrFv12` | `true` | `S5` | `S5` | `UNSUPPORTED` | `UNSUPPORTED` | `S5` | `SX` | `R14` |
| S6 | `RemediableFailureOfFv06OrFv12` | `false` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R14` |
| S6 | `RemediableFailureOfFv06OrFv12` | `true` | `S6` | `S6` | `UNSUPPORTED` | `UNSUPPORTED` | `S6` | `SX` | `R14` |
| S7 | `RemediableFailureOfFv06OrFv12` | `false` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R14` |
| S7 | `RemediableFailureOfFv06OrFv12` | `true` | `S7` | `S7` | `UNSUPPORTED` | `UNSUPPORTED` | `S7` | `SX` | `R14` |
| SH | `RemediableFailureOfFv06OrFv12` | `false` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R09a` |
| SH | `RemediableFailureOfFv06OrFv12` | `true` | `SH` | `SH` | `UNSUPPORTED` | `UNSUPPORTED` | `SH` | `SX` | `R09a` |
| SR | `RemediableFailureOfFv06OrFv12` | `false` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R14` |
| SR | `RemediableFailureOfFv06OrFv12` | `true` | `SR` | `SR` | `UNSUPPORTED` | `UNSUPPORTED` | `SR` | `SX` | `R14` |
| S0 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S0 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S1 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S1 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S2 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `SX` | `SX` | `SX` | `SX` | `S2` | `SX` | `R04` |
| S2 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `SX` | `SX` | `SX` | `SX` | `S2` | `SX` | `R04` |
| S3 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S3` | `SX` | `SX` | `SX` | `S3` | `SX` | `R14` |
| S3 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S3` | `SX` | `SX` | `SX` | `S3` | `SX` | `R14` |
| S4 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S4 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S5 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S5` | `SX` | `SX` | `SX` | `S5` | `SX` | `R14` |
| S5 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S5` | `SX` | `SX` | `SX` | `S5` | `SX` | `R14` |
| S6 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S6 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S7 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S7 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S8 | `UnlabeledMechanismLevelCarriedClaim` | `false` | `S8` | `S8` | `S8` | `SX` | `S8` | `S8` | `R14` |
| S8 | `UnlabeledMechanismLevelCarriedClaim` | `true` | `S8` | `S8` | `S8` | `SX` | `S8` | `S8` | `R14` |
| SH | `UnlabeledMechanismLevelCarriedClaim` | `false` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SH | `UnlabeledMechanismLevelCarriedClaim` | `true` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SR | `UnlabeledMechanismLevelCarriedClaim` | `false` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |
| SR | `UnlabeledMechanismLevelCarriedClaim` | `true` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |
| S0 | `UntrustedAnchorPromoted` | `false` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S0 | `UntrustedAnchorPromoted` | `true` | `S0` | `SX` | `SX` | `SX` | `S0` | `SX` | `R14` |
| S1 | `UntrustedAnchorPromoted` | `false` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S1 | `UntrustedAnchorPromoted` | `true` | `S1` | `SX` | `SX` | `SX` | `S1` | `SX` | `R14` |
| S2 | `UntrustedAnchorPromoted` | `false` | `S2` | `SX` | `SX` | `SX` | `S2` | `SX` | `R14` |
| S2 | `UntrustedAnchorPromoted` | `true` | `S2` | `SX` | `SX` | `SX` | `S2` | `SX` | `R14` |
| S3 | `UntrustedAnchorPromoted` | `false` | `SX` | `SX` | `SX` | `SX` | `S3` | `SX` | `R08` |
| S3 | `UntrustedAnchorPromoted` | `true` | `SX` | `SX` | `SX` | `SX` | `S3` | `SX` | `R08` |
| S4 | `UntrustedAnchorPromoted` | `false` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S4 | `UntrustedAnchorPromoted` | `true` | `S4` | `SX` | `SX` | `SX` | `S4` | `SX` | `R14` |
| S5 | `UntrustedAnchorPromoted` | `false` | `S5` | `SX` | `SX` | `SX` | `S5` | `SX` | `R14` |
| S5 | `UntrustedAnchorPromoted` | `true` | `S5` | `SX` | `SX` | `SX` | `S5` | `SX` | `R14` |
| S6 | `UntrustedAnchorPromoted` | `false` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S6 | `UntrustedAnchorPromoted` | `true` | `S6` | `SX` | `SX` | `SX` | `S6` | `SX` | `R14` |
| S7 | `UntrustedAnchorPromoted` | `false` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S7 | `UntrustedAnchorPromoted` | `true` | `S7` | `SX` | `SX` | `SX` | `S7` | `SX` | `R14` |
| S8 | `UntrustedAnchorPromoted` | `false` | `S8` | `S8` | `S8` | `SX` | `S8` | `SX` | `R14` |
| S8 | `UntrustedAnchorPromoted` | `true` | `S8` | `S8` | `S8` | `SX` | `S8` | `SX` | `R14` |
| SH | `UntrustedAnchorPromoted` | `false` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SH | `UntrustedAnchorPromoted` | `true` | `SH` | `SX` | `SX` | `SX` | `SH` | `SX` | `R14` |
| SR | `UntrustedAnchorPromoted` | `false` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |
| SR | `UntrustedAnchorPromoted` | `true` | `SR` | `SX` | `SX` | `SX` | `SR` | `SX` | `R14` |

In this NNT comparison run, the C baseline returned `UNSUPPORTED` for `AcceptedHeadFreshnessLock`, `Admission`, `BoundaryScreening`, `EmitFamilyVerdict`, `FamilyReportAssembly`, `ProvenanceClassification`, `ReadmissionBundleChangedAnchorDocumentRef`, `ReadmissionBundleChangedPolicySnapshotId`, `ReadmissionBundleChangedRehydrationClosureRef`, `ReadmissionReview`, `RemediableFailureOfFv06OrFv12`, `ReplayAdmissibleClosure`, `ReplayReconstruction`, and `VerifiedRehydrationClosure`. The Rust baseline returned `UNSUPPORTED` for `AcceptedHeadFreshnessLock`, `Admission`, `BoundaryScreening`, `EmitFamilyVerdict`, `FamilyReportAssembly`, `ProvenanceClassification`, `ReadmissionBundleChangedPolicySnapshotId`, `ReadmissionBundleChangedRehydrationClosureRef`, `ReadmissionReview`, `RemediableFailureOfFv06OrFv12`, `ReplayAdmissibleClosure`, `ReplayReconstruction`, and `VerifiedRehydrationClosure`. Other displayed values are the results returned by those NNT baseline interfaces, including their fallback behavior where applicable. Differences are reported descriptively; no baseline result is treated as an oracle.

## Files

| Paradigm or role | Files | Purpose |
|---|---|---|
| Common Lisp | `LISP/family_workflow.lisp`, `LISP/lisp_792.txt`, `LISP/spec_792.txt` | Projection and captured output; `spec_792.txt` is the reference vector. |
| Brainfuck | `BF/gen_bf.py`, `BF/baseline.bf`, `BF/bf.c`, `BF/run_bf.py`, `BF/bf_792.txt`, `BF/surface_probes.txt` | Program generator, Brainfuck program, C execution harness, captured vector, and Part C probes. |
| Spreadsheet formulas | `SSCAR_excel_derivation.xlsx` | `Sweep`, `PT`, `Vocab`, `Evidence`, `ObjectValues`, `GateSurface`, `EvidenceSurface`, `ProducerSurface`, `Classifications`, `Disposition`, and `FixtureCalc` sheets. |
| Analytical Engine-style | `AE/family_ae_sweep.py`, `AE/ae_792.txt` | Card program driver and captured output. |
| AWK | `AWK/family_projection.py`, `AWK/baseline.awk`, `AWK/component_pipeline.awk`, `AWK/test_fixtures.awk`, `AWK/ct_oracles.awk`, `AWK/run_pts.awk`, `AWK/run_connectors.awk`, `AWK/awk_792.txt`, `AWK/pt_run_log.txt`, `AWK/connector_run_log.txt` | Projection, component field producers, CT §6 fixture records, the CT §7 oracle table, suite and connector runners, and captured outputs. |
| Comparator | `Comparators/rust_sweep.rs`, `Comparators/rust_792.txt` | Separate Rust comparison rendering. |
| Projection rules | `SOURCE_RULES.md` | Projection boundary, declared tuple labels, rule traces, and separate verdict surface. |
| Integrity | `verify_anchor.py`, `SSCAR_Family_Supplement_Manifest.json` | Package verifier and inventory/anchor Manifest; the supplement Manifest excludes itself. |

The historical framing spans the Analytical Engine design described in 1843
and Rust's public announcement in 2010: 167 years between designs represented
by contemporary renderings. Lisp (1958), rendered here in its Common Lisp
dialect (standardized by ANSI in 1994), and Brainfuck (1993) supply additional
points in that comparison. It does not imply that the Analytical Engine itself
was built or executed in the nineteenth century.

## Reproduce

Run commands from the supplement root unless a command changes directory. The target toolchain should be installed and available to the process.

```text
sbcl --script LISP/family_workflow.lisp > LISP/lisp_792.txt
python AWK/family_projection.py --vector LISP/spec_792.txt
rustc -O Comparators/rust_sweep.rs -o Comparators/rust_sweep.exe
Comparators/rust_sweep.exe > Comparators/rust_792.txt
```

For Brainfuck, set `GCC_CMD` to the native GCC executable for the current machine, then run `python BF/run_bf.py` from the supplement root. For the Analytical Engine-style program, place the documented `py-ae` directory at `AE/py-ae`; the driver adds that directory to its import path and writes `AE/ae_792.txt` with LF line endings. Run `python AE/family_ae_sweep.py`.

For AWK Part A, run from `AWK` with `MODE=sweep`: `gawk -v MODE=sweep -v BINMODE=3 -f baseline.awk > awk_792.txt`. For the public suite and Annex C runner, set the process environment variable `AWK_CMD` to the GNU Awk executable plus `-v BINMODE=3`, then run `gawk -v BINMODE=3 -f run_pts.awk > pt_run_log.txt` and `gawk -v BINMODE=3 -f run_connectors.awk > connector_run_log.txt` from `AWK`. The runners load CT §6 fixture records from `test_fixtures.awk`, load the CT §7 verdict-set oracle from `ct_oracles.awk`, pass fixture inputs to component producers and family integration, and evaluate the assertions. AWK Part C probes are available through `MODE=state`, `MODE=field`, and `MODE=verdict`.

The Brainfuck input records are `n` + one state code + one trigger code + `p`/`f` + `-`; the ordered state and trigger codes are documented in `BF/gen_bf.py`. Part C state, verdict, and evidence probes are listed in `BF/surface_probes.txt`.

The workbook contains formulas for the `Sweep` projection, fixture evaluation on `FixtureCalc`, and public `PT` records; the latter calculate independently of AWK. The workbook was recalculated and saved in native Microsoft Excel 16.0 (`AppVersion 16.0300`) with `CalculateFullRebuild`.

## Integrity and family package anchor

`SSCAR_Family_Supplement_Manifest.json` records the SHA-256 of the canonical family package Manifest and the SHA-256 and byte length of every other supplement file. It is anchored to `SSCAR_Family_Manifest.sha256`, whose SHA-256 is `33ae0304298fe8891231455741dc512404cef9406e0f1c2ed5499945a3b497f5`. The supplement Manifest excludes itself to avoid a self-reference.

Before generating new outputs in this directory, verify the canonical family package Manifest and complete supplement inventory with:

```text
python verify_anchor.py PATH_TO/SSCAR_Family_Manifest.sha256
```

The verifier prints the supplement Manifest's own SHA-256. Verification of files inside the family package remains governed by its own `verify.md` procedure.

## Rights and use

All rights reserved. You may download, inspect and run these files to
reproduce the reported results. They are provided as is, without warranty,
and are run at your own risk. No other right is granted.
