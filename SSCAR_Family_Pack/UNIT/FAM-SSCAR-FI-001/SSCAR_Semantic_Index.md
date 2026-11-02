D1 — Canonical Semantic Index Human Edition

# Session State Continuity \& Anchor Replay Family Integrator

Canonical semantic index for the buyer-facing package version 1.1.0.

# Document metadata

| Field | Value |
| --- | --- |
| integrator\_name | Session State Continuity \& Anchor Replay Family Integrator |
| integrator\_id | FAM-SSCAR-FI-001 |
| package\_version | 1.1.0 |
| authorized\_public\_specification | SSCAR\_Specification |
| authorized\_public\_corpus | SSCAR\_Specification |
| entry\_count | 139 |

**Index scope:** Comprehensive — every normative coded item in the public specification is indexed. Vocabulary is organized in 11 canonical categories; non-vocabulary normative items (Observability Rules, Reference Scenarios, Acceptance Criteria) are organized in 3 supplementary categories; machine-readable handoff fields are organized in 1 handoff category.

**Non-indexed residue statement:** None. All FOR-\*, SC-\*, AC-\*, primary decision-object IDs (DEC-\*), and machine-readable handoff fields are indexed.

Editorial rule: All preferred labels are textually attested in the public specification. Definitions, constraints, and traceability are limited to the authorized public corpus and the public specification language.

# Identity Terms

## CTRL-16 — Authority source

**definition\_short:** Public source of authority for the family integrator.

**definition\_operational:** Authority is expressed publicly as the criteria, limits, and rules stated in the specification, not by undeclared sources or operator override.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Authority source

**related\_terms:** Jurisdiction; Non-jurisdiction; Delegated scope; Misuse boundary

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-17 — Jurisdiction

**definition\_short:** Domain in which the family integrator has public authority.

**definition\_operational:** Covers boundary cleanliness, carried-claim provenance admissibility, accepted-head and anchor validation, verified rehydration closure, replay continuity and admissibility, and boundary-event evidence reporting.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Jurisdiction

**related\_terms:** Non-jurisdiction; family integrator; Delegated scope

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-18 — Non-jurisdiction

**definition\_short:** Domain explicitly excluded from the authority of the family integrator.

**definition\_operational:** The integrator does not classify external truth, issue policy overrides, grant operator approval for tool-state, perform live restore, move continuity watermarks, or substitute local validators.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Non-jurisdiction

**related\_terms:** Jurisdiction; Misuse boundary; family integrator

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## ID-01 — Session State Continuity \& Anchor Replay Family Integrator

**definition\_short:** Family integrator defined by the public specification for inter-session continuity, semantic replay, and verified rehydration.

**definition\_operational:** Used as the display name of the target unit and as the canonical public name for the family verdict, workflow, validators, and evidence bundle defined by the specification.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro table / Display name; SSCAR\_Specification §1 Operational Objective and Required Control Coverage

**related\_terms:** FAM-SSCAR-FI-001; family integrator; family verdict; boundary event

**synonyms:** Display name

**non\_synonyms:** component agent

**usage\_constraints:** Refers to the family integrator, not to a component agent.

## ID-02 — FAM-SSCAR-FI-001

**definition\_short:** Public Integrator ID of the family integrator.

**definition\_operational:** Uniquely identifies the family integrator in the public corpus and can serve as a stable anchor for indexing, handoff, and validation.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro table / Integrator ID

**related\_terms:** Session State Continuity \& Anchor Replay Family Integrator

**synonyms:** Integrator ID

**non\_synonyms:** —

**usage\_constraints:** Use as the stable public identifier of the integrator.

## ID-03 — Normative-critical family integrator

**definition\_short:** Public class of the integrator with normative-critical status.

**definition\_operational:** Indicates that a failure directly affects admissible continuity, rehydration closure, boundary cleanliness, and boundary-event audit reconstruction.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro table / Integrator class; SSCAR\_Specification §1.1 Criticality

**related\_terms:** family integrator; family verdict; fail-closed invariant

**synonyms:** Integrator class

**non\_synonyms:** —

**usage\_constraints:** The class expresses the normative criticality of the integrator.

## ID-04 — family integrator

**definition\_short:** Target unit of the specification, distinct from a component agent.

**definition\_operational:** The specification governs the emergent family verdict, cross-domain closure, and family-level reporting, without substituting local validators.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro table / Target unit; SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Delegated scope

**related\_terms:** Session State Continuity \& Anchor Replay Family Integrator; family verdict; local verdict

**synonyms:** —

**non\_synonyms:** component agent

**usage\_constraints:** Use for family-level closure and verdict semantics; not for a component agent.

## ID-05 — Full-closure mode

**definition\_short:** Operating mode in which semantic, temporal, failure, evidence, and handoff closure are mandatory.

**definition\_operational:** Requires simultaneous closure of critical prerequisites before any positive verdict or replay admission is allowed.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro table / Operating mode; SSCAR\_Specification §2 / Family objective clause

**related\_terms:** family verdict; verified\_rehydration\_closure; replay\_continuity\_bundle; fail-closed invariant

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** Does not permit semantic replay on superficial or incomplete closure.

## ID-06 — Family objective clause

**definition\_short:** Clause that defines the simultaneous condition for admissible epistemic continuity.

**definition\_operational:** Admissible epistemic continuity exists only when carried provenance, accepted head, verified rehydration, anti-replay, and replay reconstruction closure are all closed simultaneously.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Family objective clause

**related\_terms:** accepted head; verified rehydration; anti-replay; replay reconstruction

**synonyms:** family objective clause

**non\_synonyms:** —

**usage\_constraints:** —

## ID-07 — family verdict

**definition\_short:** Emergent verdict of the family integrator, distinct from any local verdict.

**definition\_operational:** Arises only after cross-domain closure between boundary validation, freshness, verified rehydration, replay reconstruction, and evidence assembly.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1 Operational Objective and Required Control Coverage; SSCAR\_Specification §4.1 Family verdict vocabulary

**related\_terms:** local verdict; session\_replay\_admissibility; FamilyVerdict; REPLAY\_ADMISSIBLE

**synonyms:** —

**non\_synonyms:** local verdict

**usage\_constraints:** May not be inherited automatically from local outcomes.

# Boundary Terms

## CTRL-01 — family boundary

**definition\_short:** Operational frontier at which anchor document, carried payload, and verification bundles are treated as family-verdict inputs.

**definition\_operational:** The family boundary is the intersection of carried-artifact ingress screening across the session boundary, accepted-head and freshness-anchor eligibility, persistent-context restoration and read-only remount, and auditable replay with boundary-event evidence issuance.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.2 Family boundary; SSCAR\_Specification §2 / Family boundary clause

**related\_terms:** Replay boundary; Hold / readmission boundary; boundary\_validated\_role; untrusted input

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** At this boundary, anchor document and continuity payload remain untrusted and read-only until verification closes.

## CTRL-02 — Replay boundary

**definition\_short:** Contract boundary for FamilyReplayRequest.

**definition\_operational:** Binds accepted head, anchor digest, replay scope, and rehydration bundle to the conditions under which replay can be admissible.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.1 Input contract / FIC-02 FamilyReplayRequest

**related\_terms:** FamilyReplayRequest; family boundary; verified rehydration; semantic replay

**synonyms:** Boundary: Replay boundary

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-03 — Hold / readmission boundary

**definition\_short:** Contract boundary for entering hold and for readmission review.

**definition\_operational:** Delimits the hold case, new evidence or new policy state, anchor update, and hold-exit references required for controlled resumption.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.1 Input contract / FIC-03 FamilyReadmissionReview

**related\_terms:** FamilyReadmissionReview; NONCOMPLIANT\_HOLD; READMISSION\_REVIEW\_GRANTED; anchor\_update\_ref

**synonyms:** Boundary: Hold / readmission boundary

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-04 — boundary\_validated\_role

**definition\_short:** Admitted label required before a carried claim can enter family gate logic.

**definition\_operational:** A carried claim may not enter family gate logic without an admitted boundary\_validated\_role, tsa\_label, and source\_class, or an explicitly admitted equivalent.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.4 Cross-domain operating rules

**related\_terms:** tsa\_label; source\_class; carried\_claim\_set\_admissibility; FV-03 — Carried Claim Provenance Admissibility

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** Required before family gate logic.

## CTRL-13 — untrusted input

**definition\_short:** Status of anchor document and continuity payload before verification closure at the continuity boundary.

**definition\_operational:** Anchor documents and continuity payloads remain untrusted and read-only until boundary validation closes completely.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.4 Cross-domain operating rules; SSCAR\_Specification §6 Failure Semantics / UNTRUSTED\_ANCHOR\_PROMOTED

**related\_terms:** family boundary; anchor document; boundary\_validated\_role; UNTRUSTED\_ANCHOR\_PROMOTED

**synonyms:** untrusted boundary payload

**non\_synonyms:** —

**usage\_constraints:** —

