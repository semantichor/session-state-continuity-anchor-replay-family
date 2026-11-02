D1 — Semantic Index Human Edition

*Semantic Index Human Edition (D1)*

*Canonical semantic index generated from the publishable corpus of the Audit Replay Agent.*

| agent\_name | Audit Replay Agent |
| --- | --- |
| **agent\_version** | unspecified |
| **index\_version** | 2.0 |
| **source\_documents** | Audit Replay Agent — Specification |
| **derivation\_scope** | Restricted to the publishable corpus of the agent specification. |
| **authorized\_public\_corpus** | Audit Replay Agent — Specification |
| **excluded\_sources\_statement** | No non-publishable, confidential, or provenance source was used for lexical derivation or traceability. |
| **entry\_count** | 86 |

**Corpus rule.**  This deliverable is derived only from the publishable public specification. All preferred labels are textually attested in the corpus, and all source\_refs are restricted to publishable sections of that corpus.

# Category distribution

| Category | Entries |
| --- | --- |
| **Identity Terms** | 2 |
| **State Terms** | 9 |
| **Transition Terms** | 11 |
| **Decision Terms** | 13 |
| **Validation Terms** | 10 |
| **Evidence Terms** | 18 |
| **Boundary Terms** | 5 |
| **Control Terms** | 4 |
| **Abbreviation Terms** | 10 |
| **Optionality Terms** | 4 |

# Identity Terms

## ARA-AUDIT-REPLAY-001

| term\_id | ID\_ARA\_AUDIT\_REPLAY\_001 |
| --- | --- |
| **category** | Identity Terms |
| **normative\_status** | normative |
| **definition\_short** | Agent ID assigned to the Audit Replay Agent. |
| **definition\_operational** | Stable identifier that binds the machine-readable and narrative package to the named public agent. |
| **source\_refs** | Audit Replay Agent — Specification title block; Audit Replay Agent — Specification §11 |
| **related\_terms** | Audit Replay Agent |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as the agent\_id value in machine-readable handoff. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Audit Replay Agent

| term\_id | ID\_AUDIT\_REPLAY\_AGENT |
| --- | --- |
| **category** | Identity Terms |
| **normative\_status** | normative |
| **definition\_short** | Canonical audit / replay / verification agent defined by the public specification. |
| **definition\_operational** | Agent identity used for offline reconstruction, continuity verification, and reproduction of rollback sequences for ledger-backed sessions. |
| **source\_refs** | Audit Replay Agent — Specification §1; Audit Replay Agent — Specification §3 |
| **related\_terms** | ARA-AUDIT-REPLAY-001; CSL; ZSSC |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as the display name of the publishable agent, not as a software implementation label. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# State Terms

## FAIL\_CLOSED

| term\_id | STATE\_FAIL\_CLOSED |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | Critical block state in the workflow and gate logic. |
| **definition\_operational** | Critical state entered on signature failure, chain break, canonical parse failure, or invalid policy. Permits only incident output and no positive verdict or compliant finalization. |
| **source\_refs** | Audit Replay Agent — Specification §6.1; Audit Replay Agent — Specification §12; Audit Replay Agent — Specification §15 |
| **related\_terms** | S6 READMITTED; NONCOMPLIANT\_HOLD; INCIDENT\_ONLY; EV\_READMISSION\_GRANTED |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a fail-closed workflow and gate status, not as a positive audit outcome. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## S0 INGESTED

| term\_id | STATE\_S0\_INGESTED |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | Bundle received but not yet validated. |
| **definition\_operational** | Workflow state entered when input contract satisfied. and exited on ev\_parse\_ok or structural failure. |
| **source\_refs** | Audit Replay Agent — Specification §6.1 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a workflow state in the state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## S1 PARSED

| term\_id | STATE\_S1\_PARSED |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | Framing, checksum, and canonical parse are valid. |
| **definition\_operational** | Workflow state entered when v-01 through v-03 pass. and exited on signature, continuity, and policy verification. |
| **source\_refs** | Audit Replay Agent — Specification §6.1 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a workflow state in the state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## S2 VERIFIED

| term\_id | STATE\_S2\_VERIFIED |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | Signatures, hash continuity, policy binding, and freshness anchors are validated to the extent required by policy. |
| **definition\_operational** | Workflow state entered when v-04 through v-06 pass; v-09 passes when policy activates freshness or anchor control. and exited on state reconstruction. |
| **source\_refs** | Audit Replay Agent — Specification §6.1 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a workflow state in the state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## S3 RECONSTRUCTED

| term\_id | STATE\_S3\_RECONSTRUCTED |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | Session state, statement lineage, and record lineage are reconstructed offline. |
| **definition\_operational** | Workflow state entered when replay fold complete. and exited on checkpoint analysis. |
| **source\_refs** | Audit Replay Agent — Specification §6.1 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a workflow state in the state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## S4 CHECKPOINT\_RESOLVED

