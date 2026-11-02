Audit Replay Agent — Specification

Audit Replay Agent

Specification

| Agent ID | ARA-AUDIT-REPLAY-001 |
| --- | --- |
| **Operating posture** | Offline audit / replay / verification |

This document is a buyer-facing, executable-neutral technical specification. It defines the agent’s operational semantics, verdict vocabulary, validation logic, contracts, and evidence requirements in public language. It is not a software implementation, does not validate the underlying system design, and does not grant deployment exceptions.

# 1. Purpose and Operating Scope

The Audit Replay Agent reconstructs and verifies offline the decision path, checkpoints, and rollback sequences of ledger-backed sessions. It is designed for high-assurance environments in which auditability, deterministic reconstruction, and controlled fail-closed behavior are mandatory.

The target component is a canonical audit and replay agent for CSL and ZSSC session artifacts, specialized for offline reconstruction, continuity verification, and reproduction of rollback sequences.

| Attribute | Public requirement |
| --- | --- |
| **Criticality** | Failure invalidates auditability, correctness, provenance confidence, and replay sufficiency because the agent operates on critical decision and restoration artifacts. |
| **Operating mode** | Full mode. |
| **Primary goals** | Formal correctness; auditability; replay and reconstruction; controlled fail-closed behavior; downstream implementability. |
| **Deployment posture** | High-audit environments, including offline or air-gapped environments, with signed export, chain of custody, and optional integration with an external assurance component when policy requires it. |

# 2. Foundational Record Models and Interpretation Boundary

This specification operates on records that comply with the structural properties defined below. The terms CSL and ZSSC are abbreviations defined exclusively within this specification.

| Foundational model | Operational role in this specification |
| --- | --- |
| **CSL** | Provides framed record encoding, checksum validation, canonical parsing, append-only hash-chain continuity, fail-closed restoration discipline, tool-state restrictions, and auditable export semantics. |
| **ZSSC** | Provides auditable governance records and control points including ZSSC\_ENTER / ZSSC\_EXIT, CPW\_SAMPLE, BAND\_CHANGE, CHECKPOINT(LASTCLEAN), ROLLBACK, FAIL\_CLOSED, REPORT, bound verification evidence, freshness and anchor discipline, NONCOMPLIANT\_HOLD, and readmission after restored compliance prerequisites. |

All normative requirements needed to implement the agent are stated in this document. No operational rule may be introduced from undocumented auxiliary materials.

No positive verdict and no logical restoration may be issued if framing, checksum, canonical parsing, signature validation, hash continuity, or policy checks fail.

# 3. Agent Overview

| Field | Specification |
| --- | --- |
| **Display name** | Audit Replay Agent |
| **Agent class** | Canonical audit / replay / verification agent. |
| **Mission** | Determine whether a session can be reconstructed offline in a deterministic way and whether its decision path, checkpoints, and rollback sequences are complete, coherent, and verifiable without live access to the underlying system. |
| **Identity target** | A governable decision and transition unit for reconstructing ledger-backed sessions. |
| **Primary decision objects** | Session, hash chain, framed record, statement set, CHECKPOINT(LASTCLEAN), rollback sequence, and report evidence set. |
| **Policy orientation** | Audit-first, replay-first, fail-closed, evidence-sufficient. |
| **Boundary** | Input: ledger bundle, policy profile, trust store or verification policy, and policy-admitted evidence references. Output: integrity and reconstructability verdicts, audit report, rollback explanation, machine-readable evidence export, and incident notice when compliant finalization is blocked. |
| **Misuse boundary** | This document does not validate the underlying system design, does not validate a software implementation, and does not declare operational compliance in the absence of implementation, testing, and deployment policy. |

# 4. Authority Model

| Field | Normative content |
| --- | --- |
| **Authority source** | The active policy profile, the admitted input package, the validator catalogue, and the evidence contract. |
| **Delegated scope** | Framing, checksum, and parsing verification; signature and hash-continuity verification; state reconstruction; checkpoint, rollback, and report reconstruction. |
| **Non-authority zones** | The agent does not create or modify session axioms, does not rewrite the ledger, does not approve new imports, and does not replace a human operator for deployment exceptions. |
| **Authority budget** | The authority budget is bounded by policy-defined compute, time, and memory ceilings. Exceeding them triggers degrade-to-summary behavior or a fail-closed audit verdict, according to policy. |
| **Escalation path** | Audit operator to external verifier or deployment owner when execution evidence or governing policy is missing. |
| **Block triggers** | Signature failure, hash-chain break, invalid canonical parse, unresolved policy binding, replay-counter violation, or missing required checkpoint lineage. |

