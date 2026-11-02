D1 — Semantic Index

*Canonical semantic index derived from the authorized public corpus only*

| Agent | Boundary Defense Agent |
| --- | --- |
| **Agent version** | Public Release v2.0 |
| **Index version** | 2.0 |
| **Authorized public corpus** | Boundary Defense Agent — Specification (Public Release v2.0) |
| **Derivation scope** | publishable corpus only |
| **Publication package** | D1 Human Edition, D2-YAML, D2-JSON, D3 Coverage Matrix, D4 Ambiguity Register |

**Corpus rule. Only the authorized public corpus was used in D1, D2, D3, and D4. No external sources were referenced.**

# Method frame

This Semantic Index is a controlled explanatory dictionary of the publishable vocabulary used in the Boundary Defense Agent package.

Each entry is anchored in the authorized public corpus, classified into an public semantic category, and expressed with an explicit semantic status.

Source section codes used throughout D1, D2, D3, and D4 are listed below.

| Code | Publishable section |
| --- | --- |
| PR-OD | Operational Definitions |
| PR-SCS | Semantic Core Summary |
| PR-ASR | Agent Specification Record |
| PR-AAR | Agent Authority Record |
| PR-ICR | Input Contract Record Set |
| PR-OCR | Output Contract Record Set |
| PR-DTR | Decision Table Record |
| PR-VC | Validator Catalogue |
| PR-WF | Workflow / State-Transition Record |
| PR-GL | Gate Logic Record |
| PR-ECR | Evidence Contract Record |
| PR-MFC | Machine-Readable Form Catalogue |
| PR-SCR | Semantic Contract Record |
| PR-TOC | Temporal / Ordering Contract |
| PR-FSR | Failure Semantics Record |
| PR-AOC | Assumption-to-Obligation Closure |
| PR-IAC | Implementation Acceptance Criteria |
| PR-OR | Optionality Register |
| PR-AP | Assurance Profile |
| PR-VR | Validation Requirements |
| PR-RIN | Reuse and Implementation Note |

# Category summary

| Category | Entries |
| --- | --- |
| Identity Terms | 3 |
| Boundary Terms | 6 |
| Control Terms | 9 |
| Abbreviation Terms | 2 |
| State Terms | 8 |
| Transition Terms | 14 |
| Decision Terms | 20 |
| Validation Terms | 8 |
| Evidence Terms | 32 |
| Optionality Terms | 4 |

# Identity Terms

*3 indexed terms*

## IDT-001 — Boundary Defense Agent

**Status: normative**

**Short definition.** Canonical specialized boundary-control agent named in the publishable specification.

**Operational definition.** The agent identity fixed by the specification. It controls frontier interactions and exchanges, validates, filters, blocks, quarantines, and releases boundary artifacts under fail-closed governance.

**Source refs.** PR-SCS; PR-ASR; PR-AP

**Related terms.** boundary-control agent; Boundary artifact; Fail-closed policy

## IDT-002 — boundary-control agent

**Status: normative**

**Short definition.** Agent role for ingress, egress, persistence, and transport-adjacent artifact exchange.

**Operational definition.** Used for the agent role and identity class. The term frames the agent as a boundary-governed component rather than a general-purpose executor.

**Source refs.** PR-OD; PR-ASR

**Related terms.** Boundary Defense Agent; Boundary; critical core

## IDT-003 — critical core

**Status: normative**

**Short definition.** The governed core whose boundary is controlled by the agent.

**Operational definition.** Used in the jurisdiction and scope boundary. Ingress and egress artifacts that cross the controlled boundary of the critical core fall within agent governance.

**Source refs.** PR-ASR

**Related terms.** Boundary; controlled boundary

# Boundary Terms

*6 indexed terms*

## BND-002 — Boundary

**Status: normative**

**Short definition.** Logical boundary spanning runtime I/O, persistence commits, and transport of artifacts.

**Operational definition.** The boundary delimits the governed exchange surface. The agent evaluates artifacts that cross this boundary and applies explicit contracts, validators, and evidence-linked decisions before visibility or release.

**Source refs.** PR-ASR

**Related terms.** Boundary artifact; runtime I/O; persistence commits; transport of artifacts

## BND-001 — Boundary artifact

**Status: normative**

**Short definition.** Any input, output, tool-state payload, or persistence/transport-adjacent object that attempts to cross the controlled boundary.

**Operational definition.** The base boundary object class for the specification. The semantic invariant states that no boundary artifact acquires execution, persistence, or transport visibility without explicit validation evidence appropriate to its class.

**Source refs.** PR-OD; PR-SCS

**Related terms.** Boundary; tool\_state\_payload; boundary\_verdict

## BND-003 — controlled boundary

**Status: normative**

**Short definition.** The boundary that artifacts attempt to cross under agent governance.

**Operational definition.** Used in the defining statement and in the operational definition of Boundary artifact. The term identifies the governed crossing point for runtime, persistence, and transport-adjacent exchange.

**Source refs.** PR-OD; PR-ASR

**Related terms.** Boundary; Boundary artifact; critical core

## BND-005 — persistence commits

**Status: normative**

**Short definition.** Persistence-side actions included in the logical boundary.

**Operational definition.** Used in the Boundary field of the Agent Specification Record. Persistence commits are governed boundary actions and are also referenced in acceptance ordering and release authorization logic.

**Source refs.** PR-ASR; PR-TOC

**Related terms.** Boundary; transport of artifacts; Boundary artifact

## BND-004 — runtime I/O

**Status: normative**

**Short definition.** Runtime input and output side of the governed boundary.

**Operational definition.** Used in the boundary and role records. Runtime I/O is part of the logical boundary and is governed together with persistence commits and transport of artifacts.

**Source refs.** PR-SCS; PR-ASR

**Related terms.** Boundary; persistence commits; transport of artifacts

**Accepted variants.** I/O

