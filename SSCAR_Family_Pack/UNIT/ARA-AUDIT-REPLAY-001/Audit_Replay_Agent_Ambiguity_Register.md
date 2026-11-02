D4 — Ambiguity Register

*Ambiguity Register (D4)*

*Internal ambiguity controls limited to terms attested in the publishable specification.*

| source\_documents | Audit Replay Agent — Specification |
| --- | --- |
| **authorized\_public\_corpus** | Audit Replay Agent — Specification |
| **register\_size** | 14 |
| **control\_rule** | Only ambiguities internal to the publishable specification are recorded here. |

# Register

| ID | Focal term | Risky form / nearby term | Ambiguity type | Why risky in this corpus | Canonical resolution | Action |
| --- | --- | --- | --- | --- | --- | --- |
| **AMB-01** | CHECKPOINT(LASTCLEAN) | LASTCLEAN | short-form truncation | The decision object is the full checkpoint form, while LASTCLEAN also appears inside lineage and state-hash conditions. | Use CHECKPOINT(LASTCLEAN) for the decision object; use LASTCLEAN alone only when the surrounding sentence already states checkpoint lineage. | Prefer the full form in D1/D2 and in coverage references. |
| **AMB-02** | FAIL\_CLOSED | INCIDENT\_ONLY | state vs output limitation | FAIL\_CLOSED is a critical workflow and gate state; INCIDENT\_ONLY is a permitted report/output limitation. | Use FAIL\_CLOSED for state or gate status and INCIDENT\_ONLY for output eligibility or finalization scope. | Do not use the two terms as synonyms. |
| **AMB-03** | NONCOMPLIANT\_HOLD | SH HOLD\_ACTIVE | gate status vs workflow state | The corpus uses NONCOMPLIANT\_HOLD in gate logic and SH HOLD\_ACTIVE in the workflow table for closely related hold behavior. | Use SH HOLD\_ACTIVE when referring to the workflow state and NONCOMPLIANT\_HOLD when referring to gate status or control mode. | Keep both entries separate and cross-link them. |
| **AMB-04** | RECONSTRUCTABLE | REPLAYABLE | decision-object scope overlap | RECONSTRUCTABLE belongs to ledger session admissibility, while REPLAYABLE belongs to rollback correctness and the semantic contract. | Use RECONSTRUCTABLE for ledger-session reconstruction status and REPLAYABLE for rollback or replay closure. | Do not generalize REPLAYABLE to every positive reconstruction statement. |
| **AMB-05** | Hash chain continuity | Hash continuity validator | object vs validator | One term names the audited decision object; the other names the validator that tests the chain. | Use Hash chain continuity for the object under decision and Hash continuity validator for V-05. | Preserve the object/validator split in structured output. |
| **AMB-06** | Audit report | Machine Evidence | narrative output vs structured output | The audit report is the narrative finalization artifact, while Machine Evidence is the machine-readable execution consumer output. | Use Audit report for human-readable report logic and Machine Evidence for normalized machine-readable export. | Do not collapse both outputs into a single generic report term. |
| **AMB-07** | Session Bundle | ledger bundle | named contract vs broader input description | The named input contract is Session Bundle, while the broader boundary text also refers to a ledger bundle. | Use Session Bundle when referring to IC-01 and ledger bundle only for the broader input boundary description. | Keep IC-01 traceability explicit. |
| **AMB-08** | policy profile | policy\_profile\_id / policy\_hash | governing concept vs evidence field pair | The policy profile is the governing control concept, while policy\_profile\_id / policy\_hash is the evidence-contract field pair that binds the verdict. | Use policy profile for authority and governance context; use policy\_profile\_id / policy\_hash for machine evidence and binding fields. | Do not substitute the field pair for the broader governance concept. |
| **AMB-09** | trust store | verification policy | parallel verification inputs | The corpus admits a trust store or a verification policy, but they are not lexically identical and may serve different validation setups. | Treat them as separate admitted inputs that can coexist or be used as alternatives depending on policy. | Avoid merging them into one canonical label. |
| **AMB-10** | QUARANTINE | FAIL\_CLOSED | isolated control state vs critical block | QUARANTINE isolates unauthorized tool-state artifacts, while FAIL\_CLOSED is the critical block for signature, chain, parse, or invalid-policy failures. | Use QUARANTINE for replay-core isolation and FAIL\_CLOSED for critical blocking failure. | Keep separate in gate logic and failure semantics. |
| **AMB-11** | REPORT | Audit report | named control point vs decision object/output contract | REPORT appears as a ZSSC control point/reference and also as the human-readable audit output object. | Use REPORT only in the attested control-point/reference sense and Audit report for the decision object and output contract. | Prefer Audit report in semantic indexing unless the control-point reference is explicit. |
| **AMB-12** | VERIF\_COUNTER\_ANCHOR | freshness anchor | named reference vs ordering concept | VERIF\_COUNTER\_ANCHOR is a named evidence/input reference, while freshness anchor is the broader ordering concept used by policy. | Use VERIF\_COUNTER\_ANCHOR for the attested reference token and freshness anchor for the ordering concept. | Do not treat the reference token as the full ordering rule. |
| **AMB-13** | REJECTED | BLOCKED | negative verdict vs blocked finalization | REJECTED is a verdict in a decision-object vocabulary, while BLOCKED denotes prevented finalization or eligibility. | Use REJECTED for inadmissible reconstruction outcomes and BLOCKED for prevented processing or finalization. | Avoid using BLOCKED as a verdict substitute. |
| **AMB-14** | Optional Evidence | boot\_or\_verif\_refs | contract container vs evidence field | Optional Evidence is the named contract, while boot\_or\_verif\_refs is one evidence field used when bound verification is active. | Use Optional Evidence for the contract and boot\_or\_verif\_refs for the specific field in the evidence contract. | Keep the container/field distinction explicit. |

Audit Replay Agent
