Truth Arbitration Agent

D1 - Semantic Index Human Edition

| agent\_name | Truth Arbitration Agent |
| --- | --- |
| agent\_version | Final public-release specification |
| index\_version | 2.0 |
| source\_documents | Truth Arbitration Agent Public Library Specification |
| derivation\_scope | Semantic Index of terms textually attested in the public-release specification. |
| authorized\_public\_corpus | Truth Arbitration Agent Public Library Specification |
| excluded\_sources\_statement | No non-public source is used. |
| source\_ref\_policy | source\_refs point only to sections of the public-release specification. |

This human edition is a controlled glossary of terms attested in the public-release specification. Entries use the same semantic content as the structured edition and preserve public source traceability only.

# Entry schema

Each entry contains: term\_id, preferred\_label, category, definition\_short, definition\_operational, normative\_status, source\_refs, related\_terms, synonyms, non\_synonyms, usage\_constraints, allowed\_values, ambiguities, examples, term\_attested\_in\_spec, and public\_traceable.

# Identity Terms

## TAA-IDENTITY-001 - Truth Arbitration Agent

| category | Identity Terms |
| --- | --- |
| definition\_short | Closed normative agent for source provenance, labeling, conflict status, and admissibility of mechanism-level claims. |
| definition\_operational | Use this label only for the agent with restricted jurisdiction stated in the specification. It does not validate full material truth, software correctness, or act as an autonomous substantive content source. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §3 |
| related\_terms | Authority Model; mechanism-level claims; admissibility |
| synonyms | \[\] |
| non\_synonyms | autonomous substantive content source; full material truth validator |
| usage\_constraints | The agent identity is restricted to the rule set and active policy snapshot. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | Truth Arbitration Agent |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-002 - Semantic Contract

| category | Identity Terms |
| --- | --- |
| definition\_short | Contract defining canonical identity, verdict vocabulary, and the central invariant for the agent. |
| definition\_operational | Use as the semantic anchor for statement identity, verdict meanings, and Boundary-Qualified No Unlabeled Claims. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2 |
| related\_terms | canonical\_text; statement\_id; verdict; Boundary-Qualified No Unlabeled Claims |
| synonyms | \[\] |
| non\_synonyms | implementation contract |
| usage\_constraints | The Semantic Contract cannot be replaced by implementation convenience. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-003 - Authority Model

| category | Identity Terms |
| --- | --- |
| definition\_short | Rule boundary that defines what the agent may and may not authorize. |
| definition\_operational | Use to distinguish permitted classification, labeling, linkage, conflict detection, and artifact emission from non-authorized external truth validation or policy override. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §3 |
| related\_terms | Gate Logic; ESCALATION\_REQUEST; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | external truth validation |
| usage\_constraints | Authority is exhausted when provenance cannot be verified, policy snapshot consistency cannot be maintained, formal conflict is confirmed, or budgets are exceeded. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-004 - source provenance

| category | Identity Terms |
| --- | --- |
| definition\_short | Source-origin aspect adjudicated by the agent for mechanism-level claims. |
| definition\_operational | Use only as the public specification concept tied to classification and admissibility of sources. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §3 |
| related\_terms | SOURCE\_CLASS; source\_ref; Provenance Admissibility |
| synonyms | provenance classification |
| non\_synonyms | external truth |
| usage\_constraints | Source provenance is adjudicated for admissibility, not for broad content truth. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-005 - labeling

| category | Identity Terms |
| --- | --- |
| definition\_short | Required labeling condition for mechanism-level claims. |
| definition\_operational | Use with tsa\_label and source\_class to determine whether a claim may enter gating, governed state, output contracts, and other commit-relevant records. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §2.3 |
| related\_terms | tsa\_label; source\_class; Boundary-Qualified No Unlabeled Claims |
| synonyms | missing labeling |
| non\_synonyms | optional annotation |
| usage\_constraints | Missing labeling on a mechanism-level claim blocks progress. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-006 - conflict status

| category | Identity Terms |
| --- | --- |
| definition\_short | State of conflict resolution or qualification for a claim or payload. |
| definition\_operational | Use to express whether formal or heuristic conflict checks have passed, failed, or remain qualified by residual risk. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | V-006A Formal Conflict Check; V-006B Semantic Conflict Heuristic; residual\_risk\_statement |
| synonyms | \[\] |
| non\_synonyms | material truth status |
| usage\_constraints | Conflict status is scoped to the declared formalism and emitted qualifiers. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-007 - admissibility

| category | Identity Terms |
| --- | --- |
| definition\_short | Eligibility of a mechanism-level claim for consumption in the current scope. |
| definition\_operational | Use as the outcome dimension governed by verdicts, policy, provenance classification, conflict checks, and mandatory evidence closure. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | verdict; ALLOW; DENY; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | truth |
| usage\_constraints | Admissibility is not a declaration of full material truth. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-008 - mechanism-level claims

| category | Identity Terms |
| --- | --- |
| definition\_short | Claims that can affect governed state, gate logic, references, policies, or verdict-relevant outputs. |
| definition\_operational | Use for payloads that enter the mechanism-level adjudication path after boundary role validation. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §2.3; Truth Arbitration Agent Public Library Specification §4.1 |
| related\_terms | mechanism\_level; boundary\_validated\_role; Boundary-Qualified No Unlabeled Claims |
| synonyms | mechanism-level statements; mechanism content |
| non\_synonyms | explanatory\_only |
| usage\_constraints | A payload suspected to introduce or modify terms, axioms, policies, ordering parameters, governed references, tool-access conditions, inhibit\_flags, handoff constraints, or expressions that can become a verdict basis is treated as mechanism-level unless role validation closes otherwise. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-009 - record identity

| category | Identity Terms |
| --- | --- |
| definition\_short | Identity assigned to a claim record rather than universal semantic identity across phrasings. |
| definition\_operational | Use to scope statement identity to canonical\_text, scope\_id, turn\_id, and policy\_snapshot\_id. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §13 |
| related\_terms | statement\_id; canonical\_text; semantic\_normalization\_profile |
| synonyms | claim identity |
| non\_synonyms | universal semantic identity |
| usage\_constraints | Do not treat record identity as complete semantic equivalence across different surface phrasings. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-010 - canonical\_text

| category | Identity Terms |
| --- | --- |
| definition\_short | Deterministically normalized text anchoring serialization and reconstruction identity. |
| definition\_operational | Use as the input component of statement\_id after documented canonicalization. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | statement\_id; semantic\_normalization\_profile; V-001 Statement Identity |
| synonyms | \[\] |
| non\_synonyms | natural-language paraphrase |
| usage\_constraints | canonical\_text anchors record identity; it does not by itself claim universal semantic identity. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-011 - statement\_id

| category | Identity Terms |
| --- | --- |
| definition\_short | Hash-based record identifier for a claim. |
| definition\_operational | Use as statement\_id = H(canonical\_text ││ scope\_id ││ turn\_id ││ policy\_snapshot\_id). It is emitted after canonicalization and required for evidence, output records, and machine-readable forms. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | canonical\_text; scope\_id; turn\_id; policy\_snapshot\_id; MRF-STATEMENT.json |
| synonyms | \[\] |
| non\_synonyms | semantic equivalence proof |
| usage\_constraints | The formula is scoped to the record components and active policy snapshot. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | statement\_id = H(canonical\_text ││ scope\_id ││ turn\_id ││ policy\_snapshot\_id) |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-012 - scope\_id

| category | Identity Terms |
| --- | --- |
| definition\_short | Identifier for the active scope of adjudication. |
| definition\_operational | Use as a component of statement identity, input/output contracts, evidence records, ordering, and per-scope serialization. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | statement\_id; session\_id; turn\_id; one in-flight flow |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | A scope has at most one in-flight adjudication flow unless a conformant concurrency discipline is used. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-013 - turn\_id

| category | Identity Terms |
| --- | --- |
| definition\_short | Identifier for the turn associated with a statement or payload. |
| definition\_operational | Use in statement identity, input records, output records, and evidence records. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | statement\_id; scope\_id; policy\_snapshot\_id |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | turn\_id participates in replay and offline reconstruction. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-014 - policy\_snapshot\_id

| category | Identity Terms |
| --- | --- |
| definition\_short | Identifier for the policy snapshot frozen at intake. |
| definition\_operational | Use to ensure a verdict is emitted only under the same policy snapshot used during evaluation. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | policy\_hash\_ref; V-007 Policy Snapshot Consistency; policy snapshot freeze |
| synonyms | \[\] |
| non\_synonyms | current policy without freeze |
| usage\_constraints | Policy changes before verdict trigger re-evaluation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-015 - policy\_hash\_ref

| category | Identity Terms |
| --- | --- |
| definition\_short | Hash reference to the active policy snapshot used during evaluation. |
| definition\_operational | Use with policy\_snapshot\_id to detect drift and to make the decision path reconstructible. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | policy\_snapshot\_id; POLICY\_SNAPSHOT\_DRIFT; V-007 Policy Snapshot Consistency |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | A verdict may not be emitted under any policy\_hash\_ref other than the one used during evaluation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-016 - semantic\_normalization\_profile

| category | Identity Terms |
| --- | --- |
| definition\_short | Declared profile for deterministic canonicalization. |
| definition\_operational | Use to document Unicode NFKC normalization, trimming, whitespace collapse, UTF-8 stabilization, and any additional serialization rules. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.1; Truth Arbitration Agent Public Library Specification §13 |
| related\_terms | canonical\_text; statement\_id; V-001 Statement Identity |
| synonyms | \[\] |
| non\_synonyms | implicit canonicalization |
| usage\_constraints | If the profile cannot support a demonstrable semantic identity claim, complete conflict coverage is limited to the declared formalism. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-017 - SOURCE\_CLASS