## BND-006 — transport of artifacts

**Status: normative**

**Short definition.** Transport-side movement of artifacts governed by the boundary model.

**Operational definition.** Used in the Boundary field and in the evidence contract reconstruction claim. Transport effects are authorized only when the required validators and evidence fields support the action.

**Source refs.** PR-ASR; PR-ECR

**Related terms.** Boundary; Boundary artifact; persistence commits

# Control Terms

*9 indexed terms*

## CTL-002 — accepted-head visibility

**Status: normative**

**Short definition.** Visibility rule for the accepted head in replay and freshness control.

**Operational definition.** Used in the assurance and assumption sections. The rule supports replay resistance by keeping accepted-head state visible for freshness and anchor checks.

**Source refs.** PR-AOC; PR-AP; PR-RIN

**Related terms.** accepted head; Accepted anchor; Freshness / Receipt Validator

## CTL-004 — allowlist

**Status: normative**

**Short definition.** Policy allowlisting used for compatibility and admissibility checks.

**Operational definition.** Allowlist checks appear in the Policy / Allowlist Validator, the fail-closed policy, the block triggers, and failure semantics. Failure on allowlist checks blocks or quarantines the path according to class and context.

**Source refs.** PR-ASR; PR-VC; PR-FSR

**Related terms.** Policy / Allowlist Validator; BLOCK; QUARANTINE

## CTL-008 — append-only evidence ledger

**Status: normative**

**Short definition.** Append-only evidence storage for material verdicts and reconstruction.

**Operational definition.** Replay / reconstruction is mandatory and all material verdicts are emitted to an append-only evidence ledger. The evidence contract also requires append-only or tamper-evident equivalent continuity.

**Source refs.** PR-ASR; PR-ECR

**Related terms.** validator\_results; statement\_refs; hash\_prev; hash\_curr

## CTL-006 — authority limit / budget

**Status: normative**

**Short definition.** Finite policy budget for unresolved validation failures, pending approvals, and critical-risk retries.

**Operational definition.** Authority exhaustion causes block plus escalation. The decision table and failure semantics use authority budget exhaustion to drive quarantine or hold until readmission conditions are met.

**Source refs.** PR-AAR; PR-DTR; PR-FSR

**Related terms.** QUARANTINE; NONCOMPLIANT\_HOLD; Readmission

## CTL-003 — evidence gate

**Status: normative**

**Short definition.** Gate that checks finalization prerequisites and evidence conditions.

**Operational definition.** The evidence gate is invoked at finalization review with validator\_results context. It yields evidence\_ok and participates in finalization success or hold entry.

**Source refs.** PR-OD; PR-WF; PR-AAR

**Related terms.** evidence\_ok; EVIDENCE\_OK; Evidence Chain Validator; FINALIZATION\_REVIEW

## CTL-009 — Fail-closed policy

**Status: normative**

**Short definition.** Mandatory fail-closed handling at specified failure and escalation conditions.

**Operational definition.** The policy is mandatory at schema failure, allowlist failure, CPW critical escalation, evidence failure, counter replay, or authority exhaustion. It is also reflected in gate logic, workflow, and failure semantics.

**Source refs.** PR-ASR; PR-DTR; PR-FSR

**Related terms.** FAIL\_CLOSED; BLOCK; QUARANTINE; NONCOMPLIANT\_HOLD

## CTL-007 — human/operator approval channel

**Status: normative**

**Short definition.** Approval channel in the escalation path for approval-required handling.

**Operational definition.** The escalation path runs from Boundary Defense Agent to the human/operator approval channel, then to the external assurance component and implementation layer. Approval evidence is attached through approval\_ref and Approval Validator checks.

**Source refs.** PR-AAR

**Related terms.** approval\_ref; Approval Validator; External assurance component

## CTL-005 — policy profile

**Status: normative**

**Short definition.** Active policy profile bound into request and decision handling.

**Operational definition.** The input contract binds policy\_profile\_id for ingress\_request, and the assumption closure requires a stable policy profile with policy\_hash bound in decision and evidence records.

**Source refs.** PR-ICR; PR-AOC

**Related terms.** policy\_hash; ingress\_request

## CTL-001 — Readmission

**Status: normative**

**Short definition.** Controlled restoration of a previously blocked or quarantined path after all mandatory validators, approvals, and anchors are satisfied.

**Operational definition.** Readmission is the restoration control used after remediation. The authority record defines readmission triggers, the temporal contract defines when readmission is legal, and the workflow emits READMIT when restoration succeeds.

**Source refs.** PR-OD; PR-AAR; PR-WF; PR-TOC

**Related terms.** READMIT; READMISSION\_APPROVED; approval\_ref; Accepted anchor

# Abbreviation Terms

*2 indexed terms*

## ABR-001 — CPW

**Status: normative**

**Short definition.** Crash Proximity Warning.

**Operational definition.** Abbreviation for the risk-banding mechanism that constrains behavior and can force fail-closed handling at CRITICAL. It also anchors CPW\_CRITICAL and the CPW Band Validator.

**Source refs.** PR-OD; PR-VC; PR-OR

**Related terms.** CPW\_CRITICAL; CPW Band Validator; FAIL\_CLOSED

**Ambiguity note.** Do not treat CPW as a verdict token.

## ABR-002 — I/O

**Status: normative**

**Short definition.** Input and output.

**Operational definition.** Used in the role and boundary records to describe the governed runtime exchange surface.

**Source refs.** PR-SCS; PR-ASR

**Related terms.** runtime I/O; Boundary

# State Terms

*8 indexed terms*

## STA-003 — FILTER\_REVIEW

**Status: normative**

**Short definition.** State in which the validated input is reviewed for escalation, tool-state risk, or release preparation.

**Operational definition.** Entered after VALIDATION\_PASS. The workflow routes from FILTER\_REVIEW either to TOOL\_STATE\_QUARANTINED or READY\_FOR\_RELEASE.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Boundary Defense Agent

