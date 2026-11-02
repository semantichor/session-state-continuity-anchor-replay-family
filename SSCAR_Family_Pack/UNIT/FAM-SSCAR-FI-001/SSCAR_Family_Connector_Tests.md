Annex C — Family Connector Test Suite

Session State Continuity \& Anchor Replay Family Integrator

Buyer-runnable cabling tests

# Document Information

| Field | Value |
| --- | --- |
| Document class | Annex — buyer-runnable cabling tests |
| Audience | Implementers integrating the family package |
| Language | English |
| Status | Execution-neutral; runnable on the implementer's own integration harness; binds to the family integrator public specification |
| Integrator | Session State Continuity \& Anchor Replay Family Integrator (FAM-SSCAR-FI-001), package version 1.1.0 |
| Family components covered | Audit Replay Agent (ARA); Boundary Defense Agent (BDA); Freshness Portability Agent (FPA); Truth Arbitration Agent (TAA); Verified Rehydration Agent (VRA) |
| Test count | 14 tests |
| Version date | 12 May 2026 |

# 1. Purpose and Use

This document contains the buyer-runnable cabling tests for the Session State Continuity \& Anchor Replay Family Integrator. Each test verifies one cabling property of the family integrator: how the family-level validators consume the canonical fields produced by the five family components, how the verdict composition over those validators behaves under correct and adversarial inputs, and which semantic collapses must remain forbidden.

The tests are execution-neutral. The input surface lists the artifacts the implementer must furnish; the execution surface lists the boundary at which the test runs; the assertion set lists the observable conditions that must hold; the pass condition is the aggregate; the forbidden semantic collapse states the failure mode that the implementation must not exhibit; the expected evidence lists the artifacts the implementation must produce.

These tests verify wiring; they do not revalidate the family integrator semantic core and do not replace the public test suite of the integrator. They are runnable against the implementer's own integration of the family package.

# 2. Test Catalogue

| Test ID | Title | Kind | Purpose summary |
| --- | --- | --- | --- |
| CT-01 | Family component set admission | identity | Confirm that all five family components are admitted with valid public specifications. |
| CT-02 | Unlabeled mechanism-level claim block | failure propagation | Detect a carried claim without tsa\_label or source\_class; expect contamination-fail-closed. |
| CT-03 | Anchor document trust-by-assertion rejection | failure propagation | Anchor introduced as trusted via an upstream assertion; the boundary must revalidate and block until closure. |
| CT-04 | Freshness strict-increase enforcement | failure propagation | Anchor stagnant or freshness regression; expect noncompliant-hold. |
| CT-05 | Accepted head / integrity-receipt linkage | snapshot coherence | accepted\_head\_digest must link to the latest valid integrity receipt record; mismatch yields replay-incomplete at the verdict-emission layer. |
| CT-06 | Verified rehydration closure with anti-rollback | snapshot coherence | Read-only startup, snapshot stability, anti-rollback, chain or signature checks, and policy prerequisites all pass for rehydration\_closure\_ref. |
| CT-07 | Replay reconstruction round-trip | round-trip | The replay, checkpoint, and rollback lineage must be complete for offline reconstruction. |
| CT-08 | Family verdict composition with full closure | verdict composition | All family validators pass; family\_validator\_outcomes is populated; report\_signature is produced; the family verdict is replay-admissible. |
| CT-09 | Cross-component contamination absence | failure propagation | Tool-state in the anchor payload or an unauthorized artifact is present; expect contamination-fail-closed with contaminating\_ref\_set populated. |
| CT-10 | Hold to readmission with anchor update | readmission | Hold case with new evidence, strict-increase anchor\_update\_ref, and valid hold\_exit\_refs; expect readmission-review; identical readmission is forbidden. |
| CT-11 | Disclosure class preservation | verdict composition | Gaps misclassified as defect (or vice versa) yield incident-only. |
| CT-12 | Evidence sufficiency for verdict emission | evidence sufficiency | No family verdict emission without family\_validator\_outcomes populated. |
| CT-13 | Explanatory-only to mechanism-level reclassification | identity / failure propagation | Reclassification of an explanatory-only payload must be explicit; implicit consumption yields fail-closed or local reclassification. |
| CT-14 | Readmission re-entry envelope | readmission / round-trip | Re-entry from the readmission-review state targets either the boundary-screened state or the rehydration-closed state; no third re-entry point is admitted. |