## ID-08 — boundary event

**definition\_short:** Boundary event that must be reconstructed offline and supported by minimum evidence.

**definition\_operational:** The event for which the evidence report, replay closure, and family verdict are issued, with a bundle sufficient for offline reconstruction.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro table / Primary role; SSCAR\_Specification §11 Evidence Contract / FEV-02 boundary\_event\_id

**related\_terms:** BoundaryEventEvidenceReport; replay reconstruction; family verdict

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

# Control Terms

## CTRL-05 — accepted head

**definition\_short:** Accepted endpoint that must be linked to a valid IRR for eligibility and replay admission.

**definition\_operational:** Restore eligibility and anchor lock require an accepted head linked to a valid IRR; without that linkage an unanchored tail remains ineligible.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.4 Cross-domain operating rules; SSCAR\_Specification §5 Temporal and Ordering Contract; SSCAR\_Specification §11 Evidence Contract / FEV-07 accepted\_head\_digest / linked\_irr\_digest

**related\_terms:** IRR; freshness anchor; accepted\_anchor\_state; ReplayAdmissionToken

**synonyms:** accepted\_head\_digest

**non\_synonyms:** unanchored tail

**usage\_constraints:** Mandatory for replay admissibility and for FIC-02 FamilyReplayRequest.

## CTRL-06 — freshness anchor

**definition\_short:** Freshness anchor that must increase strictly for replay admissibility and readmission safety.

**definition\_operational:** Restore eligibility and family replay require strict increase and compatibility with the local continuity watermark; stagnation or monotonicity failure blocks a positive verdict.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.4 Cross-domain operating rules; SSCAR\_Specification §5 Temporal and Ordering Contract; SSCAR\_Specification §7 / FV-06 — Freshness / Anchor Strict Increase

**related\_terms:** accepted head; continuity watermark; anchor\_update\_ref; FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR

**synonyms:** freshness; anchor

**non\_synonyms:** —

**usage\_constraints:** May not be substituted by host-only timestamps.

## CTRL-07 — verified rehydration

**definition\_short:** Verified precondition for admissible semantic replay.

**definition\_operational:** Replay may not proceed on superficial continuity; verified rehydration closure requires read-only startup, snapshot stability, anti-rollback, and policy prerequisites to pass.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.4 Cross-domain operating rules; SSCAR\_Specification §7 / FV-07 — Verified Rehydration Closure; SSCAR\_Specification §17.3 Stable semantic core

**related\_terms:** verified\_rehydration\_closure; semantic replay; read-only startup; anti-rollback

**synonyms:** verified rehydration closure

**non\_synonyms:** —

**usage\_constraints:** A precondition for family replay.

## CTRL-08 — semantic replay

**definition\_short:** Semantic replay of the boundary event after critical family closure.

**definition\_operational:** May occur only after boundary screening, provenance classification, freshness and accepted-head lock, verified rehydration closure, and replay reconstruction.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro / Mission statement; SSCAR\_Specification §5 Temporal and Ordering Contract

**related\_terms:** verified rehydration; replay reconstruction; family verdict

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** Not admissible without verified rehydration and without a positive family verdict.

## CTRL-09 — replay reconstruction

**definition\_short:** Checkpoint, rollback, and report reconstruction required for family replay.

**definition\_operational:** Its sufficiency is tested by FV-08 and supports offline reconstructibility for the boundary event and evidence report.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.3 Required control coverage; SSCAR\_Specification §7 / FV-08 — Replay Reconstruction Sufficiency; SSCAR\_Specification §17.3 Stable semantic core

**related\_terms:** replay\_continuity\_bundle; BoundaryEventEvidenceReport; REPLAY\_RECONSTRUCTION\_INCOMPLETE

**synonyms:** replay reconstruction closure

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-10 — contamination

**definition\_short:** Cross-domain contamination that blocks family replay.

**definition\_operational:** Includes unlabeled claims, inadmissible provenance, a stale or non-monotonic anchor, an unanchored accepted head, unauthorized tool-state, or unverified persistent state that influences the family verdict.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.4 Cross-domain operating rules; SSCAR\_Specification §2 / Fail-closed invariant; SSCAR\_Specification §7 / FV-09 — Contamination Absence

**related\_terms:** contamination\_case; CONTAMINATION\_FAIL\_CLOSED; ContaminationIncidentNotice

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** If contamination exists, family replay is not admissible.

## CTRL-11 — anti-rollback

**definition\_short:** Control that protects anchor ordering and verified rehydration closure against rollback failure.

**definition\_operational:** Part of the read-only startup and snapshot stability prerequisites and contributes to ordering, closure, and contamination blocking.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.3 Required control coverage; SSCAR\_Specification §5 Temporal and Ordering Contract; SSCAR\_Specification §7 / FV-07 — Verified Rehydration Closure

**related\_terms:** verified rehydration; freshness anchor; REHYDRATION\_PREREQ\_FAIL

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-12 — continuity watermark

**definition\_short:** Local compatibility marker for strict freshness increase.

**definition\_operational:** Anchor strict increase must remain compatible with the local continuity watermark; otherwise the case enters hold or replay incomplete according to remediability.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.3 Required control coverage; SSCAR\_Specification §7 / FV-06 — Freshness / Anchor Strict Increase

**related\_terms:** freshness anchor; NONCOMPLIANT\_HOLD; FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-14 — Read-only startup

**definition\_short:** Rehydration prerequisite in which startup and remount remain read-only until verification.

**definition\_operational:** Part of the pass condition for FV-07 and blocks replay admission when read-only, snapshot, anti-rollback, or policy prerequisites are not closed.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.2 Family boundary; SSCAR\_Specification §7 / FV-07 — Verified Rehydration Closure

**related\_terms:** verified rehydration; anti-rollback; REHYDRATION\_PREREQ\_FAIL

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## CTRL-19 — Fail-closed invariant

**definition\_short:** Invariant that forbids replay admissibility when contamination, critical incompleteness, non-strict freshness, or unverified rehydration exists.

**definition\_operational:** Sets the minimum negative control condition for family replay and justifies hold, incomplete, and fail-closed paths.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Fail-closed invariant; SSCAR\_Specification §10 Gate Logic

**related\_terms:** family verdict; CONTAMINATION\_FAIL\_CLOSED; NONCOMPLIANT\_HOLD; REPLAY\_INCOMPLETE

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DISCLOSURE\_CLASS\_COLLAPSE — DISCLOSURE\_CLASS\_COLLAPSE

**definition\_short:** Public failure semantics code: True defects, bounded openness, and bounded handoff obligations were collapsed semantically.

**definition\_operational:** Describes a failure path of family replay; family effect: INCIDENT\_ONLY until remediation.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** INCIDENT\_ONLY until remediation

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## FAMILY\_EVIDENCE\_INSUFFICIENT — FAMILY\_EVIDENCE\_INSUFFICIENT

**definition\_short:** Public failure semantics code: The boundary-event evidence report or family validator bundle does not support offline reconstruction.

**definition\_operational:** Describes a failure path of family replay; family effect: INCIDENT\_ONLY.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** INCIDENT\_ONLY

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR — FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR

**definition\_short:** Public failure semantics code: Freshness or anchor monotonicity failed, or the accepted head was outdated.

**definition\_operational:** Describes a failure path of family replay; family effect: NONCOMPLIANT\_HOLD or REPLAY\_INCOMPLETE.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** NONCOMPLIANT\_HOLD or REPLAY\_INCOMPLETE

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## READMISSION\_WITHOUT\_CLOSURE — READMISSION\_WITHOUT\_CLOSURE

**definition\_short:** Public failure semantics code: Readmission was requested without hold\_exit\_refs, anchor\_update\_ref, or a new bundle.

**definition\_operational:** Describes a failure path of family replay; family effect: NONCOMPLIANT\_HOLD.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** NONCOMPLIANT\_HOLD

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## REHYDRATION\_PREREQ\_FAIL — REHYDRATION\_PREREQ\_FAIL

**definition\_short:** Public failure semantics code: Read-only startup, snapshot stability, anti-rollback, signature, or policy prerequisites were not closed.

**definition\_operational:** Describes a failure path of family replay; family effect: CONTAMINATION\_FAIL\_CLOSED or NONCOMPLIANT\_HOLD, depending on remediability.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** CONTAMINATION\_FAIL\_CLOSED or NONCOMPLIANT\_HOLD, depending on remediability

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## REPLAY\_RECONSTRUCTION\_INCOMPLETE — REPLAY\_RECONSTRUCTION\_INCOMPLETE

**definition\_short:** Public failure semantics code: Checkpoint, rollback, or report closure was insufficient for family replay.

**definition\_operational:** Describes a failure path of family replay; family effect: REPLAY\_INCOMPLETE.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** REPLAY\_INCOMPLETE

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## UNLABELED\_CARRIED\_MECHANISM\_CLAIM — UNLABELED\_CARRIED\_MECHANISM\_CLAIM

