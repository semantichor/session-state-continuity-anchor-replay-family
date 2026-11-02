Boundary Defense Agent

Specification

*Buyer-facing package version*

## Document Control

| Document class | Specification |
| --- | --- |
| **Audience** | Buyer-facing |
| **Language** | English |
| **Status** | Execution-neutral, standalone, normatively complete |
| **Version date** | Public Release v2.0 |
| **Agent role** | Boundary-control agent for ingress, egress, persistence, and transport-adjacent artifact exchange |

This specification defines a fail-closed boundary agent that validates, filters, quarantines, blocks, and conditionally releases artifacts that cross a controlled runtime, persistence, or transport boundary. It is designed to remain implementable without access to any non-public support material.

# Operational Definitions

| Term | Public Definition |
| --- | --- |
| **Boundary artifact** | Any input, output, tool-state payload, or persistence/transport-adjacent object that attempts to cross the controlled boundary. |
| **Tool-state payload** | A capability-bearing payload associated with a tool or tool-derived state. Structural restoration does not grant execution authority. |
| **Statement record** | A gate-relevant claim identified by statement\_id and accompanied by tsa\_label and source\_class so it can be used in auditable decision logic. |
| **tsa\_label** | The explicit label attached to a statement record to mark its status for gate use. |
| **source\_class** | The admissibility class assigned to the source of a gate-relevant statement. |
| **CPW** | Crash Proximity Warning, the risk-banding mechanism that constrains behavior and can force fail-closed handling at CRITICAL. |
| **Accepted anchor** | The last accepted freshness or verification watermark used to reject replay and downgrade attempts. |
| **evidence\_ok** | The Boolean result returned by the evidence gate when finalization prerequisites are checked. |
| **VERIF\_COUNTER** | A strictly increasing verification counter used, where deployed, to prevent replay at finalization time. |
| **Readmission** | Controlled restoration of a previously blocked or quarantined path after all mandatory validators, approvals, and anchors are satisfied. |

## Semantic Core Summary

| Agent identity | Boundary Defense Agent |
| --- | --- |
| **Role** | Controls frontier interactions and exchanges; validates, filters, and blocks I/O |
| **Architectural model** | Fail-closed runtime boundary governance with transport/persistence boundary controls |
| **Primary decision objects** | ingress\_request; tool\_state\_payload; output\_release\_request; finalization\_request; statement\_usage\_request |
| **Primary states** | IDLE; INGEST\_VALIDATE; FILTER\_REVIEW; TOOL\_STATE\_QUARANTINED; READY\_FOR\_RELEASE; OUTPUT\_BLOCKED; FINALIZATION\_REVIEW; NONCOMPLIANT\_HOLD |
| **Primary events** | INPUT\_RECEIVED; VALIDATION\_PASS; VALIDATION\_FAIL; APPROVAL\_GRANTED; APPROVAL\_DENIED; CPW\_CRITICAL; EVIDENCE\_OK; EVIDENCE\_FAIL; COUNTER\_REPLAY; READMISSION\_APPROVED |
| **Primary verdict vocabulary** | ALLOW; ALLOW\_CONSTRAINED; BLOCK; QUARANTINE; FAIL\_CLOSED; NONCOMPLIANT\_HOLD; READMIT |
| **Semantic invariant** | No boundary artifact acquires execution, persistence, or transport visibility without explicit validation evidence appropriate to its class |

## Agent Specification Record