# 5. Decision Objects and Verdict Vocabulary

| Decision object | Decision class | Admitted verdicts | Primary artifact |
| --- | --- | --- | --- |
| **Ledger session** | Admit or reject reconstruction | RECONSTRUCTABLE │ PARTIAL │ REJECTED | REPORT |
| **Hash chain continuity** | Integrity gate | CONTIGUOUS │ BROKEN | Evidence Contract |
| **Framed record** | Record admission | VALID │ MALFORMED │ UNSUPPORTED | Validator Catalogue |
| **CHECKPOINT(LASTCLEAN)** | Checkpoint usability | USABLE │ STALE │ UNVERIFIED | Workflow / State Transition |
| **Rollback sequence** | Rollback correctness | REPLAYABLE │ INCOMPLETE │ INVALID | Gate Logic |
| **Audit report** | Finalization eligibility | FINALIZABLE │ INCIDENT\_ONLY │ BLOCKED | Decision Table |

# 6. Workflow and State Transition Model

## 6.1 States

| State | Meaning | Entry trigger | Exit trigger |
| --- | --- | --- | --- |
| **S0 INGESTED** | Bundle received but not yet validated. | Input contract satisfied. | EV\_PARSE\_OK or structural failure. |
| **S1 PARSED** | Framing, checksum, and canonical parse are valid. | V-01 through V-03 pass. | Signature, continuity, and policy verification. |
| **S2 VERIFIED** | Signatures, hash continuity, policy binding, and freshness anchors are validated to the extent required by policy. | V-04 through V-06 pass; V-09 passes when policy activates freshness or anchor control. | State reconstruction. |
| **S3 RECONSTRUCTED** | Session state, statement lineage, and record lineage are reconstructed offline. | Replay fold complete. | Checkpoint analysis. |
| **S4 CHECKPOINT\_RESOLVED** | LASTCLEAN and rollback lineage are identified and evaluated. | Checkpoint lineage valid. | Report assembly or fail-closed / hold. |
| **S5 REPORT\_READY** | A finalizable report and complete machine-readable export are available. | Evidence sufficiency passes and report sufficiency passes. | Emit output. |
| **SH HOLD\_ACTIVE** | Session is in audit-only mode after evidence failure, missing verification evidence, or counter / anchor replay. | EV\_EVIDENCE\_FAIL or EV\_COUNTER\_REPLAY. | EV\_READMISSION\_GRANTED or incident-only closure. |
| **SX FAIL\_CLOSED / S6 READMITTED** | SX is a critical block. S6 is a session readmitted after compliance prerequisites are restored. | Critical validator failure, or EV\_READMISSION\_GRANTED with hold-exit evidence and an updated anchor. | A new admissible session or controlled resumption to S2 or S4. |

## 6.2 Events

| Event | Description | Normative effect |
| --- | --- | --- |
| **EV\_PARSE\_OK** | All frames can be read deterministically. | Permits S0 -> S1. |
| **EV\_SIGNATURE\_FAIL** | A required signature is invalid or missing. | Forces SX FAIL\_CLOSED. |
| **EV\_CHAIN\_BREAK** | hash\_prev / hash\_curr no longer form a continuous chain. | Forces verdict BROKEN and SX FAIL\_CLOSED. |
| **EV\_POLICY\_UNRESOLVED** | policy\_profile\_id or policy\_hash is not resolvable or not admitted. | Blocks compliant finalization and may force SX. |
| **EV\_LASTCLEAN\_FOUND** | A usable checkpoint has been identified. | Permits S3 -> S4. |
| **EV\_ROLLBACK\_REPLAYED** | A valid rollback chain has been reproduced offline. | Supports verdict REPLAYABLE. |
| **EV\_REPORT\_BOUND** | The report includes continuity, decisions, checkpoints, limitations, and evidence linkage. | Permits S4 -> S5. |
| **EV\_EVIDENCE\_FAIL** | Required verification evidence is missing, invalid, or not recognized by policy. | Forces SH HOLD\_ACTIVE and blocks compliant finalization. |
| **EV\_COUNTER\_REPLAY** | The verification counter or freshness anchor is not strictly increasing. | Forces SH HOLD\_ACTIVE and blocks compliant finalization. |
| **EV\_READMISSION\_GRANTED** | There is explicit proof that compliance prerequisites were restored, including hold-exit evidence, resolvable policy, and a strictly increasing updated anchor. | Permits readmission and controlled resumption. |

