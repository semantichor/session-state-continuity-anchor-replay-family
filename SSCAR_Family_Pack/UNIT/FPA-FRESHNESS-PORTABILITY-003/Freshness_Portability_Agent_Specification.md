Freshness Portability Agent

Specification

| Field | Value |
| --- | --- |
| Agent ID | FPA-FRESHNESS-PORTABILITY-003 |
| Document status | Released specification |
| Version | 1.0 |
| Date | 20 April 2026 |
| Document class | Canonical normative gate / portability control agent |
| Audience | Buyer-facing implementation and governance teams |

This document is a standalone buyer-facing specification. It defines the operational rules, contracts, validators, failure semantics, and decision paths required to implement the agent without reliance on undisclosed source mappings or external methodological scaffolding.

# 1. Normative Status and Scope

This specification defines the Freshness Portability Agent as a strict freshness-governed control for import acceptance, receipt anchoring, watermark advancement, restoration eligibility, quarantine, and readmission.

The agent is designed for environments that require deterministic anti-replay behavior, fail-closed restoration control, and offline-reconstructable evidence for every semantic verdict.

The specification is operationally complete and standalone. Decision semantics, validator semantics, contract semantics, ordering rules, and failure semantics are normative.

## 1.1 Primary Objectives

- Formal correctness of import acceptance and restoration eligibility decisions.
- Deterministic anti-replay protection through a strictly increasing freshness rule.
- Auditable receipt anchoring and watermark commitment.
- Policy-bound evidence validation and boundary control.
- Fail-closed behavior for invalid, incomplete, or unauthorized conditions.

## 1.2 Critical Claims

- Anti-replay
- Anti-downgrade
- Restore correctness
- Auditability
- Policy-bound import

## 1.3 Threat Model

- Stale replay attempts
- Invalid source binding
- Missing receipt anchoring
- Invalid or absent required evidence
- Transport policy bypass
- Unauthorized tool-state activation
- Rollback attempts against the acceptance watermark
- Unjustified readmission of quarantined cases

# 2. Agent Overview

| Field | Specification |
| --- | --- |
| Canonical name | Freshness Portability Agent |
| Role | Governs strictly increasing freshness acceptance across sources and devices. |
| Jurisdiction | Import acceptance, receipt anchoring, watermark advancement, restore eligibility, quarantine, and readmission. |
| Boundary | The boundary between the import channel, the receipt journal, the restore service, the operator boundary, and the policy layer. |
| Non-goals | The agent does not validate upstream source semantics, does not implement runtime execution, and does not authorize or activate tool-state. |
| Execution neutrality | The specification is execution-neutral. It declares decisions, contracts, and outputs without directly executing restore or tool activation. |

## 2.1 Normative Capabilities

