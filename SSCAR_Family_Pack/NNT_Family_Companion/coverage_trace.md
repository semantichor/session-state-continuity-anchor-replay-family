# NNT — Coverage trace for FAM-SSCAR-FI-001

> Observational only. This report records the buyer-facing claim surface and the partition of conformance tests, both resolved against the pack's CANONICAL files through the harness's canonical-claim-surface pins and byte-verified at preflight.

## Buyer-contract claim surface (an automated step canonical verification)

- specification §"17.3 Stable semantic core": 6 structural properties pinned.
- specification §"14. Implementation Assumptions and Derived Obligations": 7 deployment-substrate obligations pinned.

## Conformance test partition (canonical: conformance_tests + family_connector_tests, derivation declared_sentence_two_suites)

- Integrator Public Test Suite (`PTS-*`) — total records: 28
- Runnable on projection surface: 19
- Parameterized: 2
- Declarative (release-acceptance gate, not locally runnable): 7
- Annex C Family Connector Test Suite (`CT-*`) — wiring tests: 14

SSCAR family conformance = convergence on BOTH the `PTS-*` suite and the Annex C `CT-*` suite, per the pinned canonical declaration. The two suites are reported separately in `aggregate_observations.md`.

## Canonical guarantees (verbatim, for trace reference)

1. Family verdict vocabulary and disclosure classes.
2. Contamination definition and fail-closed behavior.
3. Strict monotonic anchor requirement and accepted-head linkage.
4. Verified rehydration precedence over semantic replay.
5. Replay sufficiency and offline reconstructibility requirements.
6. Disclosure-class preservation and evidence closure.

## Canonical deployment obligations (verbatim, for trace reference)

1. Source continuity bundles must be coherent and exportable. The family integrator must consume only bundles with complete verdict semantics, minimum evidence, and policy references.
2. source\_id and prior-session relationship must be linkable. Family evidence therefore preserves prior\_session\_ref and boundary\_event\_id.
3. Canonical statement identity must be available. carried\_statement\_refs may not be replaced by irreducible free text.
4. An anchor document may contain mixed content. Boundary screening and role validation are mandatory before any family-level consumption.
5. Policy snapshots may evolve. Any policy drift triggers re-evaluation, and readmission does not inherit a prior verdict automatically.
6. Readmission is permitted only on new evidence or a new policy state, with a strictly increasing anchor\_update\_ref.
7. A deployment may be multi-model. Model change must be treated as a boundary event and may not rely on implicit semantic equivalence.

## Bidirectional trace — coarse keyword-overlap matching

Parsed **39 test records** across the 6-pack Family Pack's conformance suites (by namespace — PTS: 25, CT: 14). The tables below show coarse keyword-overlap matches (≥2 shared content tokens, length ≥ 5, common function words/verbs stripped) between the canonical guarantee surface verified at an automated step and each record's Kind/Purpose prose. A match is a candidate link, not a normative attestation.

### Forward — canonical guarantee → matched PT records

| Guarantee | # matched | Top PT IDs (overlap score) | Shared tokens (first 5) |
|---|---|---|---|
| Canonical #1 | 15 | CT-11 (4), CT-10 (3), CT-14 (3), PTS-007 (2), PTS-014 (2), CT-01 (2) | `classes`, `disclosure`, `family`, `verdict` |
| Canonical #2 | 4 | PTS-003 (2), CT-06 (2), CT-13 (2), CT-14 (2) | `contamination`, `fail-closed` |
| Canonical #3 | 2 | CT-04 (2), CT-10 (2) | `anchor`, `linkage` |
| Canonical #4 | 10 | CT-01 (3), CT-06 (3), CT-02 (2), CT-04 (2), CT-05 (2), CT-07 (2) | `rehydration`, `replay`, `semantic` |
| Canonical #5 | 4 | CT-12 (3), CT-07 (2), CT-11 (2), CT-14 (2) | `offline`, `reconstructibility`, `sufficiency` |
| Canonical #6 | 11 | PTS-014 (3), CT-05 (3), CT-07 (3), CT-14 (3), PTS-023 (2), PTS-016 (2) | `disclosure-class`, `evidence`, `preservation` |

### Reverse — PT record → matched guarantees

Each PT is matched against all canonical guarantees using the same coarse overlap rule. A PT with zero guarantee matches is observation that its specific surface is not directly mirrored in the buyer-facing claim text (e.g., evidence-bundle field PTs may share few content tokens with high-level guarantees because they exercise the schema, not the prose).