| term\_id | STATE\_S4\_CHECKPOINT\_RESOLVED |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | LASTCLEAN and rollback lineage are identified and evaluated. |
| **definition\_operational** | Workflow state entered when checkpoint lineage valid. and exited on report assembly or fail-closed / hold. |
| **source\_refs** | Audit Replay Agent — Specification §6.1 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a workflow state in the state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## S5 REPORT\_READY

| term\_id | STATE\_S5\_REPORT\_READY |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | A finalizable report and complete machine-readable export are available. |
| **definition\_operational** | Workflow state entered when evidence sufficiency passes and report sufficiency passes. and exited on emit output. |
| **source\_refs** | Audit Replay Agent — Specification §6.1 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a workflow state in the state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## S6 READMITTED

| term\_id | STATE\_S6\_READMITTED |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | Session state for controlled resumption after restored compliance prerequisites. |
| **definition\_operational** | Readmitted session state permitted only after explicit proof of restored compliance prerequisites, including hold-exit evidence and an updated anchor. |
| **source\_refs** | Audit Replay Agent — Specification §6.1; Audit Replay Agent — Specification §6.2; Audit Replay Agent — Specification §12 |
| **related\_terms** | EV\_READMISSION\_GRANTED; hold\_exit\_refs; anchor\_update\_ref; FAIL\_CLOSED |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only after readmission prerequisites are satisfied. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## SH HOLD\_ACTIVE

| term\_id | STATE\_SH\_HOLD\_ACTIVE |
| --- | --- |
| **category** | State Terms |
| **normative\_status** | normative |
| **definition\_short** | Session is in audit-only mode after evidence failure, missing verification evidence, or counter / anchor replay. |
| **definition\_operational** | Workflow state entered when ev\_evidence\_fail or ev\_counter\_replay. and exited on ev\_readmission\_granted or incident-only closure. |
| **source\_refs** | Audit Replay Agent — Specification §6.1 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as a workflow state in the state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Transition Terms

## EV\_CHAIN\_BREAK

| term\_id | EVENT\_EV\_CHAIN\_BREAK |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | hash\_prev / hash\_curr no longer form a continuous chain. |
| **definition\_operational** | Workflow event. Normative effect: Forces verdict BROKEN and SX FAIL\_CLOSED. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_COUNTER\_REPLAY

| term\_id | EVENT\_EV\_COUNTER\_REPLAY |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | The verification counter or freshness anchor is not strictly increasing. |
| **definition\_operational** | Workflow event. Normative effect: Forces SH HOLD\_ACTIVE and blocks compliant finalization. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_EVIDENCE\_FAIL

| term\_id | EVENT\_EV\_EVIDENCE\_FAIL |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | Required verification evidence is missing, invalid, or not recognized by policy. |
| **definition\_operational** | Workflow event. Normative effect: Forces SH HOLD\_ACTIVE and blocks compliant finalization. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_LASTCLEAN\_FOUND

| term\_id | EVENT\_EV\_LASTCLEAN\_FOUND |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | A usable checkpoint has been identified. |
| **definition\_operational** | Workflow event. Normative effect: Permits S3 -> S4. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_PARSE\_OK

| term\_id | EVENT\_EV\_PARSE\_OK |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | All frames can be read deterministically. |
| **definition\_operational** | Workflow event. Normative effect: Permits S0 -> S1. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_POLICY\_UNRESOLVED

| term\_id | EVENT\_EV\_POLICY\_UNRESOLVED |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | policy\_profile\_id or policy\_hash is not resolvable or not admitted. |
| **definition\_operational** | Workflow event. Normative effect: Blocks compliant finalization and may force SX. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_READMISSION\_GRANTED

| term\_id | EVENT\_EV\_READMISSION\_GRANTED |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | There is explicit proof that compliance prerequisites were restored, including hold-exit evidence, resolvable policy, and a strictly increasing updated anchor. |
| **definition\_operational** | Workflow event. Normative effect: Permits readmission and controlled resumption. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_REPORT\_BOUND

| term\_id | EVENT\_EV\_REPORT\_BOUND |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | The report includes continuity, decisions, checkpoints, limitations, and evidence linkage. |
| **definition\_operational** | Workflow event. Normative effect: Permits S4 -> S5. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_ROLLBACK\_REPLAYED

| term\_id | EVENT\_EV\_ROLLBACK\_REPLAYED |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | A valid rollback chain has been reproduced offline. |
| **definition\_operational** | Workflow event. Normative effect: Supports verdict REPLAYABLE. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## EV\_SIGNATURE\_FAIL

| term\_id | EVENT\_EV\_SIGNATURE\_FAIL |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | A required signature is invalid or missing. |
| **definition\_operational** | Workflow event. Normative effect: Forces SX FAIL\_CLOSED. |
| **source\_refs** | Audit Replay Agent — Specification §6.2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an event in the workflow and state transition model. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## ROLLBACK

