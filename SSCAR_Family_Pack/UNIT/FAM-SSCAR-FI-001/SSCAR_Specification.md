Session State Continuity \& Anchor Replay Family Integrator

Public Release v1.1.0 · buyer-facing, standalone, execution-neutral specification

This specification defines a family integrator that determines whether an inter-session continuity event is admissible for semantic replay and verified rehydration. It is a standalone public specification: the normative rules, decision semantics, validation logic, workflow, and evidence requirements are fully stated here and do not depend on undisclosed artifacts.

| Field | Normative content |
| --- | --- |
| Integrator ID | FAM-SSCAR-FI-001 |
| Display name | Session State Continuity \& Anchor Replay Family Integrator |
| Integrator class | Normative-critical family integrator |
| Target unit | Family integrator, not a component agent |
| Primary role | Govern cross-session epistemic continuity across LLM sessions, including transitions between different LLM models, with an admissibility verdict for replay, preservation of intentional gaps, and an offline-reconstructible evidence chain for the boundary event. |
| Mission statement | Determine whether an LLM session transition can be reconstructed and semantically remounted without contamination and with offline-reconstructible continuity. |
| Operating mode | Full-closure mode. Semantic, temporal, failure, evidence, and handoff closure are mandatory. |
| Primary goals | Formal correctness; replay and reconstruction sufficiency; provenance cleanliness; anti-contamination; verified restoration; deployment handoff readiness. |
| Deployment posture | High-audit continuity environments with offline replay, cross-session handoff, and possible model change. |
| Stand-alone scope | This specification defines the family integrator only. It does not regenerate subordinate controls, does not assume undeclared sources, and does not permit contamination from unattached inputs. |
| Package version | 1.1.0 |

# 1. Operational Objective and Required Control Coverage

The family verdict is distinct from any local verdict. No single subordinate control decides family-level replay admissibility on its own; the family verdict emerges only after cross-domain closure between provenance, boundary validation, freshness, verified rehydration, replay reconstruction, and evidence assembly.

## 1.1 Criticality

A failure in this integrator invalidates continuity admissibility, anti-replay protection, provenance closure, verified rehydration, boundary cleanliness, and boundary-event audit reconstruction.

## 1.2 Family boundary

The family boundary is the intersection of four fronts: carried-artifact ingress screening across the session boundary; accepted-head and freshness-anchor eligibility; persistent-context restoration and read-only remount; and auditable replay with boundary-event evidence issuance.

## 1.3 Required control coverage

- Replay reconstruction and report sufficiency for offline reconstruction of the boundary event.
- Boundary-first ingress screening, contamination detection, and evidence-gated finalization.
- Strict freshness increase, IRR anchoring, continuity watermark compatibility, and readmission control.
- Carried-claim provenance admissibility, explicit labeling, and conflict closure.
- Read-only startup, snapshot stability, anti-rollback protection, and verified restore prerequisites.

## 1.4 Cross-domain operating rules

1. No carried claim may enter family gate logic unless it carries an admitted boundary\_validated\_role, tsa\_label, and source\_class, or an explicitly admitted equivalent.
2. Restore eligibility requires an accepted head linked to a valid IRR and a strictly increasing freshness anchor. An unanchored tail remains ineligible.
3. Every anchor document and continuity payload is treated as untrusted input at the continuity boundary and remains read-only until verification closes.
4. Verified rehydration is a precondition for admissible semantic replay. Replay may not proceed on superficial continuity alone.
5. A local replay success is insufficient. A positive family verdict requires continuity closure, provenance closure, and report closure across the full family boundary.
6. Contamination is cross-domain. It includes unlabeled claims, inadmissible provenance, a stale or non-monotonic anchor, an unanchored accepted head, unauthorized tool-state, or unverified persistent state that influences the family verdict.
7. The family integrator governs only the emergent family verdict and its closure. It does not assume local authorities or silently rewrite local decisions.
8. True defects, bounded execution-neutral openness, and bounded handoff obligations must remain explicitly distinguishable in evidence and reporting.
9. Any claim used for the family verdict must retain statement identity, provenance labeling, and policy-snapshot compatibility.
10. Ordering is determined by accepted-head sequence, IRR anchoring, hash continuity, anti-rollback, and policy-snapshot consistency; host-only timestamps are auxiliary only.
11. Each family verdict must produce a minimum evidence bundle sufficient for offline reconstruction of the boundary event.
12. Readmission is allowed only from a hold state and only on the basis of a new closure bundle or a new policy state with a strictly increasing anchor update.