# 3. Test Records

Each record lists the test identifier, the kind, the input surface, the execution surface, the assertion set, the pass condition, the forbidden semantic collapse, and the expected evidence.

## CT-01 — Family component set admission

| Test ID | CT-01 |
| --- | --- |
| Kind | identity |
| Input surface | A component-set list of five entries: the audit replay component, the boundary defense component, the freshness portability component, the truth arbitration component, and the verified rehydration component. Each entry references the component's public specification identifier. |
| Execution surface | The family integrator intake boundary, between intake and source-coverage-admitted. |
| Assertion set | Assertion 1: the component-set list has exactly five entries. Assertion 2: the set of components is {audit replay, boundary defense, freshness portability, truth arbitration, verified rehydration}. Assertion 3: each component's public-specification reference is resolvable at evaluation time. Assertion 4: no component outside the five-component family pack is present. |
| Pass condition | All four assertions hold and the workflow advances from intake to source-coverage-admitted. |
| Forbidden semantic collapse | Local component validity does not imply family-pack completeness. Treating a partial component set as sufficient is forbidden. |
| Expected evidence | A family verdict identifier at intake, with the family validator outcome for FV-01 populated. The session identifier binding is optional. |

## CT-02 — Unlabeled mechanism-level claim block

| Test ID | CT-02 |
| --- | --- |
| Kind | failure propagation |
| Input surface | A carried claim record without tsa\_label or without source\_class. statement\_id is present. policy\_snapshot\_id is set. |
| Execution surface | The provenance classification boundary, between boundary-screened and provenance-classified. |
| Assertion set | Assertion 1: FV-03 detects the missing tsa\_label or source\_class. Assertion 2: the family verdict is contamination-fail-closed or replay-incomplete depending on the labeling defect class. Assertion 3: no replay admission token is emitted. Assertion 4: contamination\_flags is populated; blocked\_stage equals "provenance\_classification". Assertion 5: tsa\_refs / provenance\_refs records the inadmissible classification. |
| Pass condition | All five assertions hold and no advancement past provenance-classified occurs; the contamination incident notice is emitted. |
| Forbidden semantic collapse | Renaming the label to appear admissible while the value remains mechanism-level is forbidden. The label-bound equivalence rule must catch this case; implicit promotion is forbidden. |
| Expected evidence | Contamination incident notice with contamination\_flags / contaminating\_ref\_set; tsa\_refs / provenance\_refs entry that records the inadmissible classification. |

## CT-03 — Anchor document trust-by-assertion rejection

| Test ID | CT-03 |
| --- | --- |
| Kind | failure propagation |
| Input surface | An anchor document presented at the boundary together with an upstream assertion claiming the document is trusted. anchor\_document\_ref and anchor\_document\_digest are present. carried\_payload is also present. |
| Execution surface | The boundary screening transition, between source-coverage-admitted and boundary-screened. |
| Assertion set | Assertion 1: FV-02 marks the anchor as untrusted-until-verification regardless of the upstream assertion. Assertion 2: no advancement past boundary-screened occurs until FV-02 passes through its own validation chain. Assertion 3: the trust assertion is logged but does not influence the verdict. Assertion 4: if the upstream assertion were accepted, the family verdict would be contamination-fail-closed. |
| Pass condition | All four assertions hold and FV-02 emits its independent verification outcome irrespective of the upstream trust claim. |
| Forbidden semantic collapse | An untrusted-anchor-promoted defect class must not be silently absorbed. Trust-by-assertion equals contamination at the boundary; the "trust the source" bypass is forbidden. |
| Expected evidence | Boundary event evidence report with anchor references; anchor\_document\_digest / anchor\_document\_ref entry. Contamination flags if the assertion was acted upon. |