| category | Identity Terms |
| --- | --- |
| definition\_short | Classified source category used in provenance admissibility. |
| definition\_operational | Use as a controlled input to the policy matrix together with tsa\_label, boundary\_validated\_role, and policy. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §3; Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | source\_class; tsa\_label; Provenance Admissibility |
| synonyms | source\_class |
| non\_synonyms | tsa\_label |
| usage\_constraints | TRAINED and UNTRUSTED are explicitly used as decision conditions; other classes depend on the active policy allowlist. |
| allowed\_values | TRAINED; UNTRUSTED |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-018 - tsa\_label

| category | Identity Terms |
| --- | --- |
| definition\_short | Policy-conformant label required for mechanism-level claims. |
| definition\_operational | Use with source\_class after boundary validation. Missing tsa\_label on a mechanism-level claim leads to FAIL\_CLOSED. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.3; Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | source\_class; Boundary-Qualified No Unlabeled Claims; UNLABELED\_CLAIM |
| synonyms | \[\] |
| non\_synonyms | source\_class |
| usage\_constraints | A tsa\_label supplied before boundary validation is not sufficient unless locally validated under policy. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-019 - source\_ref

| category | Identity Terms |
| --- | --- |
| definition\_short | Reference to the source supporting a claim or record. |
| definition\_operational | Use in input, output, evidence, and provenance admissibility checks when required by policy. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | source\_class; tsa\_label; Evidence Contract |
| synonyms | \[\] |
| non\_synonyms | evidence\_ref\_list |
| usage\_constraints | Missing policy-required source\_ref causes FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-020 - AXIOM\_SET

| category | Identity Terms |
| --- | --- |
| definition\_short | Attested source set used for linkage validation. |
| definition\_operational | Use in AXIOM / TERM Linkage and readmission conditions. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §3; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | V-004 AXIOM / TERM Linkage; TERM\_BIND; POLICY\_BIND |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Readmission does not inherit ALLOW across changes in AXIOM\_SET. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-021 - TERM\_BIND

| category | Identity Terms |
| --- | --- |
| definition\_short | Linkage element checked with AXIOM\_SET and POLICY\_BIND. |
| definition\_operational | Use as a required linkage target for V-004. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | AXIOM\_SET; POLICY\_BIND; V-004 AXIOM / TERM Linkage |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Invalid linkage leads to DENY. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-IDENTITY-022 - POLICY\_BIND

| category | Identity Terms |
| --- | --- |
| definition\_short | Policy linkage element checked with AXIOM\_SET and TERM\_BIND. |
| definition\_operational | Use as a required linkage target for V-004. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | AXIOM\_SET; TERM\_BIND; V-004 AXIOM / TERM Linkage |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Invalid linkage leads to DENY. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Boundary Terms

## TAA-BOUNDARY-001 - Boundary-Qualified No Unlabeled Claims

| category | Boundary Terms |
| --- | --- |
| definition\_short | Central invariant requiring mechanism-level claims to carry policy-conformant tsa\_label and source\_class after boundary validation. |
| definition\_operational | Use as the absolute no-unlabeled-claim property only after boundary role validation. It applies to gating, governed state changes, DECISION, FAIL\_CLOSED, CHECKPOINT, ROLLBACK, REPORT, and output-contract activation. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.3; Truth Arbitration Agent Public Library Specification §14; Truth Arbitration Agent Public Library Specification §16.1 |
| related\_terms | tsa\_label; source\_class; boundary validation; mechanism-level claims |
| synonyms | No Unlabeled Claims |
| non\_synonyms | general unlabeled text rule |
| usage\_constraints | Do not apply as absolute before boundary role validation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-002 - boundary validation

| category | Boundary Terms |
| --- | --- |
| definition\_short | Local validation step that determines whether the payload is mechanism-level before labeling obligations are applied. |
| definition\_operational | Use to prevent implicit trust in supplied statement\_role and to route payloads into mechanism-level adjudication where required. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.3; Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §5.1 |
| related\_terms | boundary\_validated\_role; input\_statement\_role; V-005 Boundary Role Consistency |
| synonyms | boundary role validation |
| non\_synonyms | upstream assertion acceptance |
| usage\_constraints | The agent shall not consume input\_statement\_role without successful local role-consistency validation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-003 - statement\_role

| category | Boundary Terms |
| --- | --- |
| definition\_short | Role assigned or proposed for a statement at the boundary. |
| definition\_operational | Use only after local confirmation; supplied statement\_role is not implicitly trusted. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.3; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §13 |
| related\_terms | input\_statement\_role; boundary\_validated\_role; V-005 Boundary Role Consistency |
| synonyms | \[\] |
| non\_synonyms | boundary\_validated\_role |
| usage\_constraints | Upstream may propose statement\_role, but V-005 confirms boundary\_validated\_role locally. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-004 - input\_statement\_role

| category | Boundary Terms |
| --- | --- |
| definition\_short | Untrusted boundary assertion supplied in the Input Contract Record. |
| definition\_operational | Use as evidence for comparison with the locally computed boundary\_validated\_role. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | statement\_role; boundary\_validated\_role; role\_reclassification\_reason |
| synonyms | \[\] |
| non\_synonyms | boundary\_validated\_role |
| usage\_constraints | An explanatory\_only input\_statement\_role cannot directly pass if mechanism content is detected. |
| allowed\_values | mechanism\_level; explanatory\_only |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-005 - boundary\_validated\_role

| category | Boundary Terms |
| --- | --- |
| definition\_short | Locally computed role of the payload after boundary validation. |
| definition\_operational | Use to decide whether the mechanism-level path, OUT\_OF\_SCOPE result, reclassification, or FAIL\_CLOSED applies. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | input\_statement\_role; mechanism\_level; OUT\_OF\_SCOPE |
| synonyms | \[\] |
| non\_synonyms | input\_statement\_role |
| usage\_constraints | If boundary\_validated\_role is not mechanism\_level, OUT\_OF\_SCOPE is available only after successful role validation. |
| allowed\_values | mechanism\_level |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-006 - mechanism\_level

| category | Boundary Terms |
| --- | --- |
| definition\_short | Boundary role value for payloads that enter the mechanism-level adjudication path. |
| definition\_operational | Use when the payload can affect terms, axioms, policies, ordering, governed references, tool-access conditions, inhibit\_flags, handoff constraints, or verdict basis. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §5.1; Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | mechanism-level claims; boundary\_validated\_role; explanatory\_only |
| synonyms | mechanism-level |
| non\_synonyms | explanatory\_only |
| usage\_constraints | Mechanism-level role triggers labeling, provenance admissibility, conflict, evidence, and gate checks. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-007 - explanatory\_only

| category | Boundary Terms |
| --- | --- |
| definition\_short | Input role assertion for payloads claimed not to be mechanism-level. |
| definition\_operational | Use cautiously: if role validation detects mechanism content and policy forbids automatic reclassification, the result is FAIL\_CLOSED. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.1; Truth Arbitration Agent Public Library Specification §5.1; Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | input\_statement\_role; ROLE\_BYPASS\_SUSPECTED; RECLASSIFY |
| synonyms | \[\] |
| non\_synonyms | mechanism\_level |
| usage\_constraints | An explanatory\_only assertion does not override local boundary validation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-008 - role\_validation\_result

| category | Boundary Terms |
| --- | --- |
| definition\_short | Evidence field recording the result of role validation. |
| definition\_operational | Use in every verdict evidence record and especially for suspected bypass payloads. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | Evidence Contract; boundary\_validated\_role; role\_validator\_refs |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Omission makes a bypass-suspected verdict non-reconstructible. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-009 - role\_reclassification\_reason

| category | Boundary Terms |
| --- | --- |
| definition\_short | Reason emitted when a payload is reclassified at the boundary. |
| definition\_operational | Use when input\_statement\_role differs from boundary\_validated\_role and the policy permits correction rather than immediate block. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | RECLASSIFY; ROLE\_BYPASS\_SUSPECTED; V-005 Boundary Role Consistency |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Required when role reclassification occurs. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-BOUNDARY-010 - role\_validator\_refs

| category | Boundary Terms |
| --- | --- |
| definition\_short | References to role validators used in boundary validation. |
| definition\_operational | Use in role validation evidence to support replay and offline reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | V-005 Boundary Role Consistency; role\_validation\_result; Evidence Contract |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | For bypass-suspected payloads, omission makes the verdict non-reconstructible. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Decision Terms

## TAA-DECISION-001 - verdict

| category | Decision Terms |
| --- | --- |
| definition\_short | Admissibility result emitted by the agent for a claim or payload. |
| definition\_operational | Use one of the declared verdict vocabulary values, with constraints and evidence appropriate to the decision path. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | ALLOW; ALLOW\_CONSTRAINED; DENY; FAIL\_CLOSED; ESCALATE; OUT\_OF\_SCOPE |
| synonyms | \[\] |
| non\_synonyms | RECLASSIFY |
| usage\_constraints | RECLASSIFY is a role-validation action, not a final admissibility verdict. |
| allowed\_values | ALLOW; ALLOW\_CONSTRAINED; DENY; FAIL\_CLOSED; ESCALATE; OUT\_OF\_SCOPE |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-002 - ALLOW