## 6.3 Remediation Paths

RP-01 Structural remediation: MALFORMED or UNSUPPORTED record -> DENY\_RECORD -> remove the offending record or re-export the bundle -> start a new audit session.

RP-02 Integrity remediation: SIGNATURE\_FAIL, CHAIN\_BREAK, or unresolved policy binding -> FAIL\_CLOSED -> issue incident notice -> provide a new bundle or remediate the trust store / policy -> start a new admissible session.

RP-03 Checkpoint remediation: CHECKPOINT\_UNVERIFIED -> rollback verdict INVALID or PARTIAL -> issue incident or partial report -> request additional evidence or a completed bundle.

RP-04 Evidence / freshness remediation: EV\_EVIDENCE\_FAIL or EV\_COUNTER\_REPLAY -> NONCOMPLIANT\_HOLD -> audit-only mode -> restore prerequisites -> EV\_READMISSION\_GRANTED -> controlled resumption.

RP-05 Report remediation: REPORT\_INSUFFICIENT -> FINALIZE\_REPORT blocked -> complete evidence references, continuity references, and limitations -> rerun V-08.

# 7. Input and Output Contracts

| Contract | Required fields | Rule |
| --- | --- | --- |
| **Input Contract IC-01 Session Bundle** | ledger\_uuid; session\_id; record stream; policy\_profile\_id; source\_id; hash head / tail; signature refs | Without these fields the agent does not enter replay logic. |
| **Input Contract IC-02 Optional Evidence** | BOOT\_\* refs; VERIF\_EVENT; VERIF\_COUNTER\_ANCHOR; export manifest; trust-store refs | Mandatory when policy requires bound verification. |
| **Output Contract OC-01 Audit Report** | report\_id; session\_id; verdict; continuity summary; checkpoints; rollback refs; limitations; signature / export refs | Must be sufficient for offline audit. |
| **Output Contract OC-02 Machine Evidence** | Normalized JSON verdict; validator outcomes; record anomalies; graph of refs | No long-form narrative is required for the execution consumer. |
| **Output Contract OC-03 Incident Notice** | reason\_code; blocked\_stage; inhibitions; required\_remediation | The only permitted output in FAIL\_CLOSED. |

# 8. Validator Catalogue

| ID | Validator | Type | Pass condition | Fail effect |
| --- | --- | --- | --- | --- |
| **V-01** | Frame length validator | Structural | The declared length matches the available bytes. | Record MALFORMED; block. |
| **V-02** | Checksum validator | Structural | The checksum over the canonical bytes is correct. | Record MALFORMED; block. |
| **V-03** | Canonical parse validator | Structural | The canonical serialization can be parsed without ambiguity. | Record UNSUPPORTED or MALFORMED; block. |
| **V-04** | Signature validator | Evidence | All required signatures are valid under the current policy. | FAIL\_CLOSED. |
| **V-05** | Hash continuity validator | Evidence | hash\_prev and hash\_curr form a continuous chain. | Verdict BROKEN; FAIL\_CLOSED. |
| **V-06** | Policy bind validator | Boundary | policy\_profile\_id and policy\_hash are resolvable and admitted. | BLOCKED. |
| **V-07** | Checkpoint lineage validator | Behavioral | LASTCLEAN precedes FAIL\_CLOSED and its state\_hash is verifiable. | Rollback INVALID. |
| **V-08** | Report sufficiency validator | Evidence | The report includes decisions, checkpoints, continuity, and limitations. | FINALIZE\_REPORT blocked. |
| **V-09** | Replay counter / freshness validator | Ordering | The counter or anchor is strictly increasing under policy. | NONCOMPLIANT\_HOLD / block. |
| **V-10** | Tool-state exclusion validator | Operational | No unauthorized tool-state artifact enters logical reconstruction. | QUARANTINE. |

# 9. Decision Table