## CT-04 — Freshness strict-increase enforcement

| Test ID | CT-04 |
| --- | --- |
| Kind | failure propagation |
| Input surface | An anchor pair: freshness\_before, freshness\_after. Case A: freshness\_after equals freshness\_before (stagnant). Case B: freshness\_after is less than freshness\_before (regression). |
| Execution surface | The anchor lock transition, between provenance-classified and anchor-locked. |
| Assertion set | Assertion 1: FV-06 detects freshness\_after less than or equal to freshness\_before. Assertion 2: the family verdict is noncompliant-hold (the workflow enters the hold state). Assertion 3: the family hold record is emitted with hold\_enter\_refs populated. Assertion 4: pending\_requirements lists the strict-increase anchor\_update\_ref as the remediation. Assertion 5: no replay admission token is emitted. |
| Pass condition | All five assertions hold and the state transitions to the hold state, ready for readmission review. |
| Forbidden semantic collapse | A stagnant anchor must not be reclassified as transient. The freshness/anchor cluster signals must use the noncompliant-hold verdict specifically, not an incident. |
| Expected evidence | Family hold record with hold\_enter\_refs; freshness\_before / freshness\_after fields; hold\_enter\_refs evidence binding. |

## CT-05 — Accepted head / integrity-receipt linkage

| Test ID | CT-05 |
| --- | --- |
| Kind | snapshot coherence |
| Input surface | accepted\_head\_digest from the freshness component. linked\_irr\_digest from the freshness component. An independent integrity-receipt-chain reference for the latest valid integrity receipt record. |
| Execution surface | The anchor-locked state. |
| Assertion set | Assertion 1: accepted\_head\_digest is byte-identical to the value published by the freshness component. Assertion 2: linked\_irr\_digest references the latest valid integrity receipt record. Assertion 3: FV-05 passes when both above hold. Assertion 4: if the linkage is broken, the family verdict is replay-incomplete at the verdict-emission layer. Assertion 5 (cross-component identity): the integrity-receipt digest at the verified rehydration component equals linked\_irr\_digest at the freshness component for the same family event. |
| Pass condition | All five assertions hold for the well-formed case; assertion 4 holds for the broken-linkage case. |
| Forbidden semantic collapse | Linking accepted\_head\_digest to a stale or fabricated integrity receipt digest is forbidden. The verdict-emission layer must signal replay-incomplete; not an acceptable advancement. |
| Expected evidence | accepted\_head\_digest / linked\_irr\_digest entry. On failure: replay-incomplete verdict and a disclosure-class entry recording the broken linkage as a true defect on the integrity-receipt linkage. |

## CT-06 — Verified rehydration closure with anti-rollback

| Test ID | CT-06 |
| --- | --- |
| Kind | snapshot coherence |
| Input surface | A rehydration request with snapshot\_id, irr\_digest, validator\_bundle\_id, a read-only startup flag, anchor\_document\_ref, and policy\_snapshot\_id. An anti-rollback chain is attached. |
| Execution surface | The rehydration closure transition, between anchor-locked and rehydration-closed. |
| Assertion set | Assertion 1: read-only startup is verified (no write to persistent state during validation). Assertion 2: snapshot\_id is stable across the validation window (no mutation). Assertion 3: the anti-rollback chain is unbroken. Assertion 4: chain or signature checks pass. Assertion 5: policy\_snapshot\_id matches the policy in force at admission. Assertion 6: rehydration\_closure\_ref is emitted only when all five above hold; otherwise the verdict is contamination-fail-closed. |
| Pass condition | All six assertions hold for the well-formed case; the contamination-fail-closed verdict is observable for any anti-rollback failure or chain break. |
| Forbidden semantic collapse | Anti-rollback failure must not be reclassified as a recoverable hold. It is fail-closed by FV-07. Downgrading to noncompliant-hold when the chain is broken is forbidden. |
| Expected evidence | On pass: rehydration\_closure\_ref and irr\_digest. On failure: contamination\_flags and the contamination incident notice. |