- Enforces strictly increasing freshness per \`source\_id\` and \`ledger\_uuid\` by comparing the incoming value against the stored acceptance watermark.
- Implements deterministic anti-replay using the monotonic rule \`freshness\_new > watermark\_stored\`.
- Makes acceptance effective only through append-only receipt anchoring and treats any tail without a valid receipt as not restore-eligible.
- Supports cross-device portability without device-bound counters, using \`SSM\`, optional \`TVC\`, and optional \`Evidence.bin\` under local policy.
- Separates acceptance from restoration: acceptance creates receipt anchoring, while restoration eligibility is granted only for the accepted head.
- Applies fail-closed behavior for structural, hash, signature, freshness, policy, evidence, and mandatory transport failures.
- Supports idempotent recovery across crash/restart classes \`C-0\`, \`C-1\`, \`C-2\`, and \`C-3\` without degrading the accepted watermark.
- Treats tool-state as untrusted input and never converts freshness acceptance into tool activation authority.

# 3. Core Terms and Public Definitions

**\`source\_id\` —** The stable source identity used to scope freshness comparison, authority, and receipt linkage.

**\`ledger\_uuid\` —** The ledger identity bound to the source and included in verdict, receipt, and watermark records.

**Acceptance watermark —** The locally committed freshness reference for a source. The watermark may move only forward and only after durable receipt anchoring.

**Import Receipt Record (IRR) —** The append-only acceptance receipt used to anchor accepted imports and to gate downstream restoration eligibility.

**\`SSM\` —** A signed metadata artifact used for source binding and packet-hash binding during acceptance evaluation.

**\`TVC\` —** An optional validation artifact that becomes mandatory only when required by local policy.

**\`Evidence.bin\` —** An optional external evidence artifact that becomes mandatory only when required by local policy.

**\`GenesisConfirmed\` —** A restore precondition indicating that the required baseline state has already been established or verified.

**Restore service —** The downstream service that consumes restore admission tokens and performs restore execution outside this agent's authority.

**Quarantine case —** A suspended case that may be re-evaluated only when new evidence or a new policy basis exists.

**Crash/restart classes \`C-0\`/\`C-1\`/\`C-2\`/\`C-3\` —** Implementation recovery checkpoints used to prove idempotence across interrupted acceptance sequences.

# 4. Agent Specification Record

| Field | Value |
| --- | --- |
| Agent identity | FPA-FRESHNESS-PORTABILITY-003 |
| Canonical name | Freshness Portability Agent |
| Agent class | Canonical normative gate / portability control agent |
| Decision objects | \`transfer\_packet\`; \`source\_freshness\_claim\`; \`SSM\`; \`TVC\`; \`Evidence.bin\`; \`IRR anchor request\`; \`restoration request\`; \`quarantine case\`; \`readmission request\` |
| State model | Finite closed-state machine \`S0\`-\`S8\` |

# 5. Agent Authority Record

Authority derives exclusively from the criteria and rules stated in this specification, together with the local policy snapshot identified by \`policy\_id\` and \`policy\_version\` in each evaluated decision path.

| Field | Normative statement |
| --- | --- |
| Permitted actions | Evaluate freshness, emit semantic gate verdicts, request receipt append, request watermark advancement, declare restoration eligibility, and quarantine or readmit cases under the rules in this specification. |
| Non-authority zones | Tool activation; policy override; direct restore execution; watermark decrement or rewrite; trust-anchor administration. |
| Authority budget | The watermark may move only forward. The agent may emit only one semantic verdict per packet-hash/freshness tuple. Retroactive downgrade is not permitted. |
| Escalation path | Invalid or stale conditions lead to rejection. Inconclusive but recoverable conditions lead to quarantine. New evidence or a new policy basis may trigger readmission review. |
| Block triggers | Invalid \`SSM\`; invalid hash; stale freshness; missing required evidence; missing required transport; missing receipt anchoring on the restore path; missing \`GenesisConfirmed\` precondition. |

# 6. Decision Table

**Canonical semantic verdict vocabulary:** \`ACCEPT\`; \`REJECT\`; \`QUARANTINE\`; \`RESTORATION\_ELIGIBLE\`; \`READMIT\`; \`FAIL\_CLOSED\`.

**Operational action tokens:** \`APPEND\_IRR\`; \`REJECT\_STALE\`; \`REJECT\_INVALID\`; \`OPEN\_QUARANTINE\_CASE\`; \`ISSUE\_RESTORE\_ADMISSION\_TOKEN\`; \`DENY\_RESTORE\`; \`REENTER\_VERIFIED\`; \`BLOCK\_TOOL\_STATE\`.

| ID | Decision object | Condition set | Semantic verdict | Operational action | Notes |
| --- | --- | --- | --- | --- | --- |
| DT-01 | accept\_import | Valid structure AND valid \`SSM\` AND valid \`packet\_hash\` AND policy compatible AND \`freshness\_new > watermark\[source\_id\]\` | ACCEPT | APPEND\_IRR | Gate class = RELEASE. The watermark may advance only after durable receipt append. |
| DT-02 | reject\_stale | \`freshness\_new \<= watermark\[source\_id\]\` | REJECT | REJECT\_STALE | Gate class = BLOCK. No receipt is emitted and the watermark is not updated. |
| DT-03 | reject\_invalid\_binding | Invalid \`SSM\` OR invalid hash OR invalid structure/canonicalization | FAIL\_CLOSED | REJECT\_INVALID | Gate class = BLOCK. No downstream restorative effect. |
| DT-04 | quarantine\_inconclusive | Required evidence or required transport cannot be confirmed, but the case is recoverable through new evidence or a new policy basis | QUARANTINE | OPEN\_QUARANTINE\_CASE | Gate class = ESCALATION. No receipt is emitted. |
| DT-05 | restore\_admit | Valid \`IRR\` AND linked \`accepted\_head\_digest\` AND \`GenesisConfirmed\` | RESTORATION\_ELIGIBLE | ISSUE\_RESTORE\_ADMISSION\_TOKEN | Gate class = RELEASE to the restore service. Execution-neutral. |
| DT-06 | restore\_deny | Missing \`IRR\` OR unlinked \`accepted\_head\_digest\` OR \`GenesisConfirmed = false\` | FAIL\_CLOSED | DENY\_RESTORE | Gate class = BLOCK. |
| DT-07 | readmit\_quarantine | Open quarantine case AND (\`new\_evidence\` OR \`new\_policy\`) AND policy permits re-evaluation | READMIT | REENTER\_VERIFIED | Gate class = ESCALATION / READMISSION. |

# 7. Validator Catalogue

**VAL-001 - Frame / Envelope Validator**

**Function:** Framing, length, checksum, and canonicalization.

**Input:** TransferPacket

**Guard / transition linkage:** \`StructureValid\`; pass \`S1 -> S2\`; fail \`S1 -> S8\`.

**Failure effect:** \`FAIL\_CLOSED -> REJECT\_INVALID\`

**VAL-002 - SSM Signature Validator**

**Function:** Validates the \`SSM\` signature and packet-hash binding.

**Input:** \`SSM\`

**Guard / transition linkage:** \`SSMValid\`; evaluated in \`S2\` before \`FreshnessPass\`.

**Failure effect:** \`FAIL\_CLOSED -> REJECT\_INVALID\`

**VAL-003 - Packet Hash Validator**

**Function:** Validates that the packet hash matches the transferred artifacts.

**Input:** TransferPacket

**Guard / transition linkage:** \`PacketHashValid\`; evaluated in \`S2\` before \`FreshnessPass\`.

**Failure effect:** \`FAIL\_CLOSED -> REJECT\_INVALID\`

**VAL-004 - Policy Compatibility Validator**

**Function:** Validates \`policy\_id\`, \`policy\_version\`, and local profile compatibility.

**Input:** \`SSM\` / policy snapshot

**Guard / transition linkage:** \`PolicyCompatible\`; fail \`S2 -> S8\` or \`S2 -> S7\` when recoverable.

**Failure effect:** \`REJECT -> REJECT\_INVALID\` or \`QUARANTINE -> OPEN\_QUARANTINE\_CASE\`

**VAL-005 - Freshness Comparator**

**Function:** Enforces \`freshness\_new > watermark\[source\_id\]\`.

**Input:** Freshness value + watermark

**Guard / transition linkage:** \`FreshnessPass\`; pass \`S2 -> S3\`; fail \`S2 -> S8\`.

**Failure effect:** \`REJECT -> REJECT\_STALE\`

**VAL-006 - IRR Linkage Validator**

**Function:** Validates receipt anchoring and accepted-head linkage.

**Input:** \`IRR\`

**Guard / transition linkage:** \`IRRValid \&\& linked\_head\`; allows \`S5 -> S6\`; failing restore path goes \`S5 -> S8\`.

**Failure effect:** \`FAIL\_CLOSED -> DENY\_RESTORE\`

**VAL-007 - Transport Policy Validator**

**Function:** Validates authenticated/encrypted transport when required by policy.

**Input:** Transport metadata

**Guard / transition linkage:** \`TransportPolicySatisfied\`; fail \`S2 -> S8\` or \`S2 -> S7\` when recoverable.

**Failure effect:** \`REJECT -> REJECT\_INVALID\` or \`QUARANTINE -> OPEN\_QUARANTINE\_CASE\`

**VAL-008 - TVC Validator**

**Function:** Validates \`TVC\` when present and/or required.

**Input:** \`TVC\`

**Guard / transition linkage:** \`TVCValidWhenRequired\`; fail \`S2 -> S8\` or \`S2 -> S7\` when recoverable.

**Failure effect:** \`REJECT -> REJECT\_INVALID\` or \`QUARANTINE -> OPEN\_QUARANTINE\_CASE\`

**VAL-009 - Evidence Validator**

**Function:** Validates \`Evidence.bin\`, including signature, hash binding, evidence sequence, and validity window.

**Input:** \`Evidence.bin\`

**Guard / transition linkage:** \`EvidenceValidWhenRequired\`; fail \`S2 -> S8\` or \`S2 -> S7\` when recoverable.

**Failure effect:** \`REJECT -> REJECT\_INVALID\` or \`QUARANTINE -> OPEN\_QUARANTINE\_CASE\`

**VAL-010 - Genesis Precondition Validator**

**Function:** Validates the \`GenesisConfirmed\` precondition before restore eligibility is granted.

**Input:** Restore context

**Guard / transition linkage:** \`GenesisConfirmed\`; allows \`S5 -> S6\`; fail \`S5 -> S8\`.

**Failure effect:** \`FAIL\_CLOSED -> DENY\_RESTORE\`

**VAL-011 - Tool-State Non-Authority Validator**

**Function:** Ensures that freshness acceptance does not authorize tool-state activation.

**Input:** Tool manifest / restore plan

**Guard / transition linkage:** \`ToolStateActivationRequested == false\` within agent authority; violation routes \`S5/S6 -> S7\` or \`S8\`.

**Failure effect:** \`QUARANTINE -> OPEN\_QUARANTINE\_CASE\` or \`FAIL\_CLOSED -> BLOCK\_TOOL\_STATE\`

# 8. Workflow / State-Transition Record

| State | Name | Meaning | Allowed outbound transitions |
| --- | --- | --- | --- |
| S0 | IDLE | No active evaluation; the local watermark is the current reference. | \`TransferPacketReceived -> S1\` |
| S1 | RECEIVED | The packet has been received and framed for validation. | \`StructureValid -> S2\`; \`StructureInvalid -> S8\` |
| S2 | VERIFIED | Preliminary \`SSM\` / hash / policy checks have passed. | \`FreshnessPass -> S3\`; \`FreshnessFail -> S8\`; \`EvidencePending -> S7\` |
| S3 | FRESHNESS\_ELIGIBLE | The strictly increasing freshness condition is satisfied. | \`IRRAppended -> S4\` |
| S4 | IRR\_COMMITTED | The receipt has been durably appended to the local journal. | \`WatermarkPersisted -> S5\` |
| S5 | WATERMARK\_COMMITTED | The accepted watermark has been updated. | \`RestoreRequest + GenesisConfirmed -> S6\` |
| S6 | RESTORATION\_ELIGIBLE | The accepted head is eligible for the restore service. | \`RestoreAdmitted -> S0\`; \`RestoreDenied -> S8\` |
| S7 | QUARANTINED | The case is suspended pending new evidence, a new policy basis, or operator review. | \`ReadmissionApproved -> S2\`; \`ReadmissionRejected -> S8\` |
| S8 | REJECTED | The import or restoration path has been denied with no effect. | \`NewPacket -> S1\` |

# 9. Input Contracts

| ID | Input | Required fields | Normative note |
| --- | --- | --- | --- |
| IC-01 | TransferPacket | \`source\_id\`, \`ledger\_uuid\`, \`freshness\_value\`, \`head\_digest\`, \`packet\_hash\`, \`ledger.csl\`, \`ledger.meta\`, \`SSM\`, \`TVC?\`, \`Evidence.bin?\` | Mandatory for every acceptance evaluation. |
| IC-02 | RestoreRequest | \`source\_id\`, \`accepted\_head\_digest\`, \`restore\_scope\`, \`genesis\_context\_id\` | The agent does not accept a restore request without a reference to an accepted head and linked receipt anchoring. |
| IC-03 | QuarantineReviewRequest | \`quarantine\_case\_id\`, \`new\_evidence?\`, \`new\_policy\_id?\` | Requires either new evidence or a new policy basis. |

# 10. Output Contracts

| ID | Output | Required fields | Normative note |
| --- | --- | --- | --- |
| OC-01 | GateVerdict | \`decision\_id\`, \`verdict\`, \`source\_id\`, \`ledger\_uuid\`, \`decision\_object\`, \`policy\_id\`, \`reason\_code\` | Mandatory on every path. |
| OC-02 | IRRAppendRequest | \`decision\_id\`, \`source\_id\`, \`ledger\_uuid\`, \`accepted\_head\_digest\`, \`packet\_hash\`, \`freshness\_value\` | Emitted only for \`APPEND\_IRR\`. |
| OC-03 | WatermarkUpdate | \`source\_id\`, \`old\_watermark\`, \`new\_watermark\`, \`linked\_decision\_id\` | Emitted only after durable receipt append. |
| OC-04 | RestoreAdmissionToken | \`source\_id\`, \`accepted\_head\_digest\`, \`linked\_irr\_digest\`, \`admission\_status\` | Execution-neutral; it does not perform the restore. |
| OC-05 | QuarantineCaseRecord | \`quarantine\_case\_id\`, \`reason\_code\`, \`pending\_requirements\` | Mandatory for quarantined cases. |

# 11. Evidence Contract

Every verdict must emit the minimum evidence required for offline reconstruction.

| Field | Purpose | Applies to / producer |
| --- | --- | --- |
| \`decision\_id\` | Unique identifier of the verdict | All verdicts; produced by the GateVerdict emitter. |
| \`agent\_id\` | Identity of the emitting agent | All verdicts; produced by agent binding. |
| \`source\_id\` | Identity of the evaluated source | All verdicts; produced by input parsing and source-binding logic. |
| \`ledger\_uuid\` | Identity of the source ledger | All verdicts; produced by input parsing and source-binding logic. |
| \`decision\_object\` | Decision object under evaluation | All verdicts; produced by the decision dispatcher. |
| \`policy\_id\` / \`policy\_version\` | Applied local policy snapshot | All verdicts; produced by the Policy Compatibility Validator. |
| \`packet\_hash\` | Hash of the transferred packet | Accept / reject / quarantine; produced by the Packet Hash Validator. |
| \`freshness\_value\` | Evaluated freshness value | Accept / reject\_stale; produced by input parsing and the Freshness Comparator. |
| \`watermark\_before\` / \`watermark\_after\` | Watermark state before and after the verdict | Accept / reject\_stale; produced by the watermark store and WatermarkUpdate path. |
| \`ssm\_validation\_result\` | \`SSM\` validation result | All import verdicts; produced by the SSM Signature Validator. |
| \`tvc\_validation\_result\` | \`TVC\` validation result when relevant | Conditional; produced by the TVC Validator. |
| \`evidence\_validation\_result\` | \`Evidence.bin\` validation result when relevant | Conditional; produced by the Evidence Validator. |
| \`transport\_validation\_result\` | Transport policy validation result when relevant | Conditional; produced by the Transport Policy Validator. |
| \`irr\_digest\` / \`prev\_receipt\_digest\` | Receipt anchoring data | Accept / restoration\_eligible; produced by the receipt journal and IRR Linkage Validator. |
| \`reason\_code\` | Normative reason code | All verdicts; produced by gate-logic mapping and the Decision Table. |
| \`semantic\_verdict\` | Canonical semantic verdict | All verdicts; produced by the Decision Table and Semantic Contract. |
| \`gate\_class\` | Gate class: \`RELEASE\`, \`BLOCK\`, \`ESCALATION\`, or \`READMISSION\` | All verdicts; produced by the Gate Logic Record. |

# 12. Machine-Readable Form Catalogue

| ID | Form | Encoding | Core fields |
| --- | --- | --- | --- |
| MF-01 | TransferEvaluationRequest | JSON object | \`agent\_id\`, \`source\_id\`, \`ledger\_uuid\`, \`packet\_hash\`, \`freshness\_value\`, \`policy\_id\` |
| MF-02 | AcceptanceReceiptRecord | JSON object | \`decision\_id\`, \`source\_id\`, \`ledger\_uuid\`, \`packet\_hash\`, \`accepted\_head\_digest\`, \`freshness\_value\`, \`prev\_receipt\_digest\` |
| MF-03 | RestoreAdmissionRecord | JSON object | \`decision\_id\`, \`source\_id\`, \`accepted\_head\_digest\`, \`linked\_irr\_digest\`, \`genesis\_context\_id\`, \`admission\_status\` |
| MF-04 | QuarantineCaseRecord | JSON object | \`quarantine\_case\_id\`, \`source\_id\`, \`decision\_id\`, \`pending\_requirements\`, \`status\` |
| MF-05 | ReadmissionDecisionRecord | JSON object | \`decision\_id\`, \`quarantine\_case\_id\`, \`new\_evidence\_ref?\`, \`new\_policy\_id?\`, \`verdict\` |

# 13. Gate Logic

**Canonical semantic verdict set:** \`ACCEPT\`; \`REJECT\`; \`QUARANTINE\`; \`RESTORATION\_ELIGIBLE\`; \`READMIT\`; \`FAIL\_CLOSED\`.

**Operational action set:** \`APPEND\_IRR\`; \`REJECT\_STALE\`; \`REJECT\_INVALID\`; \`OPEN\_QUARANTINE\_CASE\`; \`ISSUE\_RESTORE\_ADMISSION\_TOKEN\`; \`DENY\_RESTORE\`; \`REENTER\_VERIFIED\`; \`BLOCK\_TOOL\_STATE\`.

**Gate class \`RELEASE\`:** Supports \`ACCEPT\` and \`RESTORATION\_ELIGIBLE\`. \`APPEND\_IRR\` is permitted only after durable receipt append. \`ISSUE\_RESTORE\_ADMISSION\_TOKEN\` is permitted only with a valid \`IRR\` and \`GenesisConfirmed\`.

**Gate class \`BLOCK\`:** Supports \`REJECT\` and \`FAIL\_CLOSED\`. The operational actions are \`REJECT\_STALE\`, \`REJECT\_INVALID\`, \`DENY\_RESTORE\`, and \`BLOCK\_TOOL\_STATE\`. No downstream restorative mutation is allowed.

**Gate class \`ESCALATION\`:** Supports \`QUARANTINE\`. The operational action is \`OPEN\_QUARANTINE\_CASE\` for operator or policy review.

**Gate class \`READMISSION\`:** Supports \`READMIT\`. The operational action is \`REENTER\_VERIFIED\`, and it is permitted only from \`QUARANTINED\` and only when new evidence or a new policy basis exists.

**Determinacy rule:** For each decision object, exactly one normative path may remain active after evaluating the full condition set.

**Receipt rule:** No acceptance verdict becomes effective without durable \`IRR\` append.

**Watermark rule:** No watermark advances before receipt append, and no accepted watermark may be decremented.

**Restore rule:** No restoration eligibility exists without valid \`IRR\` linkage and \`GenesisConfirmed\`.

# 14. Semantic Contract

**\`ACCEPT\` —** All constitutive conditions pass and the agent may emit \`APPEND\_IRR\`. Gate class = \`RELEASE\`.

**\`REJECT\` —** The constitutive conditions fail irrecoverably for the current packet. The concrete action is \`REJECT\_STALE\` or \`REJECT\_INVALID\`. Gate class = \`BLOCK\`.

**\`QUARANTINE\` —** The case is suspended because required evidence or policy support is missing, but the case may become re-evaluable. The concrete action is \`OPEN\_QUARANTINE\_CASE\`. Gate class = \`ESCALATION\`.

**\`RESTORATION\_ELIGIBLE\` —** The accepted head is semantically admitted to the restore service. The concrete action is \`ISSUE\_RESTORE\_ADMISSION\_TOKEN\`. Gate class = \`RELEASE\`.

**\`READMIT\` —** A quarantined case re-enters evaluation from \`VERIFIED\` on the basis of normative novelty. The concrete action is \`REENTER\_VERIFIED\`. Gate class = \`READMISSION\`.

**\`FAIL\_CLOSED\` —** If the constitutive conditions are not fully satisfied, the effect is blocked. Concrete actions include \`REJECT\_INVALID\`, \`DENY\_RESTORE\`, and \`BLOCK\_TOOL\_STATE\`. Gate class = \`BLOCK\`.

# 15. Temporal and Ordering Contract

**Ordering root:** Freshness monotonicity per \`source\_id\` plus canonical acceptance ordering.

**Canonical sequence:** \`validate -> append IRR -> persist watermark -> update indexes\`

**Visibility rule:** The restore service consumes only the head anchored by the most recent valid \`IRR\`.

**Timestamp semantics:** Timestamps are informative only and are not constitutive for ordering.

**Crash recovery:** Recovery is idempotent across \`C-0\`, \`C-1\`, \`C-2\`, and \`C-3\`.

# 16. Failure Semantics

| Failure condition | Semantic effect |
| --- | --- |
| Structure / checksum / canonical parse failure | \`FAIL\_CLOSED / BLOCK -> REJECT\_INVALID\` |
| \`SSM\` or packet-hash failure | \`FAIL\_CLOSED / BLOCK -> REJECT\_INVALID\` |
| \`freshness\_new \<= watermark\` | \`REJECT / BLOCK -> REJECT\_STALE\` |
| Required evidence invalid or missing | \`FAIL\_CLOSED / BLOCK -> REJECT\_INVALID\` or \`QUARANTINE / ESCALATION -> OPEN\_QUARANTINE\_CASE\`, depending on recoverability. |
| Required transport invalid | \`FAIL\_CLOSED / BLOCK -> REJECT\_INVALID\` or \`QUARANTINE / ESCALATION -> OPEN\_QUARANTINE\_CASE\`, depending on policy. |
| Missing \`IRR\` on restore path | \`FAIL\_CLOSED / BLOCK -> DENY\_RESTORE\` |
| Missing \`GenesisConfirmed\` precondition | \`FAIL\_CLOSED / BLOCK -> DENY\_RESTORE\` |
| Tool-state activation request | \`FAIL\_CLOSED / BLOCK -> BLOCK\_TOOL\_STATE\` or \`QUARANTINE / ESCALATION -> OPEN\_QUARANTINE\_CASE\` outside authority. |
| Rollback attempt against the watermark | \`FAIL\_CLOSED / BLOCK -> REJECT\_INVALID\` plus security finding. |

# 17. Implementation Assumptions and Execution Obligations

| Assumption | Required closure | Execution obligation |
| --- | --- | --- |
| \`source\_id\` remains stable and verifiable | Input contract plus signature and evidence binding | Define canonical source identity binding. |
| The watermark store can persist monotonically | Authority and failure semantics | Choose storage with anti-rollback properties. |
| Local policy is authoritative | Semantic contract plus policy fields | Bind a concrete policy dataset and version. |
| Trust anchors exist for \`SSM\`, \`TVC\`, and \`Evidence.bin\` | Validator Catalogue | Provision PKI / trust-store material. |
| The \`GENESIS\` baseline is managed by a separate module | Workflow precondition | Integrate with a baseline initializer. |
| The execution layer provides runtime observability | Evidence Contract | Instrument logs and events for all required evidence fields. |

# 18. Execution Acceptance Criteria

1. All mandatory artifacts exist and are coherent with the semantic core.
2. The policy profile, algorithm identifiers, and trust anchors are concretely instantiated.
3. The watermark store and receipt journal support monotonicity and append-only semantics.
4. Validators \`VAL-001\` through \`VAL-011\` have a clear mapping in the execution layer.
5. An observability path exists for every field in the Evidence Contract.
6. The state machine and gate logic are implemented without implicit transitions.
7. Runtime tests for fail-closed behavior and replay / recovery are planned.
8. This document remains functionally equivalent to the operative semantics defined here.

# 19. Optionality Register

| Element | Default status | Activation rule | Effect |
| --- | --- | --- | --- |
| \`TVC\` | Optional by default | Becomes mandatory only when required by the active policy. | Without \`TVC\`, the agent may operate on the source-sequence or receiver-watermark model. |
| \`Evidence.bin\` | Optional by default | Becomes mandatory only when required by the active policy. | If mandatory and missing or invalid, the verdict is fail-closed. |
| Transport \`mTLS\` | Policy-conditioned | Mandatory only for designated \`source\_id\` values or boundaries. | Failure of required transport produces reject or quarantine. |
| Semantic continuity score | Optional supplemental control | May strengthen a decision but does not substitute for receipt anchoring, freshness control, or restoration rules. | Cannot cure failure of a constitutive condition. |
| Tool-state approval path | Conditioned on restored tool-state being present | Always outside the authority of this agent. | Freshness acceptance never implies tool-state approval. |

# 20. Assurance Scope

The assurance scope supported by this specification covers identity, authority, boundary, state/transition integrity, decision sufficiency, validator sufficiency, evidence sufficiency, fail-closed behavior, replay resistance, and build handoff clarity.

**This scope** supports specification readiness; it does not claim correctness of a particular runtime implementation.

# 21. Validation Summary

| Check | Result |
| --- | --- |
| Traceability soundness (spec-level) | PASS |
| Technical correctness (spec-level) | PASS |
| Adequacy of transfer | PASS |
| Governance readiness | PASS |
| Audit readiness | PASS |
| Replay readiness | PASS |
| Verdict vocabulary closure | PASS |
| Validator-to-transition linkage | PASS |
| Evidence producer closure | PASS |
| Gate-class coverage | PASS |
| Implementation validation | Out of scope for this public specification |

# 22. Reuse and Limitations

The agent may be reused in environments that require boundary control based on semantic monotonicity, receipt anchoring, and fail-closed restoration.

Reuse is permitted only if the functional identity, boundary definition, authority limits, and non-authority zones declared in this specification are preserved.

Freshness acceptance must never be reinterpreted as permission to execute restore directly, override policy, or activate tool-state.

# Appendix A. Normative Rule Summary

| Rule ID | Constraint | Operational category |
| --- | --- | --- |
| PR-01 | Reject any transfer when \`freshness\_value \<= watermark\[source\_id\]\`. | Behavioral / decision |
| PR-02 | Acceptance becomes effective only after durable \`IRR\` append, then watermark persistence, then auxiliary index update. | Behavioral / transition |
| PR-03 | Restore eligibility exists only for the head linked to the most recent valid \`IRR\` for the source. | Evidence / reconstruction |
| PR-04 | No boundary exchange is allowed without explicit input and output contracts. | Structural / contract |
| PR-05 | Any required hash, signature, policy, evidence, or transport failure results in reject or quarantine with no restorative effect. | Operational / gate |
| PR-06 | Every decision explicitly binds \`agent\_id\`, \`source\_id\`, \`ledger\_uuid\`, \`decision\_object\`, and authority scope. | Structural / identity |
| PR-07 | Freshness acceptance cannot activate tool-state; separate external approval is required. | Operational / quarantine |
| PR-08 | When policy requires \`Evidence.bin\`, missing, invalid, or non-monotonic evidence results in fail-closed rejection with no restoration. | Evidence / source proof |
| PR-09 | \`RESTORATION\_ELIGIBLE\` may be emitted only when the \`GENESIS\` baseline precondition is satisfied. | Behavioral / workflow |
| PR-10 | Agent states are finite and closed, and only validated transitions may be selected externally. | Behavioral / state |
| PR-11 | Every verdict emits a minimum evidence package sufficient for offline reconstruction. | Evidence / reconstruction |
| PR-12 | Readmission is allowed only from \`QUARANTINED\` and only on new evidence or a new policy basis. | Operational / readmission |
| PR-13 | Mandatory semantic ordering is determined by freshness monotonicity and \`IRR\` sequence, not by wall-clock timestamp. | Behavioral / ordering |
| PR-14 | The authority budget is finite: the watermark advances only monotonically and may not be decremented or rewritten. | Operational / remediation |