# 2. Semantic Core, Authority, and Boundary Rules

| Field | Normative content |
| --- | --- |
| Family objective clause | Admissible epistemic continuity exists only when carried provenance, accepted head, verified rehydration, anti-replay, and replay reconstruction closure are all closed simultaneously. |
| Family boundary clause | carried payload + anchor document + accepted-head evidence + verified rehydration bundle + replay audit bundle |
| Primary decision objects | carried\_claim\_set\_admissibility; anchor\_document\_boundary\_admissibility; accepted\_anchor\_state; verified\_rehydration\_closure; replay\_continuity\_bundle; contamination\_case; continuity\_disclosure\_class; session\_replay\_admissibility |
| Primary outputs | session-replay-admissibility verdict; boundary event evidence report; readmission review result; contamination incident notice |
| Fail-closed invariant | No family replay is admissible when contamination exists, when replay is critically incomplete, when freshness is not strictly increasing, or when rehydration is not verified. |
| Jurisdiction | Boundary cleanliness; carried-claim provenance admissibility; accepted-head and anchor validation; verified rehydration closure; replay continuity and admissibility; boundary-event evidence reporting. |
| Non-jurisdiction | The integrator does not classify external truth, issue policy overrides, grant operator approval for tool-state, perform live restore, move continuity watermarks, or substitute local validators. |
| Authority source | Authority is expressed publicly as the criteria, limits, and rules stated in this specification. |
| Delegated scope | Compose local outcomes into a family verdict, validate cross-domain closure, block family replay, open hold and readmission review, and issue a boundary-event evidence report. |

Authority is finite and fail-closed. At unresolved prerequisite failure, policy drift, bundle incompatibility, or contamination, the integrator blocks any positive verdict and escalates according to the workflow.

Escalation path: Family Integrator → NONCOMPLIANT\_HOLD or CONTAMINATION\_FAIL\_CLOSED → authorized external actor or new family closure bundle.

Authority exhaustion triggers include influential untrusted boundary payload, stale or non-monotonic anchor, anti-rollback failure, absent replay closure, disclosure-class collapse, and absent family-evidence closure.

Misuse boundary: the integrator does not validate the material truth of prior-session content, does not regenerate subordinate controls, does not execute restore, does not activate tool-state, and does not rewrite accepted history.

# 3. Input and Output Contracts

Exact field names may be adapted to a deployment format, but the operational meaning of every required field is fixed.

## 3.1 Input contract

**FIC-01 FamilyContinuityIntake —** 

**Required fields:** session\_id; prior\_session\_ref; carried\_payload; anchor\_document\_ref; source\_control\_bundles; policy\_snapshot\_id

**Boundary:** Family boundary

**Normative note:** Mandatory for any continuity evaluation.

**FIC-02 FamilyReplayRequest —** 

**Required fields:** session\_id; accepted\_head\_digest; anchor\_digest; replay\_scope; rehydration\_bundle\_ref

**Boundary:** Replay boundary

**Normative note:** Replay is not admissible without an accepted head and a verified rehydration bundle.

**FIC-03 FamilyReadmissionReview —** 

**Required fields:** hold\_case\_id; new\_evidence\_refs or new\_policy\_ref; anchor\_update\_ref; hold\_exit\_refs

**Boundary:** Hold / readmission boundary

**Normative note:** Identical readmission on the same artifacts is forbidden.

## 3.2 Output contract

**FOC-01 FamilyVerdict —** 

**Required fields:** family\_decision\_id; session\_id; family\_verdict; reason\_code; family\_validator\_refs; family\_evidence\_refs

**Target boundary:** Operator / execution layer

**FOC-02 BoundaryEventEvidenceReport —** 

**Required fields:** report\_id; boundary\_event\_id; carried\_statement\_refs; anchor\_refs; freshness\_refs; replay\_refs; disclosure\_class\_entries

**Target boundary:** Audit / reconstruction

**FOC-03 ReplayAdmissionToken —** 

**Required fields:** family\_decision\_id; accepted\_head\_digest; linked\_irr\_digest; rehydration\_closure\_ref; admission\_status

**Target boundary:** Execution layer

**FOC-04 ContaminationIncidentNotice —** 