| category | Decision Terms |
| --- | --- |
| definition\_short | Verdict admitting the claim for mechanism-level consumption in the current scope. |
| definition\_operational | Use only when all relevant blocking validators have passed and heuristic controls, where relevant, are above policy threshold. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §5.1; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | verdict; V-006B Semantic Conflict Heuristic; Complete evidence and closed conflict |
| synonyms | \[\] |
| non\_synonyms | ALLOW\_CONSTRAINED; ESCALATE |
| usage\_constraints | Simple ALLOW is forbidden when only V-006B is available and the result is inconclusive or below threshold. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-003 - ALLOW\_CONSTRAINED

| category | Decision Terms |
| --- | --- |
| definition\_short | Verdict allowing use only under explicitly declared restrictions. |
| definition\_operational | Use when lower-strength validation leaves residual risk but policy permits conditional progress. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | residual\_risk\_statement; V-006B Semantic Conflict Heuristic; HEURISTIC\_CONFLICT\_UNCLOSED |
| synonyms | \[\] |
| non\_synonyms | ALLOW |
| usage\_constraints | Restrictions and residual risk must be explicit. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-004 - DENY

| category | Decision Terms |
| --- | --- |
| definition\_short | Verdict making the claim inadmissible for mechanism-level consumption in the current scope. |
| definition\_operational | Use when provenance is inadmissible, formal conflict severity calls for denial, or other declared policy conditions require inadmissibility rather than fail-closed blocking. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | verdict; FAIL\_CLOSED; Provenance Admissibility |
| synonyms | \[\] |
| non\_synonyms | FAIL\_CLOSED |
| usage\_constraints | DENY is not the same as fail-closed progress blocking. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-005 - FAIL\_CLOSED

| category | Decision Terms |
| --- | --- |
| definition\_short | Verdict and state in which local progress is blocked. |
| definition\_operational | Use when blocking validators fail, required fields are missing, policy drift occurs, ordering is invalid, escalation artifacts are missing, or failure semantics require blocking. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | inhibit\_flags; root\_reason\_code; ESCALATION\_REQUEST; NONCOMPLIANT\_HOLD |
| synonyms | \[\] |
| non\_synonyms | DENY |
| usage\_constraints | When an external actor is required, FAIL\_CLOSED is incomplete without the required external remediation artifact. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-006 - ESCALATE

| category | Decision Terms |
| --- | --- |
| definition\_short | Verdict requiring remediation, clearance, or external review by an authorized role. |
| definition\_operational | Use when the agent does not authorize local consumption and external review or remediation is required. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | ESCALATION\_REQUEST; NONCOMPLIANT\_HOLD; PERMANENT\_BLOCK |
| synonyms | \[\] |
| non\_synonyms | ALLOW |
| usage\_constraints | ESCALATE is not local authorization. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-007 - OUT\_OF\_SCOPE

| category | Decision Terms |
| --- | --- |
| definition\_short | Verdict for payloads that are not mechanism-level after boundary role validation. |
| definition\_operational | Use only after boundary role validation confirms the payload does not enter the mechanism-level adjudication path. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | boundary\_validated\_role; mechanism\_level; boundary validation |
| synonyms | \[\] |
| non\_synonyms | DENY |
| usage\_constraints | OUT\_OF\_SCOPE is not the default before successful role validation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-008 - RECLASSIFY

| category | Decision Terms |
| --- | --- |
| definition\_short | Role-validation action routing a payload into the mechanism-level path. |
| definition\_operational | Use when role validation detects mechanism content and policy permits correction. It is not a final admissibility verdict. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | V-005 Boundary Role Consistency; ROLE\_BYPASS\_SUSPECTED; mechanism\_level |
| synonyms | \[\] |
| non\_synonyms | verdict |
| usage\_constraints | RECLASSIFY must be followed by mechanism-level evaluation under policy. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-009 - Decision Table

| category | Decision Terms |
| --- | --- |
| definition\_short | Total table for relevant decision combinations. |
| definition\_operational | Use to ensure no relevant combination of role, labels, provenance, policy snapshot, and conflict status remains unresolved. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §15 |
| related\_terms | Decision object; Gate Logic Record; verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | The table may be compressed through meta-rules but may not leave relevant combinations unresolved. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-010 - Decision object

| category | Decision Terms |
| --- | --- |
| definition\_short | Named decision condition with an outcome. |
| definition\_operational | Use for DO-001 through DO-009 and any equivalent compressed meta-rule preserving totality. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | Decision Table; DO-001 Unlabeled mechanism claim; DO-009 External clearance required |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Decision objects cannot be left unresolved. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-011 - DO-001 Unlabeled mechanism claim

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for a mechanism-level claim missing tsa\_label. |
| definition\_operational | Use to route boundary\_validated\_role = mechanism\_level and missing tsa\_label to FAIL\_CLOSED. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | UNLABELED\_CLAIM; FAIL\_CLOSED; tsa\_label |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Applies after boundary validation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-012 - DO-002 TRAINED in index-zero

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for TRAINED source\_class on the target concept in index-zero. |
| definition\_operational | Use to produce DENY or FAIL\_CLOSED according to policy. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | SOURCE\_CLASS; TRAINED; DENY |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Outcome is policy-dependent between DENY and FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-013 - DO-003 UNTRUSTED without reclassification

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for UNTRUSTED source\_class without reclassification decision. |
| definition\_operational | Use to route to DENY. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | SOURCE\_CLASS; UNTRUSTED; DENY |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Requires absence of a reclassification decision. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-014 - DO-004 Suspected role mismatch

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for explanatory\_only input with detected mechanism content. |
| definition\_operational | Use to route to RECLASSIFY or FAIL\_CLOSED according to policy. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | input\_statement\_role; explanatory\_only; RECLASSIFY; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | This is a role-validation branch, not a final admissibility verdict by itself. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-015 - DO-005 Confirmed formal conflict

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for V-006A failure. |
| definition\_operational | Use to route to FAIL\_CLOSED or DENY according to severity. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | V-006A Formal Conflict Check; FORMAL\_CONFLICT\_CONFIRMED; DENY; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Formal conflict closure depends on configured severity threshold. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-016 - DO-006 Probable heuristic conflict

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for failed or under-threshold V-006B. |
| definition\_operational | Use to route to ALLOW\_CONSTRAINED or ESCALATE when heuristic conflict is open or below threshold. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | V-006B Semantic Conflict Heuristic; HEURISTIC\_CONFLICT\_UNCLOSED; ALLOW\_CONSTRAINED; ESCALATE |
| synonyms | \[\] |
| non\_synonyms | ALLOW |
| usage\_constraints | Simple ALLOW is forbidden in this branch. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-017 - DO-007 Policy snapshot drift

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for policy\_hash\_ref change mid-flight. |
| definition\_operational | Use to FAIL\_CLOSED and re-evaluate. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | POLICY\_SNAPSHOT\_DRIFT; policy\_hash\_ref; V-007 Policy Snapshot Consistency |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Evaluation restarts under a new snapshot. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-018 - DO-008 Complete evidence and closed conflict

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for all blocking validators passing. |
| definition\_operational | Use to produce ALLOW only when evidence is complete and conflict is closed under policy. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6 |
| related\_terms | ALLOW; Evidence Contract; conflict check |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Completeness covers evidence and blocking validations. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-DECISION-019 - DO-009 External clearance required

| category | Decision Terms |
| --- | --- |
| definition\_short | Decision object for failure semantics requiring an external actor. |
| definition\_operational | Use to emit ESCALATE plus ESCALATION\_REQUEST. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §6; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | ESCALATE; ESCALATION\_REQUEST; clearance\_needed |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | The escalation artifact is mandatory in the same adjudication path. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# State Terms

## TAA-STATE-001 - INTAKE

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state that receives payload and boundary metadata. |
| definition\_operational | Use as the entry point for any valid input contract that enters the agent contract. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §5.1 |
| related\_terms | Input Contract Record; ROLE\_SCREENING; policy snapshot freeze |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | INTAKE precedes ROLE\_SCREENING and policy snapshot freeze. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-002 - ROLE\_SCREENING

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state that validates boundary\_validated\_role and detects bypass patterns. |
| definition\_operational | Use after INTAKE to decide whether to continue to CANONICALIZING or FAIL\_CLOSED. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5 |
| related\_terms | boundary validation; CANONICALIZING; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Applies to payloads suspected or declared as mechanism-level. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-003 - CANONICALIZING

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state that generates canonical\_text and statement\_id. |
| definition\_operational | Use only under a valid semantic\_normalization\_profile. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5 |
| related\_terms | canonical\_text; statement\_id; semantic\_normalization\_profile |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Outputs to EVALUATING. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-004 - EVALUATING

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state that runs structural and policy-snapshot validators. |
| definition\_operational | Use to execute V-001 through V-005 before classification. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §5.1 |
| related\_terms | V-001 Statement Identity; V-005 Boundary Role Consistency; CLASSIFYING |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Missing required label, source class, policy snapshot, source\_ref, or snapshot consistency leads to FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-005 - CLASSIFYING

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state applying the SOURCE\_CLASS, tsa\_label, boundary\_validated\_role, and policy matrix. |
| definition\_operational | Use to compute provenance admissibility and route to conflict checking or a blocking verdict. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5 |
| related\_terms | SOURCE\_CLASS; tsa\_label; boundary\_validated\_role; CONFLICT\_CHECKING |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | May output CONFLICT\_CHECKING, DENY, ALLOW\_CONSTRAINED, or FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-006 - CONFLICT\_CHECKING

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state running V-006A and/or V-006B according to the declared formalism. |
| definition\_operational | Use to resolve, qualify, deny, escalate, or fail closed based on conflict evidence. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §5.1 |
| related\_terms | V-006A Formal Conflict Check; V-006B Semantic Conflict Heuristic; conflict\_check\_mode |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | ALLOW requires sufficient conflict\_check\_strength under policy. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-007 - DECIDED

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state emitting verdict and evidence. |
| definition\_operational | Use when a complete decision record exists and the path can move to HANDOFF\_READY or CLOSED. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5 |
| related\_terms | verdict; Evidence Contract; HANDOFF\_READY; CLOSED |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Decision record completeness is required. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-008 - NONCOMPLIANT\_HOLD

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state waiting for audited external clearance. |
| definition\_operational | Use after FAIL\_CLOSED when remediation requires an external actor or new evidence. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §5.1; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | FAIL\_CLOSED; ESCALATION\_REQUEST; CLEARANCE\_RESPONSE |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Transition to this state must emit ESCALATION\_REQUEST. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-009 - READMISSION\_PENDING