**definition\_short:** Public failure semantics code: A carried mechanism-level claim lacked admitted tsa\_label or source\_class labeling.

**definition\_operational:** Describes a failure path of family replay; family effect: CONTAMINATION\_FAIL\_CLOSED.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** CONTAMINATION\_FAIL\_CLOSED

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## UNTRUSTED\_ANCHOR\_PROMOTED — UNTRUSTED\_ANCHOR\_PROMOTED

**definition\_short:** Public failure semantics code: An anchor document or carried payload influenced the verdict without complete boundary validation.

**definition\_operational:** Describes a failure path of family replay; family effect: CONTAMINATION\_FAIL\_CLOSED.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §6 Failure Semantics

**related\_terms:** CONTAMINATION\_FAIL\_CLOSED

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

# Contract Terms

## CTRL-15 — source\_control\_bundles

**definition\_short:** Input field of FamilyContinuityIntake that carries admitted source control bundles for family use.

**definition\_operational:** Appears in FIC-01 and enters the family boundary contract as part of the continuity package evaluated for closure and replay admissibility.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.1 Input contract / FIC-01 FamilyContinuityIntake

**related\_terms:** FamilyContinuityIntake; required control coverage; family boundary

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## FIC-01 — FIC-01 FamilyContinuityIntake

**definition\_short:** Input contract for FamilyContinuityIntake.

**definition\_operational:** Required fields: session\_id; prior\_session\_ref; carried\_payload; anchor\_document\_ref; source\_control\_bundles; policy\_snapshot\_id. Boundary: Family boundary. Mandatory for any continuity evaluation.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.1 Input contract

**related\_terms:** family boundary; Replay boundary; Hold / readmission boundary

**synonyms:** FIC-01; FamilyContinuityIntake

**non\_synonyms:** —

**usage\_constraints:** —

## FIC-02 — FIC-02 FamilyReplayRequest

**definition\_short:** Input contract for FamilyReplayRequest.

**definition\_operational:** Required fields: session\_id; accepted\_head\_digest; anchor\_digest; replay\_scope; rehydration\_bundle\_ref. Boundary: Replay boundary. Replay is not admissible without an accepted head and a verified rehydration bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.1 Input contract

**related\_terms:** family boundary; Replay boundary; Hold / readmission boundary

**synonyms:** FIC-02; FamilyReplayRequest

**non\_synonyms:** —

**usage\_constraints:** —

## FIC-03 — FIC-03 FamilyReadmissionReview

**definition\_short:** Input contract for FamilyReadmissionReview.

**definition\_operational:** Required fields: hold\_case\_id; new\_evidence\_refs or new\_policy\_ref; anchor\_update\_ref; hold\_exit\_refs. Boundary: Hold / readmission boundary. Identical readmission on the same artifacts is forbidden.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.1 Input contract

**related\_terms:** family boundary; Replay boundary; Hold / readmission boundary

**synonyms:** FIC-03; FamilyReadmissionReview

**non\_synonyms:** —

**usage\_constraints:** —

## FOC-01 — FOC-01 FamilyVerdict

**definition\_short:** Output contract for FamilyVerdict.

**definition\_operational:** Required fields: family\_decision\_id; session\_id; family\_verdict; reason\_code; family\_validator\_refs; family\_evidence\_refs. Target boundary: Operator / execution layer.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.2 Output contract

**related\_terms:** family verdict; BoundaryEventEvidenceReport; ReplayAdmissionToken

**synonyms:** FOC-01; FamilyVerdict

**non\_synonyms:** —

**usage\_constraints:** —

## FOC-02 — FOC-02 BoundaryEventEvidenceReport

**definition\_short:** Output contract for BoundaryEventEvidenceReport.

**definition\_operational:** Required fields: report\_id; boundary\_event\_id; carried\_statement\_refs; anchor\_refs; freshness\_refs; replay\_refs; disclosure\_class\_entries. Target boundary: Audit / reconstruction.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.2 Output contract

**related\_terms:** family verdict; BoundaryEventEvidenceReport; ReplayAdmissionToken

**synonyms:** FOC-02; BoundaryEventEvidenceReport

**non\_synonyms:** —

**usage\_constraints:** —

## FOC-03 — FOC-03 ReplayAdmissionToken

**definition\_short:** Output contract for ReplayAdmissionToken.

**definition\_operational:** Required fields: family\_decision\_id; accepted\_head\_digest; linked\_irr\_digest; rehydration\_closure\_ref; admission\_status. Target boundary: Execution layer.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.2 Output contract

**related\_terms:** family verdict; BoundaryEventEvidenceReport; ReplayAdmissionToken

**synonyms:** FOC-03; ReplayAdmissionToken

**non\_synonyms:** —

**usage\_constraints:** —

## FOC-04 — FOC-04 ContaminationIncidentNotice

**definition\_short:** Output contract for ContaminationIncidentNotice.

**definition\_operational:** Required fields: incident\_id; root\_reason\_code; contaminating\_ref\_set; blocked\_stage; remediation\_class. Target boundary: Operator / governance.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.2 Output contract

**related\_terms:** family verdict; BoundaryEventEvidenceReport; ReplayAdmissionToken

**synonyms:** FOC-04; ContaminationIncidentNotice

**non\_synonyms:** —

**usage\_constraints:** —

## FOC-05 — FOC-05 FamilyHoldRecord

**definition\_short:** Output contract for FamilyHoldRecord.

**definition\_operational:** Required fields: hold\_case\_id; hold\_enter\_refs; pending\_requirements; readmission\_budget; cleared\_only\_by. Target boundary: Operator / assurance.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §3.2 Output contract

**related\_terms:** family verdict; BoundaryEventEvidenceReport; ReplayAdmissionToken

**synonyms:** FOC-05; FamilyHoldRecord

**non\_synonyms:** —

**usage\_constraints:** —

# Family Verdict Terms

## CONTAMINATION\_FAIL\_CLOSED — CONTAMINATION\_FAIL\_CLOSED

**definition\_short:** Public family verdict token: Boundary contamination or inadmissible promotion of an artifact or claim immediately blocks family replay.

**definition\_operational:** Used in the family verdict vocabulary and in gate logic to express the admissible, constrained, incomplete, hold, fail-closed, or incident-only status of family replay.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.1 Family verdict vocabulary; SSCAR\_Specification §10 Gate Logic

**related\_terms:** family verdict; session\_replay\_admissibility; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## INCIDENT\_ONLY — INCIDENT\_ONLY

**definition\_short:** Public family verdict token: Only incident and audit artifacts may be issued. No compliant replay output is permitted.

**definition\_operational:** Used in the family verdict vocabulary and in gate logic to express the admissible, constrained, incomplete, hold, fail-closed, or incident-only status of family replay.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.1 Family verdict vocabulary; SSCAR\_Specification §10 Gate Logic

**related\_terms:** family verdict; session\_replay\_admissibility; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## NONCOMPLIANT\_HOLD — NONCOMPLIANT\_HOLD

**definition\_short:** Public family verdict token: Mandatory prerequisites exist but are not closed. Final verdict issuance is blocked pending a new family closure bundle.

**definition\_operational:** Used in the family verdict vocabulary and in gate logic to express the admissible, constrained, incomplete, hold, fail-closed, or incident-only status of family replay.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.1 Family verdict vocabulary; SSCAR\_Specification §10 Gate Logic

**related\_terms:** family verdict; session\_replay\_admissibility; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## REPLAY\_ADMISSIBLE — REPLAY\_ADMISSIBLE

**definition\_short:** Public family verdict token: The boundary event may be replayed and semantically remounted. All blocking local and cross-domain validators have passed.

**definition\_operational:** Used in the family verdict vocabulary and in gate logic to express the admissible, constrained, incomplete, hold, fail-closed, or incident-only status of family replay.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.1 Family verdict vocabulary; SSCAR\_Specification §10 Gate Logic

**related\_terms:** family verdict; session\_replay\_admissibility; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## REPLAY\_ADMISSIBLE\_CONSTRAINED — REPLAY\_ADMISSIBLE\_CONSTRAINED

**definition\_short:** Public family verdict token: Replay is admissible only under explicitly declared restrictions. Intentional gaps and handoff obligations remain marked.

**definition\_operational:** Used in the family verdict vocabulary and in gate logic to express the admissible, constrained, incomplete, hold, fail-closed, or incident-only status of family replay.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.1 Family verdict vocabulary; SSCAR\_Specification §10 Gate Logic

**related\_terms:** family verdict; session\_replay\_admissibility; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## REPLAY\_INCOMPLETE — REPLAY\_INCOMPLETE

**definition\_short:** Public family verdict token: Continuity can be partially reconstructed, but closure is missing for at least one critical family decision object.

**definition\_operational:** Used in the family verdict vocabulary and in gate logic to express the admissible, constrained, incomplete, hold, fail-closed, or incident-only status of family replay.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.1 Family verdict vocabulary; SSCAR\_Specification §10 Gate Logic