**Required fields:** incident\_id; root\_reason\_code; contaminating\_ref\_set; blocked\_stage; remediation\_class

**Target boundary:** Operator / governance

**FOC-05 FamilyHoldRecord —** 

**Required fields:** hold\_case\_id; hold\_enter\_refs; pending\_requirements; readmission\_budget; cleared\_only\_by

**Target boundary:** Operator / assurance

# 4. Verdict Vocabulary and Disclosure Classes

## 4.1 Family verdict vocabulary

| Verdict | Normative meaning |
| --- | --- |
| REPLAY\_ADMISSIBLE | The boundary event may be replayed and semantically remounted. All blocking local and cross-domain validators have passed. |
| REPLAY\_ADMISSIBLE\_CONSTRAINED | Replay is admissible only under explicitly declared restrictions. Intentional gaps and handoff obligations remain marked. |
| REPLAY\_INCOMPLETE | Continuity can be partially reconstructed, but closure is missing for at least one critical family decision object. |
| NONCOMPLIANT\_HOLD | Mandatory prerequisites exist but are not closed. Final verdict issuance is blocked pending a new family closure bundle. |
| CONTAMINATION\_FAIL\_CLOSED | Boundary contamination or inadmissible promotion of an artifact or claim immediately blocks family replay. |
| INCIDENT\_ONLY | Only incident and audit artifacts may be issued. No compliant replay output is permitted. |

## 4.2 Continuity disclosure classes

| Classification | Meaning |
| --- | --- |
| TRUE\_DEFECT | Affects the correctness or admissibility of the family verdict and must be treated as a real defect. |
| BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS | An explicitly preserved openness that does not change the execution verdict or the family-level gate. |
| BOUNDED\_HANDOFF\_OBLIGATION | An explicit downstream obligation. It is neither a local defect nor silent omission. |

# 5. Temporal and Ordering Contract

- Family replay ordering is grounded in accepted-head sequence, IRR anchoring, hash continuity, anti-rollback anchor control, and policy-snapshot freeze.
- Host-only timestamps are auxiliary and may not substitute for a strictly increasing anchor or registry-backed sequence.
- No family replay is admissible on a different snapshot than the one used to verify the anchor document and the rehydration bundle.
- Readmission does not inherit a prior REPLAY\_ADMISSIBLE verdict across policy-snapshot changes, anchor-epoch changes, accepted-head changes, or carried-statement-set changes.
- Semantic replay follows this order: boundary screening → provenance classification → freshness and accepted-head lock → verified rehydration closure → replay reconstruction → family verdict → evidence report.

# 6. Failure Semantics

**UNTRUSTED\_ANCHOR\_PROMOTED —** 

**Meaning:** An anchor document or carried payload influenced the verdict without complete boundary validation.

**Family effect:** CONTAMINATION\_FAIL\_CLOSED

**UNLABELED\_CARRIED\_MECHANISM\_CLAIM —** 

**Meaning:** A carried mechanism-level claim lacked admitted tsa\_label or source\_class labeling.

**Family effect:** CONTAMINATION\_FAIL\_CLOSED

**FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR —** 

**Meaning:** Freshness or anchor monotonicity failed, or the accepted head was outdated.

**Family effect:** NONCOMPLIANT\_HOLD or REPLAY\_INCOMPLETE

**REHYDRATION\_PREREQ\_FAIL —** 

**Meaning:** Read-only startup, snapshot stability, anti-rollback, signature, or policy prerequisites were not closed.

**Family effect:** CONTAMINATION\_FAIL\_CLOSED or NONCOMPLIANT\_HOLD, depending on remediability

**REPLAY\_RECONSTRUCTION\_INCOMPLETE —** 

**Meaning:** Checkpoint, rollback, or report closure was insufficient for family replay.

**Family effect:** REPLAY\_INCOMPLETE

**DISCLOSURE\_CLASS\_COLLAPSE —** 

**Meaning:** True defects, bounded openness, and bounded handoff obligations were collapsed semantically.

**Family effect:** INCIDENT\_ONLY until remediation

**FAMILY\_EVIDENCE\_INSUFFICIENT —** 

**Meaning:** The boundary-event evidence report or family validator bundle does not support offline reconstruction.

**Family effect:** INCIDENT\_ONLY

**READMISSION\_WITHOUT\_CLOSURE —** 

**Meaning:** Readmission was requested without hold\_exit\_refs, anchor\_update\_ref, or a new bundle.