| category | State Terms |
| --- | --- |
| definition\_short | Workflow state that restarts full evaluation under a new snapshot. |
| definition\_operational | Use after valid clearance and within readmission\_budget. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | readmission\_budget; policy snapshot freeze; ROLE\_SCREENING |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Readmission does not inherit ALLOW across changes in policy, scope, source\_ref, AXIOM\_SET, or clearance epoch. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-010 - HANDOFF\_READY

| category | State Terms |
| --- | --- |
| definition\_short | State or output position indicating the decision record is ready for execution-layer handoff. |
| definition\_operational | Use after DECIDED when closure is sufficient for downstream acceptance. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | DECIDED; MRF-HANDOFF-CHECK.json; Evidence Contract |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Requires semantic, evidence, failure, and policy snapshot closure. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-STATE-011 - CLOSED

| category | State Terms |
| --- | --- |
| definition\_short | Closed workflow condition after decision or failure handling completes. |
| definition\_operational | Use as the terminal non-handoff workflow output when no further local action is pending. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5 |
| related\_terms | DECIDED; FAIL\_CLOSED; NONCOMPLIANT\_HOLD |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Transition Terms

## TAA-TRANSITION-001 - policy snapshot freeze

| category | Transition Terms |
| --- | --- |
| definition\_short | Mandatory freezing of policy\_snapshot\_id and policy\_hash\_ref at intake. |
| definition\_operational | Use before boundary role validation and all subsequent adjudication steps. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11; Truth Arbitration Agent Public Library Specification §13 |
| related\_terms | policy\_snapshot\_id; policy\_hash\_ref; V-007 Policy Snapshot Consistency |
| synonyms | snapshot freeze |
| non\_synonyms | policy update without restart |
| usage\_constraints | If active policy changes before verdict, V-007 fails and evaluation restarts. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-002 - canonicalize

| category | Transition Terms |
| --- | --- |
| definition\_short | Transition action that produces canonical\_text and statement\_id. |
| definition\_operational | Use after boundary validation and before structural validators. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | canonical\_text; statement\_id; CANONICALIZING |
| synonyms | canonicalization |
| non\_synonyms | \[\] |
| usage\_constraints | Canonicalization must follow the semantic\_normalization\_profile. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-003 - structural validators

| category | Transition Terms |
| --- | --- |
| definition\_short | Validator stage that checks identity, required fields, and policy-related structure. |
| definition\_operational | Use before provenance classification and conflict checks. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | V-001 Statement Identity; V-002 Mandatory Fields Presence; V-007 Policy Snapshot Consistency |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Structural validator failure routes to FAIL\_CLOSED according to Gate Logic. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-004 - provenance classification

| category | Transition Terms |
| --- | --- |
| definition\_short | Classification stage for source-related admissibility. |
| definition\_operational | Use after structural validators and before conflict check. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | SOURCE\_CLASS; Provenance Admissibility; source\_ref |
| synonyms | \[\] |
| non\_synonyms | external truth validation |
| usage\_constraints | Cannot degrade to ALLOW when provenance cannot be verified. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-005 - conflict check

| category | Transition Terms |
| --- | --- |
| definition\_short | Transition stage that evaluates formal and/or heuristic conflict status. |
| definition\_operational | Use after provenance classification and before verdict. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | V-006A Formal Conflict Check; V-006B Semantic Conflict Heuristic; conflict\_check\_mode |
| synonyms | \[\] |
| non\_synonyms | full material truth check |
| usage\_constraints | Result must emit strength, confidence, and coverage when required. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-006 - evidence emission

| category | Transition Terms |
| --- | --- |
| definition\_short | Emission of evidence artifacts after verdict. |
| definition\_operational | Use after verdict to support replay and offline reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | Evidence Contract; DECISION; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Evidence must include required closure fields for the verdict path. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-007 - snapshot-at-intake

| category | Transition Terms |
| --- | --- |
| definition\_short | Concurrency technique using an intake snapshot to preserve ordering semantics. |
| definition\_operational | Use as one conformant way to realize one in-flight flow per scope when implementation is concurrent. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | compare-and-commit; one in-flight flow; Ordering / Serialization |
| synonyms | \[\] |
| non\_synonyms | unsynchronized concurrency |
| usage\_constraints | Must be paired with a valid commit discipline if concurrent. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-008 - compare-and-commit

| category | Transition Terms |
| --- | --- |
| definition\_short | Concurrency technique that compares the claim set at verdict time before committing a verdict. |
| definition\_operational | Use as an ordering control when explicit serialization is not used. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §11; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | snapshot-at-intake; V-008 Ordering / Serialization; ORDERING\_VIOLATION |
| synonyms | \[\] |
| non\_synonyms | best-effort concurrency |
| usage\_constraints | Failure leads to FAIL\_CLOSED under ordering rules. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-009 - readmission

| category | Transition Terms |
| --- | --- |
| definition\_short | Controlled re-entry after failure handling and valid clearance. |
| definition\_operational | Use only after audited clearance, new snapshot freeze, and full re-evaluation under budget. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §11; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | READMISSION\_PENDING; readmission\_budget; CLEARANCE\_RESPONSE |
| synonyms | \[\] |
| non\_synonyms | automatic inherited allow |
| usage\_constraints | Readmission shall not inherit ALLOW across policy, scope, source\_ref, AXIOM\_SET, or clearance epoch changes. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-TRANSITION-010 - re-entry

| category | Transition Terms |
| --- | --- |
| definition\_short | Entry back into evaluation after clearance. |
| definition\_operational | Use only after the clearance artifact closes the root cause and a new snapshot is frozen. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | clearance\_verdict; clearance\_epoch; READMISSION\_PENDING |
| synonyms | \[\] |
| non\_synonyms | readmission without clearance |
| usage\_constraints | If clearance does not close the root cause, terminal ESCALATE or PERMANENT\_BLOCK applies. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Validation Terms

## TAA-VALIDATION-001 - Validator Catalogue

| category | Validation Terms |
| --- | --- |
| definition\_short | Catalogue of validators, their classes, scopes, and effects. |
| definition\_operational | Use to distinguish validator\_id, validator\_class, strength, coverage\_scope, failure\_effect, evidence\_fields, and fallback semantics. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §15 |
| related\_terms | V-001 Statement Identity; V-009 Escalation Artifact Emission; Gate Logic Record |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Validators with different strengths cannot emit indistinguishable artifacts without explicit confidence qualification. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-002 - validator\_id

| category | Validation Terms |
| --- | --- |
| definition\_short | Identifier assigned to a validator. |
| definition\_operational | Use to reference validators in decision evidence and validator\_refs. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | validator\_refs; Validator Catalogue; evidence\_fields |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-003 - validator\_class

| category | Validation Terms |
| --- | --- |
| definition\_short | Declared class of a validator. |
| definition\_operational | Use to distinguish deterministic, heuristic-hardening, formal\_decidable, and heuristic validation. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | strength; coverage\_scope; fallback semantics |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Class affects confidence qualification and failure semantics. |
| allowed\_values | deterministic; heuristic-hardening; formal\_decidable; heuristic |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-004 - strength

| category | Validation Terms |
| --- | --- |
| definition\_short | Declared strength of a validator or conflict check. |
| definition\_operational | Use to determine whether a simple ALLOW is permitted or a constrained, escalated, denied, or fail-closed result is required. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | conflict\_check\_strength; V-006A Formal Conflict Check; V-006B Semantic Conflict Heuristic |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Different strengths require explicit confidence qualification. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-005 - coverage\_scope

| category | Validation Terms |
| --- | --- |
| definition\_short | Declared scope covered by a validator or conflict check. |
| definition\_operational | Use to state what the validator covers and whether residual risk remains outside that scope. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | conflict\_check\_coverage\_scope; residual\_risk\_statement; coverage\_scope |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Incomplete coverage must affect verdict and evidence. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-006 - fallback semantics

| category | Validation Terms |
| --- | --- |
| definition\_short | Declared behavior when a validator fails or is inconclusive. |
| definition\_operational | Use to determine DENY, FAIL\_CLOSED, ALLOW\_CONSTRAINED, ESCALATE, or RECLASSIFY routing. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | failure\_effect; Gate Logic Record; verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Fallback semantics must be explicit per validator. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-007 - V-001 Statement Identity

| category | Validation Terms |
| --- | --- |
| definition\_short | Deterministic validator for canonical\_text, statement\_id, and serialization profile. |
| definition\_operational | Use to fail closed when statement identity cannot be established. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | canonical\_text; statement\_id; semantic\_normalization\_profile |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure produces FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-008 - V-002 Mandatory Fields Presence