| term\_id | TRANSITION\_ROLLBACK |
| --- | --- |
| **category** | Transition Terms |
| **normative\_status** | normative |
| **definition\_short** | Rollback control point and reversion path used in offline replay. |
| **definition\_operational** | Valid only if CHECKPOINT(LASTCLEAN) precedes FAIL\_CLOSED and the checkpoint state\_hash verifies under the applicable verification ruleset. |
| **source\_refs** | Audit Replay Agent — Specification §2; Audit Replay Agent — Specification §10; Audit Replay Agent — Specification §14 |
| **related\_terms** | CHECKPOINT(LASTCLEAN); Rollback sequence; FAIL\_CLOSED; REPLAYABLE |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only for rollback lineage and replay conditions admitted by the specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Decision Terms

## Audit report

| term\_id | DEC\_AUDIT\_REPORT |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Decision object classified as finalization eligibility. |
| **definition\_operational** | Primary decision object in the audit vocabulary. Admitted verdicts: FINALIZABLE │ INCIDENT\_ONLY │ BLOCKED. Primary artifact linkage: Decision Table. |
| **source\_refs** | Audit Replay Agent — Specification §5 |
| **related\_terms** | Decision Table |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the admitted verdict set defined for Audit report in §5. |
| **allowed\_values** | FINALIZABLE; INCIDENT\_ONLY; BLOCKED |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## BLOCKED

| term\_id | VERDICT\_BLOCKED |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Admitted blocking state for compliant finalization or report eligibility. |
| **definition\_operational** | Used where policy binding, report sufficiency, or other critical conditions prevent compliant finalization or prevent a positive report status. |
| **source\_refs** | Audit Replay Agent — Specification §5; Audit Replay Agent — Specification §9 |
| **related\_terms** | Audit report; FAIL\_CLOSED; INCIDENT\_ONLY |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use for blocking outcomes that prevent compliant finalization. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## BROKEN

| term\_id | VERDICT\_BROKEN |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | The integrity chain is not continuous; conclusions about the full history are invalid. |
| **definition\_operational** | Normative verdict meaning from the semantic contract: The integrity chain is not continuous; conclusions about the full history are invalid. |
| **source\_refs** | Audit Replay Agent — Specification §13 |
| **related\_terms** | Ledger session; Hash chain continuity; Rollback sequence; Audit report |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only with the decision object or gate context that admits this verdict. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## CHECKPOINT(LASTCLEAN)

| term\_id | DEC\_CHECKPOINT\_LASTCLEAN |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Decision object classified as checkpoint usability. |
| **definition\_operational** | Primary decision object in the audit vocabulary. Admitted verdicts: USABLE │ STALE │ UNVERIFIED. Primary artifact linkage: Workflow / State Transition. |
| **source\_refs** | Audit Replay Agent — Specification §5 |
| **related\_terms** | Workflow / State Transition |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the admitted verdict set defined for CHECKPOINT(LASTCLEAN) in §5. |
| **allowed\_values** | USABLE; STALE; UNVERIFIED |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## FINALIZABLE

| term\_id | VERDICT\_FINALIZABLE |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Admitted finalization eligibility state for the audit report. |
| **definition\_operational** | Admitted value in the audit report decision-object vocabulary indicating that report finalization is eligible under the decision table and report sufficiency conditions. |
| **source\_refs** | Audit Replay Agent — Specification §5; Audit Replay Agent — Specification §9 |
| **related\_terms** | Audit report; FINALIZE\_REPORT; Report sufficiency validator |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an admitted audit report eligibility value. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Framed record

| term\_id | DEC\_FRAMED\_RECORD |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Decision object classified as record admission. |
| **definition\_operational** | Primary decision object in the audit vocabulary. Admitted verdicts: VALID │ MALFORMED │ UNSUPPORTED. Primary artifact linkage: Validator Catalogue. |
| **source\_refs** | Audit Replay Agent — Specification §5 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the admitted verdict set defined for Framed record in §5. |
| **allowed\_values** | VALID; MALFORMED; UNSUPPORTED |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Hash chain continuity

| term\_id | DEC\_HASH\_CHAIN\_CONTINUITY |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Decision object classified as integrity gate. |
| **definition\_operational** | Primary decision object in the audit vocabulary. Admitted verdicts: CONTIGUOUS │ BROKEN. Primary artifact linkage: Evidence Contract. |
| **source\_refs** | Audit Replay Agent — Specification §5 |
| **related\_terms** | Evidence Contract |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the admitted verdict set defined for Hash chain continuity in §5. |
| **allowed\_values** | CONTIGUOUS; BROKEN |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## INCIDENT\_ONLY

| term\_id | VERDICT\_INCIDENT\_ONLY |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Only incident and remediation artifacts are permitted, not a compliant report. |
| **definition\_operational** | Normative verdict meaning from the semantic contract: Only incident and remediation artifacts are permitted, not a compliant report. |
| **source\_refs** | Audit Replay Agent — Specification §13 |
| **related\_terms** | Ledger session; Hash chain continuity; Rollback sequence; Audit report |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only with the decision object or gate context that admits this verdict. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Ledger session