**Family effect:** NONCOMPLIANT\_HOLD

# 7. Validator Catalogue

**FV-01 — Required Control Coverage**

**Class:** Deterministic

**Pass condition:** All required continuity-control domains are present, coherent, and admitted for family use.

**Fail effect:** Block integrator issuance

**FV-02 — Boundary Input Contract**

**Class:** Deterministic

**Pass condition:** The anchor document and carried payload satisfy FIC-01 and remain untrusted until verification closes.

**Fail effect:** CONTAMINATION\_FAIL\_CLOSED

**FV-03 — Carried Claim Provenance Admissibility**

**Class:** Deterministic + semantic

**Pass condition:** Carried claims have statement identity, tsa\_label, source\_class, and policy-compatible provenance.

Fail effect:\
• CONTAMINATION\_FAIL\_CLOSED when at least one carried claim is unlabeled (missing tsa\_label or source\_class), carries an inadmissible mechanism-level claim, or contaminates the verdict per FV-09.\
• REPLAY\_INCOMPLETE when all carried claims are properly labeled but at least one fails policy-compatibility under the current policy\_snapshot\_id, with no contamination indicator present.\
Discriminator: presence of any contamination signal (FV-09 trigger condition or unlabeled mechanism-level claim) routes to CONTAMINATION\_FAIL\_CLOSED; absence of contamination plus policy-compatibility failure routes to REPLAY\_INCOMPLETE.

**FV-04 — Boundary Role Consistency**

**Class:** Heuristic hardening

**Pass condition:** Explanatory-only payload is not consumed as mechanism-level material without explicit reclassification.

Fail effect:\
• FAIL\_CLOSED → CONTAMINATION\_FAIL\_CLOSED at family level when no admissible reclassification path exists for the affected carried statement (i.e., it cannot be re-tagged as explanatory-only and isolated from mechanism consumption).\
• Local reclassification (no family verdict change) when the affected carried statement can be re-tagged as explanatory-only at the local layer, isolated from mechanism consumption, and re-submitted. The family flow blocks at S2 until reclassification closes.\
Bounded note: "Local reclassification" is not a family verdict; it is a bounded handoff obligation to the local layer (BOUNDED\_HANDOFF\_OBLIGATION disclosure class). The family flow does not advance until reclassification closes or FAIL\_CLOSED resolves.

**FV-05 — Accepted Head / IRR Linkage**

**Class:** Deterministic

**Pass condition:** accepted\_head\_digest is linked to the latest valid IRR.

**Fail effect:** REPLAY\_INCOMPLETE

**FV-06 — Freshness / Anchor Strict Increase**

**Class:** Deterministic

**Pass condition:** The anchor is strictly increasing and compatible with the local continuity watermark.

**Fail effect:** NONCOMPLIANT\_HOLD

**FV-07 — Verified Rehydration Closure**

**Class:** Deterministic

**Pass condition:** Read-only startup, snapshot stability, anti-rollback, chain or signature checks, and policy prerequisites all pass.

Fail effect:\
• CONTAMINATION\_FAIL\_CLOSED (non-remediable) when anti-rollback fails, signature or chain integrity fails, snapshot stability is broken, or read-only startup is violated.\
• NONCOMPLIANT\_HOLD (remediable) when the integrity checks above all pass but only policy prerequisites are unmet. Readmission via SH → SR with a refreshed policy\_snapshot\_id is permitted.\
Remediability test: any failure that affects integrity, anti-rollback, or read-only invariants is non-remediable and routes to CONTAMINATION\_FAIL\_CLOSED. Failures isolated to policy prerequisites are remediable and route to NONCOMPLIANT\_HOLD.

**FV-08 — Replay Reconstruction Sufficiency**

**Class:** Deterministic

**Pass condition: Checkpoint reconstruction, rollback reconstruction, and report sufficiency support family replay.**

**Fail effect:** REPLAY\_INCOMPLETE

**FV-09 — Contamination Absence**

**Class:** Cross-domain deterministic

**Pass condition:** No unauthorized artifact or inadmissible carried claim influences the verdict.

**Fail effect:** CONTAMINATION\_FAIL\_CLOSED

**FV-10 — Disclosure Class Preservation**

**Class:** Deterministic

**Pass condition:** Every carried openness or defect is classified and preserved distinctly.

**Fail effect:** INCIDENT\_ONLY

**FV-11 — Family Evidence Closure**