## CT-07 — Replay reconstruction round-trip

| Test ID | CT-07 |
| --- | --- |
| Kind | round-trip |
| Input surface | An audit replay bundle with replay\_refs, checkpoint\_refs, rollback\_refs, and report\_id. Test variants: (a) complete chain; (b) missing intermediate checkpoint; (c) missing rollback reference. |
| Execution surface | The replay reconstruction transition, between rehydration-closed and replay-reconstructed. |
| Assertion set | Assertion 1: the complete chain reconstructs end-to-end without missing steps (the pass case). Assertion 2: any missing intermediate reference yields replay-incomplete at the verdict-emission layer. Assertion 3: the lineage-complete equivalence rule (chain plus ordering) holds. Assertion 4: report sufficiency: report\_id binds to the complete replay chain. Assertion 5: the projection layer signals via non-advancement past the replay-reconstructed state when reconstruction fails. |
| Pass condition | All five assertions hold for both well-formed and broken-chain cases. |
| Forbidden semantic collapse | Host timestamps must not substitute for replay, checkpoint, or rollback references. The "time-based equivalence" shortcut is forbidden. The verdict-emission layer must signal replay-incomplete. |
| Expected evidence | replay\_refs / checkpoint\_refs / rollback\_refs entry on pass. On failure: replay-incomplete verdict with a disclosure-class entry. |

## CT-08 — Family verdict composition with full closure

| Test ID | CT-08 |
| --- | --- |
| Kind | verdict composition |
| Input surface | A complete family bundle: all family validators pass; all evidence fields are populated as applicable. The boundary event evidence report is emitted. report\_signature and export\_manifest\_ref are present. |
| Execution surface | The verdict emission gate, between report-ready and replay-admitted. |
| Assertion set | Assertion 1: all twelve family validators report pass in family\_validator\_outcomes. Assertion 2: the boundary event evidence report is emitted with non-empty report\_id, carried\_statement\_refs, anchor references, freshness references, replay references, and disclosure\_class\_entries. Assertion 3: the family verdict is replay-admissible (or replay-admissible-constrained if bounded items are declared explicitly). Assertion 4: the family verdict carries family\_decision\_id, reason\_code, family\_validator\_refs, and family\_evidence\_refs. Assertion 5: the replay admission token is emitted with accepted\_head\_digest, linked\_irr\_digest, rehydration\_closure\_ref, and admission\_status. |
| Pass condition | All five assertions hold and the state advances to replay-admitted; the boundary event evidence is offline-reconstructible. |
| Forbidden semantic collapse | A single local component verdict being pass does not imply the family verdict. The family verdict is emergent and requires full composition. Shortcutting composition with a single-component pass is forbidden. |
| Expected evidence | The full evidence bundle: family verdict, boundary event evidence report, replay admission token, and the fifteen evidence fields populated as applicable plus report\_signature. |

## CT-09 — Cross-component contamination absence

| Test ID | CT-09 |
| --- | --- |
| Kind | failure propagation |
| Input surface | An anchor payload containing a tool-state object (a capability-bearing payload). No distinct operator approval is attached. |
| Execution surface | The boundary-screened state. |
| Assertion set | Assertion 1: the boundary defense component detects tool-state in the payload (tool\_state\_activation flag). Assertion 2: structural restoration of the tool-state does not grant execution authority. Assertion 3: the family verdict is contamination-fail-closed (FV-09 cross-domain). Assertion 4: the contamination incident notice is emitted with contaminating\_ref\_set and blocked\_stage populated. Assertion 5: no replay admission; no advancement to the rehydration-closed state. |
| Pass condition | All five assertions hold and the state transitions to contamination-fail-closed; no readmission is attempted on the same artifacts. |
| Forbidden semantic collapse | Tool-state present in a payload must not be treated as authority to act. Structural restoration is not an authority grant. |
| Expected evidence | Contamination incident notice with contamination\_flags / contaminating\_ref\_set; boundary event evidence report in the incident-only form. |