## STA-007 — FINALIZATION\_REVIEW

**Status: normative**

**Short definition.** State in which finalization prerequisites are checked by the evidence gate and reconstruction-linked validators.

**Operational definition.** Entered when finalization is requested on the release path. The workflow then branches to EVIDENCE\_OK or EVIDENCE\_FAIL.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Boundary Defense Agent

## STA-001 — IDLE

**Status: normative**

**Short definition.** State in which the agent is ready to receive input or returns after successful release, readmission, or hold exit.

**Operational definition.** IDLE is the start and return state. The workflow enters IDLE from finalization success, readmission approval, and compliance restoration.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Boundary Defense Agent

## STA-002 — INGEST\_VALIDATE

**Status: normative**

**Short definition.** State in which ingress input is validated against mandatory checks.

**Operational definition.** Entered after INPUT\_RECEIVED. The workflow uses this state for VAL-01, VAL-02, VAL-03, and related failure handling before block or review.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Boundary Defense Agent

## STA-008 — NONCOMPLIANT\_HOLD

**Status: normative**

**Short definition.** Audit-only posture in which no compliance-claimed finalization is permitted until evidence prerequisites are restored.

**Operational definition.** The workflow enters NONCOMPLIANT\_HOLD when VAL-05 or VAL-08 fails at finalization review. The same token also appears in gate logic and semantic contract as a gate status and verdict token.

**Source refs.** PR-SCS; PR-WF; PR-GL; PR-SCR

**Related terms.** FINALIZATION\_REVIEW; EVIDENCE\_FAIL; READMIT; Accepted anchor

**Ambiguity note.** The token names both a workflow state and a semantic verdict.

## STA-006 — OUTPUT\_BLOCKED

**Status: normative**

**Short definition.** State in which the path remains blocked and no further release occurs.

**Operational definition.** Reached on validation failure, CPW critical handling, and other blocking conditions. Readmission may return the path to IDLE after remediation.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Boundary Defense Agent

## STA-005 — READY\_FOR\_RELEASE

**Status: normative**

**Short definition.** State in which the release path is prepared with validator context and policy scope.

**Operational definition.** Entered when no escalation condition remains or when approval is granted on a quarantined tool-state path. FINALIZATION\_REQUESTED moves the path to finalization review.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Boundary Defense Agent

## STA-004 — TOOL\_STATE\_QUARANTINED

**Status: normative**

**Short definition.** State in which a tool-state path is preserved for inspection but not released.

**Operational definition.** Entered when tool-state is present and elevated boundary risk is classified. Approval evidence is required before the path can move to READY\_FOR\_RELEASE.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Boundary Defense Agent

# Transition Terms

*14 indexed terms*

## TRN-007 — APPROVAL\_DENIED

**Status: normative**

**Short definition.** Primary event token for approval denial on an approval-required path.

**Operational definition.** Listed in the semantic core summary as a primary event. On an approval-required tool-state path, absence of approval prevents release and keeps the path blocked or quarantined.

**Source refs.** PR-SCS; PR-AAR

**Related terms.** approval\_ref; tool\_state\_payload; QUARANTINE

**Ambiguity note. The token is listed in the semantic core summary but is not expanded as a separate workflow row in the specification.**

## TRN-006 — APPROVAL\_GRANTED

**Status: normative**

**Short definition.** Workflow event for successful approval on a quarantined path.

**Operational definition.** Occurs when VAL-06 passes and moves TOOL\_STATE\_QUARANTINED to READY\_FOR\_RELEASE with approval\_ref logged.

**Source refs.** PR-SCS; PR-WF

**Related terms.** TOOL\_STATE\_QUARANTINED; READY\_FOR\_RELEASE; approval\_ref; Approval Validator

## TRN-014 — COMPLIANCE\_RESTORED

**Status: normative**

**Short definition.** Workflow event for restored evidence prerequisites on a hold path.

**Operational definition.** Occurs from NONCOMPLIANT\_HOLD when VAL-05 and VAL-08 are restored and the anchor is updated. The workflow then emits hold exit and READMIT before returning to IDLE.

**Source refs.** PR-WF

**Related terms.** NONCOMPLIANT\_HOLD; READMIT; Accepted anchor

## TRN-011 — COUNTER\_REPLAY

**Status: normative**

**Short definition.** Primary event token for counter replay in the semantic core summary.

**Operational definition.** Listed as a primary event in the semantic core summary. Replay control also appears in finalization rules and failure semantics through VERIF\_COUNTER and accepted anchor checks.

**Source refs.** PR-SCS; PR-TOC; PR-FSR

**Related terms.** VERIF\_COUNTER; Accepted anchor; NONCOMPLIANT\_HOLD

**Ambiguity note. The specification uses the token in the semantic core summary while the detailed finalization logic expresses replay through counter and anchor conditions.**

## TRN-012 — CPW\_CRITICAL

**Status: normative**

**Short definition.** Workflow event for CRITICAL risk-band escalation.

**Operational definition.** Occurs from any active state when VAL-07 detects band CRITICAL and moves the path to OUTPUT\_BLOCKED with FAIL\_CLOSED handling.

**Source refs.** PR-SCS; PR-WF; PR-FSR

**Related terms.** CPW; CPW Band Validator; FAIL\_CLOSED; OUTPUT\_BLOCKED

## TRN-010 — EVIDENCE\_FAIL

**Status: normative**

**Short definition.** Workflow event for failed finalization evidence review.

**Operational definition.** Occurs in FINALIZATION\_REVIEW when VAL-05 or VAL-08 fails because of evidence failure or replay and moves the path to NONCOMPLIANT\_HOLD.

**Source refs.** PR-SCS; PR-WF

**Related terms.** FINALIZATION\_REVIEW; NONCOMPLIANT\_HOLD; Evidence Chain Validator; Reconstruction Validator