**Class:** Deterministic

**Pass condition:** The family validator bundle and boundary-event evidence report are sufficient for offline reconstruction.

**Fail effect:** INCIDENT\_ONLY

**FV-12 — Family Readmission Closure**

**Class:** Deterministic

**Pass condition:** hold\_exit\_refs, anchor\_update\_ref, and policy stability are present for readmission.

**Fail effect:** NONCOMPLIANT\_HOLD

# 8. Decision Table

**FD-01 — ALLOW\_FAMILY\_SCREENING**

**Condition set:** FIC-01 valid; FV-01 pass; FV-02 and FV-04 pending; FV-03 and FV-05 through FV-12 pending

**Gate impact:** S0 → S1

**FD-01A — ALLOW\_FAMILY\_SCREENING**

**Condition set:** FV-02 and FV-04 pass; FV-03 pending; FV-05 through FV-12 pending

**Gate impact:** S1 → S2

FD-02 — CARRIED\_CLAIM\_INADMISSIBLE

**Condition set:** Any inadmissible carried claim or unlabeled mechanism-level carried claim

Gate impact: Enter SX (resulting family verdict: CONTAMINATION\_FAIL\_CLOSED)

**FD-03 — LOCK\_ACCEPTED\_ANCHOR\_STATE**

**Condition set:** Accepted head present; freshness strictly increasing; policy compatible

**Gate impact:** S3 → S4

**FD-04 — ALLOW\_REPLAY\_RECONSTRUCTION**

**Condition set:** Verified rehydration closure passes

**Gate impact:** S4 → S5

**FD-05 — REPLAY\_ADMISSIBLE or REPLAY\_ADMISSIBLE\_CONSTRAINED**

**Condition set:** Checkpoint, rollback, and report closure pass

**Gate impact:** S5 → S8

**FD-06 — INCIDENT\_ONLY**

**Condition set:** Family evidence closure fails

**Gate impact:** S5 or S7 → incident path

**FD-07 — NONCOMPLIANT\_HOLD**

**Condition set:** Freshness replay, missing hold-exit closure, or missing new evidence

**Gate impact:** Enter SH

**FD-08 — CONTAMINATION\_FAIL\_CLOSED**

**Condition set:** Critical contamination, anti-rollback failure, chain break, or untrusted anchor promoted

**Gate impact:** Enter SX

**FD-09 — INCIDENT\_ONLY**

**Condition set:** Disclosure-class collapse only

**Gate impact:** Report blocked; replay token withheld

**FD-10 — READMISSION\_REVIEW\_GRANTED**

**Condition set:** Hold case with new family closure bundle and anchor update

**Gate impact:** SH → SR

# 9. Workflow and State Transitions

**S0 FAMILY\_INTAKE —** 

**Meaning:** The continuity package has been received but not yet admitted.

**Entry trigger:** FIC-01 valid

**Exit trigger:** Admission

**S1 SOURCE\_COVERAGE\_ADMITTED —** 

**Meaning:** Required control coverage is present and admitted.

**Entry trigger:** FV-01 pass

**Exit trigger:** Boundary screening

**S2 BOUNDARY\_SCREENED —** 

**Meaning:** Anchor and payload remain untrusted, but boundary contracts have passed.

**Entry trigger:** FV-02 and FV-04 pass

**Exit trigger:** Provenance classification

**S3 PROVENANCE\_CLASSIFIED —** 

**Meaning:** Carried claims have passed provenance and role validation.

**Entry trigger:** FV-03 pass

**Exit trigger:** Accepted-head / freshness lock

**S4 ANCHOR\_LOCKED —** 

**Meaning:** Accepted head and strictly increasing anchor are locked.

**Entry trigger:** FV-05 and FV-06 pass

**Exit trigger:** Verified rehydration closure

**S5 REHYDRATION\_CLOSED —** 

**Meaning:** The rehydration bundle is fully verified.

**Entry trigger:** FV-07 pass

**Exit trigger:** Replay reconstruction

**S6 REPLAY\_RECONSTRUCTED —** 

**Meaning: Replay reconstruction is sufficient for offline reconstruction.**

**Entry trigger:** FV-08 pass

**Exit trigger:** Family report assembly

**S7 REPORT\_READY —** 

**Meaning:** The boundary-event evidence report is complete.

**Entry trigger:** FV-10 and FV-11 pass

**Exit trigger:** Emit family verdict