| Rule ID | Input condition | Decision | Gate impact | Evidence linkage |
| --- | --- | --- | --- | --- |
| **D-01** | V-01 through V-03 pass and V-04 through V-06 are pending. | ALLOW\_PARSE | S0 -> S1 | Validator set. |
| **D-02** | Any record is MALFORMED. | DENY\_RECORD | Block affected session. | Record anomaly list. |
| **D-03** | Signatures valid + continuity valid + policy valid. | ALLOW\_RECONSTRUCTION | S1 -> S2 | Signature and chain refs. |
| **D-04** | Continuity broken. | FAIL\_CLOSED\_CHAIN\_BREAK | Enter SX. | Hash-break proof. |
| **D-05** | LASTCLEAN found and precedes FAIL\_CLOSED. | ALLOW\_CHECKPOINT\_USE | S3 -> S4 | Checkpoint refs. |
| **D-06** | Rollback chain complete and coherent. | VERDICT\_REPLAYABLE | Permit OC-01 / OC-02. | Rollback refs. |
| **D-07** | Report sufficiency passes. | FINALIZE\_REPORT | S4 -> S5 | REPORT fields. |
| **D-08** | Freshness / counter replay or evidence failure. | INCIDENT\_ONLY | NONCOMPLIANT\_HOLD or SX | Verification refs. |

# 10. Evidence Contract

Each verdict must be linked to the minimum evidence set required for offline reconstruction and audit without live access to the underlying system. No positive conclusion may be issued unless the verdict is bound to the exact input bundle, policy binding, validator outcomes, continuity proofs, and, where applicable, checkpoint, rollback, hold, and readmission evidence.

For ZSSC-bound sessions, the final report must be able to include or explicitly reference AXIOM\_SET, POLICY\_BIND, CPW summary, DECISION / FAIL\_CLOSED, checkpoints, rollback references, holds, and continuity fields.

The audit export must be signed and must preserve chain of custody: exporter identity, covered interval, hashes, CSL head, governing policy, and the evidence references used.

| Evidence field | Required | Purpose |
| --- | --- | --- |
| **bundle\_digest** | Yes | Binds the verdict to the exact input bundle. |
| **policy\_profile\_id / policy\_hash** | Yes | Fixes the governing policy under which the verdict is issued. |
| **validator\_outcomes** | Yes | Allows the consumer to replay admissibility and blocking decisions. |
| **hash\_continuity\_refs** | Yes | Proves append-only history and reconstructable ordering. |
| **signature\_refs** | Yes when policy requires signatures | Proves authenticity and provenance where signatures are policy-required. |
| **checkpoint\_refs** | Yes for checkpoint, rollback, or replay verdicts | Proves the clean state used for replay. |
| **rollback\_refs** | Yes for verdict REPLAYABLE | Proves the reversion path. |
| **report\_fields\_ref** | Yes for FINALIZE\_REPORT | Proves minimum report completeness. |
| **hold\_enter\_refs** | Yes when NONCOMPLIANT\_HOLD exists | Proves entry into audit-only mode. |
| **hold\_exit\_refs** | Yes for readmission | Proves restoration of compliance prerequisites. |
| **anchor\_update\_ref** | Yes for readmission and counter-sensitive profiles | Proves strict increase after a hold. |
| **boot\_or\_verif\_refs** | Yes when policy activates bound verification | Links the verdict to the external evidence chain when policy requires it. |
| **report\_signature / export\_manifest\_ref** | Yes for final output | Proves export integrity and chain of custody. |

# 11. Machine-Readable Output Form

The JSON form below is normative for automated handoff. Long-form explanatory text remains in the narrative audit document. Enum values are strict; any value outside the admitted set must be rejected by the consumer.

```
{ “agent_id”: “ARA-AUDIT-REPLAY-001”, “session_id”: “”, “verdict”: “REPLAYABLE│PARTIAL│REJECTED”, “chain_status”: “CONTIGUOUS│BROKEN”, “lastclean_ref”: “”, “rollback_refs”: [“…”], “validator_outcomes”: [ {“id”: “V-05”, “status”: “pass│fail”, “evidence_ref”: “…”} ], “report_ref”: “”, “blocked_stage”: “” }
```

# 12. Gate Logic