| term\_id | DEC\_LEDGER\_SESSION |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Decision object classified as admit or reject reconstruction. |
| **definition\_operational** | Primary decision object in the audit vocabulary. Admitted verdicts: RECONSTRUCTABLE │ PARTIAL │ REJECTED. Primary artifact linkage: REPORT. |
| **source\_refs** | Audit Replay Agent — Specification §5 |
| **related\_terms** | REPORT |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the admitted verdict set defined for Ledger session in §5. |
| **allowed\_values** | RECONSTRUCTABLE; PARTIAL; REJECTED |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## PARTIAL

| term\_id | VERDICT\_PARTIAL |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Some artifacts can be reconstructed, but closure is missing for at least one critical decision object. |
| **definition\_operational** | Normative verdict meaning from the semantic contract: Some artifacts can be reconstructed, but closure is missing for at least one critical decision object. |
| **source\_refs** | Audit Replay Agent — Specification §13 |
| **related\_terms** | Ledger session; Hash chain continuity; Rollback sequence; Audit report |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only with the decision object or gate context that admits this verdict. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## REJECTED

| term\_id | VERDICT\_REJECTED |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | The input cannot support admissible reconstruction; no compliance output may be issued. |
| **definition\_operational** | Normative verdict meaning from the semantic contract: The input cannot support admissible reconstruction; no compliance output may be issued. |
| **source\_refs** | Audit Replay Agent — Specification §13 |
| **related\_terms** | Ledger session; Hash chain continuity; Rollback sequence; Audit report |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only with the decision object or gate context that admits this verdict. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## REPLAYABLE

| term\_id | VERDICT\_REPLAYABLE |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | The session can be reconstructed offline with a decision path, continuity, and rollback lineage sufficient for independent audit. |
| **definition\_operational** | Normative verdict meaning from the semantic contract: The session can be reconstructed offline with a decision path, continuity, and rollback lineage sufficient for independent audit. |
| **source\_refs** | Audit Replay Agent — Specification §13 |
| **related\_terms** | Ledger session; Hash chain continuity; Rollback sequence; Audit report |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only with the decision object or gate context that admits this verdict. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Rollback sequence

| term\_id | DEC\_ROLLBACK\_SEQUENCE |
| --- | --- |
| **category** | Decision Terms |
| **normative\_status** | normative |
| **definition\_short** | Decision object classified as rollback correctness. |
| **definition\_operational** | Primary decision object in the audit vocabulary. Admitted verdicts: REPLAYABLE │ INCOMPLETE │ INVALID. Primary artifact linkage: Gate Logic. |
| **source\_refs** | Audit Replay Agent — Specification §5 |
| **related\_terms** | Gate Logic |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the admitted verdict set defined for Rollback sequence in §5. |
| **allowed\_values** | REPLAYABLE; INCOMPLETE; INVALID |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Validation Terms

## Canonical parse validator

| term\_id | VAL\_V\_03 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Structural validator. |
| **definition\_operational** | Canonical parse validator (V-03). Pass condition: The canonical serialization can be parsed without ambiguity. Fail effect: Record UNSUPPORTED or MALFORMED; block. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-03 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Checkpoint lineage validator

| term\_id | VAL\_V\_07 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Behavioral validator. |
| **definition\_operational** | Checkpoint lineage validator (V-07). Pass condition: LASTCLEAN precedes FAIL\_CLOSED and its state\_hash is verifiable. Fail effect: Rollback INVALID. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-07 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Checksum validator

| term\_id | VAL\_V\_02 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Structural validator. |
| **definition\_operational** | Checksum validator (V-02). Pass condition: The checksum over the canonical bytes is correct. Fail effect: Record MALFORMED; block. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-02 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Frame length validator

| term\_id | VAL\_V\_01 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Structural validator. |
| **definition\_operational** | Frame length validator (V-01). Pass condition: The declared length matches the available bytes. Fail effect: Record MALFORMED; block. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-01 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Hash continuity validator

| term\_id | VAL\_V\_05 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Evidence validator. |
| **definition\_operational** | Hash continuity validator (V-05). Pass condition: hash\_prev and hash\_curr form a continuous chain. Fail effect: Verdict BROKEN; FAIL\_CLOSED. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-05 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Policy bind validator

| term\_id | VAL\_V\_06 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Boundary validator. |
| **definition\_operational** | Policy bind validator (V-06). Pass condition: policy\_profile\_id and policy\_hash are resolvable and admitted. Fail effect: BLOCKED. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-06 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Replay counter / freshness validator

| term\_id | VAL\_V\_09 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Ordering validator. |
| **definition\_operational** | Replay counter / freshness validator (V-09). Pass condition: The counter or anchor is strictly increasing under policy. Fail effect: NONCOMPLIANT\_HOLD / block. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-09 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Report sufficiency validator

