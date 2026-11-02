D3 — Semantic Coverage Matrix

Freshness Portability Agent \| Coverage by category and public section

The matrix links each indexed term to its primary public section and records attestation and traceability status.

| Authorized public corpus | Freshness\_Portability\_Agent\_Specification |
| --- | --- |
| **Indexed entries** | 121 |
| **Covered categories** | 10 |

| Category | Entries | Primary sections represented |
| --- | --- | --- |
| Identity Terms | 6 | Header Table; §1 Normative Status and Scope; §11 Evidence Contract; §3 Core Terms and Public Definitions; §5 Agent Authority Record |
| State Terms | 9 | §8 Workflow |
| Transition Terms | 14 | §8 Workflow |
| Decision Terms | 26 | §13 Gate Logic; §14 Semantic Contract; §3 Core Terms and Public Definitions; §6 Decision Table |
| Validation Terms | 11 | §7 Validator Catalogue |
| Evidence Terms | 17 | §11 Evidence Contract |
| Boundary Terms | 18 | §10 Output Contracts; §12 Machine-Readable Form Catalogue; §2 Agent Overview; §3 Core Terms and Public Definitions; §9 Input Contracts |
| Control Terms | 10 | §1 Normative Status and Scope; §13 Gate Logic; §15 Temporal and Ordering Contract; §3 Core Terms and Public Definitions; §5 Agent Authority Record |
| Abbreviation Terms | 5 | §3 Core Terms and Public Definitions |
| Optionality Terms | 5 | §19 Optionality Register |