| Agent name | Boundary Defense Agent |
| --- | --- |
| **Identity class** | Canonical specialized boundary-control agent |
| **Role** | Validate, authenticate, filter, block, quarantine, and release boundary artifacts under fail-closed governance |
| **Jurisdiction / scope boundary** | All ingress and egress artifacts that cross the controlled boundary of the critical core, including tool-state payloads and finalization-relevant persistence or transport requests |
| **Decision objects** | ingress\_request; tool\_state\_payload; output\_release\_request; finalization\_request; statement\_usage\_request |
| **Boundary** | Logical boundary spanning runtime I/O, persistence commits, and transport of artifacts |
| **Policy model** | Explicit contracts, validator-driven decisions, replay resistance, and evidence-gated finalization |
| **State model** | Closed finite-state machine defined in the workflow section |
| **Event model** | Explicit events defined in the semantic core and workflow sections |
| **Transition model** | Deterministic, validator-driven, and evidence-linked |
| **Fail-closed policy** | Mandatory at schema failure, allowlist failure, CPW critical escalation, evidence failure, counter replay, or authority exhaustion |
| **Replay / reconstruction** | Mandatory; all material verdicts are emitted to an append-only evidence ledger |
| **Build target** | Execution-neutral specification suitable for implementation handoff |

## Agent Authority Record

| Authority source | Authority is defined by this specification together with the active operator policy |
| --- | --- |
| **Delegated scope** | May validate, classify, filter, block, quarantine, release validated artifacts, request finalization evidence checks, and emit decision and evidence records |
| **Non-authority zones** | May not execute tools by virtue of restored state alone; may not bypass the evidence gate; may not rewrite accepted history; may not override operator approval requirements; may not claim truth for unlabeled or inadmissible statements |
| **Authority limit / budget** | Finite policy budget for unresolved validation failures, pending approvals, and critical-risk retries; exhaustion causes block plus escalation |
| **Escalation path** | Boundary Defense Agent -> human/operator approval channel -> external assurance component -> implementation layer |
| **Block triggers** | schema invalid; allowlist miss; unlabeled gate statement; CPW critical; evidence\_ok=false; VERIF\_COUNTER replay; approval absent; authority budget exhausted |
| **Readmission triggers** | All mandatory validators pass, approval (if required) exists, risk band is below CRITICAL, and evidence prerequisites are restored |

## Input Contract Record Set

| Contract ID | Decision object | Mandatory fields | Validators | Default failure verdict |
| --- | --- | --- | --- | --- |
| CONTRACT-IN-001 | ingress\_request | artifact\_type; source\_id; policy\_profile\_id; payload\_digest; schema\_id | Schema Validator; Policy/Allowlist Validator; source binding check | BLOCK |
| CONTRACT-IN-002 | tool\_state\_payload | tool\_manifest; tool\_ids; claimed\_permissions; payload\_digest | Schema Validator; Policy/Allowlist Validator; Approval Validator | QUARANTINE |
| CONTRACT-IN-003 | finalization\_request | op\_type; state\_hash; policy\_hash; measurement\_ref | Evidence Chain Validator; Freshness/replay validator | NONCOMPLIANT\_HOLD |
| CONTRACT-IN-004 | statement\_usage\_request | statement\_id; tsa\_label; source\_class; scope\_id | Statement Provenance Validator | BLOCK / CONFLICT |

## Output Contract Record Set

| Contract ID | Output artifact | Mandatory fields |
| --- | --- | --- |
| CONTRACT-OUT-001 | boundary\_verdict | decision\_id; verdict; reason\_code; validator\_results; statement\_refs; input\_digest |
| CONTRACT-OUT-002 | quarantine\_notice | decision\_id; quarantine\_reason; activation\_requirements; approval\_ref(optional) |
| CONTRACT-OUT-003 | release\_notice | decision\_id; release\_scope; policy\_hash; evidence\_refs(optional) |
| CONTRACT-OUT-004 | incident\_report | decision\_id; fail\_reason; hold\_refs; rollback\_ref(optional); limitations |

## Decision Table Record