| term\_id | VAL\_V\_08 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Evidence validator. |
| **definition\_operational** | Report sufficiency validator (V-08). Pass condition: The report includes decisions, checkpoints, continuity, and limitations. Fail effect: FINALIZE\_REPORT blocked. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-08 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Signature validator

| term\_id | VAL\_V\_04 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Evidence validator. |
| **definition\_operational** | Signature validator (V-04). Pass condition: All required signatures are valid under the current policy. Fail effect: FAIL\_CLOSED. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-04 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Tool-state exclusion validator

| term\_id | VAL\_V\_10 |
| --- | --- |
| **category** | Validation Terms |
| **normative\_status** | normative |
| **definition\_short** | Operational validator. |
| **definition\_operational** | Tool-state exclusion validator (V-10). Pass condition: No unauthorized tool-state artifact enters logical reconstruction. Fail effect: QUARANTINE. |
| **source\_refs** | Audit Replay Agent — Specification §8 |
| **related\_terms** | — |
| **synonyms** | V-10 |
| **non\_synonyms** | — |
| **usage\_constraints** | Use with the exact pass condition and fail effect defined in the validator catalogue. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Evidence Terms

## anchor\_update\_ref

| term\_id | EVID\_ANCHOR\_UPDATE\_REF |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves strict increase after a hold. |
| **definition\_operational** | Evidence-contract field. Required status: Yes for readmission and counter-sensitive profiles. Purpose: Proves strict increase after a hold. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Audit Report

| term\_id | CONTRACT\_OUTPUT\_CONTRACT\_OC\_01\_AUDIT\_REPORT |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Contracted package with required fields: report\_id; session\_id; verdict; continuity summary; checkpoints; rollback refs; limitations; signature / export refs |
| **definition\_operational** | Contract rule: Must be sufficient for offline audit. |
| **source\_refs** | Audit Replay Agent — Specification §7 |
| **related\_terms** | — |
| **synonyms** | Output Contract OC-01 Audit Report |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an input or output contract exactly as listed in §7. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## boot\_or\_verif\_refs

| term\_id | EVID\_BOOT\_OR\_VERIF\_REFS |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Links the verdict to the external evidence chain when policy requires it. |
| **definition\_operational** | Evidence-contract field. Required status: Yes when policy activates bound verification. Purpose: Links the verdict to the external evidence chain when policy requires it. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## bundle\_digest

| term\_id | EVID\_BUNDLE\_DIGEST |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Binds the verdict to the exact input bundle. |
| **definition\_operational** | Evidence-contract field. Required status: Yes. Purpose: Binds the verdict to the exact input bundle. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## checkpoint\_refs

| term\_id | EVID\_CHECKPOINT\_REFS |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves the clean state used for replay. |
| **definition\_operational** | Evidence-contract field. Required status: Yes for checkpoint, rollback, or replay verdicts. Purpose: Proves the clean state used for replay. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## hash\_continuity\_refs

| term\_id | EVID\_HASH\_CONTINUITY\_REFS |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves append-only history and reconstructable ordering. |
| **definition\_operational** | Evidence-contract field. Required status: Yes. Purpose: Proves append-only history and reconstructable ordering. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## hold\_enter\_refs

| term\_id | EVID\_HOLD\_ENTER\_REFS |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves entry into audit-only mode. |
| **definition\_operational** | Evidence-contract field. Required status: Yes when NONCOMPLIANT\_HOLD exists. Purpose: Proves entry into audit-only mode. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## hold\_exit\_refs

| term\_id | EVID\_HOLD\_EXIT\_REFS |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves restoration of compliance prerequisites. |
| **definition\_operational** | Evidence-contract field. Required status: Yes for readmission. Purpose: Proves restoration of compliance prerequisites. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Incident Notice

| term\_id | CONTRACT\_OUTPUT\_CONTRACT\_OC\_03\_INCIDENT\_NOTICE |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Contracted package with required fields: reason\_code; blocked\_stage; inhibitions; required\_remediation |
| **definition\_operational** | Contract rule: The only permitted output in FAIL\_CLOSED. |
| **source\_refs** | Audit Replay Agent — Specification §7 |
| **related\_terms** | — |
| **synonyms** | Output Contract OC-03 Incident Notice |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an input or output contract exactly as listed in §7. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Machine Evidence

| term\_id | CONTRACT\_OUTPUT\_CONTRACT\_OC\_02\_MACHINE\_EVIDENCE |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Contracted package with required fields: Normalized JSON verdict; validator outcomes; record anomalies; graph of refs |
| **definition\_operational** | Contract rule: No long-form narrative is required for the execution consumer. |
| **source\_refs** | Audit Replay Agent — Specification §7 |
| **related\_terms** | — |
| **synonyms** | Output Contract OC-02 Machine Evidence |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an input or output contract exactly as listed in §7. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Optional Evidence