**related\_terms:** family verdict; session\_replay\_admissibility; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

# Optionality Terms

## BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS — BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS

**definition\_short:** Disclosure class with distinct normative meaning: An explicitly preserved openness that does not change the execution verdict or the family-level gate.

**definition\_operational:** Used to keep true defects, bounded execution-neutral openness, and bounded handoff obligations distinct in evidence and reporting.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.2 Continuity disclosure classes; SSCAR\_Specification §7 / FV-10 — Disclosure Class Preservation

**related\_terms:** continuity\_disclosure\_class; DISCLOSURE\_CLASS\_COLLAPSE; disclosure\_class\_entries

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## BOUNDED\_HANDOFF\_OBLIGATION — BOUNDED\_HANDOFF\_OBLIGATION

**definition\_short:** Disclosure class with distinct normative meaning: An explicit downstream obligation. It is neither a local defect nor silent omission.

**definition\_operational:** Used to keep true defects, bounded execution-neutral openness, and bounded handoff obligations distinct in evidence and reporting.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.2 Continuity disclosure classes; SSCAR\_Specification §7 / FV-10 — Disclosure Class Preservation

**related\_terms:** continuity\_disclosure\_class; DISCLOSURE\_CLASS\_COLLAPSE; disclosure\_class\_entries

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## TRUE\_DEFECT — TRUE\_DEFECT

**definition\_short:** Disclosure class with distinct normative meaning: Affects the correctness or admissibility of the family verdict and must be treated as a real defect.

**definition\_operational:** Used to keep true defects, bounded execution-neutral openness, and bounded handoff obligations distinct in evidence and reporting.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §4.2 Continuity disclosure classes; SSCAR\_Specification §7 / FV-10 — Disclosure Class Preservation

**related\_terms:** continuity\_disclosure\_class; DISCLOSURE\_CLASS\_COLLAPSE; disclosure\_class\_entries

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

# Family Decision Terms

## DEC-01 — carried\_claim\_set\_admissibility

**definition\_short:** The decision object that establishes whether the carried claim set can admissibly enter the family verdict.

**definition\_operational:** Evaluated through provenance, role validation, and contamination absence, with linkage to carried\_statement\_refs, tsa/provenance refs, and contaminating\_ref\_set where applicable. Validator linkage: FV-03 / FV-04 / FV-09. Evidence linkage: FEV-04, FEV-05, FEV-14.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DEC-02 — anchor\_document\_boundary\_admissibility

**definition\_short:** The decision object that establishes whether the anchor document remains admissible at the family boundary.

**definition\_operational:** Determines whether the anchor document may participate in the verdict only after boundary validation, as untrusted input treated read-only until closure. Validator linkage: FV-02 / FV-04. Evidence linkage: FEV-06.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DEC-03 — accepted\_anchor\_state

**definition\_short:** The decision object that locks the accepted head and the strictly increasing anchor as the accepted state for replay.

**definition\_operational:** Links the accepted head, a valid IRR, strict increase, and the anchor update into a blocking or admissible state for replay. Validator linkage: FV-05 / FV-06 / FV-07. Evidence linkage: FEV-06, FEV-07, FEV-08.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DEC-04 — verified\_rehydration\_closure

**definition\_short:** The decision object that confirms the verified closure of the rehydration bundle.

**definition\_operational:** It is closed only when read-only startup, snapshot stability, anti-rollback, chain or signature checks, and policy prerequisites pass. Validator linkage: FV-07. Evidence linkage: FEV-09.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DEC-05 — replay\_continuity\_bundle

**definition\_short:** The decision object that groups the replay closure required for offline reconstruction.

**definition\_operational:** Covers checkpoint\_refs, rollback\_refs, and replay\_refs sufficient for family replay and the evidence report. Validator linkage: FV-08. Evidence linkage: FEV-10.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DEC-06 — contamination\_case

**definition\_short:** The decision object that describes the case in which contamination blocks family replay.

**definition\_operational:** Gathers the root reason, contaminating\_ref\_set, and blocked\_stage when an inadmissible artifact or claim influences the verdict. Validator linkage: FV-09. Evidence linkage: FEV-14 (with FOC-04 ContaminationIncidentNotice as bounded producer).

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DEC-07 — continuity\_disclosure\_class

**definition\_short:** The decision object that keeps the classification among true defect, bounded openness, and bounded handoff obligation distinct.

**definition\_operational:** Must be kept distinct in evidence and reporting; semantic collapse produces the incident-only path. Validator linkage: FV-10. Evidence linkage: FEV-11.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## DEC-08 — session\_replay\_admissibility

**definition\_short:** The final decision object for session-level replay admissibility.

**definition\_operational:** Composes local outcomes and cross-domain closure into a family verdict, with linkage to the family validators and the family evidence bundle. Validator linkage: FV-02 through FV-12. Evidence linkage: FEV-01 through FEV-15.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** family verdict; family\_validator\_outcomes; BoundaryEventEvidenceReport

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## FD-01 — FD-01 — ALLOW\_FAMILY\_SCREENING

**definition\_short:** Public decision rule for ALLOW\_FAMILY\_SCREENING.

**definition\_operational:** Condition set: FIC-01 valid; FV-01 pass; FV-02 and FV-04 pending; FV-03 and FV-05 through FV-12 pending Gate impact: S0 → S1.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** S0 → S1

**synonyms:** FD-01; ALLOW\_FAMILY\_SCREENING

**non\_synonyms:** —

**usage\_constraints:** —

## FD-01A — FD-01A — ALLOW\_FAMILY\_SCREENING

**definition\_short:** Public decision rule for ALLOW\_FAMILY\_SCREENING.

**definition\_operational:** Condition set: FV-02 and FV-04 pass; FV-03 pending; FV-05 through FV-12 pending Gate impact: S1 → S2.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** S1 → S2

**synonyms:** FD-01A; ALLOW\_FAMILY\_SCREENING

**non\_synonyms:** —

**usage\_constraints:** —

## FD-02 — FD-02 — CARRIED\_CLAIM\_INADMISSIBLE

**definition\_short:** Public decision rule for CARRIED\_CLAIM\_INADMISSIBLE.

**definition\_operational:** Condition set: Any inadmissible carried claim or unlabeled mechanism-level carried claim Gate impact: Enter SX (resulting family verdict: CONTAMINATION\_FAIL\_CLOSED).

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** Enter SX; CONTAMINATION\_FAIL\_CLOSED

**synonyms:** FD-02; CARRIED\_CLAIM\_INADMISSIBLE

**non\_synonyms:** —

**usage\_constraints:** —

## FD-03 — FD-03 — LOCK\_ACCEPTED\_ANCHOR\_STATE

**definition\_short:** Public decision rule for LOCK\_ACCEPTED\_ANCHOR\_STATE.

**definition\_operational:** Condition set: Accepted head present; freshness strictly increasing; policy compatible Gate impact: S3 → S4.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** S3 → S4

**synonyms:** FD-03; LOCK\_ACCEPTED\_ANCHOR\_STATE

**non\_synonyms:** —

**usage\_constraints:** —

## FD-04 — FD-04 — ALLOW\_REPLAY\_RECONSTRUCTION

**definition\_short:** Public decision rule for ALLOW\_REPLAY\_RECONSTRUCTION.

**definition\_operational:** Condition set: Verified rehydration closure passes Gate impact: S4 → S5.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** S4 → S5

**synonyms:** FD-04; ALLOW\_REPLAY\_RECONSTRUCTION

**non\_synonyms:** —

**usage\_constraints:** —

## FD-05 — FD-05 — REPLAY\_ADMISSIBLE or REPLAY\_ADMISSIBLE\_CONSTRAINED

**definition\_short:** Public decision rule for REPLAY\_ADMISSIBLE or REPLAY\_ADMISSIBLE\_CONSTRAINED.

**definition\_operational:** Condition set: Checkpoint, rollback, and report closure pass Gate impact: S5 → S8.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** S5 → S8

**synonyms:** FD-05; REPLAY\_ADMISSIBLE or REPLAY\_ADMISSIBLE\_CONSTRAINED

**non\_synonyms:** —

**usage\_constraints:** —

## FD-06 — FD-06 — INCIDENT\_ONLY

**definition\_short:** Public decision rule for INCIDENT\_ONLY.

**definition\_operational:** Condition set: Family evidence closure fails Gate impact: S5 or S7 → incident path.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** S5 or S7 → incident path

**synonyms:** FD-06; INCIDENT\_ONLY

**non\_synonyms:** —

**usage\_constraints:** —

## FD-07 — FD-07 — NONCOMPLIANT\_HOLD

**definition\_short:** Public decision rule for NONCOMPLIANT\_HOLD.

**definition\_operational:** Condition set: Freshness replay, missing hold-exit closure, or missing new evidence Gate impact: Enter SH.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** Enter SH

**synonyms:** FD-07; NONCOMPLIANT\_HOLD

**non\_synonyms:** —