| Rule ID | Condition | Verdict | Required effect |
| --- | --- | --- | --- |
| D-01 | schema\_invalid=true | BLOCK | Emit boundary\_verdict; no downstream parsing |
| D-02 | allowlist\_pass=false | BLOCK | Emit boundary\_verdict; remain OUTPUT\_BLOCKED |
| D-03 | tool\_state\_detected=true AND approval\_ref absent | QUARANTINE | Enter TOOL\_STATE\_QUARANTINED; emit quarantine\_notice |
| D-04 | statement missing tsa\_label OR source\_class inadmissible | BLOCK / CONFLICT | Emit conflict event; deny gate use |
| D-05 | freshness \<= accepted\_anchor OR receipt missing | BLOCK | Keep accepted head unchanged |
| D-06 | cpw\_band=CRITICAL | FAIL\_CLOSED | Emit FAIL\_CLOSED; inhibit release/finalization |
| D-07 | evidence\_ok=false OR VERIF\_COUNTER\<=anchor | NONCOMPLIANT\_HOLD | Block finalization and emit incident\_report |
| D-08 | all mandatory validators pass AND no escalation condition | ALLOW\_CONSTRAINED or ALLOW | Release according to policy scope |
| D-09 | authority\_budget\_exhausted=true | QUARANTINE / NONCOMPLIANT\_HOLD | Escalate; no further release until readmission |

# Validator Catalogue

The validator set operates only over the semantic verdict set ALLOW, ALLOW\_CONSTRAINED, BLOCK, QUARANTINE, FAIL\_CLOSED, NONCOMPLIANT\_HOLD, and READMIT. No uncontrolled synonym set is permitted.

| Validator ID | Validator | Purpose | Failure effect |
| --- | --- | --- | --- |
| VAL-01 | Schema Validator | Confirms required structure and field typing | Produces BLOCK for malformed ingress or tool-state payloads |
| VAL-02 | Policy / Allowlist Validator | Checks policy compatibility and allowlisted types/tools | Produces BLOCK or QUARANTINE for disallowed classes |
| VAL-03 | Statement Provenance Validator | Checks statement\_id, tsa\_label, source\_class, and scope | Produces BLOCK plus conflict evidence for unlabeled gate logic |
| VAL-04 | Freshness / Receipt Validator | Checks strict increase and accepted-head binding | Produces BLOCK for replay and downgrade attempts |
| VAL-05 | Evidence Chain Validator | Checks evidence\_ok, evidence\_ref, and replay anchor conditions | Produces NONCOMPLIANT\_HOLD or FAIL\_CLOSED at finalization failure |
| VAL-06 | Approval Validator | Checks explicit operator approval for tool-state activation | Keeps the path in QUARANTINE until explicit approval is evidenced |
| VAL-07 | CPW Band Validator | Confirms the band-driven action envelope | Produces FAIL\_CLOSED at CRITICAL band |
| VAL-08 | Reconstruction Validator | Confirms evidence sufficiency for offline replay | Supports READMIT by confirming that replay evidence is sufficient |

# Workflow / State-Transition Record

Every validator above is bound through guard conditions or required artifacts. Reconstruction readiness (VAL-08) is bound at finalization, hold-exit, and readmission-relevant paths.