| Status | Conditions | Permitted actions | Prohibited actions |
| --- | --- | --- | --- |
| **OPEN** | Structural and evidence validators have passed. | Reconstruction; checkpoint analysis; report assembly. | None beyond policy. |
| **CONSTRAINED** | Partial reconstruction is possible but critical insufficiency is absent. | Partial report; anomaly export. | Final verdict REPLAYABLE. |
| **QUARANTINE** | Unauthorized tool-state or auxiliary artifact detected. | Isolated audit; incident export. | Injection into the replay core. |
| **NONCOMPLIANT\_HOLD** | evidence\_ok = false or freshness replay detected. | Audit-only mode; incident report. | Checkpoint or report compliant finalization. |
| **FAIL\_CLOSED** | Signature failure, chain break, canonical parse failure, or invalid policy. | Incident-only output. | Any positive verdict or any compliant finalization. |

Readmission is governed by the workflow readmission path: no readmission is permitted without hold\_exit\_refs and anchor\_update\_ref.

# 13. Semantic Contract

| Verdict | Normative meaning |
| --- | --- |
| **REPLAYABLE** | The session can be reconstructed offline with a decision path, continuity, and rollback lineage sufficient for independent audit. |
| **PARTIAL** | Some artifacts can be reconstructed, but closure is missing for at least one critical decision object. |
| **REJECTED** | The input cannot support admissible reconstruction; no compliance output may be issued. |
| **BROKEN** | The integrity chain is not continuous; conclusions about the full history are invalid. |
| **INCIDENT\_ONLY** | Only incident and remediation artifacts are permitted, not a compliant report. |

# 14. Temporal and Ordering Rules

Ordering must be grounded in a justified mechanism, not in host-only timestamps. When physical time is used, it is auxiliary and not constitutive of verdict correctness.

Primary replay ordering is determined by ledger sequence and the hash\_prev / hash\_curr chain.

For key lifecycle states or freshness anchors, effective ordering points may be expressed by ledger sequence instead of system-clock time.

ROLLBACK is valid only if CHECKPOINT(LASTCLEAN) precedes FAIL\_CLOSED and the checkpoint state\_hash verifies under the applicable verification ruleset.

# 15. Failure Semantics

| Reason code | Meaning | Failure semantics |
| --- | --- | --- |
| **FRAME\_INVALID** | Corrupted or truncated frame. | Reject input; no reconstruction. |
| **CANONICAL\_PARSE\_FAIL** | Non-canonical or unparseable serialization. | Reject input; incident. |
| **SIGNATURE\_FAIL** | Authenticity cannot be verified. | FAIL\_CLOSED. |
| **CHAIN\_BREAK** | Hash continuity is compromised. | FAIL\_CLOSED; chain status BROKEN. |
| **COUNTER\_REPLAY** | Freshness or anchor value is not strictly increasing. | NONCOMPLIANT\_HOLD. |
| **CHECKPOINT\_UNVERIFIED** | LASTCLEAN cannot be reproduced. | Rollback invalid; partial or rejected. |
| **REPORT\_INSUFFICIENT** | Evidence is incomplete for independent audit. | INCIDENT\_ONLY or PARTIAL. |

# 16. Assumptions and Derived Obligations

| Assumption | Derived obligation |
| --- | --- |
| **Resolvable active policies exist.** | The consumer must be able to resolve policy\_id / policy\_hash at replay time. |
| **The ledger is append-only or equivalently tamper-evident.** | The implementation must preserve detectable continuity and verifiable export. |
| **A trust store or verification policy is available.** | Validator V-04 may not be omitted when policy requires signatures. |
| **Checkpoints are produced under ZSSC-compliant schemes.** | The agent may not invent LASTCLEAN; it may only identify and verify it. |
| **Deployment controls may be missing or partial.** | The report must mark operational gaps explicitly without changing CSL or ZSSC semantics. |

# 17. Optional Features and Constraints

| Element | Status | Optionality rule |
| --- | --- | --- |
| **Semantic continuity score** | Controlled optional | Use only when policy activates it; it does not replace constitutive verification. |
| **TVC / proof from freshness issuer** | Conditional optional | Mandatory only when required by the acceptance policy. |
| **NONCOMPLIANT\_HOLD interval in the ledger** | Schema optional | Recommended when FAIL\_CLOSED is related to evidence failure. |
| **Auxiliary indexes / SQLite** | Implementation optional | They must not become the source of truth for admission or audit. |

# 18. Observability Requirements

Critical transitions must remain observable. No critical transition is admissible without an observable trace and linkage to validator outcomes, evidence references, or report fields.