## CT-10 — Hold to readmission with anchor update

| Test ID | CT-10 |
| --- | --- |
| Kind | readmission |
| Input surface | A hold case in the noncompliant-hold state with a family hold record. A new evidence bundle, a new anchor\_update\_ref (strict-increase), and non-empty hold\_exit\_refs are presented as a readmission request through the family readmission review contract. |
| Execution surface | The hold-to-readmission-review transition. |
| Assertion set | Assertion 1: FV-12 verifies that hold\_exit\_refs is non-empty. Assertion 2: anchor\_update\_ref is strict-increase relative to the anchor at hold entry. Assertion 3: policy\_snapshot\_id stability is preserved across the hold-to-readmit transition. Assertion 4: the family verdict transitions to readmission-review; the state moves from the hold state to the readmission-review state. Assertion 5: an identical readmission attempt on the same artifacts is rejected. Assertion 6: the re-entry target obeys the envelope described in CT-14: boundary-screened if boundary fields were altered; rehydration-closed if rehydration fields were altered. |
| Pass condition | All six assertions hold and the readmission-review state is ready for another validation cycle; hold\_exit\_refs propagate to the family hold record. |
| Forbidden semantic collapse | Readmission is not a retry on the same artifacts; it requires materially new evidence and a monotonic anchor advancement. The identical-artifact retry loop is forbidden. |
| Expected evidence | Updated family hold record with hold\_exit\_refs; hold\_enter\_refs and hold\_exit\_refs entries; anchor\_update\_ref with strict-increase. |

## CT-11 — Disclosure class preservation

| Test ID | CT-11 |
| --- | --- |
| Kind | verdict composition |
| Input surface | A carried openness item present in the family event. Test variants: (a) the item is correctly classified as bounded execution-neutral openness in disclosure\_class\_entries; (b) the same item is misclassified as true defect; (c) a bounded handoff is misclassified as defect. |
| Execution surface | The report-ready state. |
| Assertion set | Assertion 1: in the well-formed case the family verdict is replay-admissible-constrained, with the bounded items explicitly preserved in disclosure\_class\_entries. Assertion 2: in the misclassified case the family verdict is incident-only (FV-10 fail). Assertion 3: the three classes true defect, bounded execution-neutral openness, and bounded handoff obligation never collapse into each other. Assertion 4: the boundary event evidence report preserves the class distinctness. Assertion 5: report\_signature reflects the disclosure-class set actually observed. |
| Pass condition | All five assertions hold and incident-only is the verdict when a collapse is detected. |
| Forbidden semantic collapse | Treating bounded openness as a true defect, or vice versa, destroys the reconstructibility of the boundary event. Editorial flattening of disclosure classes is forbidden. The verdict-emission layer must signal incident-only. |
| Expected evidence | disclosure\_class\_entries with distinct class labels; boundary event evidence report in the incident-only form on failure. |

## CT-12 — Evidence sufficiency for verdict emission

| Test ID | CT-12 |
| --- | --- |
| Kind | evidence sufficiency |
| Input surface | An attempt to emit a family verdict with an empty or partially populated family\_validator\_outcomes. |
| Execution surface | The verdict emission gate at the report-ready state. |
| Assertion set | Assertion 1: FV-11 detects empty family\_validator\_outcomes and blocks the emission. Assertion 2: FV-11 detects partial family\_validator\_outcomes (some validator outcomes missing) and yields incident-only. Assertion 3: no family verdict is emitted while family\_validator\_outcomes is incomplete (a hard observability rule). Assertion 4: in the well-formed case, family\_validator\_outcomes contains outcomes for every validator actually evaluated; the family verdict emission is allowed. Assertion 5: family\_evidence\_refs in the family verdict binds to a non-empty family\_validator\_outcomes. |
| Pass condition | All five assertions hold for both the well-formed and the incomplete cases. |
| Forbidden semantic collapse | Emitting a family verdict without populated family\_validator\_outcomes destroys offline reconstructibility. The validator outcome closure constraint and the family verdict observability rule are mandatory. |
| Expected evidence | family\_validator\_outcomes (complete); family verdict with family\_evidence\_refs; on failure: incident-only and a contamination incident notice. |