| From state | Event | Guard | To state | Required artifact |
| --- | --- | --- | --- | --- |
| IDLE | INPUT\_RECEIVED | always | INGEST\_VALIDATE | create ingress\_request record |
| INGEST\_VALIDATE | VALIDATION\_PASS | VAL-01 + VAL-02 + VAL-03 pass | FILTER\_REVIEW | attach validator\_results {VAL-01, VAL-02, VAL-03} |
| INGEST\_VALIDATE | VALIDATION\_FAIL | any of VAL-01 / VAL-02 / VAL-03 / VAL-04 fails | OUTPUT\_BLOCKED | emit BLOCK verdict + failed\_validator\_set |
| FILTER\_REVIEW | TOOL\_STATE\_DETECTED | tool-state present; VAL-02 classifies elevated boundary risk | TOOL\_STATE\_QUARANTINED | emit QUARANTINE verdict + quarantine\_notice |
| FILTER\_REVIEW | NO\_ESCALATION | VAL-02 + VAL-04 + VAL-07 pass and no tool-state risk | READY\_FOR\_RELEASE | prepare release\_notice + validator\_results update |
| TOOL\_STATE\_QUARANTINED | APPROVAL\_GRANTED | VAL-06 passes | READY\_FOR\_RELEASE | log approval\_ref + validator\_results update |
| READY\_FOR\_RELEASE | FINALIZATION\_REQUESTED | release path selected; validator bundle remains attached | FINALIZATION\_REVIEW | call evidence gate with validator\_results context |
| FINALIZATION\_REVIEW | EVIDENCE\_OK | VAL-05 + VAL-08 pass; evidence\_ok=true and the counter strictly increases | IDLE | emit release/commit records + reconstruction-ready evidence bundle |
| FINALIZATION\_REVIEW | EVIDENCE\_FAIL | VAL-05 or VAL-08 fails; evidence failure or replay | NONCOMPLIANT\_HOLD | emit FAIL\_CLOSED, hold entry, and reconstruction\_gap record |
| ANY ACTIVE STATE | CPW\_CRITICAL | VAL-07 detects band CRITICAL | OUTPUT\_BLOCKED | emit FAIL\_CLOSED; optional rollback |
| OUTPUT\_BLOCKED | READMISSION\_APPROVED | failed validators remediated; VAL-08 available where replay claim is restored | IDLE | emit READMIT verdict + remediation\_refs |
| NONCOMPLIANT\_HOLD | COMPLIANCE\_RESTORED | VAL-05 + VAL-08 restored and the anchor is updated | IDLE | emit hold exit + READMIT verdict |

# Gate Logic Record

For this agent, release is represented by ALLOW / ALLOW\_CONSTRAINED, block is represented by BLOCK / QUARANTINE, and escalation is represented by FAIL\_CLOSED / NONCOMPLIANT\_HOLD with READMIT-controlled recovery.

| Gate status | Meaning | Entry condition |
| --- | --- | --- |
| ALLOW | Artifact may cross the boundary within the declared scope | all mandatory validators pass; no escalation condition |
| ALLOW\_CONSTRAINED | Artifact may cross with reduced scope or human review | non-critical risk; policy requires constrained release |
| BLOCK | Artifact may not cross the boundary and no state mutation occurs | schema, policy, or provenance failure |
| QUARANTINE | Artifact is preserved for inspection but is not executable or releasable | tool-state or authority ambiguity |
| FAIL\_CLOSED | No further substantive boundary action is permitted; an auditable failure is emitted | critical risk or prerequisite violation |
| NONCOMPLIANT\_HOLD | Audit-only interval; no compliance-claimed finalization is permitted | evidence gate failure or replay |
| READMIT | A previously blocked or quarantined path is restored under proof | all restoration prerequisites satisfied |

## Evidence Contract Record

| Mandatory fields | decision\_id; session\_id; boundary\_side; decision\_object; input\_digest; policy\_hash; validator\_results; statement\_refs; verdict; reason\_code; order\_index; hash\_prev; hash\_curr |
| --- | --- |
| **Conditional fields** | approval\_ref for tool-state activation; evidence\_ref and verif\_counter\_anchor for finalization; rollback\_ref for recovery actions |
| **Minimum reconstruction claim** | A third party can determine what artifact was evaluated, which validators ran, which claims were used, which verdict was emitted, and whether persistence or transport effects were authorized |
| **Storage requirement** | Append-only or tamper-evident equivalent with externally checkable continuity |
| **Failure rule** | Absence of mandatory evidence downgrades the action to non-compliant and blocks compliance-claimed release |
| **Primary producers** | decision\_id, verdict, reason\_code, and order\_index by the decision engine; validator\_results by VAL-01..VAL-08; statement\_refs by the statement-governance path and VAL-03; approval\_ref by an authorized operator validated through VAL-06; evidence\_ref and verif\_counter\_anchor by the external assurance component and VAL-05; rollback\_ref by the remediation controller |

## Machine-Readable Form Catalogue