## TRN-009 — EVIDENCE\_OK

**Status: normative**

**Short definition.** Workflow event for successful finalization evidence review.

**Operational definition.** Occurs in FINALIZATION\_REVIEW when VAL-05 and VAL-08 pass, evidence\_ok=true, and the counter strictly increases.

**Source refs.** PR-SCS; PR-WF

**Related terms.** FINALIZATION\_REVIEW; evidence\_ok; Evidence Chain Validator; Reconstruction Validator

**Ambiguity note.** Do not confuse the event token EVIDENCE\_OK with the evidence field evidence\_ok.

## TRN-008 — FINALIZATION\_REQUESTED

**Status: normative**

**Short definition.** Workflow event that moves the release path into finalization review.

**Operational definition.** Occurs from READY\_FOR\_RELEASE when the release path is selected and the validator bundle remains attached.

**Source refs.** PR-WF

**Related terms.** READY\_FOR\_RELEASE; FINALIZATION\_REVIEW; validator\_results

## TRN-001 — INPUT\_RECEIVED

**Status: normative**

**Short definition.** Workflow event that starts ingress handling.

**Operational definition.** Occurs from IDLE and creates the ingress\_request record that opens validation.

**Source refs.** PR-SCS; PR-WF

**Related terms.** IDLE; INGEST\_VALIDATE; ingress\_request

## TRN-005 — NO\_ESCALATION

**Status: normative**

**Short definition.** Workflow event for release-path continuation without escalation.

**Operational definition.** Occurs in FILTER\_REVIEW when VAL-02, VAL-04, and VAL-07 pass and no tool-state risk remains.

**Source refs.** PR-WF

**Related terms.** FILTER\_REVIEW; READY\_FOR\_RELEASE; CPW Band Validator

## TRN-013 — READMISSION\_APPROVED

**Status: normative**

**Short definition.** Workflow event for approved readmission after remediation.

**Operational definition.** Occurs from OUTPUT\_BLOCKED when failed validators are remediated and VAL-08 is available where replay claim is restored. The workflow then emits READMIT and returns to IDLE.

**Source refs.** PR-SCS; PR-WF

**Related terms.** Readmission; READMIT; IDLE

## TRN-004 — TOOL\_STATE\_DETECTED

**Status: normative**

**Short definition.** Workflow event for detected tool-state on an elevated-risk path.

**Operational definition.** Occurs in FILTER\_REVIEW when tool-state is present and VAL-02 classifies elevated boundary risk.

**Source refs.** PR-WF

**Related terms.** FILTER\_REVIEW; TOOL\_STATE\_QUARANTINED; tool\_state\_payload

## TRN-003 — VALIDATION\_FAIL

**Status: normative**

**Short definition.** Workflow event for failed mandatory validation.

**Operational definition.** Occurs when any of VAL-01, VAL-02, VAL-03, or VAL-04 fails and moves the path to OUTPUT\_BLOCKED.

**Source refs.** PR-SCS; PR-WF

**Related terms.** INGEST\_VALIDATE; OUTPUT\_BLOCKED; Freshness / Receipt Validator

## TRN-002 — VALIDATION\_PASS

**Status: normative**

**Short definition.** Workflow event for successful mandatory validation.

**Operational definition.** Occurs when VAL-01, VAL-02, and VAL-03 pass and moves the path from INGEST\_VALIDATE to FILTER\_REVIEW.

**Source refs.** PR-SCS; PR-WF

**Related terms.** INGEST\_VALIDATE; FILTER\_REVIEW; Schema Validator; Policy / Allowlist Validator; Statement Provenance Validator

# Decision Terms

*20 indexed terms*

## DEC-001 — ALLOW

**Status: normative**

**Short definition.** The artifact is admissible for the declared boundary scope only; no implied authority exists beyond that scope.

**Operational definition.** Used when all mandatory validators pass and no escalation condition exists. Release is within the declared scope only.

**Source refs.** PR-SCS; PR-GL; PR-SCR

**Related terms.** boundary\_verdict

## DEC-002 — ALLOW\_CONSTRAINED

**Status: normative**

**Short definition.** The artifact is admissible under reduced scope, tighter observation, or explicit follow-up review.

**Operational definition.** Used when release is permitted but policy requires constrained handling or human review.

**Source refs.** PR-SCS; PR-GL; PR-SCR

**Related terms.** boundary\_verdict

## DEC-003 — BLOCK

**Status: normative**

**Short definition.** The artifact is inadmissible and SHALL NOT mutate governed state or gain boundary visibility.

**Operational definition.** Used for schema, policy, provenance, replay, or related inadmissibility conditions. Block may emit boundary\_verdict and keep accepted head unchanged where required.

**Source refs.** PR-SCS; PR-GL; PR-SCR

**Related terms.** boundary\_verdict

## DEC-012 — boundary\_verdict

**Status: normative**

**Short definition.** Output artifact that records a boundary decision.

**Operational definition.** Carries decision\_id, verdict, reason\_code, validator\_results, statement\_refs, and input\_digest. It is emitted for blocking or release-linked decisions as required by the decision table and evidence contract.

**Source refs.** PR-OCR; PR-DTR; PR-ECR

**Related terms.** BoundaryDecisionRecord; decision\_id; validator\_results; statement\_refs; reason\_code

## DEC-018 — BoundaryDecisionRecord

**Status: normative**

**Short definition.** Machine-readable form for a boundary decision record.

**Operational definition.** Canonical field skeleton: {decision\_id, verdict, reason\_code, validator\_results\[\], statement\_refs\[\], order\_index}. It packages the boundary\_verdict record shape for structured representation.

**Source refs.** PR-MFC; PR-OCR; PR-ECR

**Related terms.** boundary\_verdict; decision\_id; validator\_results; statement\_refs; order\_index

## DEC-020 — BoundaryIncidentRecord

**Status: normative**