| term\_id | CONTRACT\_INPUT\_CONTRACT\_IC\_02\_OPTIONAL\_EVIDENCE |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Contracted package with required fields: BOOT\_\* refs; VERIF\_EVENT; VERIF\_COUNTER\_ANCHOR; export manifest; trust-store refs |
| **definition\_operational** | Contract rule: Mandatory when policy requires bound verification. |
| **source\_refs** | Audit Replay Agent — Specification §7 |
| **related\_terms** | — |
| **synonyms** | Input Contract IC-02 Optional Evidence |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an input or output contract exactly as listed in §7. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## policy\_profile\_id / policy\_hash

| term\_id | EVID\_POLICY\_PROFILE\_ID\_POLICY\_HASH |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Fixes the governing policy under which the verdict is issued. |
| **definition\_operational** | Evidence-contract field. Required status: Yes. Purpose: Fixes the governing policy under which the verdict is issued. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## report\_fields\_ref

| term\_id | EVID\_REPORT\_FIELDS\_REF |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves minimum report completeness. |
| **definition\_operational** | Evidence-contract field. Required status: Yes for FINALIZE\_REPORT. Purpose: Proves minimum report completeness. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## report\_signature / export\_manifest\_ref

| term\_id | EVID\_REPORT\_SIGNATURE\_EXPORT\_MANIFEST\_REF |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves export integrity and chain of custody. |
| **definition\_operational** | Evidence-contract field. Required status: Yes for final output. Purpose: Proves export integrity and chain of custody. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## rollback\_refs

| term\_id | EVID\_ROLLBACK\_REFS |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves the reversion path. |
| **definition\_operational** | Evidence-contract field. Required status: Yes for verdict REPLAYABLE. Purpose: Proves the reversion path. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Session Bundle

| term\_id | CONTRACT\_INPUT\_CONTRACT\_IC\_01\_SESSION\_BUNDLE |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Contracted package with required fields: ledger\_uuid; session\_id; record stream; policy\_profile\_id; source\_id; hash head / tail; signature refs |
| **definition\_operational** | Contract rule: Without these fields the agent does not enter replay logic. |
| **source\_refs** | Audit Replay Agent — Specification §7 |
| **related\_terms** | — |
| **synonyms** | Input Contract IC-01 Session Bundle |
| **non\_synonyms** | — |
| **usage\_constraints** | Use as an input or output contract exactly as listed in §7. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## signature\_refs

| term\_id | EVID\_SIGNATURE\_REFS |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Proves authenticity and provenance where signatures are policy-required. |
| **definition\_operational** | Evidence-contract field. Required status: Yes when policy requires signatures. Purpose: Proves authenticity and provenance where signatures are policy-required. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## validator\_outcomes

| term\_id | EVID\_VALIDATOR\_OUTCOMES |
| --- | --- |
| **category** | Evidence Terms |
| **normative\_status** | normative |
| **definition\_short** | Allows the consumer to replay admissibility and blocking decisions. |
| **definition\_operational** | Evidence-contract field. Required status: Yes. Purpose: Allows the consumer to replay admissibility and blocking decisions. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a field in the minimum evidence set for offline reconstruction and audit. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Boundary Terms

## chain of custody

| term\_id | BOUNDARY\_CHAIN\_OF\_CUSTODY |
| --- | --- |
| **category** | Boundary Terms |
| **normative\_status** | normative |
| **definition\_short** | Export integrity requirement for auditable output. |
| **definition\_operational** | Audit export must preserve chain of custody through exporter identity, covered interval, hashes, CSL head, governing policy, and evidence references used. |
| **source\_refs** | Audit Replay Agent — Specification §1; Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in the public operational sense defined by the specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## freshness anchor

| term\_id | BOUNDARY\_FRESHNESS\_ANCHOR |
| --- | --- |
| **category** | Boundary Terms |
| **normative\_status** | normative |
| **definition\_short** | Ordering anchor used in policy-sensitive replay and readmission control. |
| **definition\_operational** | Freshness or anchor values must be strictly increasing under policy; replay or non-increase enters NONCOMPLIANT\_HOLD and blocks compliant finalization until restored prerequisites are proven. |
| **source\_refs** | Audit Replay Agent — Specification §6.1; Audit Replay Agent — Specification §6.2; Audit Replay Agent — Specification §14; Audit Replay Agent — Specification §15 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in the public operational sense defined by the specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## policy profile

| term\_id | BOUNDARY\_POLICY\_PROFILE |
| --- | --- |
| **category** | Boundary Terms |
| **normative\_status** | normative |
| **definition\_short** | Active governing profile used for authority, validation, and policy binding. |
| **definition\_operational** | Authority source and input element that fixes the governing policy under which the audit is executed and the verdict is issued. |
| **source\_refs** | Audit Replay Agent — Specification §3; Audit Replay Agent — Specification §4; Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in the public operational sense defined by the specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## trust store