**SH NONCOMPLIANT\_HOLD —** 

**Meaning:** Closure is incomplete but remediable.

**Entry trigger:** Remediable failure of FV-06 or FV-12

**Exit trigger:** Readmission review

**SR READMISSION\_REVIEW —** 

**Meaning:** A new bundle or new policy state is under evaluation.

**Entry trigger:** hold\_exit\_refs and anchor\_update\_ref present

Exit trigger:\
• → S2 BOUNDARY\_SCREENED when the readmission bundle introduces a changed carried\_payload, a changed anchor\_document\_ref, or changed source\_control\_bundles. Boundary screening must be re-executed before any other gate.\
• → S5 REHYDRATION\_CLOSED when the readmission bundle changes only policy\_snapshot\_id or the verified-rehydration closure (rehydration\_closure\_ref), and the previously locked accepted\_head\_digest and the prior boundary-screening result remain valid under the strictly increasing anchor\_update\_ref.\
Discriminator: the readmission bundle's altered field set determines the re-entry target. The two branches are mutually exclusive and exhaustive within the package envelope. Deployment may not introduce a third re-entry point; this is a bounded handoff obligation.

**SX CONTAMINATION\_FAIL\_CLOSED —** 

**Meaning:** Critical contamination or unresolved prerequisite failure has occurred.

**Entry trigger:** Blocking failure of FV-02, FV-03, FV-07, or FV-09

**Exit trigger:** Incident-only output

**S8 REPLAY\_ADMITTED —** 

**Meaning:** Family replay is admissible.

**Entry trigger:** Family verdict issued

**Exit trigger:** Handoff

# 10. Gate Logic

- If FV-02, FV-03, FV-07, or FV-09 fails in blocking mode, the verdict is CONTAMINATION\_FAIL\_CLOSED and no ReplayAdmissionToken is issued.
- If FV-05 or FV-06 fails without contamination, the case enters NONCOMPLIANT\_HOLD or REPLAY\_INCOMPLETE according to remediability.
- If only replay-audit closure is missing, the minimum family verdict is REPLAY\_INCOMPLETE. If evidence closure is also missing, the verdict becomes INCIDENT\_ONLY.
- REPLAY\_ADMISSIBLE\_CONSTRAINED is permitted only when every blocking validator has passed and the remaining restrictions are explicitly classified as bounded execution-neutral openness or bounded handoff obligation.
- No positive family verdict is permitted without a BoundaryEventEvidenceReport and linkage to component evidence bundles or equivalent subordinate evidence packages.

# 11. Evidence Contract

| Field | Purpose |
| --- | --- |
| FEV-01 family\_decision\_id | Unique identifier of the family verdict. |
| FEV-02 boundary\_event\_id | Identifies the reconstructible boundary event. |
| FEV-03 session\_id / prior\_session\_ref | Links the verdict to the current session and the prior source. |
| FEV-04 carried\_statement\_refs | Lists the carried claims that influenced the verdict. |
| FEV-05 tsa\_refs / provenance\_refs | Proves provenance classification and admissibility. |
| FEV-06 anchor\_document\_digest / anchor\_document\_ref | Links the verdict to the anchor document treated as untrusted input. |
| FEV-07 accepted\_head\_digest / linked\_irr\_digest | Closes accepted-head visibility. |
| FEV-08 freshness\_before / freshness\_after / anchor\_update\_ref | Proves strict increase and readmission safety. |
| FEV-09 rehydration\_closure\_ref | Links the verdict to the verified rehydration bundle. |
| FEV-10 replay\_refs / checkpoint\_refs / rollback\_refs | Proves replay reconstruction closure and reconstructibility. |
| FEV-11 disclosure\_class\_entries | Preserves real defects, bounded openness, and handoff obligations distinctly. |
| FEV-12 family\_validator\_outcomes | Supports replay of family-level admissibility. |
| FEV-13 hold\_enter\_refs / hold\_exit\_refs | Mandatory when a hold or readmission exists. |
| FEV-14 contamination\_flags / contaminating\_ref\_set | Mandatory for contamination fail-closed cases. |
| FEV-15 report\_signature / export\_manifest\_ref | Mandatory for final output and chain of custody. |

# 12. Machine-Readable Form Catalogue

The following JSON shape is normative for automated handoff. The exact field names may be adapted only where this specification explicitly allows parameterization.