**Short definition.** Machine-readable form for incident record packaging.

**Operational definition.** Canonical field skeleton: {decision\_id, fail\_reason, hold\_refs\[\], rollback\_ref?, limitations\[\]}. It packages incident\_report in structured representation.

**Source refs.** PR-MFC; PR-OCR

**Related terms.** incident\_report; fail\_reason; hold\_refs; rollback\_ref

## DEC-016 — BoundaryInputEnvelope

**Status: normative**

**Short definition.** Machine-readable form for ingress input packaging.

**Operational definition.** Canonical field skeleton: {request\_id, source\_id, artifact\_type, payload\_digest, schema\_id, policy\_profile\_id}. It packages the ingress\_request form in structured representation.

**Source refs.** PR-MFC; PR-ICR

**Related terms.** ingress\_request; payload\_digest; policy\_hash

## DEC-005 — FAIL\_CLOSED

**Status: normative**

**Short definition.** The agent halts substantive boundary progression and emits an auditable failure state.

**Operational definition.** Used at critical risk or prerequisite violation, including CPW critical conditions and finalization-adjacent failure paths.

**Source refs.** PR-SCS; PR-GL; PR-SCR

**Related terms.** boundary\_verdict

## DEC-010 — finalization\_request

**Status: normative**

**Short definition.** Decision object for finalization-relevant handling.

**Operational definition.** Carries op\_type, state\_hash, policy\_hash, and measurement\_ref. It is checked by the Evidence Chain Validator and the Freshness / Receipt Validator, with NONCOMPLIANT\_HOLD as the default failure verdict.

**Source refs.** PR-SCS; PR-ICR; PR-WF

**Related terms.** FinalizationRequestEnvelope; Evidence Chain Validator; measurement\_ref; state\_hash; policy\_hash

## DEC-019 — FinalizationRequestEnvelope

**Status: normative**

**Short definition.** Machine-readable form for finalization request packaging.

**Operational definition.** Canonical field skeleton: {request\_id, op\_type, state\_hash, policy\_hash, measurement\_ref}. It packages finalization\_request for evidence-linked finalization handling.

**Source refs.** PR-MFC; PR-ICR

**Related terms.** finalization\_request; state\_hash; policy\_hash; measurement\_ref

## DEC-015 — incident\_report

**Status: normative**

**Short definition.** Output artifact that records failure or hold handling.

**Operational definition.** Carries decision\_id, fail\_reason, hold\_refs, optional rollback\_ref, and limitations. It is emitted when finalization is blocked into NONCOMPLIANT\_HOLD.

**Source refs.** PR-OCR; PR-DTR

**Related terms.** NONCOMPLIANT\_HOLD; rollback\_ref; hold\_refs; fail\_reason

## DEC-007 — ingress\_request

**Status: normative**

**Short definition.** Decision object for boundary input evaluation.

**Operational definition.** Created when input is received. Carries artifact\_type, source\_id, policy\_profile\_id, payload\_digest, and schema\_id for schema, policy, and source binding checks before downstream handling.

**Source refs.** PR-SCS; PR-ICR; PR-WF

**Related terms.** BoundaryInputEnvelope; Schema Validator; Policy / Allowlist Validator

## DEC-009 — output\_release\_request

**Status: normative**

**Short definition.** Decision object for release of an output artifact.

**Operational definition.** Primary decision object on the release path. Release proceeds according to policy scope only when validator-driven conditions support ALLOW or ALLOW\_CONSTRAINED handling.

**Source refs.** PR-SCS; PR-ASR; PR-GL

**Related terms.** release\_notice; ALLOW; ALLOW\_CONSTRAINED

## DEC-004 — QUARANTINE

**Status: normative**

**Short definition.** The artifact may be stored for inspection but remains non-executable and non-releasable.

**Operational definition.** Used for tool-state or authority ambiguity and for approval-required paths that lack explicit approval.

**Source refs.** PR-SCS; PR-GL; PR-SCR

**Related terms.** boundary\_verdict

## DEC-013 — quarantine\_notice

**Status: normative**

**Short definition.** Output artifact that records quarantine handling.

**Operational definition.** Carries decision\_id, quarantine\_reason, activation\_requirements, and optional approval\_ref. It is emitted when tool-state or equivalent elevated-risk handling enters quarantine.

**Source refs.** PR-OCR; PR-DTR; PR-WF

**Related terms.** QUARANTINE; approval\_ref; activation\_requirements

## DEC-006 — READMIT

**Status: normative**

**Short definition.** A previously blocked or quarantined path is re-opened only after explicit restoration evidence is attached.

**Operational definition.** Used at restoration after failed validators are remediated and the required validators, approvals, and anchors are restored.

**Source refs.** PR-SCS; PR-GL; PR-SCR

**Related terms.** boundary\_verdict

## DEC-014 — release\_notice

**Status: normative**

**Short definition.** Output artifact that records release handling.

**Operational definition.** Carries decision\_id, release\_scope, policy\_hash, and optional evidence\_refs. It is prepared on the ready-for-release path and binds release to policy scope.

**Source refs.** PR-OCR; PR-WF

**Related terms.** release\_scope; policy\_hash; ALLOW; ALLOW\_CONSTRAINED

## DEC-011 — statement\_usage\_request

**Status: normative**

**Short definition.** Decision object for use of a statement in gate logic.

**Operational definition.** Carries statement\_id, tsa\_label, source\_class, and scope\_id. It is checked by the Statement Provenance Validator, and missing label or inadmissible source handling blocks gate use.

**Source refs.** PR-SCS; PR-ICR; PR-DTR

**Related terms.** Statement record; statement\_id; tsa\_label; source\_class

## DEC-008 — tool\_state\_payload

**Status: normative**

**Short definition.** Decision object for a capability-bearing tool-state payload.