| term\_id | BOUNDARY\_TRUST\_STORE |
| --- | --- |
| **category** | Boundary Terms |
| **normative\_status** | normative |
| **definition\_short** | Verification trust input admitted by the specification. |
| **definition\_operational** | Input element used together with a compatible policy to validate signatures or verification prerequisites where policy requires it. |
| **source\_refs** | Audit Replay Agent — Specification §3; Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §16; Audit Replay Agent — Specification §18 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in the public operational sense defined by the specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## verification policy

| term\_id | BOUNDARY\_VERIFICATION\_POLICY |
| --- | --- |
| **category** | Boundary Terms |
| **normative\_status** | normative |
| **definition\_short** | Policy-based verification input admitted by the specification. |
| **definition\_operational** | Alternative or companion verification control used in inputs, assumptions, and observability surfaces for signature and evidence validation. |
| **source\_refs** | Audit Replay Agent — Specification §3; Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §16; Audit Replay Agent — Specification §18 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in the public operational sense defined by the specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Control Terms

## CONSTRAINED

| term\_id | CONTROL\_CONSTRAINED |
| --- | --- |
| **category** | Control Terms |
| **normative\_status** | normative |
| **definition\_short** | Partial reconstruction is possible but critical insufficiency is absent. |
| **definition\_operational** | Gate status with permitted actions: Partial report; anomaly export. Prohibited actions: Final verdict REPLAYABLE. |
| **source\_refs** | Audit Replay Agent — Specification §12 |
| **related\_terms** | FAIL\_CLOSED; Audit report; Machine Evidence |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in gate logic and control-state reasoning. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## NONCOMPLIANT\_HOLD

| term\_id | CONTROL\_NONCOMPLIANT\_HOLD |
| --- | --- |
| **category** | Control Terms |
| **normative\_status** | normative |
| **definition\_short** | evidence\_ok = false or freshness replay detected. |
| **definition\_operational** | Gate status with permitted actions: Audit-only mode; incident report. Prohibited actions: Checkpoint or report compliant finalization. |
| **source\_refs** | Audit Replay Agent — Specification §12 |
| **related\_terms** | FAIL\_CLOSED; Audit report; Machine Evidence |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in gate logic and control-state reasoning. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## OPEN

| term\_id | CONTROL\_OPEN |
| --- | --- |
| **category** | Control Terms |
| **normative\_status** | normative |
| **definition\_short** | Structural and evidence validators have passed. |
| **definition\_operational** | Gate status with permitted actions: Reconstruction; checkpoint analysis; report assembly. Prohibited actions: None beyond policy. |
| **source\_refs** | Audit Replay Agent — Specification §12 |
| **related\_terms** | FAIL\_CLOSED; Audit report; Machine Evidence |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in gate logic and control-state reasoning. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## QUARANTINE

| term\_id | CONTROL\_QUARANTINE |
| --- | --- |
| **category** | Control Terms |
| **normative\_status** | normative |
| **definition\_short** | Unauthorized tool-state or auxiliary artifact detected. |
| **definition\_operational** | Gate status with permitted actions: Isolated audit; incident export. Prohibited actions: Injection into the replay core. |
| **source\_refs** | Audit Replay Agent — Specification §12 |
| **related\_terms** | FAIL\_CLOSED; Audit report; Machine Evidence |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only in gate logic and control-state reasoning. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Abbreviation Terms

## AXIOM\_SET

| term\_id | ABBR\_AXIOM\_SET |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | Named report element referenced for ZSSC-bound sessions. |
| **definition\_operational** | ZSSC-bound final reports must be able to include or explicitly reference AXIOM\_SET as part of the required report content. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## BAND\_CHANGE

| term\_id | ABBR\_BAND\_CHANGE |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | ZSSC control point listed by the specification. |
| **definition\_operational** | Named auditable governance record or control point supplied by ZSSC and admitted by the public specification. |
| **source\_refs** | Audit Replay Agent — Specification §2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## CPW\_SAMPLE

| term\_id | ABBR\_CPW\_SAMPLE |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | ZSSC control point listed by the specification. |
| **definition\_operational** | Named auditable governance record or control point supplied by ZSSC and admitted by the public specification. |
| **source\_refs** | Audit Replay Agent — Specification §2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## CSL

| term\_id | ABBR\_CSL |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | Foundational model that provides framed record encoding and continuity-related record semantics. |
| **definition\_operational** | Public operational concept used by the specification for framed record encoding, checksum validation, canonical parsing, append-only hash-chain continuity, fail-closed restoration discipline, tool-state restrictions, and auditable export semantics. |
| **source\_refs** | Audit Replay Agent — Specification §2 |
| **related\_terms** | Framed record; Hash chain continuity; chain of custody |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as a foundational model already assumed by the public specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## POLICY\_BIND

