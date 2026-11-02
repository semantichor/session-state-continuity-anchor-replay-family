Truth Arbitration Agent

Public Library Specification

Buyer-facing, English-only, operationally complete specification for implementation and audit.

| Document status | Final public-release specification. |
| --- | --- |
| Intended use | Normative specification for implementing, integrating, and auditing the Truth Arbitration Agent without dependence on unpublished internal materials. |

# 1. Scope and Criticality

Truth Arbitration Agent is a closed normative agent that adjudicates only source provenance, labeling, conflict status, and admissibility for mechanism-level claims. It does not determine full material truth, validate software implementation correctness, or act as an autonomous substantive content source.

The agent has direct impact on the admissibility of mechanism-level statements and on commit-relevant actions. Incorrect provenance classification, missing labeling, or unjustified authorization can invalidate correctness, auditability, and fail-closed session semantics.

The implementation shall operate in fail-closed mode, maintain replay and offline reconstruction capability, and permit readmission only under policy and only after audited clearance.

# 2. Semantic Contract

## 2.1 Canonical identity

| The record identity of a claim is statement\_id = H(canonical\_text |  | scope\_id |  | turn\_id |  | policy\_snapshot\_id). canonical\_text anchors serialization and reconstruction identity; it does not claim universal semantic identity across different surface phrasings. |
| --- | --- | --- | --- | --- | --- | --- |

Canonicalization shall be deterministic, documented, and auditable. At minimum it shall include Unicode NFKC normalization, trimming, whitespace collapse, UTF-8 stabilization, and any additional serialization rules declared in semantic\_normalization\_profile.

If semantic\_normalization\_profile does not support a demonstrable semantic identity claim, any claim of complete conflict coverage remains limited to the declared formalism.

## 2.2 Verdict vocabulary

• ALLOW — the claim is admissible for mechanism-level consumption in the current scope. All relevant blocking validators have passed, and any relevant heuristic controls are above the policy threshold.

• ALLOW\_CONSTRAINED — the claim may be used only under the restrictions explicitly declared in the verdict. This verdict is mandatory when a lower-strength validator cannot fully close residual risk but policy permits conditional progress.

• DENY — the claim is inadmissible for mechanism-level consumption in the current scope.

• FAIL\_CLOSED — progress is blocked. The output shall include inhibit\_flags, clearance requirements, and, where applicable, an escalation artifact for an authorized external actor.

• ESCALATE — the agent does not authorize local consumption and requires remediation, clearance, or external review by an authorized role.

• OUT\_OF\_SCOPE — after boundary role validation, the payload is not mechanism-level and does not enter the mechanism-level adjudication path.

## 2.3 Central invariant: Boundary-Qualified No Unlabeled Claims

No claim may be used for gating, for changing governed state, for populating references in DECISION, FAIL\_CLOSED, CHECKPOINT, ROLLBACK, or REPORT, or for activating an output contract unless, after boundary validation, the claim is classified as mechanism-level and carries a policy-conformant tsa\_label and source\_class.

No Unlabeled Claims is therefore an absolute property only after boundary role validation. The implementation shall place no implicit trust in statement\_role supplied by an upstream component.

# 3. Authority Model

The agent’s authority is limited to the rule set defined in this specification and the active policy snapshot. Within that scope, the agent may classify SOURCE\_CLASS, verify tsa\_label presence, verify linkage to AXIOM\_SET or other attested sources, detect conflicts within the declared formalism, and emit DECISION, CONFLICT\_EVENT, FAIL\_CLOSED, and ESCALATION\_REQUEST artifacts for mechanism-level use.

The agent has no authority to validate external truth, generate new technical substance as an authoritative source, override policy without an auditable path, redefine terms implicitly, or issue unauthorized clearance.

Where provenance cannot be verified, policy snapshot consistency cannot be maintained, formal conflict is confirmed, or declared budgets are exceeded, the agent shall not degrade to ALLOW. Authority is exhausted in those conditions.

Escalation path: Truth Arbitration Agent → Gate Logic → FAIL\_CLOSED and, where required, NONCOMPLIANT\_HOLD plus ESCALATION\_REQUEST to an authorized external actor.