**usage\_constraints:** —

## FD-08 — FD-08 — CONTAMINATION\_FAIL\_CLOSED

**definition\_short:** Public decision rule for CONTAMINATION\_FAIL\_CLOSED.

**definition\_operational:** Condition set: Critical contamination, anti-rollback failure, chain break, or untrusted anchor promoted Gate impact: Enter SX.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** Enter SX

**synonyms:** FD-08; CONTAMINATION\_FAIL\_CLOSED

**non\_synonyms:** —

**usage\_constraints:** —

## FD-09 — FD-09 — INCIDENT\_ONLY

**definition\_short:** Public decision rule for INCIDENT\_ONLY.

**definition\_operational:** Condition set: Disclosure-class collapse only Gate impact: Report blocked; replay token withheld.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** Report blocked; replay token withheld

**synonyms:** FD-09; INCIDENT\_ONLY

**non\_synonyms:** —

**usage\_constraints:** —

## FD-10 — FD-10 — READMISSION\_REVIEW\_GRANTED

**definition\_short:** Public decision rule for READMISSION\_REVIEW\_GRANTED.

**definition\_operational:** Condition set: Hold case with new family closure bundle and anchor update Gate impact: SH → SR.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §8 Decision Table

**related\_terms:** SH → SR

**synonyms:** FD-10; READMISSION\_REVIEW\_GRANTED

**non\_synonyms:** —

**usage\_constraints:** —

# Family Validation Terms

## FV-01 — FV-01 — Required Control Coverage

**definition\_short:** Family validator for required control coverage.

**definition\_operational:** Class: Deterministic. Pass condition: All required continuity-control domains are present, coherent, and admitted for family use. Fail effect: Block integrator issuance.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** Block integrator issuance

**synonyms:** FV-01; Required Control Coverage

**non\_synonyms:** —

**usage\_constraints:** —

## FV-02 — FV-02 — Boundary Input Contract

**definition\_short:** Family validator for boundary input contract.

**definition\_operational:** Class: Deterministic. Pass condition: The anchor document and carried payload satisfy FIC-01 and remain untrusted until verification closes. Fail effect: CONTAMINATION\_FAIL\_CLOSED.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** CONTAMINATION\_FAIL\_CLOSED

**synonyms:** FV-02; Boundary Input Contract

**non\_synonyms:** —

**usage\_constraints:** —

## FV-03 — FV-03 — Carried Claim Provenance Admissibility

**definition\_short:** Family validator for carried claim provenance admissibility.

**definition\_operational:** Class: Deterministic + semantic. Pass condition: Carried claims have statement identity, tsa\_label, source\_class, and policy-compatible provenance. Fail effect: CONTAMINATION\_FAIL\_CLOSED or REPLAY\_INCOMPLETE.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** CONTAMINATION\_FAIL\_CLOSED or REPLAY\_INCOMPLETE

**synonyms:** FV-03; Carried Claim Provenance Admissibility

**non\_synonyms:** —

**usage\_constraints:** —

## FV-04 — FV-04 — Boundary Role Consistency

**definition\_short:** Family validator for boundary role consistency.

**definition\_operational:** Class: Heuristic hardening. Pass condition: Explanatory-only payload is not consumed as mechanism-level material without explicit reclassification. Fail effect: FAIL\_CLOSED or local reclassification; family flow blocks until closure.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** FAIL\_CLOSED or local reclassification; family flow blocks until closure

**synonyms:** FV-04; Boundary Role Consistency

**non\_synonyms:** —

**usage\_constraints:** —

## FV-05 — FV-05 — Accepted Head / IRR Linkage

**definition\_short:** Family validator for accepted head / irr linkage.

**definition\_operational:** Class: Deterministic. Pass condition: accepted\_head\_digest is linked to the latest valid IRR. Fail effect: REPLAY\_INCOMPLETE.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** REPLAY\_INCOMPLETE

**synonyms:** FV-05; Accepted Head / IRR Linkage

**non\_synonyms:** —

**usage\_constraints:** —

## FV-06 — FV-06 — Freshness / Anchor Strict Increase

**definition\_short:** Family validator for freshness / anchor strict increase.

**definition\_operational:** Class: Deterministic. Pass condition: The anchor is strictly increasing and compatible with the local continuity watermark. Fail effect: NONCOMPLIANT\_HOLD.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** NONCOMPLIANT\_HOLD

**synonyms:** FV-06; Freshness / Anchor Strict Increase

**non\_synonyms:** —

**usage\_constraints:** —

## FV-07 — FV-07 — Verified Rehydration Closure

**definition\_short:** Family validator for verified rehydration closure.

**definition\_operational:** Class: Deterministic. Pass condition: Read-only startup, snapshot stability, anti-rollback, chain or signature checks, and policy prerequisites all pass. Fail effect: CONTAMINATION\_FAIL\_CLOSED or NONCOMPLIANT\_HOLD.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** CONTAMINATION\_FAIL\_CLOSED or NONCOMPLIANT\_HOLD

**synonyms:** FV-07; Verified Rehydration Closure

**non\_synonyms:** —

**usage\_constraints:** —

## FV-08 — FV-08 — Replay Reconstruction Sufficiency

**definition\_short:** Family validator for replay reconstruction sufficiency.

**definition\_operational:** Class: Deterministic. Pass condition: Checkpoint reconstruction, rollback reconstruction, and report sufficiency support family replay. Fail effect: REPLAY\_INCOMPLETE.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** REPLAY\_INCOMPLETE

**synonyms:** FV-08; Replay Reconstruction Sufficiency

**non\_synonyms:** —

**usage\_constraints:** —

## FV-09 — FV-09 — Contamination Absence

**definition\_short:** Family validator for contamination absence.

**definition\_operational:** Class: Cross-domain deterministic. Pass condition: No unauthorized artifact or inadmissible carried claim influences the verdict. Fail effect: CONTAMINATION\_FAIL\_CLOSED.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** CONTAMINATION\_FAIL\_CLOSED

**synonyms:** FV-09; Contamination Absence

**non\_synonyms:** —

**usage\_constraints:** —

## FV-10 — FV-10 — Disclosure Class Preservation

**definition\_short:** Family validator for disclosure class preservation.

**definition\_operational:** Class: Deterministic. Pass condition: Every carried openness or defect is classified and preserved distinctly. Fail effect: INCIDENT\_ONLY.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** INCIDENT\_ONLY

**synonyms:** FV-10; Disclosure Class Preservation

**non\_synonyms:** —

**usage\_constraints:** —

## FV-11 — FV-11 — Family Evidence Closure

**definition\_short:** Family validator for family evidence closure.

**definition\_operational:** Class: Deterministic. Pass condition: The family validator bundle and boundary-event evidence report are sufficient for offline reconstruction. Fail effect: INCIDENT\_ONLY.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** INCIDENT\_ONLY

**synonyms:** FV-11; Family Evidence Closure

**non\_synonyms:** —

**usage\_constraints:** —

## FV-12 — FV-12 — Family Readmission Closure

**definition\_short:** Family validator for family readmission closure.

**definition\_operational:** Class: Deterministic. Pass condition: hold\_exit\_refs, anchor\_update\_ref, and policy stability are present for readmission. Fail effect: NONCOMPLIANT\_HOLD.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §7 Validator Catalogue

**related\_terms:** NONCOMPLIANT\_HOLD

**synonyms:** FV-12; Family Readmission Closure

**non\_synonyms:** —

**usage\_constraints:** —

# State Terms

## S0 — S0 FAMILY\_INTAKE

**definition\_short:** The continuity package has been received but not yet admitted.

**definition\_operational:** Entry trigger: FIC-01 valid. Exit trigger: Admission.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FIC-01 valid; Admission

**synonyms:** S0; FAMILY\_INTAKE

**non\_synonyms:** —

**usage\_constraints:** —

## S1 — S1 SOURCE\_COVERAGE\_ADMITTED

**definition\_short:** Required control coverage is present and admitted.

**definition\_operational:** Entry trigger: FV-01 pass. Exit trigger: Boundary screening.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FV-01 pass; Boundary screening

**synonyms:** S1; SOURCE\_COVERAGE\_ADMITTED

**non\_synonyms:** —

**usage\_constraints:** —

## S2 — S2 BOUNDARY\_SCREENED

**definition\_short:** Anchor and payload remain untrusted, but boundary contracts have passed.

**definition\_operational:** Entry trigger: FV-02 and FV-04 pass. Exit trigger: Provenance classification.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FV-02 and FV-04 pass; Provenance classification

**synonyms:** S2; BOUNDARY\_SCREENED

**non\_synonyms:** —

**usage\_constraints:** —

## S3 — S3 PROVENANCE\_CLASSIFIED

**definition\_short:** Carried claims have passed provenance and role validation.

**definition\_operational:** Entry trigger: FV-03 pass. Exit trigger: Accepted-head / freshness lock.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FV-03 pass; Accepted-head / freshness lock