## CT-13 — Explanatory-only to mechanism-level reclassification

| Test ID | CT-13 |
| --- | --- |
| Kind | identity / failure propagation |
| Input surface | A carried payload classified as explanatory-only at admission. A downstream consumer attempts to use the payload at the mechanism level without an explicit reclassification step. |
| Execution surface | The transition between boundary-screened and provenance-classified. |
| Assertion set | Assertion 1: FV-04 detects mechanism-level consumption of an explanatory-only payload. Assertion 2: the family verdict is fail-closed or a local reclassification is triggered. Assertion 3: if reclassification is attempted, the reclassification step is logged explicitly (never implicit) and follows the declared reclassification policy. Assertion 4: the family flow blocks until closure (no advancement past provenance-classified without the reclassification finalized). Assertion 5: the bounded handoff envelope is respected: the reclassification policy may extend the deployment without breaking the semantic core. |
| Pass condition | All five assertions hold and reclassification, when applied, is observable and policy-bound. |
| Forbidden semantic collapse | Silently promoting an explanatory-only payload to mechanism-level without an explicit reclassification step destroys boundary discipline. Inferred role escalation is forbidden. |
| Expected evidence | carried\_statement\_refs and tsa\_refs (with the reclassification annotation); the contamination incident notice on failure. |

## CT-14 — Readmission re-entry envelope

| Test ID | CT-14 |
| --- | --- |
| Kind | readmission / round-trip |
| Input surface | Five readmission scenarios with altered field sets: (a) carried\_payload altered only; (b) anchor\_document\_ref altered only; (c) policy\_snapshot\_id altered only; (d) the component set altered only; (e) the rehydration bundle altered only. |
| Execution surface | The readmission-review state, on re-entry. |
| Assertion set | Assertion 1: cases (a), (b), (c), (d) re-enter at the boundary-screened state (boundary fields altered). Assertion 2: case (e) re-enters at the rehydration-closed state (rehydration fields altered). Assertion 3: no third re-entry point is invented (the implementation must not route to intake, provenance-classified, anchor-locked, replay-reconstructed, report-ready, or replay-admitted directly). Assertion 4: the re-entry target is deterministic given the altered-field set (no operator discretion). Assertion 5: the full validator chain replays from the re-entry point onward. |
| Pass condition | All five assertions hold for all five readmission scenarios. |
| Forbidden semantic collapse | Routing readmission to an intermediate state outside the admitted set of two re-entry points bypasses validator chain integrity. Operator-decided re-entry is forbidden. The re-entry envelope is hard. |
| Expected evidence | Updated family hold record and hold\_enter\_refs / hold\_exit\_refs entries; replay continuity preserved from the re-entry point. |

# 4. Coverage Map

The link between each test, the family validator exercised, the family decision object verified, the tokens consumed, and the producer-consumer row that the test covers.