# 4. Boundary and I/O Contracts

## 4.1 Input Contract Record

The Input Contract Record shall include, at minimum: input\_id, session\_id, scope\_id, turn\_id, payload, input\_statement\_role, tsa\_label if provided upstream, source\_class if provided upstream, source\_ref, any upstream-declared policy\_hash\_ref, producer\_id, and producer\_assertions.

input\_statement\_role is an untrusted boundary assertion. The agent shall compute boundary\_validated\_role independently and shall not consume input\_statement\_role without a successful local role-consistency validation.

A payload is suspected to be mechanism-level if it introduces or modifies terms, axioms, policies, ordering parameters, references for governed records, tool-access conditions, inhibit\_flags, handoff constraints, or any expression that can become the basis for a verdict. If any such signal is present, an upstream explanatory\_only assertion shall not pass directly.

## 4.2 Output Contract Record

The Output Contract Record shall include, at minimum: decision\_id, session\_id, scope\_id, statement\_id\_list, boundary\_validated\_role, verdict, reason\_code, validator\_refs, tsa\_label, source\_class, source\_ref, policy\_snapshot\_id, policy\_hash\_ref, order\_ref, evidence\_ref\_list, and gate\_impact.

For ALLOW and ALLOW\_CONSTRAINED, the output shall also include conflict\_check\_mode, conflict\_check\_confidence, conflict\_check\_coverage\_scope, and residual\_risk\_statement whenever conflict handling is not fully decidable across the entire payload.

For FAIL\_CLOSED, the output shall also include inhibit\_flags, root\_reason\_code, cleared\_only\_by, remediation\_class, and, where applicable, escalation\_request\_ref.

For ESCALATE or FAIL\_CLOSED paths that require an external actor, the agent shall emit an explicit ESCALATION\_REQUEST or CLEARANCE\_NEEDED\_NOTIFICATION artifact. A FAIL\_CLOSED log entry by itself is not a sufficient interoperable output.

# 5. State Model and Workflow

The state model is sequential per scope. For each active scope there shall be only one adjudication flow in flight. Any concurrent implementation shall realize this property either through explicit serialization or through snapshot-at-intake with compare-and-commit at verdict time. Without one of those techniques, produced verdicts are non-conformant with the ordering contract.

| State | Purpose | Entry condition | Normative output |
| --- | --- | --- | --- |
| INTAKE | Receive payload and boundary metadata. | Valid input contract. | ROLE\_SCREENING |
| ROLE\_SCREENING | Validate boundary\_validated\_role and detect bypass patterns. | Payload suspected or declared as mechanism-level. | CANONICALIZING or FAIL\_CLOSED |
| CANONICALIZING | Generate canonical\_text and statement\_id. | Valid semantic\_normalization\_profile. | EVALUATING |
| EVALUATING | Run structural and policy-snapshot validators. | V-001 through V-005. | CLASSIFYING or FAIL\_CLOSED |
| CLASSIFYING | Apply the SOURCE\_CLASS × tsa\_label × boundary\_validated\_role × policy matrix. | Computed provenance admissibility. | CONFLICT\_CHECKING, DENY, ALLOW\_CONSTRAINED, or FAIL\_CLOSED |
| CONFLICT\_CHECKING | Run V-006A and/or V-006B according to the declared formalism. | Conflict resolved or qualified. | DECIDED, ESCALATE, or FAIL\_CLOSED |
| DECIDED | Emit verdict and evidence. | Complete decision record. | HANDOFF\_READY or CLOSED |
| FAIL\_CLOSED | Block local progress. | Failure semantics satisfied. | NONCOMPLIANT\_HOLD or CLOSED |
| NONCOMPLIANT\_HOLD | Wait for audited external clearance. | Valid clearance response. | READMISSION\_PENDING or CLOSED |
| READMISSION\_PENDING | Restart full evaluation under a new snapshot. | Available readmission\_budget. | ROLE\_SCREENING |

## 5.1 Transition triggers

• INTAKE → ROLE\_SCREENING for any payload that enters the agent contract.

• ROLE\_SCREENING → CANONICALIZING if boundary\_validated\_role is mechanism\_level or if the payload can be referenced in a DECISION, FAIL\_CLOSED, CHECKPOINT, ROLLBACK, or REPORT record.