| ID | Preferred label | Category | Primary source | Attested | Traceable |
| --- | --- | --- | --- | --- | --- |
| ID-002 | FPA-FRESHNESS-PORTABILITY-003 | Identity Terms | Header Table | true | true |
| ID-001 | Freshness Portability Agent | Identity Terms | §1 Normative Status and Scope | true | true |
| ID-005 | agent\_id | Identity Terms | §11 Evidence Contract / \`agent\_id\` | true | true |
| ID-004 | ledger\_uuid | Identity Terms | §3 Core Terms and Public Definitions | true | true |
| ID-006 | policy\_id / policy\_version | Identity Terms | §5 Agent Authority Record | true | true |
| ID-003 | source\_id | Identity Terms | §3 Core Terms and Public Definitions | true | true |
| STA-004 | FRESHNESS\_ELIGIBLE | State Terms | §8 Workflow / State-Transition Record / S3 | true | true |
| STA-001 | IDLE | State Terms | §8 Workflow / State-Transition Record / S0 | true | true |
| STA-005 | IRR\_COMMITTED | State Terms | §8 Workflow / State-Transition Record / S4 | true | true |
| STA-008 | QUARANTINED | State Terms | §8 Workflow / State-Transition Record / S7 | true | true |
| STA-002 | RECEIVED | State Terms | §8 Workflow / State-Transition Record / S1 | true | true |
| STA-009 | REJECTED | State Terms | §8 Workflow / State-Transition Record / S8 | true | true |
| STA-007 | RESTORATION\_ELIGIBLE | State Terms | §8 Workflow / State-Transition Record / S6 | true | true |
| STA-003 | VERIFIED | State Terms | §8 Workflow / State-Transition Record / S2 | true | true |
| STA-006 | WATERMARK\_COMMITTED | State Terms | §8 Workflow / State-Transition Record / S5 | true | true |
| TRN-006 | EvidencePending | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-005 | FreshnessFail | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-004 | FreshnessPass | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-007 | IRRAppended | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-014 | NewPacket | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-012 | ReadmissionApproved | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-013 | ReadmissionRejected | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-010 | RestoreAdmitted | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-011 | RestoreDenied | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-009 | RestoreRequest + GenesisConfirmed | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-003 | StructureInvalid | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-002 | StructureValid | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-001 | TransferPacketReceived | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| TRN-008 | WatermarkPersisted | Transition Terms | §8 Workflow / State-Transition Record | true | true |
| DEC-101 | ACCEPT | Decision Terms | §14 Semantic Contract | true | true |
| DEC-201 | APPEND\_IRR | Decision Terms | §13 Gate Logic | true | true |
| DEC-302 | BLOCK | Decision Terms | §13 Gate Logic | true | true |
| DEC-208 | BLOCK\_TOOL\_STATE | Decision Terms | §13 Gate Logic | true | true |
| DEC-206 | DENY\_RESTORE | Decision Terms | §13 Gate Logic | true | true |
| DEC-303 | ESCALATION | Decision Terms | §13 Gate Logic | true | true |
| DEC-106 | FAIL\_CLOSED | Decision Terms | §14 Semantic Contract | true | true |
| DEC-205 | ISSUE\_RESTORE\_ADMISSION\_TOKEN | Decision Terms | §13 Gate Logic | true | true |
| DEC-204 | OPEN\_QUARANTINE\_CASE | Decision Terms | §13 Gate Logic | true | true |
| DEC-103 | QUARANTINE | Decision Terms | §14 Semantic Contract | true | true |
| DEC-001 | Quarantine case | Decision Terms | §3 Core Terms and Public Definitions | true | true |
| DEC-304 | READMISSION | Decision Terms | §13 Gate Logic | true | true |
| DEC-105 | READMIT | Decision Terms | §14 Semantic Contract | true | true |
| DEC-207 | REENTER\_VERIFIED | Decision Terms | §13 Gate Logic | true | true |
| DEC-102 | REJECT | Decision Terms | §14 Semantic Contract | true | true |
| DEC-203 | REJECT\_INVALID | Decision Terms | §13 Gate Logic | true | true |
| DEC-202 | REJECT\_STALE | Decision Terms | §13 Gate Logic | true | true |
| DEC-301 | RELEASE | Decision Terms | §13 Gate Logic | true | true |
| DEC-104 | RESTORATION\_ELIGIBLE | Decision Terms | §14 Semantic Contract | true | true |
| DEC-002 | accept\_import | Decision Terms | §6 Decision Table / DT-01 | true | true |
| DEC-005 | quarantine\_inconclusive | Decision Terms | §6 Decision Table / DT-04 | true | true |
| DEC-008 | readmit\_quarantine | Decision Terms | §6 Decision Table / DT-07 | true | true |
| DEC-004 | reject\_invalid\_binding | Decision Terms | §6 Decision Table / DT-03 | true | true |
| DEC-003 | reject\_stale | Decision Terms | §6 Decision Table / DT-02 | true | true |
| DEC-006 | restore\_admit | Decision Terms | §6 Decision Table / DT-05 | true | true |
| DEC-007 | restore\_deny | Decision Terms | §6 Decision Table / DT-06 | true | true |
| VAL-001 | VAL-001 - Frame / Envelope Validator | Validation Terms | §7 Validator Catalogue / VAL-001 | true | true |
| VAL-002 | VAL-002 - SSM Signature Validator | Validation Terms | §7 Validator Catalogue / VAL-002 | true | true |
| VAL-003 | VAL-003 - Packet Hash Validator | Validation Terms | §7 Validator Catalogue / VAL-003 | true | true |
| VAL-004 | VAL-004 - Policy Compatibility Validator | Validation Terms | §7 Validator Catalogue / VAL-004 | true | true |
| VAL-005 | VAL-005 - Freshness Comparator | Validation Terms | §7 Validator Catalogue / VAL-005 | true | true |
| VAL-006 | VAL-006 - IRR Linkage Validator | Validation Terms | §7 Validator Catalogue / VAL-006 | true | true |
| VAL-007 | VAL-007 - Transport Policy Validator | Validation Terms | §7 Validator Catalogue / VAL-007 | true | true |
| VAL-008 | VAL-008 - TVC Validator | Validation Terms | §7 Validator Catalogue / VAL-008 | true | true |
| VAL-009 | VAL-009 - Evidence Validator | Validation Terms | §7 Validator Catalogue / VAL-009 | true | true |
| VAL-010 | VAL-010 - Genesis Precondition Validator | Validation Terms | §7 Validator Catalogue / VAL-010 | true | true |
| VAL-011 | VAL-011 - Tool-State Non-Authority Validator | Validation Terms | §7 Validator Catalogue / VAL-011 | true | true |
| EVD-002 | agent\_id | Evidence Terms | §11 Evidence Contract / \`agent\_id\` | true | true |
| EVD-001 | decision\_id | Evidence Terms | §11 Evidence Contract / \`decision\_id\` | true | true |
| EVD-005 | decision\_object | Evidence Terms | §11 Evidence Contract / \`decision\_object\` | true | true |
| EVD-012 | evidence\_validation\_result | Evidence Terms | §11 Evidence Contract / \`evidence\_validation\_result\` | true | true |
| EVD-008 | freshness\_value | Evidence Terms | §11 Evidence Contract / \`freshness\_value\` | true | true |
| EVD-017 | gate\_class | Evidence Terms | §11 Evidence Contract / \`gate\_class\` | true | true |
| EVD-014 | irr\_digest / prev\_receipt\_digest | Evidence Terms | §11 Evidence Contract / \`irr\_digest\` / \`prev\_receipt\_digest\` | true | true |
| EVD-004 | ledger\_uuid | Evidence Terms | §11 Evidence Contract / \`ledger\_uuid\` | true | true |
| EVD-007 | packet\_hash | Evidence Terms | §11 Evidence Contract / \`packet\_hash\` | true | true |
| EVD-006 | policy\_id / policy\_version | Evidence Terms | §11 Evidence Contract / \`policy\_id\` / \`policy\_version\` | true | true |
| EVD-015 | reason\_code | Evidence Terms | §11 Evidence Contract / \`reason\_code\` | true | true |
| EVD-016 | semantic\_verdict | Evidence Terms | §11 Evidence Contract / \`semantic\_verdict\` | true | true |
| EVD-003 | source\_id | Evidence Terms | §11 Evidence Contract / \`source\_id\` | true | true |
| EVD-010 | ssm\_validation\_result | Evidence Terms | §11 Evidence Contract / \`ssm\_validation\_result\` | true | true |
| EVD-013 | transport\_validation\_result | Evidence Terms | §11 Evidence Contract / \`transport\_validation\_result\` | true | true |
| EVD-011 | tvc\_validation\_result | Evidence Terms | §11 Evidence Contract / \`tvc\_validation\_result\` | true | true |
| EVD-009 | watermark\_before / watermark\_after | Evidence Terms | §11 Evidence Contract / \`watermark\_before\` / \`watermark\_after\` | true | true |
| BND-MF02 | AcceptanceReceiptRecord | Boundary Terms | §12 Machine-Readable Form Catalogue / MF-02 | true | true |
| BND-OC01 | GateVerdict | Boundary Terms | §10 Output Contracts / OC-01 | true | true |
| BND-OC02 | IRRAppendRequest | Boundary Terms | §10 Output Contracts / OC-02 | true | true |
| BND-MF04 | QuarantineCaseRecord | Boundary Terms | §12 Machine-Readable Form Catalogue / MF-04 | true | true |
| BND-OC05 | QuarantineCaseRecord | Boundary Terms | §10 Output Contracts / OC-05 | true | true |
| BND-IC03 | QuarantineReviewRequest | Boundary Terms | §9 Input Contracts / IC-03 | true | true |
| BND-MF05 | ReadmissionDecisionRecord | Boundary Terms | §12 Machine-Readable Form Catalogue / MF-05 | true | true |
| BND-001 | Restore service | Boundary Terms | §3 Core Terms and Public Definitions | true | true |
| BND-MF03 | RestoreAdmissionRecord | Boundary Terms | §12 Machine-Readable Form Catalogue / MF-03 | true | true |
| BND-OC04 | RestoreAdmissionToken | Boundary Terms | §10 Output Contracts / OC-04 | true | true |
| BND-IC02 | RestoreRequest | Boundary Terms | §9 Input Contracts / IC-02 | true | true |
| BND-MF01 | TransferEvaluationRequest | Boundary Terms | §12 Machine-Readable Form Catalogue / MF-01 | true | true |
| BND-IC01 | TransferPacket | Boundary Terms | §9 Input Contracts / IC-01 | true | true |
| BND-OC03 | WatermarkUpdate | Boundary Terms | §10 Output Contracts / OC-03 | true | true |
| BND-002 | import channel | Boundary Terms | §2 Agent Overview | true | true |
| BND-004 | operator boundary | Boundary Terms | §2 Agent Overview | true | true |
| BND-005 | policy layer | Boundary Terms | §2 Agent Overview | true | true |
| BND-003 | receipt journal | Boundary Terms | §2 Agent Overview | true | true |
| CTL-001 | Acceptance watermark | Control Terms | §3 Core Terms and Public Definitions | true | true |
| CTL-002 | GenesisConfirmed | Control Terms | §3 Core Terms and Public Definitions | true | true |
| CTL-010 | authority budget | Control Terms | §5 Agent Authority Record | true | true |
| CTL-004 | canonical sequence | Control Terms | §15 Temporal and Ordering Contract | true | true |
| CTL-005 | determinacy rule | Control Terms | §13 Gate Logic | true | true |
| CTL-009 | fail-closed behavior | Control Terms | §1 Normative Status and Scope | true | true |
| CTL-003 | freshness monotonicity | Control Terms | §15 Temporal and Ordering Contract | true | true |
| CTL-006 | receipt rule | Control Terms | §13 Gate Logic | true | true |
| CTL-008 | restore rule | Control Terms | §13 Gate Logic | true | true |
| CTL-007 | watermark rule | Control Terms | §13 Gate Logic | true | true |
| ABR-005 | Crash/restart classes C-0/C-1/C-2/C-3 | Abbreviation Terms | §3 Core Terms and Public Definitions | true | true |
| ABR-004 | Evidence.bin | Abbreviation Terms | §3 Core Terms and Public Definitions | true | true |
| ABR-001 | Import Receipt Record (IRR) | Abbreviation Terms | §3 Core Terms and Public Definitions | true | true |
| ABR-002 | SSM | Abbreviation Terms | §3 Core Terms and Public Definitions | true | true |
| ABR-003 | TVC | Abbreviation Terms | §3 Core Terms and Public Definitions | true | true |
| OPT-002 | Evidence.bin | Optionality Terms | §19 Optionality Register / Evidence.bin | true | true |
| OPT-004 | Semantic continuity score | Optionality Terms | §19 Optionality Register / Semantic continuity score | true | true |
| OPT-001 | TVC | Optionality Terms | §19 Optionality Register / TVC | true | true |
| OPT-005 | Tool-state approval path | Optionality Terms | §19 Optionality Register / Tool-state approval path | true | true |
| OPT-003 | Transport mTLS | Optionality Terms | §19 Optionality Register / Transport mTLS | true | true |