| category | Validation Terms |
| --- | --- |
| definition\_short | Deterministic validator for required fields across input, output, and evidence contracts. |
| definition\_operational | Use to fail closed when mandatory contract fields are absent. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | Input Contract Record; Output Contract Record; Evidence Contract |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure produces FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-009 - V-003 Provenance Admissibility

| category | Validation Terms |
| --- | --- |
| definition\_short | Deterministic validator for tsa\_label, source\_class, source\_ref, and policy allowlist validity. |
| definition\_operational | Use to produce DENY or FAIL\_CLOSED on invalid provenance admissibility. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | tsa\_label; SOURCE\_CLASS; source\_ref; policy allowlist |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure produces DENY or FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-010 - V-004 AXIOM / TERM Linkage

| category | Validation Terms |
| --- | --- |
| definition\_short | Deterministic validator for linkage to AXIOM\_SET, TERM\_BIND, and POLICY\_BIND. |
| definition\_operational | Use to deny claims with invalid linkage. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | AXIOM\_SET; TERM\_BIND; POLICY\_BIND |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure produces DENY. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-011 - V-005 Boundary Role Consistency

| category | Validation Terms |
| --- | --- |
| definition\_short | Heuristic-hardening validator for statement\_role at the boundary. |
| definition\_operational | Use to confirm or reclassify statement\_role and to detect role bypass. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §13 |
| related\_terms | statement\_role; boundary\_validated\_role; RECLASSIFY |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure or inconsistency routes to RECLASSIFY, ALLOW\_CONSTRAINED, or FAIL\_CLOSED according to policy. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-012 - V-006A Formal Conflict Check

| category | Validation Terms |
| --- | --- |
| definition\_short | Formal\_decidable validator detecting contradictions inside the declared formalism. |
| definition\_operational | Use to produce FAIL\_CLOSED or DENY when formal conflict is confirmed. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | FORMAL\_CONFLICT\_CONFIRMED; DO-005 Confirmed formal conflict; conflict\_check\_mode |
| synonyms | \[\] |
| non\_synonyms | V-006B Semantic Conflict Heuristic |
| usage\_constraints | Failure produces FAIL\_CLOSED or DENY according to severity. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-013 - V-006B Semantic Conflict Heuristic

| category | Validation Terms |
| --- | --- |
| definition\_short | Heuristic validator detecting probable contradictions outside the fully decidable formalism. |
| definition\_operational | Use when formal conflict coverage is incomplete; below threshold it cannot support simple ALLOW. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | HEURISTIC\_CONFLICT\_UNCLOSED; ALLOW\_CONSTRAINED; ESCALATE; residual\_risk\_statement |
| synonyms | \[\] |
| non\_synonyms | V-006A Formal Conflict Check |
| usage\_constraints | If V-006B is the only available conflict check, simple ALLOW is forbidden below threshold. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-014 - V-007 Policy Snapshot Consistency

| category | Validation Terms |
| --- | --- |
| definition\_short | Deterministic validator ensuring the verdict uses the policy snapshot captured at intake. |
| definition\_operational | Use to fail closed and re-evaluate if policy drift occurs. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | policy\_snapshot\_id; policy\_hash\_ref; POLICY\_SNAPSHOT\_DRIFT |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure produces FAIL\_CLOSED and re-evaluate. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-015 - V-008 Ordering / Serialization

| category | Validation Terms |
| --- | --- |
| definition\_short | Deterministic validator ensuring one in-flight flow per scope or valid compare-and-commit discipline. |
| definition\_operational | Use to fail closed on ordering violations. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | one in-flight flow; compare-and-commit; ORDERING\_VIOLATION |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure produces FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-VALIDATION-016 - V-009 Escalation Artifact Emission

| category | Validation Terms |
| --- | --- |
| definition\_short | Deterministic validator ensuring ESCALATION\_REQUEST is emitted when required. |
| definition\_operational | Use to fail closed if an external-actor path lacks the required escalation artifact. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | ESCALATION\_REQUEST; CLEARANCE\_ARTIFACT\_MISSING; External clearance required |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Failure produces FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Evidence Terms

## TAA-EVIDENCE-001 - Input Contract Record

| category | Evidence Terms |
| --- | --- |
| definition\_short | Minimum input record received by the agent. |
| definition\_operational | Use to carry input\_id, session\_id, scope\_id, turn\_id, payload, input\_statement\_role, labels if provided, source\_ref, policy hash reference, producer\_id, and producer\_assertions. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.1 |
| related\_terms | payload; input\_statement\_role; source\_ref; producer\_assertions |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | input\_statement\_role remains untrusted until local validation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-002 - Output Contract Record

| category | Evidence Terms |
| --- | --- |
| definition\_short | Minimum output record emitted by the agent. |
| definition\_operational | Use to carry decision\_id, statement\_id\_list, boundary\_validated\_role, verdict, reason\_code, validator\_refs, labels, source references, policy data, order\_ref, evidence\_ref\_list, and gate\_impact. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2 |
| related\_terms | decision\_id; statement\_id\_list; verdict; gate\_impact |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | ALLOW and ALLOW\_CONSTRAINED require conflict qualifiers when conflict handling is not fully decidable. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-003 - Evidence Contract

| category | Evidence Terms |
| --- | --- |
| definition\_short | Required evidence fields emitted for every verdict and additional fields for role validation, conflict handling, and failure paths. |
| definition\_operational | Use as the offline reconstruction contract for all verdicts. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §15 |
| related\_terms | decision\_id; statement\_id\_list; residual\_risk\_statement; escalation\_request\_ref |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Any verdict missing required closure fields is partial or invalid. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-004 - DECISION

| category | Evidence Terms |
| --- | --- |
| definition\_short | Decision artifact emitted for mechanism-level use. |
| definition\_operational | Use as an observable artifact supporting replay and offline reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §3; Truth Arbitration Agent Public Library Specification §5.2 |
| related\_terms | verdict; Evidence Contract; decision\_id |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-005 - CONFLICT\_EVENT

| category | Evidence Terms |
| --- | --- |
| definition\_short | Conflict artifact emitted when conflict status is detected or recorded. |
| definition\_operational | Use for mechanism-level conflict evidence and reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §3; Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | MRF-CONFLICT.json; conflict\_check\_mode; conflicting\_statement\_ids |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-006 - ESCALATION\_REQUEST

| category | Evidence Terms |
| --- | --- |
| definition\_short | Normative request for external remediation. |
| definition\_operational | Use whenever an external actor is required by failure semantics or gate logic. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §3; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §9; Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | request\_id; failure\_ref; required\_actor\_role; required\_evidence |
| synonyms | \[\] |
| non\_synonyms | FAIL\_CLOSED log entry |
| usage\_constraints | A FAIL\_CLOSED log entry alone is not a sufficient interoperable output. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-007 - CLEARANCE\_NEEDED\_NOTIFICATION

| category | Evidence Terms |
| --- | --- |
| definition\_short | Artifact notifying that clearance is required. |
| definition\_operational | Use for ESCALATE or FAIL\_CLOSED paths requiring an external actor when this notification is applicable. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2 |
| related\_terms | ESCALATION\_REQUEST; clearance\_needed; cleared\_only\_by |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | It does not replace the required escalation request when that request is required. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-008 - CLEARANCE\_RESPONSE

| category | Evidence Terms |
| --- | --- |
| definition\_short | Response artifact to an external clearance request. |
| definition\_operational | Use to record request\_id, actor\_id, evidence\_refs, and clearance\_verdict before readmission can proceed. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5.2; Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | request\_id; actor\_id; evidence\_refs; clearance\_verdict |
| synonyms | \[\] |
| non\_synonyms | ESCALATION\_REQUEST |
| usage\_constraints | Re-entry requires valid clearance plus new snapshot freeze and full re-evaluation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-009 - CHECKPOINT(LASTCLEAN)

| category | Evidence Terms |
| --- | --- |
| definition\_short | Observable checkpoint artifact for replay and rollback basis. |
| definition\_operational | Use as one of the minimum observable artifacts supporting offline reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5.2 |
| related\_terms | ROLLBACK; DECISION; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-010 - ROLLBACK

| category | Evidence Terms |
| --- | --- |
| definition\_short | Observable rollback artifact for reconstruction and recovery. |
| definition\_operational | Use with CHECKPOINT(LASTCLEAN) and other evidence artifacts to support replay. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.3; Truth Arbitration Agent Public Library Specification §5.2 |
| related\_terms | CHECKPOINT(LASTCLEAN); DECISION; FAIL\_CLOSED |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-011 - decision\_id

| category | Evidence Terms |
| --- | --- |
| definition\_short | Identifier for a decision record. |
| definition\_operational | Use in output and evidence contracts. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | DECISION; Output Contract Record; Evidence Contract |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-012 - statement\_id\_list

| category | Evidence Terms |
| --- | --- |
| definition\_short | List of statement identifiers covered by an output or evidence record. |
| definition\_operational | Use to bind a verdict to the statement records it adjudicates. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | statement\_id; decision\_id; MRF-DECISION.json |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-013 - reason\_code

| category | Evidence Terms |
| --- | --- |
| definition\_short | Reason code explaining a verdict. |
| definition\_operational | Use in output and evidence records; concrete reason\_code names may be specialized without changing the semantic core. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §16.2 |
| related\_terms | verdict; root\_reason\_code; Decision Table |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Must remain semantically coherent with the decision path. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-014 - validator\_refs

| category | Evidence Terms |
| --- | --- |
| definition\_short | References to validators used by a decision. |
| definition\_operational | Use in Output Contract Record and MRF-DECISION.json. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | validator\_id; Validator Catalogue; MRF-DECISION.json |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-015 - gate\_impact