**synonyms:** S3; PROVENANCE\_CLASSIFIED

**non\_synonyms:** —

**usage\_constraints:** —

## S4 — S4 ANCHOR\_LOCKED

**definition\_short:** Accepted head and strictly increasing anchor are locked.

**definition\_operational:** Entry trigger: FV-05 and FV-06 pass. Exit trigger: Verified rehydration closure.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FV-05 and FV-06 pass; Verified rehydration closure

**synonyms:** S4; ANCHOR\_LOCKED

**non\_synonyms:** —

**usage\_constraints:** —

## S5 — S5 REHYDRATION\_CLOSED

**definition\_short:** The rehydration bundle is fully verified.

**definition\_operational:** Entry trigger: FV-07 pass. Exit trigger: Replay reconstruction.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FV-07 pass; Replay reconstruction

**synonyms:** S5; REHYDRATION\_CLOSED

**non\_synonyms:** —

**usage\_constraints:** —

## S6 — S6 REPLAY\_RECONSTRUCTED

**definition\_short:** Replay reconstruction is sufficient for offline reconstruction.

**definition\_operational:** Entry trigger: FV-08 pass. Exit trigger: Family report assembly.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FV-08 pass; Family report assembly

**synonyms:** S6; REPLAY\_RECONSTRUCTED

**non\_synonyms:** —

**usage\_constraints:** —

## S7 — S7 REPORT\_READY

**definition\_short:** The boundary-event evidence report is complete.

**definition\_operational:** Entry trigger: FV-10 and FV-11 pass. Exit trigger: Emit family verdict.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** FV-10 and FV-11 pass; Emit family verdict

**synonyms:** S7; REPORT\_READY

**non\_synonyms:** —

**usage\_constraints:** —

## S8 — S8 REPLAY\_ADMITTED

**definition\_short:** Family replay is admissible.

**definition\_operational:** Entry trigger: Family verdict issued. Exit trigger: Handoff.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** Family verdict issued; Handoff

**synonyms:** S8; REPLAY\_ADMITTED

**non\_synonyms:** —

**usage\_constraints:** —

## SH — SH NONCOMPLIANT\_HOLD

**definition\_short:** Closure is incomplete but remediable.

**definition\_operational:** Entry trigger: Remediable failure of FV-06 or FV-12. Exit trigger: Readmission review.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** Remediable failure of FV-06 or FV-12; Readmission review

**synonyms:** SH; NONCOMPLIANT\_HOLD

**non\_synonyms:** —

**usage\_constraints:** —

## SR — SR READMISSION\_REVIEW

**definition\_short:** A new bundle or new policy state is under evaluation.

**definition\_operational:** Entry trigger: hold\_exit\_refs and anchor\_update\_ref present. Exit trigger: S2 or S5.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** hold\_exit\_refs and anchor\_update\_ref present; S2 or S5

**synonyms:** SR; READMISSION\_REVIEW

**non\_synonyms:** —

**usage\_constraints:** —

## SX — SX CONTAMINATION\_FAIL\_CLOSED

**definition\_short:** Critical contamination or unresolved prerequisite failure has occurred.

**definition\_operational:** Entry trigger: Blocking failure of FV-02, FV-03, FV-07, or FV-09. Exit trigger: Incident-only output.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §9 Workflow and State Transitions

**related\_terms:** Blocking failure of FV-02, FV-03, FV-07, or FV-09; Incident-only output

**synonyms:** SX; CONTAMINATION\_FAIL\_CLOSED

**non\_synonyms:** —

**usage\_constraints:** —

# Family Evidence Terms

## FEV-01 — FEV-01 family\_decision\_id

**definition\_short:** Unique identifier of the family verdict.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-01; family\_decision\_id

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-02 — FEV-02 boundary\_event\_id

**definition\_short:** Identifies the reconstructible boundary event.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-02; boundary\_event\_id

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-03 — FEV-03 session\_id / prior\_session\_ref

**definition\_short:** Links the verdict to the current session and the prior source.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-03; session\_id / prior\_session\_ref

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-04 — FEV-04 carried\_statement\_refs

**definition\_short:** Lists the carried claims that influenced the verdict.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-04; carried\_statement\_refs

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-05 — FEV-05 tsa\_refs / provenance\_refs

**definition\_short:** Proves provenance classification and admissibility.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-05; tsa\_refs / provenance\_refs

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-06 — FEV-06 anchor\_document\_digest / anchor\_document\_ref

**definition\_short:** Links the verdict to the anchor document treated as untrusted input.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-06; anchor\_document\_digest / anchor\_document\_ref

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-07 — FEV-07 accepted\_head\_digest / linked\_irr\_digest

**definition\_short:** Closes accepted-head visibility.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-07; accepted\_head\_digest / linked\_irr\_digest

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-08 — FEV-08 freshness\_before / freshness\_after / anchor\_update\_ref

**definition\_short:** Proves strict increase and readmission safety.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-08; freshness\_before / freshness\_after / anchor\_update\_ref

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-09 — FEV-09 rehydration\_closure\_ref

**definition\_short:** Links the verdict to the verified rehydration bundle.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-09; rehydration\_closure\_ref

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-10 — FEV-10 replay\_refs / checkpoint\_refs / rollback\_refs

**definition\_short:** Proves replay reconstruction closure and reconstructibility.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-10; replay\_refs / checkpoint\_refs / rollback\_refs

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-11 — FEV-11 disclosure\_class\_entries

**definition\_short:** Preserves real defects, bounded openness, and handoff obligations distinctly.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-11; disclosure\_class\_entries

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-12 — FEV-12 family\_validator\_outcomes

**definition\_short:** Supports replay of family-level admissibility.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-12; family\_validator\_outcomes

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-13 — FEV-13 hold\_enter\_refs / hold\_exit\_refs

**definition\_short:** Mandatory when a hold or readmission exists.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-13; hold\_enter\_refs / hold\_exit\_refs

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-14 — FEV-14 contamination\_flags / contaminating\_ref\_set

**definition\_short:** Mandatory for contamination fail-closed cases.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-14; contamination\_flags / contaminating\_ref\_set

**non\_synonyms:** —

**usage\_constraints:** —

## FEV-15 — FEV-15 report\_signature / export\_manifest\_ref

**definition\_short:** Mandatory for final output and chain of custody.

**definition\_operational:** Public field of the Evidence Contract. Used for closure, offline reconstruction, and chain of custody in the boundary-event evidence bundle.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §11 Evidence Contract; SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix

**related\_terms:** BoundaryEventEvidenceReport; family\_validator\_outcomes; disclosure\_class\_entries

**synonyms:** FEV-15; report\_signature / export\_manifest\_ref

**non\_synonyms:** —

**usage\_constraints:** —

# Family Observability Terms

## FOR-01 — FOR-01 Material transition observability

**definition\_short:** Every material family-level transition emits an observable artifact.

**definition\_operational:** A material family-level transition is one that crosses a §9 workflow state boundary, enters SH/SR/SX/S8, or emits a §3.2 output artifact (FOC-01..05). The integrator must produce at least one observable artifact for each such transition; silent state advancement is forbidden.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §13 Observability Rules

**related\_terms:** family verdict; BoundaryEventEvidenceReport; family\_validator\_outcomes

**synonyms:** FOR-01

**non\_synonyms:** —

**usage\_constraints:** Observability is mandatory; deployment may not suppress emission.

## FOR-02 — FOR-02 Verdict requires validator outcomes

**definition\_short:** No family verdict exists without family\_validator\_outcomes.

**definition\_operational:** A family verdict (FOC-01 FamilyVerdict) is admissible only if accompanied by a populated family\_validator\_outcomes evidence record (FEV-12). Verdict emission without validator-outcome evidence is forbidden.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §13 Observability Rules

**related\_terms:** family verdict; FEV-12 family\_validator\_outcomes; FOC-01 FamilyVerdict

**synonyms:** FOR-02

**non\_synonyms:** —

**usage\_constraints:** Mandatory pre-condition for any family verdict emission.

## FOR-03 — FOR-03 Hold records hold\_enter\_refs

**definition\_short:** Every hold records hold\_enter\_refs and pending requirements.

**definition\_operational:** Entry into SH NONCOMPLIANT\_HOLD requires emission of FOC-05 FamilyHoldRecord with non-empty hold\_enter\_refs and a populated pending\_requirements list. Hold cases without these fields are inadmissible.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §13 Observability Rules

**related\_terms:** SH NONCOMPLIANT\_HOLD; FOC-05 FamilyHoldRecord; FEV-13 hold\_enter\_refs

**synonyms:** FOR-03

**non\_synonyms:** —

**usage\_constraints:** Mandatory whenever the workflow enters SH.

## FOR-04 — FOR-04 Readmission records hold\_exit and anchor\_update

**definition\_short:** Every readmission records hold\_exit\_refs and anchor\_update\_ref.