**Operational definition.** Used for a capability-bearing payload associated with a tool or tool-derived state. Structural restoration does not grant execution authority, and the default failure verdict is QUARANTINE until required approval is evidenced.

**Source refs.** PR-SCS; PR-OD; PR-ICR; PR-WF

**Related terms.** ToolStateEnvelope; QUARANTINE; approval\_ref

**Accepted variants.** Tool-state payload

## DEC-017 — ToolStateEnvelope

**Status: normative**

**Short definition.** Machine-readable form for tool-state packaging.

**Operational definition.** Canonical field skeleton: {request\_id, tool\_ids\[\], claimed\_permissions\[\], payload\_digest, approval\_required=true}. It packages tool\_state\_payload for structured handling.

**Source refs.** PR-MFC; PR-ICR

**Related terms.** tool\_state\_payload; approval\_ref; payload\_digest

# Validation Terms

*8 indexed terms*

## VAL-006 — Approval Validator

**Status: normative**

**Short definition.** Checks explicit operator approval for tool-state activation.

**Operational definition.** Keeps the path in QUARANTINE until explicit approval is evidenced through approval\_ref.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

## VAL-007 — CPW Band Validator

**Status: normative**

**Short definition.** Confirms the band-driven action envelope.

**Operational definition.** Detects CRITICAL band conditions and produces FAIL\_CLOSED when the risk band requires it.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

## VAL-005 — Evidence Chain Validator

**Status: normative**

**Short definition.** Checks evidence\_ok, evidence\_ref, and replay anchor conditions.

**Operational definition.** Used in finalization review. It produces NONCOMPLIANT\_HOLD or FAIL\_CLOSED at finalization failure.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

## VAL-004 — Freshness / Receipt Validator

**Status: normative**

**Short definition.** Checks strict increase and accepted-head binding.

**Operational definition.** Used for replay and downgrade resistance. It blocks replay attempts and participates in finalization and no-escalation path checks.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

## VAL-002 — Policy / Allowlist Validator

**Status: normative**

**Short definition.** Checks policy compatibility and allowlisted types/tools.

**Operational definition.** Runs on policy compatibility and allowlist conditions and produces BLOCK or QUARANTINE for disallowed classes.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

## VAL-008 — Reconstruction Validator

**Status: normative**

**Short definition.** Confirms evidence sufficiency for offline replay.

**Operational definition.** Supports READMIT and finalization by confirming that replay evidence is sufficient.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

## VAL-001 — Schema Validator

**Status: normative**

**Short definition.** Confirms required structure and field typing.

**Operational definition.** Runs on malformed ingress or tool-state payloads and produces BLOCK on schema failure.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

## VAL-003 — Statement Provenance Validator

**Status: normative**

**Short definition.** Checks statement\_id, tsa\_label, source\_class, and scope.

**Operational definition.** Used on statement\_usage\_request and unlabeled gate logic handling; produces BLOCK plus conflict evidence for inadmissible statement use.

**Source refs.** PR-VC; PR-WF

**Related terms.** validator\_results

# Evidence Terms

32 indexed terms

## EVI-005 — Accepted anchor

**Status: normative**

**Short definition.** Last accepted freshness or verification watermark used to reject replay and downgrade attempts.

**Operational definition.** Used in replay resistance, finalization rules, and readmission control. Finalization may proceed only if evidence\_ok=true and VERIF\_COUNTER is greater than the accepted anchor.

**Source refs.** PR-OD; PR-DTR; PR-TOC

**Related terms.** accepted head; VERIF\_COUNTER; evidence\_ok

**Accepted variants.** accepted\_anchor

## EVI-006 — accepted head

**Status: normative**

**Short definition.** Accepted-head state kept unchanged on replay or missing receipt conditions.

**Operational definition.** Used by the Freshness / Receipt Validator, failure semantics, and accepted-head visibility rule to express replay resistance and stable acceptance state.

**Source refs.** PR-DTR; PR-VC; PR-FSR; PR-AOC; PR-AP

**Related terms.** Accepted anchor; accepted-head visibility; VERIF\_COUNTER

## EVI-031 — activation\_requirements

**Status: normative**

**Short definition.** Requirements attached to quarantine activation and release eligibility.

**Operational definition.** Mandatory in quarantine\_notice. The field expresses what must be restored or evidenced before a quarantined path can move toward release.

**Source refs.** PR-OCR

**Related terms.** quarantine\_notice; approval\_ref

## EVI-026 — approval\_ref

**Status: normative**

**Short definition.** Approval evidence field for tool-state activation or release.

**Operational definition.** Conditional in the evidence contract and optional in quarantine\_notice. Approval Validator requires it for approval-required tool-state handling before release can proceed.

**Source refs.** PR-OCR; PR-ECR; PR-WF

**Related terms.** Approval Validator; APPROVAL\_GRANTED; tool\_state\_payload

**Ambiguity note.** Do not confuse approval\_ref with the transition events APPROVAL\_GRANTED or APPROVAL\_DENIED.

## EVI-015 — boundary\_side

**Status: normative**

**Short definition.** Evidence field that records which boundary side the decision concerns.

**Operational definition.** Mandatory in the evidence contract and used in minimum reconstruction claims to explain persistence or transport authorization context.

**Source refs.** PR-ECR

**Related terms.** Boundary; decision\_id

## EVI-032 — decision\_object

## Status: normative

## Short definition. Evidence field naming the decision object covered by the evidence bundle.

## Operational definition. Mandatory in the evidence contract. The field identifies which decision object the evidence bundle concerns so reconstruction can determine the evaluated decision context without inferring it from adjacent records.

## Source refs. PR-ECR

## Related terms. boundary\_verdict; finalization\_request; decision\_id

## EVI-009 — decision\_id

**Status: normative**

**Short definition.** Identity field for a decision and for decision-linked artifacts.

**Operational definition.** Mandatory in boundary\_verdict and in the evidence contract. Also appears in release, quarantine, and incident records and in machine-readable forms.