| term\_id | ABBR\_POLICY\_BIND |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | Named report element referenced for ZSSC-bound sessions. |
| **definition\_operational** | ZSSC-bound final reports must be able to include or explicitly reference POLICY\_BIND in the required report content. |
| **source\_refs** | Audit Replay Agent — Specification §10 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## VERIF\_COUNTER\_ANCHOR

| term\_id | ABBR\_VERIF\_COUNTER\_ANCHOR |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | Optional evidence or input reference used for counter or anchor verification. |
| **definition\_operational** | Named verification reference admitted as optional evidence and input-surface content when policy activates bound verification or counter-sensitive ordering. |
| **source\_refs** | Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §18 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## VERIF\_EVENT

| term\_id | ABBR\_VERIF\_EVENT |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | Optional evidence or input reference used when policy requires bound verification. |
| **definition\_operational** | Named verification reference admitted as optional evidence and input-surface content when bound verification is activated by policy. |
| **source\_refs** | Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §18 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## ZSSC

| term\_id | ABBR\_ZSSC |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | Foundational model that provides auditable governance records and control points. |
| **definition\_operational** | Public operational concept used for governance records and control points such as ZSSC\_ENTER, ZSSC\_EXIT, CPW\_SAMPLE, BAND\_CHANGE, CHECKPOINT(LASTCLEAN), ROLLBACK, FAIL\_CLOSED, and REPORT. |
| **source\_refs** | Audit Replay Agent — Specification §2; Audit Replay Agent — Specification §10 |
| **related\_terms** | ZSSC\_ENTER; ZSSC\_EXIT; CPW\_SAMPLE; BAND\_CHANGE; CHECKPOINT(LASTCLEAN); ROLLBACK; FAIL\_CLOSED; Audit report |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only for records and control points explicitly admitted by the specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## ZSSC\_ENTER

| term\_id | ABBR\_ZSSC\_ENTER |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | ZSSC governance record listed by the specification. |
| **definition\_operational** | Named auditable governance record or control point supplied by ZSSC and admitted by the public specification. |
| **source\_refs** | Audit Replay Agent — Specification §2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## ZSSC\_EXIT

| term\_id | ABBR\_ZSSC\_EXIT |
| --- | --- |
| **category** | Abbreviation Terms |
| **normative\_status** | normative |
| **definition\_short** | ZSSC governance record listed by the specification. |
| **definition\_operational** | Named auditable governance record or control point supplied by ZSSC and admitted by the public specification. |
| **source\_refs** | Audit Replay Agent — Specification §2 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only as an attested abbreviation or named control point from the publishable specification. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

# Optionality Terms

## Auxiliary indexes / SQLite

| term\_id | OPT\_AUXILIARY\_INDEXES\_SQLITE |
| --- | --- |
| **category** | Optionality Terms |
| **normative\_status** | implementation\_optional |
| **definition\_short** | Implementation optional. |
| **definition\_operational** | Optionality rule: They must not become the source of truth for admission or audit. |
| **source\_refs** | Audit Replay Agent — Specification §17 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only under the optionality rule stated in §17. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## NONCOMPLIANT\_HOLD interval in the ledger

| term\_id | OPT\_NONCOMPLIANT\_HOLD\_INTERVAL\_IN\_THE\_LEDGER |
| --- | --- |
| **category** | Optionality Terms |
| **normative\_status** | implementation\_optional |
| **definition\_short** | Schema optional. |
| **definition\_operational** | Optionality rule: Recommended when FAIL\_CLOSED is related to evidence failure. |
| **source\_refs** | Audit Replay Agent — Specification §17 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only under the optionality rule stated in §17. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## Semantic continuity score

| term\_id | OPT\_SEMANTIC\_CONTINUITY\_SCORE |
| --- | --- |
| **category** | Optionality Terms |
| **normative\_status** | implementation\_optional |
| **definition\_short** | Controlled optional. |
| **definition\_operational** | Optionality rule: Use only when policy activates it; it does not replace constitutive verification. |
| **source\_refs** | Audit Replay Agent — Specification §17 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only under the optionality rule stated in §17. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

## TVC / proof from freshness issuer

| term\_id | OPT\_TVC\_PROOF\_FROM\_FRESHNESS\_ISSUER |
| --- | --- |
| **category** | Optionality Terms |
| **normative\_status** | implementation\_optional |
| **definition\_short** | Conditional optional. |
| **definition\_operational** | Optionality rule: Mandatory only when required by the acceptance policy. |
| **source\_refs** | Audit Replay Agent — Specification §17 |
| **related\_terms** | — |
| **synonyms** | — |
| **non\_synonyms** | — |
| **usage\_constraints** | Use only under the optionality rule stated in §17. |
| **allowed\_values** | — |
| **ambiguities** | — |
| **examples** | — |
| **term\_attested\_in\_spec** | true |
| **public\_traceable** | true |

Audit Replay Agent