**definition\_operational:** Transition from SH to SR requires non-empty hold\_exit\_refs (FEV-13) and a strictly increasing anchor\_update\_ref (FEV-08). Readmission attempts missing either field are inadmissible.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §13 Observability Rules

**related\_terms:** SR READMISSION\_REVIEW; FIC-03 FamilyReadmissionReview; FEV-08 anchor\_update\_ref; FEV-13 hold\_exit\_refs

**synonyms:** FOR-04

**non\_synonyms:** —

**usage\_constraints:** Mandatory for every SH → SR transition.

## FOR-05 — FOR-05 Contamination records contaminating\_ref\_set

**definition\_short:** Every contamination case records contaminating\_ref\_set and blocked\_stage.

**definition\_operational:** Entry into SX CONTAMINATION\_FAIL\_CLOSED requires emission of FOC-04 ContaminationIncidentNotice with a populated contaminating\_ref\_set (FEV-14) and a non-empty blocked\_stage. Contamination cases without these fields are inadmissible.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §13 Observability Rules

**related\_terms:** SX CONTAMINATION\_FAIL\_CLOSED; FOC-04 ContaminationIncidentNotice; FEV-14 contamination\_flags / contaminating\_ref\_set

**synonyms:** FOR-05

**non\_synonyms:** —

**usage\_constraints:** Mandatory whenever the workflow enters SX.

## FOR-06 — FOR-06 Disclosure entries on gaps and handoffs

**definition\_short:** disclosure\_class\_entries are mandatory whenever the report contains gaps or transfer obligations.

**definition\_operational:** Whenever the BoundaryEventEvidenceReport (FOC-02) contains content classified as TRUE\_DEFECT, BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS, or BOUNDED\_HANDOFF\_OBLIGATION, the corresponding disclosure\_class\_entries (FEV-11) record must be populated. Reports containing such content without disclosure\_class\_entries collapse the disclosure classes (DISCLOSURE\_CLASS\_COLLAPSE) and route to INCIDENT\_ONLY.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §13 Observability Rules

**related\_terms:** FEV-11 disclosure\_class\_entries; TRUE\_DEFECT; BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS; BOUNDED\_HANDOFF\_OBLIGATION; DISCLOSURE\_CLASS\_COLLAPSE

**synonyms:** FOR-06

**non\_synonyms:** —

**usage\_constraints:** Mandatory whenever a disclosure-class condition exists in the report.

# Family Conformance Scenarios

## SC-01 — SC-01 Required control coverage complete

**definition\_short:** Reference scenario: required control coverage is complete.

**definition\_operational:** Scenario in which all required continuity-control domains are present and admitted for family use. Expected result: all required continuity-control domains are admitted. Minimum evidence: FV-01 evidence.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-01 Required Control Coverage; S1 SOURCE\_COVERAGE\_ADMITTED

**synonyms:** SC-01

**non\_synonyms:** —

**usage\_constraints:** Used as the canonical positive-path coverage scenario for FV-01.

## SC-02 — SC-02 Carried mechanism-level claim lacks tsa\_label or source\_class

**definition\_short:** Reference scenario: a carried mechanism-level claim lacks tsa\_label or source\_class.

**definition\_operational:** Scenario in which a carried mechanism-level claim is missing admitted tsa\_label or source\_class. Expected result: CONTAMINATION\_FAIL\_CLOSED. Minimum evidence: tsa\_refs and blocked\_stage.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-03 Carried Claim Provenance Admissibility; FD-02 CARRIED\_CLAIM\_INADMISSIBLE; UNLABELED\_CARRIED\_MECHANISM\_CLAIM; CONTAMINATION\_FAIL\_CLOSED

**synonyms:** SC-02

**non\_synonyms:** —

**usage\_constraints:** Canonical negative-path scenario for FV-03 contamination branch.

## SC-03 — SC-03 Anchor document treated as trusted

**definition\_short:** Reference scenario: an upstream assertion attempts to treat the anchor document as trusted.

**definition\_operational:** Scenario in which an upstream caller attempts to bypass boundary validation and treat the anchor document as already-trusted input. Expected result: boundary revalidation and block until closure (UNTRUSTED\_ANCHOR\_PROMOTED → CONTAMINATION\_FAIL\_CLOSED). Minimum evidence: boundary-validator evidence.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-02 Boundary Input Contract; untrusted input; UNTRUSTED\_ANCHOR\_PROMOTED; CONTAMINATION\_FAIL\_CLOSED

**synonyms:** SC-03

**non\_synonyms:** —

**usage\_constraints:** Canonical negative-path scenario for FV-02 / boundary trust violation.

## SC-04 — SC-04 Freshness fail or anchor stagnates

**definition\_short:** Reference scenario: freshness\_new ≤ watermark or anchor stagnates.

**definition\_operational:** Scenario in which the freshness anchor is not strictly increasing relative to the local continuity watermark, or the accepted head is outdated. Expected result: NONCOMPLIANT\_HOLD. Minimum evidence: freshness\_before/after and hold\_enter\_refs.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-06 Freshness / Anchor Strict Increase; FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR; FD-07 NONCOMPLIANT\_HOLD; SH NONCOMPLIANT\_HOLD

**synonyms:** SC-04

**non\_synonyms:** —

**usage\_constraints:** Canonical negative-path scenario for FV-06 freshness branch.

## SC-05 — SC-05 Snapshot mismatch or anti-rollback failure

**definition\_short:** Reference scenario: snapshot mismatch or anti-rollback failure.

**definition\_operational:** Scenario in which snapshot stability is broken or anti-rollback verification fails during rehydration. Expected result: CONTAMINATION\_FAIL\_CLOSED (non-remediable per FV-07 remediability test). Minimum evidence: rehydration\_closure\_ref and anchor status.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-07 Verified Rehydration Closure; anti-rollback; REHYDRATION\_PREREQ\_FAIL; CONTAMINATION\_FAIL\_CLOSED

**synonyms:** SC-05

**non\_synonyms:** —

**usage\_constraints:** Canonical negative-path scenario for FV-07 non-remediable branch.

## SC-06 — SC-06 Replay reconstruction incomplete

**definition\_short:** Reference scenario: checkpoint, rollback, or report closure is incomplete.

**definition\_operational:** Scenario in which checkpoint reconstruction, rollback reconstruction, or report sufficiency is insufficient to support family replay. Expected result: REPLAY\_INCOMPLETE. Minimum evidence: replay\_refs and report-field evidence.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-08 Replay Reconstruction Sufficiency; REPLAY\_RECONSTRUCTION\_INCOMPLETE; REPLAY\_INCOMPLETE

**synonyms:** SC-06

**non\_synonyms:** —

**usage\_constraints:** Canonical negative-path scenario for FV-08 replay closure.

## SC-07 — SC-07 Unauthorized tool-state in anchor payload

**definition\_short:** Reference scenario: unauthorized tool-state appears inside the anchor payload.

**definition\_operational:** Scenario in which the anchor payload contains tool-state material not admitted by the boundary contract. Expected result: contamination handling or local quarantine without replay admission. Minimum evidence: tool-state evidence and contamination flags.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-09 Contamination Absence; FOC-04 ContaminationIncidentNotice; CONTAMINATION\_FAIL\_CLOSED

**synonyms:** SC-07

**non\_synonyms:** —

**usage\_constraints:** Canonical negative-path scenario for unauthorized tool-state contamination.

## SC-08 — SC-08 Family closure complete

**definition\_short:** Reference scenario: family closure is complete.

**definition\_operational:** Scenario in which boundary screening, provenance classification, accepted-head/freshness lock, verified rehydration closure, replay reconstruction, disclosure-class preservation, and family evidence closure all pass. Expected result: REPLAY\_ADMISSIBLE. Minimum evidence: complete family validator bundle (FEV-01..FEV-15 as applicable).

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** S8 REPLAY\_ADMITTED; FOC-01 FamilyVerdict; FOC-03 ReplayAdmissionToken; REPLAY\_ADMISSIBLE

**synonyms:** SC-08

**non\_synonyms:** —

**usage\_constraints:** Canonical positive-path terminal scenario.

## SC-09 — SC-09 Disclosure classes collapsed

**definition\_short:** Reference scenario: disclosure classes are collapsed into a generic defect.

**definition\_operational:** Scenario in which TRUE\_DEFECT, BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS, and BOUNDED\_HANDOFF\_OBLIGATION are merged or omitted in the report rather than recorded distinctly. Expected result: INCIDENT\_ONLY until disclosure classes are corrected. Minimum evidence: disclosure\_class\_entries.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-10 Disclosure Class Preservation; DISCLOSURE\_CLASS\_COLLAPSE; FD-09 INCIDENT\_ONLY; INCIDENT\_ONLY

**synonyms:** SC-09

**non\_synonyms:** —

**usage\_constraints:** Canonical negative-path scenario for FV-10 disclosure preservation.

## SC-10 — SC-10 Hold case with new evidence and anchor update

**definition\_short:** Reference scenario: a hold case receives new evidence and a new anchor update.