| category | Evidence Terms |
| --- | --- |
| definition\_short | Output field indicating impact on gate behavior. |
| definition\_operational | Use in Output Contract Record and MRF-DECISION.json to support execution-layer consumption. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | Gate Logic Record; MRF-DECISION.json; verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-016 - evidence\_ref\_list

| category | Evidence Terms |
| --- | --- |
| definition\_short | Output field listing evidence references. |
| definition\_operational | Use to bind decision output to evidence artifacts. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2 |
| related\_terms | Evidence Contract; source\_ref; validator\_refs |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-017 - conflict\_check\_mode

| category | Evidence Terms |
| --- | --- |
| definition\_short | Conflict evidence field stating the conflict-checking mode used. |
| definition\_operational | Use for ALLOW, ALLOW\_CONSTRAINED, and conflict handling evidence. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | conflict\_check\_strength; conflict\_check\_confidence; conflict\_check\_coverage\_scope |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Conflict mode affects verdict permissibility. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-018 - conflict\_check\_strength

| category | Evidence Terms |
| --- | --- |
| definition\_short | Conflict evidence field stating the strength of the conflict check. |
| definition\_operational | Use to determine whether simple ALLOW is supported or a constrained/escalated result is required. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | strength; V-006A Formal Conflict Check; V-006B Semantic Conflict Heuristic |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-019 - conflict\_check\_confidence

| category | Evidence Terms |
| --- | --- |
| definition\_short | Conflict evidence field stating confidence in conflict results. |
| definition\_operational | Use when conflict handling is formal, heuristic, partial, or below threshold. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | conflict\_check\_mode; V-006B Semantic Conflict Heuristic; residual\_risk\_statement |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Below-threshold heuristic confidence forbids simple ALLOW. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-020 - conflict\_check\_coverage\_scope

| category | Evidence Terms |
| --- | --- |
| definition\_short | Conflict evidence field stating what the conflict check covers. |
| definition\_operational | Use to qualify residual risk and to limit claims of conflict closure. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | coverage\_scope; residual\_risk\_statement; declared formalism |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Complete conflict coverage remains limited to the declared formalism. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-021 - compared\_claim\_set\_ref

| category | Evidence Terms |
| --- | --- |
| definition\_short | Reference to the claim set compared during conflict handling. |
| definition\_operational | Use in conflict evidence to make conflict comparison reconstructible. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | conflict\_check\_mode; statement\_id\_list; Evidence Contract |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-022 - residual\_risk\_statement

| category | Evidence Terms |
| --- | --- |
| definition\_short | Statement of remaining risk when conflict handling is not fully closed. |
| definition\_operational | Use whenever conflict handling is not fully decidable across the entire payload or when V-006B leaves unresolved risk. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | ALLOW\_CONSTRAINED; V-006B Semantic Conflict Heuristic; conflict\_check\_coverage\_scope |
| synonyms | \[\] |
| non\_synonyms | simple ALLOW |
| usage\_constraints | Required for qualified conflict handling. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-023 - inhibit\_flags

| category | Evidence Terms |
| --- | --- |
| definition\_short | FAIL\_CLOSED evidence field indicating blocked conditions. |
| definition\_operational | Use in FAIL\_CLOSED outputs and failure evidence. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §2.2; Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | FAIL\_CLOSED; root\_reason\_code; remediation\_class |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-024 - root\_reason\_code

| category | Evidence Terms |
| --- | --- |
| definition\_short | FAIL\_CLOSED evidence field stating the root reason for blocking. |
| definition\_operational | Use to support remediation and reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | reason\_code; FAIL\_CLOSED; MRF-FAIL\_CLOSED.json |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-025 - clearance\_needed

| category | Evidence Terms |
| --- | --- |
| definition\_short | Evidence field indicating that clearance is required. |
| definition\_operational | Use in FAIL\_CLOSED and NONCOMPLIANT\_HOLD paths. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | cleared\_only\_by; ESCALATION\_REQUEST; NONCOMPLIANT\_HOLD |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-026 - cleared\_only\_by

| category | Evidence Terms |
| --- | --- |
| definition\_short | Evidence field identifying who may clear a failure path. |
| definition\_operational | Use to decide whether external actor handling and ESCALATION\_REQUEST are required. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | clearance\_needed; required\_actor\_role; ESCALATION\_REQUEST |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | If cleared\_only\_by implies an external actor, ESCALATION\_REQUEST is emitted immediately. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-027 - remediation\_class

| category | Evidence Terms |
| --- | --- |
| definition\_short | Evidence field describing the class of remediation required. |
| definition\_operational | Use in FAIL\_CLOSED outputs and evidence to support proper clearance and readmission handling. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | FAIL\_CLOSED; root\_reason\_code; clearance\_needed |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-028 - escalation\_request\_ref

| category | Evidence Terms |
| --- | --- |
| definition\_short | Evidence reference to an ESCALATION\_REQUEST artifact. |
| definition\_operational | Use in FAIL\_CLOSED and NONCOMPLIANT\_HOLD evidence where external handling is required. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §4.2; Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | ESCALATION\_REQUEST; CLEARANCE\_ARTIFACT\_MISSING; V-009 Escalation Artifact Emission |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Missing when required makes the gate structurally incomplete. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-029 - clearance\_response\_ref

| category | Evidence Terms |
| --- | --- |
| definition\_short | Evidence reference to a CLEARANCE\_RESPONSE artifact. |
| definition\_operational | Use when clearance has been provided and readmission is being evaluated. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §8 |
| related\_terms | CLEARANCE\_RESPONSE; READMISSION\_PENDING; clearance\_verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-030 - request\_id

| category | Evidence Terms |
| --- | --- |
| definition\_short | Identifier for escalation or clearance request linkage. |
| definition\_operational | Use in ESCALATION\_REQUEST and CLEARANCE\_RESPONSE to bind request and response. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | ESCALATION\_REQUEST; CLEARANCE\_RESPONSE; failure\_ref |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-031 - failure\_ref

| category | Evidence Terms |
| --- | --- |
| definition\_short | Reference linking a clearance or escalation artifact to a failure. |
| definition\_operational | Use in ESCALATION\_REQUEST and minimum clearance artifact contracts. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | ESCALATION\_REQUEST; root\_reason\_code; clearance\_verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-032 - required\_actor\_role

| category | Evidence Terms |
| --- | --- |
| definition\_short | Actor role required to handle an escalation request. |
| definition\_operational | Use in MRF-ESCALATION\_REQUEST.json for external remediation. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | ESCALATION\_REQUEST; cleared\_only\_by; required\_evidence |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-033 - required\_evidence

| category | Evidence Terms |
| --- | --- |
| definition\_short | Evidence required for external remediation. |
| definition\_operational | Use in escalation requests to specify what must be supplied. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | ESCALATION\_REQUEST; Evidence Contract; CLEARANCE\_RESPONSE |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-034 - actor\_id

| category | Evidence Terms |
| --- | --- |
| definition\_short | Identifier of the actor responding to clearance. |
| definition\_operational | Use in CLEARANCE\_RESPONSE and minimum clearance artifact contracts. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | actor\_role; CLEARANCE\_RESPONSE; clearance\_verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-035 - actor\_role

| category | Evidence Terms |
| --- | --- |
| definition\_short | Role of the actor providing clearance. |
| definition\_operational | Use when actor\_id is not sufficient or when clearance is role-bound. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | actor\_id; required\_actor\_role; cleared\_only\_by |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-036 - evidence\_refs

| category | Evidence Terms |
| --- | --- |
| definition\_short | References to evidence supplied in clearance response. |
| definition\_operational | Use in CLEARANCE\_RESPONSE and clearance artifact contracts. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | CLEARANCE\_RESPONSE; Evidence Contract; clearance\_verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-037 - clearance\_verdict

| category | Evidence Terms |
| --- | --- |
| definition\_short | Verdict in a clearance response. |
| definition\_operational | Use to determine whether re-entry is permitted after failure handling. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | CLEARANCE\_RESPONSE; re-entry; clearance\_epoch |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Re-entry is permitted only after valid clearance and full re-evaluation. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-EVIDENCE-038 - clearance\_epoch

| category | Evidence Terms |
| --- | --- |
| definition\_short | Epoch associated with clearance. |
| definition\_operational | Use to prevent readmission from inheriting ALLOW across clearance changes. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | clearance\_verdict; readmission; policy snapshot freeze |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Readmission does not inherit ALLOW across clearance epoch changes. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Control Terms

## TAA-CONTROL-001 - Gate Logic Record

| category | Control Terms |
| --- | --- |
| definition\_short | Deterministic and total verdict function binding validators, decision objects, policy snapshot rules, and failure semantics. |
| definition\_operational | Use to convert validation and decision outcomes into a final verdict without unresolved branches. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §9 |
| related\_terms | Validator Catalogue; Decision Table; FAIL\_CLOSED |
| synonyms | Gate Logic |
| non\_synonyms | \[\] |
| usage\_constraints | If no specialized branch applies and the decision path is structurally incomplete, the result is FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-002 - policy allowlist

| category | Control Terms |
| --- | --- |
| definition\_short | Policy-controlled allowlist used by Provenance Admissibility. |
| definition\_operational | Use with tsa\_label, source\_class, and source\_ref to determine source admissibility. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §7 |
| related\_terms | V-003 Provenance Admissibility; SOURCE\_CLASS; policy\_snapshot\_id |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Invalid policy allowlist status leads to DENY or FAIL\_CLOSED. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-003 - Temporal and Ordering Contract