| Test | Family validator exercised | Family decision object | Tokens exercised | Producer-consumer matrix row |
| --- | --- | --- | --- | --- |
| CT-01 | FV-01 | Session replay admissibility (intake) | session\_id; prior\_session\_ref | Row 1 |
| CT-02 | FV-03 and FV-09 | Carried claim set admissibility | tsa\_label; source\_class; policy\_snapshot\_id; statement\_id; contaminating\_ref\_set | Rows 3 and 9 |
| CT-03 | FV-02 | Anchor document boundary admissibility | anchor\_document\_ref; anchor\_document\_digest | Row 2 |
| CT-04 | FV-06 | Accepted anchor state | freshness\_before; freshness\_after; anchor\_update\_ref | Row 6 |
| CT-05 | FV-05 | Accepted anchor state | accepted\_head\_digest; linked\_irr\_digest; irr\_digest | Row 5 |
| CT-06 | FV-07 | Verified rehydration closure | rehydration\_closure\_ref; snapshot\_id; irr\_digest; policy\_snapshot\_id | Row 7 |
| CT-07 | FV-08 | Replay continuity bundle | replay\_refs; checkpoint\_refs; rollback\_refs | Row 8 |
| CT-08 | FV-11 with cross-validator composition | Session replay admissibility (full) | family\_decision\_id; boundary\_event\_id; family\_validator\_outcomes; report\_signature | Row 11 and the composition gate |
| CT-09 | FV-09 | Contamination case | contaminating\_ref\_set; tool\_state\_activation flag | Row 9 |
| CT-10 | FV-12 | Session replay admissibility (readmission) | hold\_enter\_refs; hold\_exit\_refs; anchor\_update\_ref; policy\_snapshot\_id | Row 12 |
| CT-11 | FV-10 | Continuity disclosure class | disclosure\_class\_entries | Row 10 |
| CT-12 | FV-11 with observability rule | Session replay admissibility (evidence gate) | family\_validator\_outcomes; family\_evidence\_refs | Row 11 |
| CT-13 | FV-04 | Carried claim set admissibility (reclassification branch) | tsa\_label; boundary\_validated\_role | Row 4 |
| CT-14 | FV-12 (re-entry envelope) | Session replay admissibility (readmission routing) | hold\_exit\_refs; anchor\_update\_ref; altered-field set | Row 12 and the workflow transitions |

# 5. Failure and Readmission Coverage

The connector test suite covers failure propagation, hold and readmission, and evidence sufficiency. Fail-closed and hold semantics are not relaxed at any point in the suite.

- CT-02, CT-03, CT-09 cover failure propagation on the contamination branch (FV-02, FV-03, FV-09 leading to contamination-fail-closed).
- CT-04 covers failure propagation on the freshness/anchor branch (FV-06 leading to noncompliant-hold).
- CT-05, CT-06, CT-07 cover failure propagation on the snapshot/replay branch (FV-05, FV-07, FV-08 leading to contamination-fail-closed or replay-incomplete).
- CT-10 and CT-14 cover readmission (FV-12 and the re-entry envelope).
- CT-11 and CT-12 cover evidence insufficiency (FV-10 disclosure class, FV-11 evidence closure, and the verdict observability rule).
- CT-13 covers the boundary reclassification branch (FV-04).
- No test downgrades fail-closed to transient: anti-rollback failure (CT-06), tool-state in the payload (CT-09), and an unlabeled mechanism claim (CT-02) remain contamination-fail-closed.
- No test downgrades hold to admit without a strict-increase anchor\_update\_ref (CT-10 enforcement). Identical readmission is forbidden.

# 6. Reuse Note

| Field | Value |
| --- | --- |
| Status | Active; companion to the family integrator public specification |
| Objective | Provide a buyer-runnable cabling test suite for the family integrator producer-consumer wiring |
| Reusable elements | Test catalogue; test records; coverage map; failure and readmission coverage |
| Reuse conditions | Reuse is permitted only with explicit preservation of input surfaces, execution surfaces, assertion sets, pass conditions, forbidden semantic collapses, and expected evidence. |
| Open items for implementation | Concrete cryptographic suite; storage backend; operator workflow; verdict-emission-layer implementation; harness selection. |
| Boundary with the public test suite | These tests verify cabling between components and the family integrator. They do not revalidate the family integrator semantic core and do not replace the public test suite of the integrator. |

*Annex C — Family Connector Test Suite — Session State Continuity \& Anchor Replay Family Integrator*