**Source refs.** PR-OCR; PR-ECR; PR-MFC

**Related terms.** boundary\_verdict; BoundaryDecisionRecord

## EVI-007 — evidence\_ok

**Status: normative**

**Short definition.** Boolean result returned by the evidence gate when finalization prerequisites are checked.

**Operational definition.** Used by the Evidence Chain Validator, decision table, and finalization rules. A false value blocks compliance-claimed finalization.

**Source refs.** PR-OD; PR-DTR; PR-VC; PR-TOC

**Related terms.** EVIDENCE\_OK; EVIDENCE\_FAIL; evidence gate

**Ambiguity note.** Do not confuse the evidence field evidence\_ok with the workflow event EVIDENCE\_OK.

## EVI-012 — evidence\_ref

**Status: normative**

**Short definition.** Evidence reference field used for finalization-linked evidence.

**Operational definition.** Conditional in the evidence contract and checked by the Evidence Chain Validator for finalization handling.

**Source refs.** PR-ECR; PR-VC

**Related terms.** Evidence Chain Validator; verif\_counter\_anchor

## EVI-030 — fail\_reason

**Status: normative**

**Short definition.** Failure reason field in incident handling.

**Operational definition.** Mandatory in incident\_report so failure-driven hold or remediation handling can be reconstructed.

**Source refs.** PR-OCR; PR-MFC

**Related terms.** incident\_report; reason\_code

## EVI-025 — hash\_curr

**Status: normative**

**Short definition.** Current-link integrity field for evidence continuity.

**Operational definition.** Mandatory in the evidence contract and paired with hash\_prev for externally checkable continuity.

**Source refs.** PR-ECR

**Related terms.** hash\_prev; append-only evidence ledger

## EVI-024 — hash\_prev

**Status: normative**

**Short definition.** Previous-link integrity field for evidence continuity.

**Operational definition.** Mandatory in the evidence contract to support append-only or tamper-evident continuity with externally checkable linkage.

**Source refs.** PR-ECR

**Related terms.** hash\_curr; append-only evidence ledger

## EVI-028 — hold\_refs

**Status: normative**

**Short definition.** References to hold-linked records in incident handling.

**Operational definition.** Mandatory in incident\_report and used when finalization is blocked into NONCOMPLIANT\_HOLD.

**Source refs.** PR-OCR

**Related terms.** incident\_report; NONCOMPLIANT\_HOLD

## EVI-016 — input\_digest

**Status: normative**

**Short definition.** Digest field for the evaluated input in boundary decision evidence.

**Operational definition.** Mandatory in boundary\_verdict and in the evidence contract so the evaluated artifact can be reconstructed and compared without ambiguity.

**Source refs.** PR-OCR; PR-ECR

**Related terms.** payload\_digest; Boundary artifact

## EVI-020 — measurement\_ref

**Status: normative**

**Short definition.** Measurement reference attached to finalization handling.

**Operational definition.** Mandatory in finalization\_request and FinalizationRequestEnvelope for evidence-linked finalization review.

**Source refs.** PR-ICR; PR-MFC

**Related terms.** finalization\_request; state\_hash

## EVI-023 — order\_index

**Status: normative**

**Short definition.** Monotonically increasing order field for boundary decisions.

**Operational definition.** Each boundary decision receives a monotonically increasing order\_index within its session or scope. The field is also produced by the decision engine.

**Source refs.** PR-ECR; PR-TOC; PR-MFC

**Related terms.** session\_id; decision\_id; BoundaryDecisionRecord

## EVI-017 — payload\_digest

**Status: normative**

**Short definition.** Digest field for request payloads in input envelopes.

**Operational definition.** Mandatory in ingress\_request and tool\_state\_payload contracts and in machine-readable input forms. It binds request identity to the evaluated payload.

**Source refs.** PR-ICR; PR-MFC

**Related terms.** input\_digest; ingress\_request; tool\_state\_payload

## EVI-018 — policy\_hash

**Status: normative**

**Short definition.** Hash field that binds policy state into decision or finalization handling.

**Operational definition.** Mandatory in finalization\_request and release\_notice, and required by the assumption closure for every decision and evidence record when the policy profile is active and stable.

**Source refs.** PR-ICR; PR-OCR; PR-AOC

**Related terms.** policy profile; finalization\_request; release\_notice

## EVI-022 — reason\_code

**Status: normative**

**Short definition.** Recorded reason field for a boundary decision.

**Operational definition.** Mandatory in boundary\_verdict and the evidence contract so an auditable failure or release reason can be reconstructed.

**Source refs.** PR-OCR; PR-ECR

**Related terms.** decision\_id; verdict

## EVI-027 — release\_scope

**Status: normative**

**Short definition.** Scope field attached to release handling.

**Operational definition.** Mandatory in release\_notice. It binds the release to policy-defined scope and supports ALLOW or ALLOW\_CONSTRAINED handling.

**Source refs.** PR-OCR; PR-DTR

**Related terms.** release\_notice; ALLOW; ALLOW\_CONSTRAINED

## EVI-029 — rollback\_ref

**Status: normative**

**Short definition.** Reference to a rollback action or target.

**Operational definition.** Optional in incident\_report and conditional in the evidence contract for recovery actions. Rollback may target the last clean boundary state when FAIL\_CLOSED occurs after a LASTCLEAN-equivalent checkpoint.

**Source refs.** PR-OCR; PR-ECR; PR-TOC

**Related terms.** Rollback operation; FAIL\_CLOSED

## EVI-014 — session\_id

**Status: normative**

**Short definition.** Session identifier in the evidence contract.

**Operational definition.** Mandatory in the evidence contract so a third party can determine scope and order of boundary decisions within a session or equivalent scope.

**Source refs.** PR-ECR

**Related terms.** order\_index; decision\_id

## EVI-004 — source\_class

**Status: normative**