| PT ID | Kind | # matched | Top guarantee IDs (overlap score) |
|---|---|---|---|
| PTS-001 | unit / state-transition | 0 | (none) |
| PTS-002 | unit / state-transition | 0 | (none) |
| PTS-006 | unit / hold routing | 0 | (none) |
| PTS-007 | parameterized / reclassification | 1 | Canonical #1 (2) |
| PTS-008 | comparative / oracle | 0 | (none) |
| PTS-009 | unit / fail-closed override | 0 | (none) |
| PTS-010 | unit / non-initial override | 0 | (none) |
| PTS-012 | unit / recovery path | 0 | (none) |
| PTS-013 | unit / non-inheritance | 0 | (none) |
| PTS-017A | integration / conditional evidence | 0 | (none) |
| PTS-017B | integration / conditional evidence | 0 | (none) |
| PTS-017D | integration / conditional evidence | 0 | (none) |
| PTS-018 | integration / non-validator-producer | 0 | (none) |
| PTS-021 | unit / type-system fidelity | 0 | (none) |
| PTS-022 | comparative / oracle | 0 | (none) |
| PTS-024 | derivation-discipline | 0 | (none) |
| PTS-025 | integration / cross-derived evidence | 0 | (none) |
| PTS-026 | meta / projection-adequacy | 0 | (none) |
| PTS-004A | Contaminated-anchor bundle (FV-02 fail) | 0 | (none) |
| PTS-004B | Unlabeled-mechanism bundle (FV-03 contamination branch) | 0 | (none) |
| PTS-011 | Chain-break / untrusted-anchor at S3 | 0 | (none) |
| PTS-023 | Readmission bundle changing only policy/rehydration | 1 | Canonical #6 (2) |
| PTS-003 | If disclosure\_class\_entries non-empty AND closure otherwise valid → REPLAY\_ADMISSIBLE\_CONSTRAINED; else REPLAY\_ADMISSIBLE. Bounded envelope: disclosure\_class taxonomy (TRUE\_DEFECT / BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS / BOUNDED\_HANDOFF\_OBLIGATION). | 1 | Canonical #2 (2) |
| PTS-016 | All 15 mandatory FEV fields present at any positive family verdict emission | 1 | Canonical #6 (2) |
| PTS-014 | S8 and SX are terminal absent explicit reopen authority | 2 | Canonical #6 (3), Canonical #1 (2) |
| CT-01 | Kind | 2 | Canonical #4 (3), Canonical #1 (2) |
| CT-02 | Kind | 2 | Canonical #1 (2), Canonical #4 (2) |
| CT-03 | Kind | 1 | Canonical #1 (2) |
| CT-04 | Kind | 3 | Canonical #1 (2), Canonical #3 (2), Canonical #4 (2) |
| CT-05 | Kind | 3 | Canonical #6 (3), Canonical #1 (2), Canonical #4 (2) |
| CT-06 | Kind | 3 | Canonical #4 (3), Canonical #2 (2), Canonical #6 (2) |
| CT-07 | Kind | 4 | Canonical #6 (3), Canonical #1 (2), Canonical #4 (2), Canonical #5 (2) |
| CT-08 | Kind | 2 | Canonical #1 (2), Canonical #4 (2) |
| CT-09 | Kind | 2 | Canonical #1 (2), Canonical #4 (2) |
| CT-10 | Kind | 4 | Canonical #1 (3), Canonical #3 (2), Canonical #4 (2), Canonical #6 (2) |
| CT-11 | Kind | 3 | Canonical #1 (4), Canonical #5 (2), Canonical #6 (2) |
| CT-12 | Kind | 3 | Canonical #5 (3), Canonical #1 (2), Canonical #6 (2) |
| CT-13 | Kind | 3 | Canonical #1 (2), Canonical #2 (2), Canonical #6 (2) |
| CT-14 | FV-12 (re-entry envelope) | 5 | Canonical #1 (3), Canonical #6 (3), Canonical #2 (2), Canonical #4 (2), Canonical #5 (2) |

### Bidirectional coverage observation

- PT records with at least one guarantee match: **19 / 39**
- Canonical guarantees with at least one PT match: **6 / 6**

These are coarse-matcher counts, not normative coverage scores. A PT with no guarantee match may still be valid coverage (e.g., evidence-schema PTs that test fields rather than claims). A guarantee with no PT match may indicate the guarantee is exercised indirectly via composite PTs whose Purpose prose summarizes a transition rather than mentioning the guarantee's keywords.

Expected convergence frame: a buyer building from this pack alone, in idiomatically distinct paradigms, should produce implementations that converge on the agent-logic surface (the guarantees above) and diverge on the deployment-substrate surface (the artifacts above). See `aggregate_observations.md` for the observed per-PT convergence in this run.

