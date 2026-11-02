Truth Arbitration Agent

D4 - Ambiguity Register

| agent\_name | Truth Arbitration Agent |
| --- | --- |
| agent\_version | Final public-release specification |
| index\_version | 2.0 |
| source\_documents | Truth Arbitration Agent Public Library Specification |
| derivation\_scope | Semantic Index of terms textually attested in the public-release specification. |
| authorized\_public\_corpus | Truth Arbitration Agent Public Library Specification |
| excluded\_sources\_statement | No non-public source is used. |
| source\_ref\_policy | source\_refs point only to sections of the public-release specification. |

The register addresses only ambiguities internal to the public-release specification and uses only attested public vocabulary.

| ambiguity\_id | preferred\_label | risky\_or\_rejected\_form | clarification | resolution | source\_refs | affected\_terms |
| --- | --- | --- | --- | --- | --- | --- |
| AMB-001 | record identity | universal semantic identity | statement\_id is record identity and does not claim universal semantic identity across different surface phrasings. | Use record identity for serialization and reconstruction; qualify any broader conflict coverage by declared formalism. | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §13 | statement\_id; canonical\_text; semantic\_normalization\_profile |
| AMB-002 | input\_statement\_role | boundary\_validated\_role | input\_statement\_role is an untrusted boundary assertion; boundary\_validated\_role is computed locally. | Never consume input\_statement\_role without local role-consistency validation. | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §8 | statement\_role; V-005 Boundary Role Consistency |
| AMB-003 | ALLOW\_CONSTRAINED | ALLOW | ALLOW\_CONSTRAINED is mandatory when residual risk remains but policy permits conditional progress. | Emit explicit restrictions and residual\_risk\_statement. | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 | V-006B Semantic Conflict Heuristic; residual\_risk\_statement |
| AMB-004 | DENY | FAIL\_CLOSED | DENY makes a claim inadmissible; FAIL\_CLOSED blocks local progress and may require clearance artifacts. | Use Gate Logic and failure semantics to select the correct outcome. | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 | verdict; ESCALATION\_REQUEST; inhibit\_flags |
| AMB-005 | OUT\_OF\_SCOPE | DENY | OUT\_OF\_SCOPE applies only after successful boundary role validation when the payload is not mechanism-level. | Do not use OUT\_OF\_SCOPE before local boundary validation. | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §6 | boundary\_validated\_role; mechanism\_level |
| AMB-006 | RECLASSIFY | verdict | RECLASSIFY is a role-validation action, not a final admissibility verdict. | Route reclassified payloads into the mechanism-level path and continue evaluation. | Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §12 | ROLE\_BYPASS\_SUSPECTED; V-005 Boundary Role Consistency |
| AMB-007 | V-006A Formal Conflict Check | V-006B Semantic Conflict Heuristic | V-006A is formal\_decidable within the declared formalism; V-006B is heuristic and cannot support simple ALLOW below threshold when used alone. | Emit conflict mode, strength, confidence, coverage, and residual risk as required. | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §9 | conflict\_check\_mode; conflict\_check\_strength; residual\_risk\_statement |
| AMB-008 | policy\_snapshot\_id | policy\_hash\_ref | policy\_snapshot\_id names the frozen snapshot; policy\_hash\_ref binds the hash reference used for consistency checking. | Emit both fields where required and re-evaluate on drift. | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §11 | V-007 Policy Snapshot Consistency; POLICY\_SNAPSHOT\_DRIFT |
| AMB-009 | ESCALATION\_REQUEST | FAIL\_CLOSED log entry | A FAIL\_CLOSED log entry alone is not a sufficient interoperable output when an external actor is required. | Emit ESCALATION\_REQUEST or required clearance notification in the same adjudication path. | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 | CLEARANCE\_ARTIFACT\_MISSING; V-009 Escalation Artifact Emission |
| AMB-010 | CLEARANCE\_RESPONSE | ESCALATION\_REQUEST | ESCALATION\_REQUEST asks for remediation; CLEARANCE\_RESPONSE records the response and clearance verdict. | Require valid clearance response before re-entry. | Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12.1 | readmission; clearance\_verdict; READMISSION\_PENDING |
| AMB-011 | snapshot-at-intake | compare-and-commit | Both are permitted concurrency controls, but they are not the same operation. | Use explicit serialization or a valid snapshot-at-intake plus compare-and-commit discipline. | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §11 | V-008 Ordering / Serialization; ORDERING\_VIOLATION |
| AMB-012 | hardware-backed attestation | semantic gate logic | Hardware-backed attestation may strengthen assurance but does not replace semantic gate logic, validator semantics, or admissibility rules. | Treat it as optional and non-substituting. | Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §14 | Optional Capabilities; Non-Substitution Rule |
| AMB-013 | quarantine/readmission workflow | readmission\_budget replacement | A separate workflow may support recovery but cannot relax audited escalation, validated clearance, or readmission\_budget. | Keep readmission\_budget and clearance requirements active. | Truth Arbitration Agent Public Library Specification §14 | readmission; readmission\_budget; ESCALATION\_REQUEST |
| AMB-014 | Stable semantic core | Parameterized elements | Stable semantic core elements shall not be reinterpreted; parameterized elements may be specialized only while preserving semantics. | Apply non-reuse zones when the semantic core would be changed. | Truth Arbitration Agent Public Library Specification §16.1; Truth Arbitration Agent Public Library Specification §16.2; Truth Arbitration Agent Public Library Specification §16.3 | Non-reuse zones; Patch discipline |
| AMB-015 | source\_ref | evidence\_ref\_list | source\_ref points to source support; evidence\_ref\_list binds decision output to emitted evidence artifacts. | Keep source and evidence references distinct in records. | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 | Evidence Contract; Output Contract Record |

# D4 closure checks

| ambiguities\_internal\_only | True |
| --- | --- |
| source\_refs\_public\_only | True |
| D1\_D2\_alignment | True |
| non\_accepted\_forms\_do\_not\_expand\_vocabulary | True |