**definition\_operational:** Scenario in which a case in SH NONCOMPLIANT\_HOLD is presented with new\_evidence\_refs (or a new\_policy\_ref) and a strictly increasing anchor\_update\_ref. Expected result: READMISSION\_REVIEW\_GRANTED with controlled resumption (SH → SR; identical readmission on the same artifacts is forbidden). Minimum evidence: hold\_exit\_refs and anchor\_update\_ref.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §15.2 Reference scenarios

**related\_terms:** FV-12 Family Readmission Closure; FIC-03 FamilyReadmissionReview; FD-10 READMISSION\_REVIEW\_GRANTED; SR READMISSION\_REVIEW

**synonyms:** SC-10

**non\_synonyms:** —

**usage\_constraints:** Canonical recovery-path scenario.

# Family Acceptance Criteria

## AC-01 — AC-01 Control-domain coherence

**definition\_short:** All required control domains and public specification artifacts exist and are internally coherent.

**definition\_operational:** Acceptance criterion: the public specification covers all required control domains (boundary, provenance, anchor, rehydration, replay, disclosure, evidence, readmission) without internal contradiction across §1–§17.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria

**related\_terms:** Required control coverage; FV-01 Required Control Coverage

**synonyms:** AC-01

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion; verified during freeze gate.

## AC-02 — AC-02 Continuity-bundle admission

**definition\_short:** Every required source continuity bundle or equivalent control bundle is admitted explicitly for family use.

**definition\_operational:** Acceptance criterion: source continuity bundles enter family processing only via FIC-01 FamilyContinuityIntake with admitted source\_control\_bundles; ad-hoc admission paths are forbidden.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria

**related\_terms:** FIC-01 FamilyContinuityIntake; source\_control\_bundles

**synonyms:** AC-02

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion.

## AC-03 — AC-03 Decision-rule full linkage

**definition\_short:** Every family decision rule is linked to at least one family validator and at least one family evidence field.

**definition\_operational:** Acceptance criterion: each FD-\* in §8 must trace to at least one FV-\* in §7 and at least one FEV-\* in §11. Decision rules without validator-and-evidence linkage are inadmissible.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria

**related\_terms:** FD-01 through FD-10; FV-01 through FV-12; FEV-01 through FEV-15

**synonyms:** AC-03

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion; cross-checked against Appendix A.

## AC-04 — AC-04 State-model verdict and remediation coverage

**definition\_short:** The state model covers every verdict and every declared remediation path.

**definition\_operational:** Acceptance criterion: every canonical verdict (REPLAY\_ADMISSIBLE, REPLAY\_ADMISSIBLE\_CONSTRAINED, REPLAY\_INCOMPLETE, NONCOMPLIANT\_HOLD, CONTAMINATION\_FAIL\_CLOSED, INCIDENT\_ONLY) is reachable through §9 workflow paths or via the verdict-emission layer; every declared remediation path (SH → SR → S2/S5) is defined.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria

**related\_terms:** Family verdict vocabulary; Workflow and State Transitions; SR READMISSION\_REVIEW

**synonyms:** AC-04

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion.

## AC-05 — AC-05 Offline reconstruction of representative event

**definition\_short:** The family verdict can be reconstructed offline for at least one representative boundary event.

**definition\_operational:** Acceptance criterion: using only the BoundaryEventEvidenceReport (FOC-02), the family validator bundle, and the linked evidence fields, an external auditor must be able to reconstruct the family verdict for at least one representative boundary event without access to the live runtime.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria

**related\_terms:** FOC-02 BoundaryEventEvidenceReport; boundary event; replay reconstruction

**synonyms:** AC-05

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion; replay-readiness gate.

## AC-06 — AC-06 Negative-path coverage

**definition\_short:** Negative-path coverage exists for contamination, freshness replay, and incomplete replay closure.

**definition\_operational:** Acceptance criterion: §15.2 reference scenarios include at least one scenario each for contamination (SC-02, SC-03, SC-05, SC-07), freshness replay (SC-04), and incomplete replay closure (SC-06), with corresponding workflow and verdict semantics defined.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria

**related\_terms:** SC-02; SC-03; SC-04; SC-05; SC-06; SC-07

**synonyms:** AC-06

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion; technical-correctness gate.

## AC-07 — AC-07 No critical unresolved gap

**definition\_short:** No critical unresolved gap remains on identity, authority, boundary, evidence, replay, or handoff semantics.

**definition\_operational:** Acceptance criterion: at the freeze gate, the package contains no TRUE\_DEFECT classified item affecting identity, authority, boundary, evidence, replay, or handoff semantics. Bounded execution-neutral openness and bounded handoff obligations are permitted; true defects are not.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria

**related\_terms:** TRUE\_DEFECT; BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS; BOUNDED\_HANDOFF\_OBLIGATION

**synonyms:** AC-07

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion; freeze gate.

## AC-08 — AC-08 Implementation-owned items separated

**definition\_short:** Implementation-owned open items are explicitly separated and do not affect the semantic core, validator semantics, evidence closure, or handoff readiness.

**definition\_operational:** Acceptance criterion: every implementation-owned open item (cryptographic suite, storage backend, serialization, operator workflow, optional assurance components, hardware attestation, rollback execution per §17) is explicitly listed and does not modify the §17.3 stable semantic core. Items that would alter the semantic core, verdict vocabulary, validator semantics, evidence closure, or handoff rules are forbidden under §17.5 non-reuse zones.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §16 Acceptance Criteria; SSCAR\_Specification §17 Implementation Boundaries, Optional Parameters, and Reuse Rules

**related\_terms:** Stable semantic core; Implementation boundaries; Non-reuse zones

**synonyms:** AC-08

**non\_synonyms:** —

**usage\_constraints:** Package-level conformance criterion; execution-neutrality gate.

# Machine-Readable Handoff Terms

## family\_integrator\_id — family\_integrator\_id

**definition\_short:** Machine-readable handoff field identifying the family integrator.

**definition\_operational:** Appears in the §12 normative JSON shape for automated handoff and binds the handoff record to the SSCAR family integrator. For this package the value is FAM-SSCAR-FI-001.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §12 Machine-Readable Form Catalogue

**related\_terms:** FAM-SSCAR-FI-001; family integrator; FamilyVerdict

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** Use only as the machine-readable field binding automated handoff to the family integrator identity.

## blocked\_stage — blocked\_stage

**definition\_short:** Machine-readable handoff field recording the stage blocked by fail-closed or incident handling.

**definition\_operational:** Appears in the §12 normative JSON shape and in FOC-04 ContaminationIncidentNotice. It identifies the workflow or gate stage at which processing was blocked for contamination, incident-only handling, or equivalent protected routing.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §12 Machine-Readable Form Catalogue; SSCAR\_Specification §3.2 Output contract / FOC-04 ContaminationIncidentNotice

**related\_terms:** FOC-04 ContaminationIncidentNotice; CONTAMINATION\_FAIL\_CLOSED; FEV-14 contamination\_flags / contaminating\_ref\_set

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** Required for contamination incident notices and for machine-readable protected-routing traceability when a stage is blocked.

## readmission\_case\_id — readmission\_case\_id

**definition\_short:** Machine-readable handoff field identifying a readmission case.

**definition\_operational:** Appears in the §12 normative JSON shape for automated handoff and links the machine-readable record to a hold/readmission case when the workflow enters or resumes from NONCOMPLIANT\_HOLD / READMISSION\_REVIEW handling.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §12 Machine-Readable Form Catalogue

**related\_terms:** FIC-03 FamilyReadmissionReview; SH NONCOMPLIANT\_HOLD; SR READMISSION\_REVIEW; FEV-13 hold\_enter\_refs / hold\_exit\_refs

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** Use when automated handoff must identify the readmission case associated with hold or readmission processing.

# Abbreviation Terms

## ABBR-01 — IRR

**definition\_short:** Public abbreviation used for the accepted head / IRR linkage and linked\_irr\_digest.

**definition\_operational:** In ordering, the accepted head must be linked to the latest valid IRR, and ReplayAdmissionToken preserves linked\_irr\_digest as evidence of that linkage.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification §1.3 Required control coverage; SSCAR\_Specification §1.4 Cross-domain operating rules; SSCAR\_Specification §3.2 Output contract / FOC-03 ReplayAdmissionToken

**related\_terms:** accepted head; ReplayAdmissionToken; accepted\_anchor\_state

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —

## ABBR-02 — LLM

**definition\_short:** Public abbreviation for the language model at the session level.

**definition\_operational:** The specification governs cross-session epistemic continuity across LLM sessions, including transitions between different LLM models.

**normative\_status:** normative

**source\_refs:** SSCAR\_Specification Intro table / Primary role; SSCAR\_Specification Intro table / Mission statement

**related\_terms:** Session State Continuity \& Anchor Replay Family Integrator

**synonyms:** —

**non\_synonyms:** —

**usage\_constraints:** —