• ROLE\_SCREENING → FAIL\_CLOSED if the input claims explanatory\_only, but role validation detects commit-relevant mechanism content and policy forbids automatic reclassification.

• EVALUATING → FAIL\_CLOSED if tsa\_label, source\_class, policy\_snapshot\_id, or a policy-required source\_ref is missing, or if policy snapshot drift is detected.

• CONFLICT\_CHECKING → ALLOW only if all blocking validations have passed and conflict\_check\_strength is sufficient under policy.

• CONFLICT\_CHECKING → ALLOW\_CONSTRAINED or ESCALATE if conflict handling is partial, heuristic, or below threshold, but policy permits conditional progress or external review.

• FAIL\_CLOSED → NONCOMPLIANT\_HOLD if remediation requires an external actor or new evidence; the same transition shall emit ESCALATION\_REQUEST.

## 5.2 Observability and replay basis

For every relevant transition, the implementation shall emit enough observable artifacts to support replay and offline reconstruction. At minimum this includes DECISION, FAIL\_CLOSED, CHECKPOINT(LASTCLEAN), ROLLBACK, ESCALATION\_REQUEST, CLEARANCE\_RESPONSE, and, where applicable, NONCOMPLIANT\_HOLD.

# 6. Decision Objects and Decision Table

The Decision Table shall be total for all relevant combinations. The implementation may compress the table through meta-rules but may not leave any relevant combination unresolved.

General totality rule: if boundary\_validated\_role is not mechanism\_level, the default outcome is OUT\_OF\_SCOPE only after successful role validation. If boundary\_validated\_role is mechanism\_level, any missing labeling, inadmissible provenance, policy snapshot drift, or confirmed formal conflict shall lead to DENY or FAIL\_CLOSED. Only fully admissible combinations may lead to ALLOW or ALLOW\_CONSTRAINED.

RECLASSIFY is a role-validation action, not a final admissibility verdict. It routes the payload into the mechanism-level path under the policy conditions declared for role correction.

| ID | Decision object | Condition | Outcome |
| --- | --- | --- | --- |
| DO-001 | Unlabeled mechanism claim | boundary\_validated\_role = mechanism\_level and tsa\_label is missing | FAIL\_CLOSED |
| DO-002 | TRAINED in index-zero | source\_class = TRAINED for the target concept in index-zero | DENY or FAIL\_CLOSED, according to policy |
| DO-003 | UNTRUSTED without reclassification | source\_class = UNTRUSTED and no reclassification decision exists | DENY |
| DO-004 | Suspected role mismatch | input\_statement\_role = explanatory\_only but the role validator detects mechanism content | RECLASSIFY or FAIL\_CLOSED |
| DO-005 | Confirmed formal conflict | V-006A = fail | FAIL\_CLOSED or DENY, according to severity |
| DO-006 | Probable heuristic conflict | V-006B = fail or inconclusive below threshold | ALLOW\_CONSTRAINED or ESCALATE |
| DO-007 | Policy snapshot drift | policy\_hash\_ref changed mid-flight | FAIL\_CLOSED and re-evaluate |
| DO-008 | Complete evidence and closed conflict | All blocking validators pass | ALLOW |
| DO-009 | External clearance required | Failure semantics require an external actor | ESCALATE plus ESCALATION\_REQUEST |

# 7. Validator Catalogue

Each validator shall declare validator\_id, validator\_class, strength, coverage\_scope, failure\_effect, evidence\_fields, and fallback semantics. Validators with different strengths shall not emit indistinguishable artifacts without an explicit confidence qualifier.