| category | Control Terms |
| --- | --- |
| definition\_short | Contract defining mandatory order, policy snapshot freeze, per-scope concurrency, and readmission reset rules. |
| definition\_operational | Use as the source for intake-to-verdict sequencing and concurrency validity. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | mandatory minimum order; one in-flight flow; compare-and-commit |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Verdicts from a changed claim set are invalid. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-004 - mandatory minimum order

| category | Control Terms |
| --- | --- |
| definition\_short | Required ordering from intake through optional escalation or handoff. |
| definition\_operational | Use to sequence intake, policy snapshot freeze, boundary role validation, canonicalization, validators, classification, conflict check, verdict, evidence emission, and optional escalation or handoff. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | Temporal and Ordering Contract; policy snapshot freeze; evidence emission |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | A verdict may not skip required predecessor stages. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-005 - one in-flight flow

| category | Control Terms |
| --- | --- |
| definition\_short | Per-scope sequentiality requirement. |
| definition\_operational | Use to ensure only one adjudication flow is active per scope unless serialization or compare-and-commit is used. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §11 |
| related\_terms | scope\_id; V-008 Ordering / Serialization; compare-and-commit |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Without a conformant ordering technique, produced verdicts are non-conformant. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-006 - offline reconstruction

| category | Control Terms |
| --- | --- |
| definition\_short | Ability to reconstruct agent decisions from emitted evidence without internal engine state. |
| definition\_operational | Use as an audit and replay requirement for all verdict paths. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §15 |
| related\_terms | Evidence Contract; replay; DECISION |
| synonyms | offline reconstructibility |
| non\_synonyms | internal engine state dependency |
| usage\_constraints | Missing closure fields make verdicts partial or invalid. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-007 - replay

| category | Control Terms |
| --- | --- |
| definition\_short | Ability to replay decision paths from emitted artifacts. |
| definition\_operational | Use with observable artifacts including DECISION, FAIL\_CLOSED, CHECKPOINT(LASTCLEAN), ROLLBACK, ESCALATION\_REQUEST, CLEARANCE\_RESPONSE, and NONCOMPLIANT\_HOLD. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §1; Truth Arbitration Agent Public Library Specification §5.2 |
| related\_terms | offline reconstruction; CHECKPOINT(LASTCLEAN); ROLLBACK |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Every relevant transition must emit enough observable artifacts for replay. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-008 - Failure Semantics and Readmission

| category | Control Terms |
| --- | --- |
| definition\_short | Normative block and recovery rules for failure codes, clearance, and readmission. |
| definition\_operational | Use to map failures to required output, clearance, and terminal handling. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | UNLABELED\_CLAIM; READMISSION\_PENDING; readmission\_budget |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | FAIL\_CLOSED is not the only externally meaningful failure output. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-009 - readmission\_budget

| category | Control Terms |
| --- | --- |
| definition\_short | Budget limiting readmission loops. |
| definition\_operational | Use to prevent readmission loops without progress. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §5; Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | READMISSION\_PENDING; recurrence\_counter; PERMANENT\_BLOCK |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | When exhausted, terminal ESCALATE or PERMANENT\_BLOCK applies according to policy. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-010 - recurrence\_counter

| category | Control Terms |
| --- | --- |
| definition\_short | Counter used with readmission\_budget to detect repeated readmission loops. |
| definition\_operational | Use to enforce terminal handling when loops do not progress. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | readmission\_budget; terminal ESCALATE; PERMANENT\_BLOCK |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-011 - terminal ESCALATE

| category | Control Terms |
| --- | --- |
| definition\_short | Terminal escalation emitted when readmission cannot proceed. |
| definition\_operational | Use when budget is exhausted or clearance does not close the root cause and policy selects escalation rather than block. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | ESCALATE; readmission\_budget; PERMANENT\_BLOCK |
| synonyms | \[\] |
| non\_synonyms | local ALLOW |
| usage\_constraints | Terminal handling prevents infinite readmission loops. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-012 - PERMANENT\_BLOCK

| category | Control Terms |
| --- | --- |
| definition\_short | Terminal block emitted when readmission cannot proceed. |
| definition\_operational | Use when readmission\_budget is exhausted or clearance does not close the root cause and policy selects permanent blocking. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12; Truth Arbitration Agent Public Library Specification §12.1 |
| related\_terms | readmission\_budget; terminal ESCALATE; READMISSION\_PENDING |
| synonyms | \[\] |
| non\_synonyms | FAIL\_CLOSED |
| usage\_constraints | PERMANENT\_BLOCK is terminal according to policy. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-013 - Conformance Conditions

| category | Control Terms |
| --- | --- |
| definition\_short | Conditions for implementation conformance. |
| definition\_operational | Use to verify fields, decision coverage, validators, role-bypass handling, conflict handling, escalation, clearance, terminal readmission handling, and offline reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §15 |
| related\_terms | Semantic Contract; Validator Catalogue; Gate Logic Record; Evidence Contract |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | No open inconsistency may remain in boundary handling, validator semantics, policy snapshot semantics, conflict closure, fail-closed escalation, replay, or readmission semantics. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-014 - UNLABELED\_CLAIM

| category | Control Terms |
| --- | --- |
| definition\_short | Failure code for a mechanism-level claim without conformant tsa\_label or source\_class. |
| definition\_operational | Use to FAIL\_CLOSED with clearance by an authorized actor. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | DO-001 Unlabeled mechanism claim; tsa\_label; SOURCE\_CLASS |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Applies to mechanism-level claims. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-015 - ROLE\_BYPASS\_SUSPECTED

| category | Control Terms |
| --- | --- |
| definition\_short | Failure code for explanatory\_only input inconsistent with the payload. |
| definition\_operational | Use to FAIL\_CLOSED or RECLASSIFY under policy. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | explanatory\_only; RECLASSIFY; V-005 Boundary Role Consistency |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-016 - FORMAL\_CONFLICT\_CONFIRMED

| category | Control Terms |
| --- | --- |
| definition\_short | Failure code for V-006A-confirmed contradiction. |
| definition\_operational | Use to produce DENY or FAIL\_CLOSED. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | V-006A Formal Conflict Check; DO-005 Confirmed formal conflict; DENY |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-017 - HEURISTIC\_CONFLICT\_UNCLOSED

| category | Control Terms |
| --- | --- |
| definition\_short | Failure code for probable semantic conflict that remains open or under-closed. |
| definition\_operational | Use to produce ALLOW\_CONSTRAINED or ESCALATE; simple ALLOW is forbidden. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | V-006B Semantic Conflict Heuristic; ALLOW\_CONSTRAINED; ESCALATE |
| synonyms | \[\] |
| non\_synonyms | ALLOW |
| usage\_constraints | Simple ALLOW is forbidden. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-018 - POLICY\_SNAPSHOT\_DRIFT

| category | Control Terms |
| --- | --- |
| definition\_short | Failure code for policy changes mid-flight. |
| definition\_operational | Use to FAIL\_CLOSED and re-evaluate. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | policy\_snapshot\_id; policy\_hash\_ref; V-007 Policy Snapshot Consistency |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-019 - ORDERING\_VIOLATION

| category | Control Terms |
| --- | --- |
| definition\_short | Failure code for unserialized concurrent flow or failed compare-and-commit. |
| definition\_operational | Use to FAIL\_CLOSED. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | compare-and-commit; V-008 Ordering / Serialization; one in-flight flow |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-CONTROL-020 - CLEARANCE\_ARTIFACT\_MISSING

| category | Control Terms |
| --- | --- |
| definition\_short | Failure code for missing ESCALATION\_REQUEST on an external-actor path. |
| definition\_operational | Use to FAIL\_CLOSED structurally. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §12 |
| related\_terms | ESCALATION\_REQUEST; V-009 Escalation Artifact Emission; escalation\_request\_ref |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Abbreviation Terms

## TAA-ABBREVIATION-001 - Machine-Readable Form Catalogue

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Catalogue of JSON forms for machine-readable records. |
| definition\_operational | Use to align statement, decision, conflict, fail-closed, escalation, clearance, and handoff records. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | MRF-STATEMENT.json; MRF-DECISION.json; MRF-HANDOFF-CHECK.json |
| synonyms | MRF |
| non\_synonyms | \[\] |
| usage\_constraints | Machine-readable forms must preserve the semantic contracts. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-ABBREVIATION-002 - MRF-STATEMENT.json

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Machine-readable canonical payload for a statement candidate. |
| definition\_operational | Use with input\_statement\_role, boundary\_validated\_role, canonical\_text, and statement\_id. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | canonical\_text; statement\_id; boundary\_validated\_role |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-ABBREVIATION-003 - MRF-DECISION.json

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Machine-readable arbitration verdict. |
| definition\_operational | Use with verdict, reason\_code, validator\_refs, gate\_impact, and policy\_snapshot\_id. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | verdict; reason\_code; validator\_refs; gate\_impact |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-ABBREVIATION-004 - MRF-CONFLICT.json

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Machine-readable conflict event. |
| definition\_operational | Use with conflict\_mode, strength, confidence, and conflicting\_statement\_ids. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | CONFLICT\_EVENT; conflict\_check\_strength; conflict\_check\_confidence |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-ABBREVIATION-005 - MRF-FAIL\_CLOSED.json

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Machine-readable block record. |
| definition\_operational | Use with inhibit\_flags, root\_reason\_code, clearance\_needed, and cleared\_only\_by. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | FAIL\_CLOSED; inhibit\_flags; root\_reason\_code |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-ABBREVIATION-006 - MRF-ESCALATION\_REQUEST.json

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Machine-readable external remediation request. |
| definition\_operational | Use with request\_id, failure\_ref, required\_actor\_role, required\_evidence, and status. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | ESCALATION\_REQUEST; request\_id; failure\_ref |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-ABBREVIATION-007 - MRF-CLEARANCE\_RESPONSE.json

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Machine-readable response to an external clearance request. |
| definition\_operational | Use with request\_id, actor\_id, evidence\_refs, and clearance\_verdict. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | CLEARANCE\_RESPONSE; clearance\_verdict; evidence\_refs |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-ABBREVIATION-008 - MRF-HANDOFF-CHECK.json