```json
{
  "family_integrator_id": "FAM-SSCAR-FI-001",
  "session_id": "<session_id>",
  "boundary_event_id": "<boundary_event_id>",
  "family_verdict": "REPLAY_ADMISSIBLE|REPLAY_ADMISSIBLE_CONSTRAINED|REPLAY_INCOMPLETE|NONCOMPLIANT_HOLD|CONTAMINATION_FAIL_CLOSED|INCIDENT_ONLY",
  "accepted_head_digest": "<optional>",
  "anchor_document_digest": "<optional>",
  "carried_statement_refs": ["..."],
  "family_validator_outcomes": [{"id":"FV-07","status":"pass|fail","evidence_ref":"..."}],
  "disclosure_class_entries": [{"ref":"...","class":"TRUE_DEFECT|BOUNDED_EXECUTION_NEUTRAL_OPENNESS|BOUNDED_HANDOFF_OBLIGATION"}],
  "blocked_stage": "<optional>",
  "readmission_case_id": "<optional>"
}
```

Family-level enumerations are strict and may not be replaced by local operational tokens.

# 13. Observability Rules

- FOR-01 — Every material family-level transition emits an observable artifact.
- FOR-02 — No family verdict exists without family\_validator\_outcomes.
- FOR-03 — Every hold records hold\_enter\_refs and pending requirements.
- FOR-04 — Every readmission records hold\_exit\_refs and anchor\_update\_ref.
- FOR-05 — Every contamination case records contaminating\_ref\_set and blocked\_stage.
- FOR-06 — disclosure\_class\_entries are mandatory whenever the report contains gaps or transfer obligations.

# 14. Implementation Assumptions and Derived Obligations

- Source continuity bundles must be coherent and exportable. The family integrator must consume only bundles with complete verdict semantics, minimum evidence, and policy references.
- source\_id and prior-session relationship must be linkable. Family evidence therefore preserves prior\_session\_ref and boundary\_event\_id.
- Canonical statement identity must be available. carried\_statement\_refs may not be replaced by irreducible free text.
- An anchor document may contain mixed content. Boundary screening and role validation are mandatory before any family-level consumption.
- Policy snapshots may evolve. Any policy drift triggers re-evaluation, and readmission does not inherit a prior verdict automatically.
- Readmission is permitted only on new evidence or a new policy state, with a strictly increasing anchor\_update\_ref.
- A deployment may be multi-model. Model change must be treated as a boundary event and may not rely on implicit semantic equivalence.

# 15. Conformance Coverage and Reference Scenarios

## 15.1 Required conformance coverage

- Traceability soundness: all decision objects, validators, evidence fields, and verdict paths are covered and linked.
- Technical correctness: negative-path handling covers contamination, freshness replay, missing IRR linkage, anti-rollback failure, missing replay reconstruction closure, and disclosure-class collapse.
- Transfer adequacy: the family verdict remains useful as a distinct control surface beyond isolated local verdicts.
- Replay readiness: at least one representative boundary event can be reconstructed offline.
- Audit readiness: the BoundaryEventEvidenceReport and family validator bundle support external reconstruction and review.
- Governance readiness: family gate logic and failure semantics are fully determined and fully covered.

## 15.2 Reference scenarios

**SC-01 — Required control coverage is complete**

**Expected result:** All required continuity-control domains are admitted

**Minimum evidence:** FV-01 evidence

**SC-02 — A carried mechanism-level claim lacks tsa\_label or source\_class**

**Expected result:** CONTAMINATION\_FAIL\_CLOSED

**Minimum evidence:** tsa\_refs + blocked\_stage

**SC-03 — An upstream assertion attempts to treat the anchor document as trusted**

**Expected result:** Boundary revalidation and block until closure

**Minimum evidence:** Boundary-validator evidence

**SC-04 — freshness\_new ≤ watermark or anchor stagnates**

**Expected result:** NONCOMPLIANT\_HOLD

**Minimum evidence:** freshness\_before/after + hold\_enter\_refs

**SC-05 — Snapshot mismatch or anti-rollback failure**

**Expected result:** CONTAMINATION\_FAIL\_CLOSED

**Minimum evidence:** rehydration\_closure\_ref + anchor status

**SC-06 — Checkpoint, rollback, or report closure is incomplete**

**Expected result:** REPLAY\_INCOMPLETE

**Minimum evidence:** replay\_refs + report-field evidence