**Short definition.** Admissibility class assigned to the source of a gate-relevant statement.

**Operational definition.** Used with statement\_id and tsa\_label to determine whether a statement is admissible for gate logic.

**Source refs.** PR-OD; PR-ICR; PR-DTR

**Related terms.** Statement record; tsa\_label; Statement Provenance Validator

## EVI-019 — state\_hash

**Status: normative**

**Short definition.** Hash field for the state under finalization handling.

**Operational definition.** Mandatory in finalization\_request and FinalizationRequestEnvelope so evidence-linked finalization can bind the evaluated state.

**Source refs.** PR-ICR; PR-MFC

**Related terms.** finalization\_request; measurement\_ref

## EVI-001 — Statement record

**Status: normative**

**Short definition.** Gate-relevant claim identified by statement\_id and accompanied by tsa\_label and source\_class so it can be used in auditable decision logic.

**Operational definition.** Used when gate logic consumes claims. The record binds statement identity, label, and source admissibility for auditable use.

**Source refs.** PR-OD; PR-ICR

**Related terms.** statement\_id; tsa\_label; source\_class; statement\_usage\_request

## EVI-002 — statement\_id

**Status: normative**

**Short definition.** Stable identity for a gate-relevant statement.

**Operational definition.** Statement ordering requires statement\_id identity to remain stable and decision references to point only to prior or current statement records.

**Source refs.** PR-OD; PR-ICR; PR-TOC

**Related terms.** Statement record; statement\_refs

## EVI-011 — statement\_refs

**Status: normative**

**Short definition.** References to statement records used by a decision.

**Operational definition.** Mandatory in boundary\_verdict and evidence records. Statement ordering requires decision references to point only to prior or current statement records.

**Source refs.** PR-OCR; PR-ECR; PR-TOC

**Related terms.** Statement record; statement\_id; BoundaryDecisionRecord

## EVI-003 — tsa\_label

**Status: normative**

**Short definition.** Explicit label attached to a statement record to mark its status for gate use.

**Operational definition.** Used in statement records and statement\_usage\_request. Missing tsa\_label blocks gate use and yields conflict handling.

**Source refs.** PR-OD; PR-ICR; PR-DTR

**Related terms.** Statement record; source\_class; Statement Provenance Validator

## EVI-010 — validator\_results

**Status: normative**

**Short definition.** Recorded results of validator execution.

**Operational definition.** Mandatory in boundary\_verdict and evidence records. The workflow attaches validator\_results on validation pass, updates it on approval or release preparation, and passes it to the evidence gate.

**Source refs.** PR-OCR; PR-WF; PR-ECR

**Related terms.** decision\_id; Schema Validator; BoundaryDecisionRecord

## EVI-021 — verdict

**Status: normative**

**Short definition.** Recorded decision token emitted by the agent.

**Operational definition.** Mandatory in boundary\_verdict and the evidence contract. The semantic verdict set is closed to ALLOW, ALLOW\_CONSTRAINED, BLOCK, QUARANTINE, FAIL\_CLOSED, NONCOMPLIANT\_HOLD, and READMIT.

**Source refs.** PR-OCR; PR-ECR; PR-VC

**Related terms.** ALLOW; BLOCK; QUARANTINE; FAIL\_CLOSED; READMIT

## EVI-008 — VERIF\_COUNTER

**Status: normative**

**Short definition.** Strictly increasing verification counter used, where deployed, to prevent replay at finalization time.

**Operational definition.** Used in finalization rules and decision logic. Finalization may proceed only when the counter strictly exceeds the accepted anchor.

**Source refs.** PR-OD; PR-DTR; PR-TOC

**Related terms.** Accepted anchor; COUNTER\_REPLAY; verif\_counter\_anchor

## EVI-013 — verif\_counter\_anchor

**Status: normative**

**Short definition.** Counter-anchor field used in finalization-linked evidence handling.

**Operational definition.** Conditional in the evidence contract for finalization and paired with evidence\_ref by the external assurance component and VAL-05.

**Source refs.** PR-ECR

**Related terms.** VERIF\_COUNTER; Accepted anchor; evidence\_ref

# Optionality Terms

*4 indexed terms*

## OPT-002 — CPW numeric profile

**Status: implementation\_optional**

**Short definition.** Policy-variable numeric profile for CPW banding.

**Operational definition.** The Optionality Register permits variability in the numeric profile, but banded escalation and CRITICAL to FAIL\_CLOSED handling remain mandatory.

**Source refs.** PR-OR

**Related terms.** CPW; FAIL\_CLOSED

## OPT-001 — External assurance component

**Status: implementation\_optional**

**Short definition.** Optional for non-finalizing audit-only operation; mandatory for compliance-claimed finalization and persisted release claims.

**Operational definition.** Appears in the Optionality Register and the escalation path. The component is optional only in non-finalizing audit-only operation and required where compliance-claimed finalization or persisted release claims are made.

**Source refs.** PR-OR; PR-AAR

**Related terms.** human/operator approval channel; evidence\_ref

## OPT-003 — Operator approval for non-tool artifacts

**Status: implementation\_optional**

**Short definition.** Optional approval requirement for non-tool artifacts unless policy elevates a class to approval-required.

**Operational definition.** This optionality applies only where policy elevates a class. It does not relax the mandatory approval requirement for approval-required tool-state activation.

**Source refs.** PR-OR

**Related terms.** Approval Validator; human/operator approval channel

## OPT-004 — Rollback operation

**Status: implementation\_optional**

**Short definition.** Optional rollback if no clean checkpoint exists; FAIL\_CLOSED remains mandatory.

**Operational definition.** Rollback is optional in the Optionality Register, but rollback behavior is still governed by the temporal contract and failure semantics when a clean checkpoint exists.

**Source refs.** PR-OR; PR-TOC; PR-FSR

**Related terms.** rollback\_ref; FAIL\_CLOSED