| Surface | Required content |
| --- | --- |
| **Input surfaces** | Session bundle; policy profile; trust store or verification policy; signature refs; BOOT\_\* refs; VERIF\_EVENT; VERIF\_COUNTER\_ANCHOR; optional export manifest refs. |
| **Output surfaces** | Audit report; machine-readable verdict; anomaly export; incident notice; hold and readmission diagnostics when the governing profile activates them. |
| **Observability surfaces** | Validator outcomes; continuity proofs; checkpoint refs; rollback refs; report / export refs; hold-enter refs; hold-exit refs; blocked\_stage; reason\_code; policy and evidence linkage. |
| **Closure rule** | No readmission is permitted without hold\_exit\_refs and anchor\_update\_ref. |

# 19. Assurance Claims and Operational Limits

| Claim or limit | Public statement |
| --- | --- |
| **Identity claim** | The agent is delimited explicitly by identity, role, authority, boundary, and output contracts. |
| **Replay claim** | The specified artifacts permit offline reconstruction of state and history without live access to the underlying system. |
| **Integrity claim** | Verdict REPLAYABLE may not be issued without proof of frame-parse validity, signature validity, and hash-chain continuity. |
| **Failure claim** | Every critical failure produces FAIL\_CLOSED, NONCOMPLIANT\_HOLD, or an explicit negative verdict. Silent failure is not permitted. |
| **Operational limit** | Deployment controls and external verification remain the responsibility of the deployment owner or external assurance component. Their absence must be reported as an explicit gap, not masked. |

# 20. Minimum Verification Scenarios

The implementation should be validated at minimum against the scenarios below. They provide buyer-facing implementation checks while preserving the same operational semantics.

| Scenario | Objective | Expected result |
| --- | --- | --- |
| **Valid bundle vs. corrupted bundle** | Validate framing, checksum, and canonical parsing. | The valid bundle passes structural validation; the corrupted bundle is blocked structurally. |
| **Valid signatures and continuity vs. chain break** | Validate signature and continuity enforcement. | Reconstruction is permitted only on the valid bundle; a chain break forces FAIL\_CLOSED. |
| **Resolvable policy vs. unresolved policy** | Validate policy binding. | Compliant finalization is blocked when policy cannot be resolved or admitted. |
| **Usable checkpoint vs. unverifiable checkpoint** | Validate checkpoint lineage. | A usable checkpoint permits replay; an unverifiable checkpoint yields CHECKPOINT\_UNVERIFIED and a negative or partial outcome. |
| **Complete report vs. incomplete report** | Validate report sufficiency. | FINALIZE\_REPORT is permitted only when the report is sufficient. |
| **Strictly increasing freshness / counter vs. replay or non-increase** | Validate ordering and hold logic. | Replay or non-increase enters NONCOMPLIANT\_HOLD. |
| **Unauthorized tool-state artifact present** | Validate replay-core isolation. | The session enters QUARANTINE and the tool-state artifact is not admitted into logical reconstruction. |
| **Checkpoint + rollback + report path** | Validate end-to-end replay logic. | The specification-level outcome is REPLAYABLE only when checkpoint, rollback, and report conditions all close successfully. |
| **Auditable export for an external auditor** | Validate export and evidence sufficiency. | Verdict and evidence set remain reconstructable offline. |
| **HOLD\_ACTIVE to READMITTED** | Validate controlled readmission. | Resumption is permitted only with hold\_exit\_refs, anchor\_update\_ref, resolvable policy, and successful revalidation. |

# 21. Reuse and Dependency Notes

This public specification may be reused only together with an active policy profile, a compatible trust store or verification policy, and input artifacts that are admissible under those controls.

Implementers must take the validator semantics, gate logic, ordering rules, verdict vocabulary, and evidence sufficiency requirements directly from this specification rather than re-deriving them from secondary materials.

Included in scope: identity, jurisdiction, authority and non-authority boundary, decision objects, validator semantics, workflow and state transitions, gate logic, evidence contract, machine-readable verdict form, semantic and ordering rules, failure semantics, observability requirements, assurance claims, and minimum verification scenarios.

Out of scope: software implementation, underlying system-design validation, primary-import approval, and deployment exceptions.

The public release must remain semantically stable: no buyer-facing derivative may introduce new normative rules, alter verdict vocabulary, relax fail-closed behavior, or weaken evidence requirements.