**SC-07 — Unauthorized tool-state appears inside the anchor payload**

**Expected result:** Contamination handling or local quarantine without replay admission

**Minimum evidence:** tool-state evidence + contamination flags

**SC-08 — Family closure is complete**

**Expected result:** REPLAY\_ADMISSIBLE

**Minimum evidence:** Complete family validator bundle

**SC-09 — Disclosure classes are collapsed into a generic defect**

**Expected result:** INCIDENT\_ONLY until disclosure classes are corrected

**Minimum evidence:** disclosure\_class\_entries

**SC-10 — A hold case receives new evidence and a new anchor update**

**Expected result:** READMISSION\_REVIEW with controlled resumption

**Minimum evidence:** hold\_exit\_refs + anchor\_update\_ref

# 16. Acceptance Criteria

1. AC-01 — All required control domains and public specification artifacts exist and are internally coherent.
2. AC-02 — Every required source continuity bundle or equivalent control bundle is admitted explicitly for family use.
3. AC-03 — Every family decision rule is linked to at least one family validator and at least one family evidence field.
4. AC-04 — The state model covers every verdict and every declared remediation path.
5. AC-05 — The family verdict can be reconstructed offline for at least one representative boundary event.
6. AC-06 — Negative-path coverage exists for contamination, freshness replay, and incomplete replay closure.
7. AC-07 — No critical unresolved gap remains on identity, authority, boundary, evidence, replay, or handoff semantics.
8. AC-08 — Implementation-owned open items are explicitly separated and do not affect the semantic core, validator semantics, evidence closure, or handoff readiness.

# 17. Implementation Boundaries, Optional Parameters, and Reuse Rules

## 17.1 Implementation boundaries

- The concrete cryptographic suite belongs to the execution layer and is not fixed by this specification.
- Storage backend, persistent serialization details, and operator workflow belong to the execution layer.
- These implementation choices may not extend or narrow the semantic core, verdict vocabulary, validator semantics, evidence closure, or handoff rules.

## 17.2 Optional parameters

- A family-level numeric profile is optional. The mandatory mapping remains CRITICAL → fail-closed or hold.
- An external assurance component is optional for audit-only replay and required only where a deployment claims compliance-finalization through such a control.
- Hardware attestation or comparable anchor-binding mechanisms are optional strengthening controls and may not substitute for validators or provenance admissibility.
- Rollback execution as a downstream action is optional; the family verdict may remain execution-neutral.

## 17.3 Stable semantic core

- Family verdict vocabulary and disclosure classes.
- Contamination definition and fail-closed behavior.
- Strict monotonic anchor requirement and accepted-head linkage.
- Verified rehydration precedence over semantic replay.
- Replay sufficiency and offline reconstructibility requirements.
- Disclosure-class preservation and evidence closure.

## 17.4 Parameterizable without semantic change

- reason\_code naming
- Concrete JSON field names where this specification allows parameterization
- Operator role names
- Cryptographic suite selection
- Storage backend selection

## 17.5 Non-reuse zones

- Removing boundary role validation.
- Treating the anchor document as trusted by default.
- Automatically inheriting a local verdict as the family verdict.
- Relaxing CONTAMINATION\_FAIL\_CLOSED or NONCOMPLIANT\_HOLD into a non-blocking warning.

## 17.6 Change-control rule

Any change that affects family decision objects, validators, the evidence bundle, or verdict vocabulary requires a full conformance rerun across validator linkage, evidence linkage, decision rules, workflow, and acceptance criteria.

# Appendix A. Decision-Object Traceability Matrix

| Decision object | Validator linkage | Evidence linkage |
| --- | --- | --- |
| carried\_claim\_set\_admissibility | FV-03 / FV-04 / FV-09 | FEV-04, FEV-05, FEV-14 |
| anchor\_document\_boundary\_admissibility | FV-02 / FV-04 | FEV-06 |
| accepted\_anchor\_state | FV-05 / FV-06 / FV-07 | FEV-06, FEV-07, FEV-08 |
| verified\_rehydration\_closure | FV-07 | FEV-09 |
| replay\_continuity\_bundle | FV-08 | FEV-10 |
| contamination\_case | FV-09 | FEV-14 (FOC-04 as bounded producer) |
| continuity\_disclosure\_class | FV-10 | FEV-11 |
| session\_replay\_admissibility | FV-02 through FV-12 | FEV-01 through FEV-15 |