| Form ID | Name | Canonical field skeleton |
| --- | --- | --- |
| FORM-001 | BoundaryInputEnvelope | {request\_id, source\_id, artifact\_type, payload\_digest, schema\_id, policy\_profile\_id} |
| FORM-002 | ToolStateEnvelope | {request\_id, tool\_ids\[\], claimed\_permissions\[\], payload\_digest, approval\_required=true} |
| FORM-003 | BoundaryDecisionRecord | {decision\_id, verdict, reason\_code, validator\_results\[\], statement\_refs\[\], order\_index} |
| FORM-004 | FinalizationRequestEnvelope | {request\_id, op\_type, state\_hash, policy\_hash, measurement\_ref} |
| FORM-005 | BoundaryIncidentRecord | {decision\_id, fail\_reason, hold\_refs\[\], rollback\_ref?, limitations\[\]} |

## Semantic Contract Record

| Verdict token | Normative semantic meaning |
| --- | --- |
| ALLOW | The artifact is admissible for the declared boundary scope only; no implied authority exists beyond that scope. |
| ALLOW\_CONSTRAINED | The artifact is admissible under reduced scope, tighter observation, or explicit follow-up review. |
| BLOCK | The artifact is inadmissible and SHALL NOT mutate governed state or gain boundary visibility. |
| QUARANTINE | The artifact may be stored for inspection but remains non-executable and non-releasable. |
| FAIL\_CLOSED | The agent halts substantive boundary progression and emits an auditable failure state. |
| NONCOMPLIANT\_HOLD | The system enters an audit-only posture until evidence prerequisites are restored. |
| READMIT | A previously blocked or quarantined path is re-opened only after explicit restoration evidence is attached. |

## Temporal / Ordering Contract

| Local ordering rule | Each boundary decision receives a monotonically increasing order\_index within its session or scope |
| --- | --- |
| **Statement ordering rule** | statement\_id identity is stable; decision references MUST point to prior or current statement records, never to implicit prose |
| **Acceptance ordering rule** | For transport- or persistence-adjacent actions: validation -> durable receipt or evidence append -> anchor update -> visibility or release |
| **Finalization rule** | Finalization may proceed only if evidence\_ok=true and VERIF\_COUNTER > accepted anchor |
| **Rollback rule** | If FAIL\_CLOSED occurs after a LASTCLEAN-equivalent checkpoint, rollback targets the last clean boundary state only |
| **Readmission rule** | Readmission is legal only after mandatory validators and any required anchors or approvals are present |

## Failure Semantics Record

| Failure condition | Verdict | Normative effect |
| --- | --- | --- |
| schema\_invalid | BLOCK | no downstream parsing or release |
| allowlist\_fail | BLOCK | artifact remains outside admissible scope |
| tool\_state\_without\_approval | QUARANTINE | capability remains inactive |
| unlabeled\_gate\_statement | BLOCK / CONFLICT | gate logic cannot consume the claim |
| freshness\_replay\_or\_missing\_receipt | BLOCK | accepted head remains unchanged |
| cpw\_critical | FAIL\_CLOSED | release inhibited; optional rollback |
| evidence\_fail\_or\_counter\_replay | NONCOMPLIANT\_HOLD | no compliance-claimed finalization |
| authority\_budget\_exhausted | QUARANTINE / HOLD | escalate to the operator or assurance layer |

## Assumption-to-Obligation Closure

| Assumption | Resulting obligation |
| --- | --- |
| Schemas exist for boundary payload classes | Maintain a versioned schema catalogue and bind schema\_id in every input envelope |
| The policy profile is active and stable | Bind policy\_hash in every decision and evidence record |
| An approval channel exists for tool activation | Require approval\_ref before any activation or release of tool-state-derived capability |
| An evidence provider exists where compliance-claimed finalization is required | Block finalization and enter hold if evidence cannot be produced |
| Append-only continuity is preserved | Maintain hash\_prev/hash\_curr or equivalent integrity metadata |
| Source identity can be bound for transport and persistence events | Maintain source\_id-specific anchors and accepted-head visibility |

## Implementation Acceptance Criteria

