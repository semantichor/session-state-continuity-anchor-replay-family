D1 — Semantic Index Human Edition

Freshness Portability Agent \| Canonical public-corpus index

This edition presents the indexed vocabulary in a compact human-readable form. Each entry is anchored to the authorized public corpus and grouped by the canonical category set.

| Agent | Freshness Portability Agent |
| --- | --- |
| **Agent version** | 1.0 |
| **Index version** | 2.0 |
| **Authorized public corpus** | Freshness\_Portability\_Agent\_Specification |
| **Total indexed entries** | 121 |

| Category | Entry count |
| --- | --- |
| Identity Terms | 6 |
| State Terms | 9 |
| Transition Terms | 14 |
| Decision Terms | 26 |
| Validation Terms | 11 |
| Evidence Terms | 17 |
| Boundary Terms | 18 |
| Control Terms | 10 |
| Abbreviation Terms | 5 |
| Optionality Terms | 5 |

## Identity Terms

*6 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| ID-002 | FPA-FRESHNESS-PORTABILITY-003 | Agent identity assigned to the Freshness Portability Agent. | normative | Header Table |
| ID-001 | Freshness Portability Agent | Strict freshness-governed control for import acceptance, receipt anchoring, watermark advancement, restoration eligibility, quarantine, and readmission. | normative | §1 Normative Status and Scope |
| ID-005 | agent\_id | Identity of the emitting agent. | normative | §11 Evidence Contract / \`agent\_id\` |
| ID-004 | ledger\_uuid | The ledger identity bound to the source and included in verdict, receipt, and watermark records. | normative | §3 Core Terms and Public Definitions |
| ID-006 | policy\_id / policy\_version | Applied local policy snapshot. | normative | §5 Agent Authority Record |
| ID-003 | source\_id | The stable source identity used to scope freshness comparison, authority, and receipt linkage. | normative | §3 Core Terms and Public Definitions |

## State Terms

*9 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| STA-004 | FRESHNESS\_ELIGIBLE | The strictly increasing freshness condition is satisfied. | normative | §8 Workflow / State-Transition Record / S3 |
| STA-001 | IDLE | No active evaluation; the local watermark is the current reference. | normative | §8 Workflow / State-Transition Record / S0 |
| STA-005 | IRR\_COMMITTED | The receipt has been durably appended to the local journal. | normative | §8 Workflow / State-Transition Record / S4 |
| STA-008 | QUARANTINED | The case is suspended pending new evidence, a new policy basis, or operator review. | normative | §8 Workflow / State-Transition Record / S7 |
| STA-002 | RECEIVED | The packet has been received and framed for validation. | normative | §8 Workflow / State-Transition Record / S1 |
| STA-009 | REJECTED | The import or restoration path has been denied with no effect. | normative | §8 Workflow / State-Transition Record / S8 |
| STA-007 | RESTORATION\_ELIGIBLE | The accepted head is eligible for the restore service. | normative | §8 Workflow / State-Transition Record / S6 |
| STA-003 | VERIFIED | Preliminary \`SSM\` / hash / policy checks have passed. | normative | §8 Workflow / State-Transition Record / S2 |
| STA-006 | WATERMARK\_COMMITTED | The accepted watermark has been updated. | normative | §8 Workflow / State-Transition Record / S5 |

## Transition Terms

*14 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| TRN-006 | EvidencePending | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-005 | FreshnessFail | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-004 | FreshnessPass | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-007 | IRRAppended | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-014 | NewPacket | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-012 | ReadmissionApproved | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-013 | ReadmissionRejected | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-010 | RestoreAdmitted | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-011 | RestoreDenied | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-009 | RestoreRequest + GenesisConfirmed | Combined restore trigger from WATERMARK\_COMMITTED to RESTORATION\_ELIGIBLE. | normative | §8 Workflow / State-Transition Record |
| TRN-003 | StructureInvalid | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-002 | StructureValid | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-001 | TransferPacketReceived | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |
| TRN-008 | WatermarkPersisted | Validated transition token used by the closed state machine. | normative | §8 Workflow / State-Transition Record |

## Decision Terms

*26 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| DEC-101 | ACCEPT | All constitutive conditions pass and the agent may emit APPEND\_IRR. | normative | §14 Semantic Contract |
| DEC-201 | APPEND\_IRR | Operational action that requests durable receipt append for an accepted import. | normative | §13 Gate Logic |
| DEC-302 | BLOCK | Gate class that supports REJECT and FAIL\_CLOSED. | normative | §13 Gate Logic |
| DEC-208 | BLOCK\_TOOL\_STATE | Operational action that blocks tool-state activation outside agent authority. | normative | §13 Gate Logic |
| DEC-206 | DENY\_RESTORE | Operational action that blocks restore admission on the restore path. | normative | §13 Gate Logic |
| DEC-303 | ESCALATION | Gate class that supports QUARANTINE. | normative | §13 Gate Logic |
| DEC-106 | FAIL\_CLOSED | If the constitutive conditions are not fully satisfied, the effect is blocked. | normative | §14 Semantic Contract |
| DEC-205 | ISSUE\_RESTORE\_ADMISSION\_TOKEN | Operational action that emits the restore admission token for a restore-eligible accepted head. | normative | §13 Gate Logic |
| DEC-204 | OPEN\_QUARANTINE\_CASE | Operational action that opens a suspended case for operator or policy review. | normative | §13 Gate Logic |
| DEC-103 | QUARANTINE | The case is suspended because required evidence or policy support is missing, but the case may become re-evaluable. | normative | §14 Semantic Contract |
| DEC-001 | Quarantine case | A suspended case that may be re-evaluated only when new evidence or a new policy basis exists. | normative | §3 Core Terms and Public Definitions |
| DEC-304 | READMISSION | Gate class that supports READMIT. | normative | §13 Gate Logic |
| DEC-105 | READMIT | A quarantined case re-enters evaluation from VERIFIED on the basis of normative novelty. | normative | §14 Semantic Contract |
| DEC-207 | REENTER\_VERIFIED | Operational action that returns a quarantined case to VERIFIED for re-evaluation. | normative | §13 Gate Logic |
| DEC-102 | REJECT | The constitutive conditions fail irrecoverably for the current packet. | normative | §14 Semantic Contract |
| DEC-203 | REJECT\_INVALID | Operational action that rejects an invalid packet or invalid binding with no downstream restorative effect. | normative | §13 Gate Logic |
| DEC-202 | REJECT\_STALE | Operational action that rejects a stale packet without receipt emission or watermark update. | normative | §13 Gate Logic |
| DEC-301 | RELEASE | Gate class that supports ACCEPT and RESTORATION\_ELIGIBLE. | normative | §13 Gate Logic |
| DEC-104 | RESTORATION\_ELIGIBLE | The accepted head is semantically admitted to the restore service. | normative | §14 Semantic Contract |
| DEC-002 | accept\_import | Decision object with condition set: Valid structure AND valid \`SSM\` AND valid \`packet\_hash\` AND policy compatible AND \`freshness\_new > watermark\[source\_id\]\` | normative | §6 Decision Table / DT-01 |
| DEC-005 | quarantine\_inconclusive | Decision object with condition set: Required evidence or required transport cannot be confirmed, but the case is recoverable through new evidence or a new policy basis | normative | §6 Decision Table / DT-04 |
| DEC-008 | readmit\_quarantine | Decision object with condition set: Open quarantine case AND (\`new\_evidence\` OR \`new\_policy\`) AND policy permits re-evaluation | normative | §6 Decision Table / DT-07 |
| DEC-004 | reject\_invalid\_binding | Decision object with condition set: Invalid \`SSM\` OR invalid hash OR invalid structure/canonicalization | normative | §6 Decision Table / DT-03 |
| DEC-003 | reject\_stale | Decision object with condition set: \`freshness\_new \<= watermark\[source\_id\]\` | normative | §6 Decision Table / DT-02 |
| DEC-006 | restore\_admit | Decision object with condition set: Valid \`IRR\` AND linked \`accepted\_head\_digest\` AND \`GenesisConfirmed\` | normative | §6 Decision Table / DT-05 |
| DEC-007 | restore\_deny | Decision object with condition set: Missing \`IRR\` OR unlinked \`accepted\_head\_digest\` OR \`GenesisConfirmed = false\` | normative | §6 Decision Table / DT-06 |

## Validation Terms

*11 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| VAL-001 | VAL-001 - Frame / Envelope Validator | Framing, length, checksum, and canonicalization. | normative | §7 Validator Catalogue / VAL-001 |
| VAL-002 | VAL-002 - SSM Signature Validator | Validates the \`SSM\` signature and packet-hash binding. | normative | §7 Validator Catalogue / VAL-002 |
| VAL-003 | VAL-003 - Packet Hash Validator | Validates that the packet hash matches the transferred artifacts. | normative | §7 Validator Catalogue / VAL-003 |
| VAL-004 | VAL-004 - Policy Compatibility Validator | Validates \`policy\_id\`, \`policy\_version\`, and local profile compatibility. | normative | §7 Validator Catalogue / VAL-004 |
| VAL-005 | VAL-005 - Freshness Comparator | Enforces \`freshness\_new > watermark\[source\_id\]\`. | normative | §7 Validator Catalogue / VAL-005 |
| VAL-006 | VAL-006 - IRR Linkage Validator | Validates receipt anchoring and accepted-head linkage. | normative | §7 Validator Catalogue / VAL-006 |
| VAL-007 | VAL-007 - Transport Policy Validator | Validates authenticated/encrypted transport when required by policy. | normative | §7 Validator Catalogue / VAL-007 |
| VAL-008 | VAL-008 - TVC Validator | Validates \`TVC\` when present and/or required. | normative | §7 Validator Catalogue / VAL-008 |
| VAL-009 | VAL-009 - Evidence Validator | Validates \`Evidence.bin\`, including signature, hash binding, evidence sequence, and validity window. | normative | §7 Validator Catalogue / VAL-009 |
| VAL-010 | VAL-010 - Genesis Precondition Validator | Validates the \`GenesisConfirmed\` precondition before restore eligibility is granted. | normative | §7 Validator Catalogue / VAL-010 |
| VAL-011 | VAL-011 - Tool-State Non-Authority Validator | Ensures that freshness acceptance does not authorize tool-state activation. | normative | §7 Validator Catalogue / VAL-011 |

## Evidence Terms

*17 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| EVD-002 | agent\_id | Identity of the emitting agent | normative | §11 Evidence Contract / \`agent\_id\` |
| EVD-001 | decision\_id | Unique identifier of the verdict | normative | §11 Evidence Contract / \`decision\_id\` |
| EVD-005 | decision\_object | Decision object under evaluation | normative | §11 Evidence Contract / \`decision\_object\` |
| EVD-012 | evidence\_validation\_result | \`Evidence.bin\` validation result when relevant | normative | §11 Evidence Contract / \`evidence\_validation\_result\` |
| EVD-008 | freshness\_value | Evaluated freshness value | normative | §11 Evidence Contract / \`freshness\_value\` |
| EVD-017 | gate\_class | Gate class: \`RELEASE\`, \`BLOCK\`, \`ESCALATION\`, or \`READMISSION\` | normative | §11 Evidence Contract / \`gate\_class\` |
| EVD-014 | irr\_digest / prev\_receipt\_digest | Receipt anchoring data | normative | §11 Evidence Contract / \`irr\_digest\` / \`prev\_receipt\_digest\` |
| EVD-004 | ledger\_uuid | Identity of the source ledger | normative | §11 Evidence Contract / \`ledger\_uuid\` |
| EVD-007 | packet\_hash | Hash of the transferred packet | normative | §11 Evidence Contract / \`packet\_hash\` |
| EVD-006 | policy\_id / policy\_version | Applied local policy snapshot | normative | §11 Evidence Contract / \`policy\_id\` / \`policy\_version\` |
| EVD-015 | reason\_code | Normative reason code | normative | §11 Evidence Contract / \`reason\_code\` |
| EVD-016 | semantic\_verdict | Canonical semantic verdict | normative | §11 Evidence Contract / \`semantic\_verdict\` |
| EVD-003 | source\_id | Identity of the evaluated source | normative | §11 Evidence Contract / \`source\_id\` |
| EVD-010 | ssm\_validation\_result | \`SSM\` validation result | normative | §11 Evidence Contract / \`ssm\_validation\_result\` |
| EVD-013 | transport\_validation\_result | Transport policy validation result when relevant | normative | §11 Evidence Contract / \`transport\_validation\_result\` |
| EVD-011 | tvc\_validation\_result | \`TVC\` validation result when relevant | normative | §11 Evidence Contract / \`tvc\_validation\_result\` |
| EVD-009 | watermark\_before / watermark\_after | Watermark state before and after the verdict | normative | §11 Evidence Contract / \`watermark\_before\` / \`watermark\_after\` |

## Boundary Terms

*18 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| BND-MF02 | AcceptanceReceiptRecord | Machine-readable form encoded as JSON object. | normative | §12 Machine-Readable Form Catalogue / MF-02 |
| BND-OC01 | GateVerdict | Output contract with required fields: \`decision\_id\`, \`verdict\`, \`source\_id\`, \`ledger\_uuid\`, \`decision\_object\`, \`policy\_id\`, \`reason\_code\` | normative | §10 Output Contracts / OC-01 |
| BND-OC02 | IRRAppendRequest | Output contract with required fields: \`decision\_id\`, \`source\_id\`, \`ledger\_uuid\`, \`accepted\_head\_digest\`, \`packet\_hash\`, \`freshness\_value\` | normative | §10 Output Contracts / OC-02 |
| BND-MF04 | QuarantineCaseRecord | Machine-readable form encoded as JSON object. | normative | §12 Machine-Readable Form Catalogue / MF-04 |
| BND-OC05 | QuarantineCaseRecord | Output contract with required fields: \`quarantine\_case\_id\`, \`reason\_code\`, \`pending\_requirements\` | normative | §10 Output Contracts / OC-05 |
| BND-IC03 | QuarantineReviewRequest | Input contract with required fields: \`quarantine\_case\_id\`, \`new\_evidence?\`, \`new\_policy\_id?\` | normative | §9 Input Contracts / IC-03 |
| BND-MF05 | ReadmissionDecisionRecord | Machine-readable form encoded as JSON object. | normative | §12 Machine-Readable Form Catalogue / MF-05 |
| BND-001 | Restore service | The downstream service that consumes restore admission tokens and performs restore execution outside this agent's authority. | normative | §3 Core Terms and Public Definitions |
| BND-MF03 | RestoreAdmissionRecord | Machine-readable form encoded as JSON object. | normative | §12 Machine-Readable Form Catalogue / MF-03 |
| BND-OC04 | RestoreAdmissionToken | Output contract with required fields: \`source\_id\`, \`accepted\_head\_digest\`, \`linked\_irr\_digest\`, \`admission\_status\` | normative | §10 Output Contracts / OC-04 |
| BND-IC02 | RestoreRequest | Input contract with required fields: \`source\_id\`, \`accepted\_head\_digest\`, \`restore\_scope\`, \`genesis\_context\_id\` | normative | §9 Input Contracts / IC-02 |
| BND-MF01 | TransferEvaluationRequest | Machine-readable form encoded as JSON object. | normative | §12 Machine-Readable Form Catalogue / MF-01 |
| BND-IC01 | TransferPacket | Input contract with required fields: \`source\_id\`, \`ledger\_uuid\`, \`freshness\_value\`, \`head\_digest\`, \`packet\_hash\`, \`ledger.csl\`, \`ledger.meta\`, \`SSM\`, \`TVC?\`, \`Evidence.bin?\` | normative | §9 Input Contracts / IC-01 |
| BND-OC03 | WatermarkUpdate | Output contract with required fields: \`source\_id\`, \`old\_watermark\`, \`new\_watermark\`, \`linked\_decision\_id\` | normative | §10 Output Contracts / OC-03 |
| BND-002 | import channel | Boundary component on the import side of the agent. | normative | §2 Agent Overview |
| BND-004 | operator boundary | Boundary component separating operator review from automated gate behavior. | normative | §2 Agent Overview |
| BND-005 | policy layer | Boundary component representing the applied local policy context. | normative | §2 Agent Overview |
| BND-003 | receipt journal | Boundary component that holds the append-only acceptance receipt path. | normative | §2 Agent Overview |

## Control Terms

*10 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| CTL-001 | Acceptance watermark | The locally committed freshness reference for a source. | normative | §3 Core Terms and Public Definitions |
| CTL-002 | GenesisConfirmed | A restore precondition indicating that the required baseline state has already been established or verified. | normative | §3 Core Terms and Public Definitions |
| CTL-010 | authority budget | Finite authority budget under which the watermark may move only forward and only one semantic verdict may be emitted per packet-hash/freshness tuple. | normative | §5 Agent Authority Record |
| CTL-004 | canonical sequence | Mandatory semantic ordering declared as validate -> append IRR -> persist watermark -> update indexes. | normative | §15 Temporal and Ordering Contract |
| CTL-005 | determinacy rule | For each decision object, exactly one normative path may remain active after evaluating the full condition set. | normative | §13 Gate Logic |
| CTL-009 | fail-closed behavior | Blocked effect for invalid, incomplete, or unauthorized conditions. | normative | §1 Normative Status and Scope |
| CTL-003 | freshness monotonicity | Strictly increasing freshness ordering per source\_id. | normative | §15 Temporal and Ordering Contract |
| CTL-006 | receipt rule | No acceptance verdict becomes effective without durable IRR append. | normative | §13 Gate Logic |
| CTL-008 | restore rule | No restoration eligibility exists without valid IRR linkage and GenesisConfirmed. | normative | §13 Gate Logic |
| CTL-007 | watermark rule | No watermark advances before receipt append, and no accepted watermark may be decremented. | normative | §13 Gate Logic |

## Abbreviation Terms

*5 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| ABR-005 | Crash/restart classes C-0/C-1/C-2/C-3 | Implementation recovery checkpoints used to prove idempotence across interrupted acceptance sequences. | normative | §3 Core Terms and Public Definitions |
| ABR-004 | Evidence.bin | An optional external evidence artifact that becomes mandatory only when required by local policy. | normative | §3 Core Terms and Public Definitions |
| ABR-001 | Import Receipt Record (IRR) | The append-only acceptance receipt used to anchor accepted imports and to gate downstream restoration eligibility. | normative | §3 Core Terms and Public Definitions |
| ABR-002 | SSM | A signed metadata artifact used for source binding and packet-hash binding during acceptance evaluation. | normative | §3 Core Terms and Public Definitions |
| ABR-003 | TVC | An optional validation artifact that becomes mandatory only when required by local policy. | normative | §3 Core Terms and Public Definitions |

## Optionality Terms

*5 indexed entries*

| ID | Preferred label | Definition | Status | Primary source |
| --- | --- | --- | --- | --- |
| OPT-002 | Evidence.bin | Optional by default. | implementation\_optional | §19 Optionality Register / Evidence.bin |
| OPT-004 | Semantic continuity score | Optional supplemental control. | implementation\_optional | §19 Optionality Register / Semantic continuity score |
| OPT-001 | TVC | Optional by default. | implementation\_optional | §19 Optionality Register / TVC |
| OPT-005 | Tool-state approval path | Conditioned on restored tool-state being present. | implementation\_optional | §19 Optionality Register / Tool-state approval path |
| OPT-003 | Transport mTLS | Policy-conditioned. | implementation\_optional | §19 Optionality Register / Transport mTLS |