| Validator | Class | Scope | Effect at fail / inconclusive |
| --- | --- | --- | --- |
| V-001 Statement Identity | deterministic | canonical\_text, statement\_id, and a valid serialization profile exist | FAIL\_CLOSED |
| V-002 Mandatory Fields Presence | deterministic | Required fields exist across input, output, and evidence contracts | FAIL\_CLOSED |
| V-003 Provenance Admissibility | deterministic | tsa\_label, source\_class, source\_ref, and the policy allowlist are valid | DENY or FAIL\_CLOSED |
| V-004 AXIOM / TERM Linkage | deterministic | Linkage to AXIOM\_SET, TERM\_BIND, and POLICY\_BIND is valid | DENY |
| V-005 Boundary Role Consistency | heuristic-hardening | Confirms or reclassifies statement\_role at the boundary | RECLASSIFY, ALLOW\_CONSTRAINED, or FAIL\_CLOSED |
| V-006A Formal Conflict Check | formal\_decidable | Detects contradictions inside the declared formalism | FAIL\_CLOSED or DENY |
| V-006B Semantic Conflict Heuristic | heuristic | Detects probable contradictions outside the fully decidable formalism | ALLOW\_CONSTRAINED, ESCALATE, or DENY; never simple ALLOW below threshold |
| V-007 Policy Snapshot Consistency | deterministic | Ensures that the verdict uses the same policy snapshot captured at intake | FAIL\_CLOSED and re-evaluate |
| V-008 Ordering / Serialization | deterministic | Ensures one in-flight flow per scope or a valid compare-and-commit discipline | FAIL\_CLOSED |
| V-009 Escalation Artifact Emission | deterministic | Ensures that ESCALATION\_REQUEST is emitted when required by failure semantics | FAIL\_CLOSED |

# 8. Evidence Contract

For every verdict, the emitted evidence shall include at minimum: decision\_id, statement\_id\_list, verdict, reason\_code, tsa\_label, source\_class, source\_ref, boundary\_validated\_role, role\_validation\_result, policy\_snapshot\_id, policy\_hash\_ref, scope\_id, turn\_id, order\_ref, and logical timestamp.

For role validation, the evidence shall also include: input\_statement\_role, boundary\_validated\_role, role\_validator\_refs, and role\_reclassification\_reason when applicable. For payloads suspected of bypass, omission of these fields makes the verdict non-reconstructible.

For conflict handling, the evidence shall also include: conflict\_check\_mode, conflict\_check\_strength, conflict\_check\_confidence, conflict\_check\_coverage\_scope, compared\_claim\_set\_ref, and residual\_risk\_statement. If V-006B is the only available conflict check, simple ALLOW is forbidden; the verdict shall be ALLOW\_CONSTRAINED, ESCALATE, DENY, or FAIL\_CLOSED according to policy.

For FAIL\_CLOSED and NONCOMPLIANT\_HOLD, the evidence shall additionally include: inhibit\_flags, root\_reason\_code, clearance\_needed, cleared\_only\_by, remediation\_class, escalation\_request\_ref, and, where applicable, clearance\_response\_ref.

All artifacts shall support offline reconstruction without access to the internal engine state. Any verdict missing the required closure fields is partial or invalid.

Optional deployment-level pairing or hardware-backed attestation may strengthen provenance binding and assurance, but it does not replace semantic gate logic, validator semantics, or admissibility rules.

# 9. Gate Logic

The Gate Logic Record shall be deterministic and total. It binds validators, decision objects, policy snapshot rules, and failure semantics into a single verdict function.

• If V-001, V-002, V-003, V-007, V-008, or V-009 fails, the verdict is FAIL\_CLOSED.

• If V-005 identifies a role mismatch and policy permits reclassification, the payload enters the mechanism-level path; otherwise the verdict is FAIL\_CLOSED.

• If V-006A confirms conflict, the verdict is DENY or FAIL\_CLOSED according to the configured severity threshold.

• If only V-006B is available and the result is inconclusive or below threshold, simple ALLOW is forbidden. The minimum result is ALLOW\_CONSTRAINED or ESCALATE.

• Any verdict that requires an external actor shall create ESCALATION\_REQUEST in the same adjudication path. Otherwise the gate is structurally incomplete and converts to FAIL\_CLOSED.

• If no specialized branch applies and the decision path is structurally incomplete, the result shall be FAIL\_CLOSED.

# 10. Machine-Readable Form Catalogue