| category | Abbreviation Terms |
| --- | --- |
| definition\_short | Machine-readable acceptance record for the execution layer. |
| definition\_operational | Use to record semantic closure, evidence closure, failure closure, and policy snapshot closure. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §10 |
| related\_terms | HANDOFF\_READY; semantic closure; evidence closure |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | \[\] |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Optionality Terms

## TAA-OPTIONALITY-001 - Optional Capabilities

| category | Optionality Terms |
| --- | --- |
| definition\_short | Capabilities that may strengthen or support operation without replacing required semantic obligations. |
| definition\_operational | Use only as non-substituting deployment-level or workflow support. |
| normative\_status | implementation\_optional |
| source\_refs | Truth Arbitration Agent Public Library Specification §14 |
| related\_terms | Non-Substitution Rule; hardware-backed attestation; quarantine/readmission workflow |
| synonyms | \[\] |
| non\_synonyms | semantic core |
| usage\_constraints | Optional capabilities do not alter semantic arbitration logic. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-002 - Non-Substitution Rule

| category | Optionality Terms |
| --- | --- |
| definition\_short | Rule that optional capabilities may not replace normative obligations. |
| definition\_operational | Use to prevent contextual escalation support, attestation, or quarantine/readmission workflow from replacing core requirements. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §14 |
| related\_terms | Optional Capabilities; Boundary-Qualified No Unlabeled Claims; validator semantics; gate closure |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | No optional capability may substitute for an active normative obligation in the semantic core. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-003 - contextual escalation support

| category | Optionality Terms |
| --- | --- |
| definition\_short | Optional support that may improve risk grading. |
| definition\_operational | Use only to support escalation context; it does not replace hard blocks or V-006 qualifiers. |
| normative\_status | implementation\_optional |
| source\_refs | Truth Arbitration Agent Public Library Specification §14 |
| related\_terms | Optional Capabilities; V-006B Semantic Conflict Heuristic; No Unlabeled Claims |
| synonyms | \[\] |
| non\_synonyms | hard block |
| usage\_constraints | Cannot replace the hard block for No Unlabeled Claims. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-004 - hardware-backed attestation

| category | Optionality Terms |
| --- | --- |
| definition\_short | Optional deployment-level attestation that may strengthen provenance binding and clearance assurance. |
| definition\_operational | Use only as an assurance-strengthening mechanism; it does not replace semantic gate logic, validator semantics, admissibility rules, provenance admissibility, role validation, or conflict qualifiers. |
| normative\_status | implementation\_optional |
| source\_refs | Truth Arbitration Agent Public Library Specification §8; Truth Arbitration Agent Public Library Specification §14 |
| related\_terms | commit-boundary pairing; Provenance Admissibility; Non-Substitution Rule |
| synonyms | \[\] |
| non\_synonyms | semantic gate logic |
| usage\_constraints | Does not alter semantic arbitration logic. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-005 - commit-boundary pairing

| category | Optionality Terms |
| --- | --- |
| definition\_short | Optional pairing capability that may strengthen provenance binding. |
| definition\_operational | Use only as a non-substituting deployment-level support. |
| normative\_status | implementation\_optional |
| source\_refs | Truth Arbitration Agent Public Library Specification §14 |
| related\_terms | hardware-backed attestation; Optional Capabilities; Non-Substitution Rule |
| synonyms | \[\] |
| non\_synonyms | role validation |
| usage\_constraints | Does not replace provenance admissibility, role validation, or conflict qualifiers. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-006 - quarantine/readmission workflow

| category | Optionality Terms |
| --- | --- |
| definition\_short | Optional workflow supporting controlled recovery. |
| definition\_operational | Use only if it preserves audited ESCALATION\_REQUEST, validated clearance, and readmission\_budget. |
| normative\_status | implementation\_optional |
| source\_refs | Truth Arbitration Agent Public Library Specification §14 |
| related\_terms | readmission; ESCALATION\_REQUEST; readmission\_budget |
| synonyms | \[\] |
| non\_synonyms | readmission budget replacement |
| usage\_constraints | Does not relax the requirement for audited ESCALATION\_REQUEST, validated clearance, or readmission\_budget. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-007 - Stable semantic core

| category | Optionality Terms |
| --- | --- |
| definition\_short | Reuse guidance identifying elements that shall not be reinterpreted. |
| definition\_operational | Use to preserve identity, restricted jurisdiction, central invariant, authority boundaries, verdict vocabulary, escalation requirements, ordering, policy freeze, failure semantics, evidence closure, and offline reconstructibility. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §16.1 |
| related\_terms | Reuse and Adaptation Guidance; Boundary-Qualified No Unlabeled Claims; verdict |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Stable elements shall not be reinterpreted in downstream use. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-008 - Parameterized elements

| category | Optionality Terms |
| --- | --- |
| definition\_short | Reuse guidance identifying elements that may be specialized without changing the semantic core. |
| definition\_operational | Use for concrete reason\_code names, field naming, policy profiles, external roles, serialization details, and optional integrations that do not substitute for required logic. |
| normative\_status | derived |
| source\_refs | Truth Arbitration Agent Public Library Specification §16.2 |
| related\_terms | reason\_code; policy profiles; Optional Capabilities |
| synonyms | \[\] |
| non\_synonyms | Stable semantic core |
| usage\_constraints | Specialization must preserve identical semantics. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-009 - Non-reuse zones

| category | Optionality Terms |
| --- | --- |
| definition\_short | Reuse guidance identifying changes requiring full re-specification. |
| definition\_operational | Use when a variant expands jurisdiction, adds full material truth authority, removes boundary validation, relaxes No Unlabeled Claims, permits simple ALLOW on under-threshold heuristic-only conflict handling, removes required escalation request, or changes record identity semantics. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §16.3 |
| related\_terms | Stable semantic core; record identity; Boundary-Qualified No Unlabeled Claims |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Cannot reuse this specification without full re-specification in these zones. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-010 - Required dependencies across sections

| category | Optionality Terms |
| --- | --- |
| definition\_short | Reuse guidance requiring coherence across major contracts and rules. |
| definition\_operational | Use to keep Semantic Contract, Authority Model, State Model, Decision Table, Validator Catalogue, Evidence Contract, Gate Logic, Failure Semantics, machine-readable forms, and ordering rules coherent. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §16.4 |
| related\_terms | Semantic Contract; Authority Model; Gate Logic Record |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Conformant reuse depends on cross-section coherence. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-011 - Patch discipline

| category | Optionality Terms |
| --- | --- |
| definition\_short | Rule requiring consistent updates across affected rules, contracts, and machine-readable forms. |
| definition\_operational | Use when a patch affects identity, authority, boundary handling, decision objects, validator semantics, evidence fields, failure semantics, replay, readmission, or reuse conditions. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §16.5 |
| related\_terms | Required dependencies across sections; Machine-Readable Form Catalogue; Conformance Conditions |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Affected rules, contracts, and machine-readable forms must be updated consistently. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-012 - Rendering and output compatibility

| category | Optionality Terms |
| --- | --- |
| definition\_short | Reuse guidance for rendering public library or controlled downstream outputs. |
| definition\_operational | Use only when the semantic core remains complete and unique and the downstream consumer does not need unpublished manual reconstruction. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §16.6 |
| related\_terms | Stable semantic core; offline reconstruction; Reuse and Adaptation Guidance |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Rendering is allowed only with complete and unique semantic core. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

## TAA-OPTIONALITY-013 - Reuse and Adaptation Guidance

| category | Optionality Terms |
| --- | --- |
| definition\_short | Guidance for stable reuse, specialization, non-reuse zones, dependencies, patches, and output compatibility. |
| definition\_operational | Use to govern downstream reuse of the public specification while preserving the semantic core. |
| normative\_status | normative |
| source\_refs | Truth Arbitration Agent Public Library Specification §16 |
| related\_terms | Stable semantic core; Parameterized elements; Non-reuse zones |
| synonyms | \[\] |
| non\_synonyms | \[\] |
| usage\_constraints | Reuse depends on coherence across the specified sections. |
| allowed\_values | null |
| ambiguities | \[\] |
| examples | \[\] |
| term\_attested\_in\_spec | True |
| public\_traceable | True |

# Formal pre-publication checkpoint

| D1\_present | True |
| --- | --- |
| D2\_YAML\_present | True |
| D2\_JSON\_present | True |
| D3\_present | True |
| D4\_present | True |
| D1\_and\_D2\_semantically\_coherent | True |
| all\_indexed\_terms\_textually\_attested\_in\_publishable\_specification | True |
| all\_source\_refs\_publishable | True |
| no\_non\_public\_source\_reference\_in\_D1\_D2\_D3\_D4 | True |
| no\_lexical\_extension\_beyond\_publishable\_specification | True |
| D3\_covers\_terms\_and\_categories | True |
| D4\_addresses\_internal\_ambiguities\_only | True |
| package\_complete\_and\_cross\_checked | True |