| Criterion ID | Acceptance criterion | Result type |
| --- | --- | --- |
| HC-01 | All mandatory artifacts in this specification are present and internally consistent | Pass/Fail |
| HC-02 | 100% of decision rules link to at least one validator and one evidence field | Pass/Fail |
| HC-03 | The state model covers all declared verdicts and remediation paths | Pass/Fail |
| HC-04 | Replay and freshness tests for the accepted head and finalization anchor pass | Pass/Fail |
| HC-05 | No open high-severity gaps remain on identity, authority, boundary, evidence, or implementation handoff | Pass/Fail |
| HC-06 | Offline reconstruction of at least one representative boundary session succeeds | Pass/Fail |

## Optionality Register

| Element | Optionality effect |
| --- | --- |
| External assurance component | Optional for non-finalizing audit-only operation; mandatory for compliance-claimed finalization and persisted release claims |
| CPW numeric profile | Policy-variable, but banded escalation and CRITICAL -> FAIL\_CLOSED are mandatory |
| Operator approval for non-tool artifacts | Optional unless policy elevates a class to approval-required |
| Rollback operation | Optional if no clean checkpoint exists; FAIL\_CLOSED remains mandatory |

# Assurance Profile

The assurance claim for the Boundary Defense Agent is that it maintains a closed and explicit identity and authority boundary, governs exchange through explicit contracts, emits sufficient evidence for offline reconstruction, and degrades deterministically by fail-closed handling, quarantine, rollback, or hold rather than by silent or ambiguous behavior.

| Claim family | Assurance content |
| --- | --- |
| Identity claims | Agent name, role, scope, and non-authority zones are fixed |
| Boundary claims | No artifact crosses the boundary without contract evaluation |
| Decision sufficiency claims | Every verdict is linked to validators and evidence fields |
| Fail-closed claims | Critical risk, replay, evidence failure, and tool-state ambiguity produce deterministic blocking states |
| Replay / reconstruction claims | Accepted-head visibility and append-only evidence support offline replay |
| Known gaps | No cryptographic primitive suite is fixed here; implementation-side performance envelopes remain out of scope |

## Validation Requirements

| Validation area | Normative content |
| --- | --- |
| Level 1 - Specification consistency | Decision rules, validators, workflow, gate logic, evidence fields, ordering rules, and failure semantics SHALL be internally consistent with no unresolved high-severity contradiction |
| Level 2 - Technical correctness | Required: schema tests, allowlist tests, provenance mutation tests, replay tests, evidence gate tests, FSM coverage tests, and reconstruction audit |
| Level 3 - Adequacy of transfer | Boundary contract coverage, replay sufficiency, gate determinacy, authority clarity, and state transition coverage SHALL be assessed against a generic pass-through boundary baseline |
| Primary metrics | agent specification completeness; decision contract coverage; boundary contract coverage; replay sufficiency ratio; gate determinacy; authority clarity; state transition coverage; readmission traceability |
| Minimum negative tests | invalid schema; disallowed tool; missing approval; non-increasing freshness; missing receipt; unlabeled claim; CPW critical; evidence failure; counter replay |
| Expected readiness outcome | Implementation-ready if all acceptance criteria pass and no high-severity boundary gaps remain |
| Semantic verdict coverage | ALLOW; ALLOW\_CONSTRAINED; BLOCK; QUARANTINE; FAIL\_CLOSED; NONCOMPLIANT\_HOLD; READMIT preserved identically across decision, validator, workflow, gate, and handoff artifacts |

## Reuse and Implementation Note

| Status | active |
| --- | --- |
| **Objective** | Provide a ready-to-build, execution-neutral specification for a boundary-governed frontier agent |
| **Reusable elements** | contract-first ingress model; tool-state quarantine model; accepted-head visibility rule; evidence-gated finalization; labeled statement gating |
| **Reuse conditions** | Reuse is permitted only with explicit preservation of verdict semantics, authority limits, and evidence contract fields |
| **Open items for implementation** | cryptographic suite selection; storage backend; user interface and operator workflow details; throughput budgets |
| **Last update** | Public Release v2.0 |