| Form | Purpose | Key fields |
| --- | --- | --- |
| MRF-STATEMENT.json | Canonical payload for a statement candidate | input\_statement\_role, boundary\_validated\_role, canonical\_text, statement\_id |
| MRF-DECISION.json | Arbitration verdict | verdict, reason\_code, validator\_refs, gate\_impact, policy\_snapshot\_id |
| MRF-CONFLICT.json | Conflict event | conflict\_mode, strength, confidence, conflicting\_statement\_ids |
| MRF-FAIL\_CLOSED.json | Block record | inhibit\_flags, root\_reason\_code, clearance\_needed, cleared\_only\_by |
| MRF-ESCALATION\_REQUEST.json | Normative request for external remediation | request\_id, failure\_ref, required\_actor\_role, required\_evidence, status |
| MRF-CLEARANCE\_RESPONSE.json | Response to an external clearance request | request\_id, actor\_id, evidence\_refs, clearance\_verdict |
| MRF-HANDOFF-CHECK.json | Acceptance record for the execution layer | semantic closure, evidence closure, failure closure, policy snapshot closure |

# 11. Temporal and Ordering Contract

The mandatory minimum order is: intake → policy snapshot freeze → boundary role validation → canonicalize → statement\_id → structural validators → provenance classification → conflict check → verdict → evidence emission → optional escalation or handoff.

At intake, the implementation shall freeze policy\_snapshot\_id and policy\_hash\_ref. If active policy changes before verdict, V-007 shall fail and the evaluation shall restart under the new snapshot. A verdict may not be emitted under any policy\_hash\_ref other than the one used during evaluation.

Per scope, there shall be at most one in-flight flow. Concurrent implementations shall ensure serialization or compare-and-commit. Any verdict produced from a claim set that changed in the meantime is invalid.

Readmission shall not inherit ALLOW across changes in policy, scope, source\_ref, AXIOM\_SET, or clearance epoch. Every readmission requires a full re-evaluation under an explicit budget.

# 12. Failure Semantics and Readmission

| Failure code | Meaning | Required output / clearance |
| --- | --- | --- |
| UNLABELED\_CLAIM | Mechanism-level claim without a conformant tsa\_label or source\_class | FAIL\_CLOSED; clearance by an authorized actor |
| ROLE\_BYPASS\_SUSPECTED | input\_statement\_role = explanatory\_only is inconsistent with the payload | FAIL\_CLOSED or RECLASSIFY under policy |
| FORMAL\_CONFLICT\_CONFIRMED | V-006A confirmed contradiction | DENY or FAIL\_CLOSED |
| HEURISTIC\_CONFLICT\_UNCLOSED | Probable semantic conflict remains open or under-closed | ALLOW\_CONSTRAINED or ESCALATE; simple ALLOW is forbidden |
| POLICY\_SNAPSHOT\_DRIFT | Policy changed mid-flight | FAIL\_CLOSED and re-evaluate |
| ORDERING\_VIOLATION | Concurrent flow not serialized, or compare-and-commit failed | FAIL\_CLOSED |
| CLEARANCE\_ARTIFACT\_MISSING | An external-actor path exists but ESCALATION\_REQUEST is missing | FAIL\_CLOSED (structural) |

FAIL\_CLOSED is not the only externally meaningful failure output. If cleared\_only\_by implies an external actor, the agent shall emit ESCALATION\_REQUEST immediately. That request is part of failure semantics, not an optional deployment extension.

Readmission loops without progress are forbidden. The implementation shall enforce readmission\_budget and recurrence\_counter. When the budget is exhausted, the agent shall emit terminal ESCALATE or PERMANENT\_BLOCK according to policy.

## 12.1 Clearance artifact and re-entry criteria

The minimum clearance artifact contract includes: request\_id, actor\_id or actor\_role, evidence\_refs, clearance\_verdict, clearance\_epoch, and linkage to failure\_ref.

Re-entry is permitted only after valid clearance, a new snapshot freeze, and a full re-evaluation. If readmission\_budget is exhausted or the clearance does not close the root cause, the agent shall emit terminal ESCALATE or PERMANENT\_BLOCK.

# 13. Implementation Assumptions and Required Controls

| Assumption | Required control |
| --- | --- |
| Deterministic canonicalization exists. | semantic\_normalization\_profile shall be documented, and statement identity shall be declared as record identity rather than universal semantic identity. |
| Upstream may propose statement\_role. | V-005 shall confirm boundary\_validated\_role locally; No Unlabeled Claims applies only after that validation. |
| Conflict checking may use different formalisms. | conflict\_check\_mode, strength, confidence, and coverage\_scope shall be emitted and shall affect the verdict. |
| Some failure paths require external clearance. | FAIL\_CLOSED shall be accompanied by interoperable ESCALATION\_REQUEST when the path depends on an external actor. |
| Policy may evolve over time. | The implementation shall freeze the snapshot at intake and shall re-evaluate when drift occurs. |

# 14. Optional Capabilities and Non-Substitution Rule

• Contextual escalation support may improve risk grading, but it does not replace the hard block for No Unlabeled Claims and does not replace V-006 qualifiers.

• Hardware-backed attestation or commit-boundary pairing may strengthen provenance binding and clearance assurance, but it does not alter semantic arbitration logic.

• A separate quarantine/readmission workflow may support controlled recovery, but it does not relax the requirement for audited ESCALATION\_REQUEST, validated clearance, or readmission\_budget.

No optional capability declared in this specification may substitute for an active normative obligation in the semantic core. In particular, optional escalation tooling may not replace No Unlabeled Claims, validator semantics, or gate closure; hardware attestation may not replace provenance admissibility, role validation, or conflict qualifiers; and a separate quarantine/readmission workflow may not replace ESCALATION\_REQUEST, auditable clearance, or readmission budget.

# 15. Conformance Conditions

• All mandatory fields across the Semantic Contract, Authority Model, Input and Output Contracts, State Model, Gate Logic, Failure Semantics, and Evidence Contract are present and populated.

• The Decision Table and Validator Catalogue jointly cover all declared decision objects and do not leave relevant combinations unresolved.

• The implementation supports role-bypass handling, formal conflict handling, heuristic conflict handling, ALLOW\_CONSTRAINED, ESCALATION\_REQUEST, clearance response, and terminal handling at readmission budget exhaustion.

• Offline reconstruction is possible from emitted evidence alone, including role reclassification, conflict qualifiers, policy snapshot data, and clearance-driven remediation.

• No open inconsistency remains in boundary handling, validator semantics, policy snapshot semantics, conflict closure, fail-closed escalation, replay, or readmission semantics.

# 16. Reuse and Adaptation Guidance

## 16.1 Stable semantic core

The following elements are stable and shall not be reinterpreted in downstream use: the agent’s identity and restricted jurisdiction; Boundary-Qualified No Unlabeled Claims; authority and non-authority zones; the verdict vocabulary; the requirement for ESCALATION\_REQUEST when an external actor is needed; the ordering contract and policy snapshot freeze; blocking failure semantics; evidence closure; and offline reconstructibility.

## 16.2 Parameterized elements

The following elements may be specialized without altering the semantic core: concrete reason\_code names; machine-readable field naming where semantics remain identical; concrete policy profiles; exact external roles for clearance and escalation; serialization details of machine-readable forms; and optional integrations that do not substitute for required normative logic.

## 16.3 Non-reuse zones

This specification shall not be reused without full re-specification if the intended variant expands the agent’s jurisdiction beyond provenance, labeling, conflict, and admissibility; adds authority to validate full material truth; removes local boundary role validation; relaxes No Unlabeled Claims; permits simple ALLOW on heuristic-only conflict handling below threshold; removes ESCALATION\_REQUEST from external remediation paths; or changes record identity semantics.

## 16.4 Required dependencies across sections

Conformant reuse depends on coherence across the Semantic Contract, Authority Model, State Model, Decision Table, Validator Catalogue, Evidence Contract, Gate Logic, Failure Semantics, machine-readable forms, and ordering rules.

## 16.5 Patch discipline

Any patch that affects identity, authority, boundary handling, decision objects, validator semantics, evidence fields, failure semantics, replay or readmission, or reuse conditions shall update every affected rule, contract, and machine-readable form consistently.

## 16.6 Rendering and output compatibility

This specification may be rendered into public library or controlled downstream outputs only if the semantic core remains complete and unique and the downstream consumer does not need unpublished manual reconstruction to implement the agent.

| Truth Arbitration Agent — Public Library Specification |
| --- |
