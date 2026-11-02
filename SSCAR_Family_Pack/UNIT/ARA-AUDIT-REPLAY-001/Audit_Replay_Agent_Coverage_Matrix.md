D3 — Semantic Coverage Matrix

*Semantic Coverage Matrix (D3)*

*Coverage and attestation matrix for all indexed terms.*

| source\_documents | Audit Replay Agent — Specification |
| --- | --- |
| **authorized\_public\_corpus** | Audit Replay Agent — Specification |
| **entry\_count** | 86 |
| **coverage\_rule** | Every row must remain textually attested in the publishable corpus and traceable to a publishable section. |

# Coverage summary

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

# Matrix

| Category | Preferred label | Term ID | Normative status | Source section(s) | Attested form | Checks |
| --- | --- | --- | --- | --- | --- | --- |
| **Identity Terms** | ARA-AUDIT-REPLAY-001 | ID\_ARA\_AUDIT\_REPLAY\_001 | normative | Audit Replay Agent — Specification title block; Audit Replay Agent — Specification §11 | ARA-AUDIT-REPLAY-001 | attested=true; traceable=true |
| **Identity Terms** | Audit Replay Agent | ID\_AUDIT\_REPLAY\_AGENT | normative | Audit Replay Agent — Specification §1; Audit Replay Agent — Specification §3 | Audit Replay Agent | attested=true; traceable=true |
| **State Terms** | FAIL\_CLOSED | STATE\_FAIL\_CLOSED | normative | Audit Replay Agent — Specification §6.1; Audit Replay Agent — Specification §12; Audit Replay Agent — Specification §15 | FAIL\_CLOSED | attested=true; traceable=true |
| **State Terms** | S0 INGESTED | STATE\_S0\_INGESTED | normative | Audit Replay Agent — Specification §6.1 | S0 INGESTED | attested=true; traceable=true |
| **State Terms** | S1 PARSED | STATE\_S1\_PARSED | normative | Audit Replay Agent — Specification §6.1 | S1 PARSED | attested=true; traceable=true |
| **State Terms** | S2 VERIFIED | STATE\_S2\_VERIFIED | normative | Audit Replay Agent — Specification §6.1 | S2 VERIFIED | attested=true; traceable=true |
| **State Terms** | S3 RECONSTRUCTED | STATE\_S3\_RECONSTRUCTED | normative | Audit Replay Agent — Specification §6.1 | S3 RECONSTRUCTED | attested=true; traceable=true |
| **State Terms** | S4 CHECKPOINT\_RESOLVED | STATE\_S4\_CHECKPOINT\_RESOLVED | normative | Audit Replay Agent — Specification §6.1 | S4 CHECKPOINT\_RESOLVED | attested=true; traceable=true |
| **State Terms** | S5 REPORT\_READY | STATE\_S5\_REPORT\_READY | normative | Audit Replay Agent — Specification §6.1 | S5 REPORT\_READY | attested=true; traceable=true |
| **State Terms** | S6 READMITTED | STATE\_S6\_READMITTED | normative | Audit Replay Agent — Specification §6.1; Audit Replay Agent — Specification §6.2; Audit Replay Agent — Specification §12 | S6 READMITTED | attested=true; traceable=true |
| **State Terms** | SH HOLD\_ACTIVE | STATE\_SH\_HOLD\_ACTIVE | normative | Audit Replay Agent — Specification §6.1 | SH HOLD\_ACTIVE | attested=true; traceable=true |
| **Transition Terms** | EV\_CHAIN\_BREAK | EVENT\_EV\_CHAIN\_BREAK | normative | Audit Replay Agent — Specification §6.2 | EV\_CHAIN\_BREAK | attested=true; traceable=true |
| **Transition Terms** | EV\_COUNTER\_REPLAY | EVENT\_EV\_COUNTER\_REPLAY | normative | Audit Replay Agent — Specification §6.2 | EV\_COUNTER\_REPLAY | attested=true; traceable=true |
| **Transition Terms** | EV\_EVIDENCE\_FAIL | EVENT\_EV\_EVIDENCE\_FAIL | normative | Audit Replay Agent — Specification §6.2 | EV\_EVIDENCE\_FAIL | attested=true; traceable=true |
| **Transition Terms** | EV\_LASTCLEAN\_FOUND | EVENT\_EV\_LASTCLEAN\_FOUND | normative | Audit Replay Agent — Specification §6.2 | EV\_LASTCLEAN\_FOUND | attested=true; traceable=true |
| **Transition Terms** | EV\_PARSE\_OK | EVENT\_EV\_PARSE\_OK | normative | Audit Replay Agent — Specification §6.2 | EV\_PARSE\_OK | attested=true; traceable=true |
| **Transition Terms** | EV\_POLICY\_UNRESOLVED | EVENT\_EV\_POLICY\_UNRESOLVED | normative | Audit Replay Agent — Specification §6.2 | EV\_POLICY\_UNRESOLVED | attested=true; traceable=true |
| **Transition Terms** | EV\_READMISSION\_GRANTED | EVENT\_EV\_READMISSION\_GRANTED | normative | Audit Replay Agent — Specification §6.2 | EV\_READMISSION\_GRANTED | attested=true; traceable=true |
| **Transition Terms** | EV\_REPORT\_BOUND | EVENT\_EV\_REPORT\_BOUND | normative | Audit Replay Agent — Specification §6.2 | EV\_REPORT\_BOUND | attested=true; traceable=true |
| **Transition Terms** | EV\_ROLLBACK\_REPLAYED | EVENT\_EV\_ROLLBACK\_REPLAYED | normative | Audit Replay Agent — Specification §6.2 | EV\_ROLLBACK\_REPLAYED | attested=true; traceable=true |
| **Transition Terms** | EV\_SIGNATURE\_FAIL | EVENT\_EV\_SIGNATURE\_FAIL | normative | Audit Replay Agent — Specification §6.2 | EV\_SIGNATURE\_FAIL | attested=true; traceable=true |
| **Transition Terms** | ROLLBACK | TRANSITION\_ROLLBACK | normative | Audit Replay Agent — Specification §2; Audit Replay Agent — Specification §10; Audit Replay Agent — Specification §14 | ROLLBACK | attested=true; traceable=true |
| **Decision Terms** | Audit report | DEC\_AUDIT\_REPORT | normative | Audit Replay Agent — Specification §5 | Audit report | attested=true; traceable=true |
| **Decision Terms** | BLOCKED | VERDICT\_BLOCKED | normative | Audit Replay Agent — Specification §5; Audit Replay Agent — Specification §9 | BLOCKED | attested=true; traceable=true |
| **Decision Terms** | BROKEN | VERDICT\_BROKEN | normative | Audit Replay Agent — Specification §13 | BROKEN | attested=true; traceable=true |
| **Decision Terms** | CHECKPOINT(LASTCLEAN) | DEC\_CHECKPOINT\_LASTCLEAN | normative | Audit Replay Agent — Specification §5 | CHECKPOINT(LASTCLEAN) | attested=true; traceable=true |
| **Decision Terms** | FINALIZABLE | VERDICT\_FINALIZABLE | normative | Audit Replay Agent — Specification §5; Audit Replay Agent — Specification §9 | FINALIZABLE | attested=true; traceable=true |
| **Decision Terms** | Framed record | DEC\_FRAMED\_RECORD | normative | Audit Replay Agent — Specification §5 | Framed record | attested=true; traceable=true |
| **Decision Terms** | Hash chain continuity | DEC\_HASH\_CHAIN\_CONTINUITY | normative | Audit Replay Agent — Specification §5 | Hash chain continuity | attested=true; traceable=true |
| **Decision Terms** | INCIDENT\_ONLY | VERDICT\_INCIDENT\_ONLY | normative | Audit Replay Agent — Specification §13 | INCIDENT\_ONLY | attested=true; traceable=true |
| **Decision Terms** | Ledger session | DEC\_LEDGER\_SESSION | normative | Audit Replay Agent — Specification §5 | Ledger session | attested=true; traceable=true |
| **Decision Terms** | PARTIAL | VERDICT\_PARTIAL | normative | Audit Replay Agent — Specification §13 | PARTIAL | attested=true; traceable=true |
| **Decision Terms** | REJECTED | VERDICT\_REJECTED | normative | Audit Replay Agent — Specification §13 | REJECTED | attested=true; traceable=true |
| **Decision Terms** | REPLAYABLE | VERDICT\_REPLAYABLE | normative | Audit Replay Agent — Specification §13 | REPLAYABLE | attested=true; traceable=true |
| **Decision Terms** | Rollback sequence | DEC\_ROLLBACK\_SEQUENCE | normative | Audit Replay Agent — Specification §5 | Rollback sequence | attested=true; traceable=true |
| **Validation Terms** | Canonical parse validator | VAL\_V\_03 | normative | Audit Replay Agent — Specification §8 | Canonical parse validator | attested=true; traceable=true |
| **Validation Terms** | Checkpoint lineage validator | VAL\_V\_07 | normative | Audit Replay Agent — Specification §8 | Checkpoint lineage validator | attested=true; traceable=true |
| **Validation Terms** | Checksum validator | VAL\_V\_02 | normative | Audit Replay Agent — Specification §8 | Checksum validator | attested=true; traceable=true |
| **Validation Terms** | Frame length validator | VAL\_V\_01 | normative | Audit Replay Agent — Specification §8 | Frame length validator | attested=true; traceable=true |
| **Validation Terms** | Hash continuity validator | VAL\_V\_05 | normative | Audit Replay Agent — Specification §8 | Hash continuity validator | attested=true; traceable=true |
| **Validation Terms** | Policy bind validator | VAL\_V\_06 | normative | Audit Replay Agent — Specification §8 | Policy bind validator | attested=true; traceable=true |
| **Validation Terms** | Replay counter / freshness validator | VAL\_V\_09 | normative | Audit Replay Agent — Specification §8 | Replay counter / freshness validator | attested=true; traceable=true |
| **Validation Terms** | Report sufficiency validator | VAL\_V\_08 | normative | Audit Replay Agent — Specification §8 | Report sufficiency validator | attested=true; traceable=true |
| **Validation Terms** | Signature validator | VAL\_V\_04 | normative | Audit Replay Agent — Specification §8 | Signature validator | attested=true; traceable=true |
| **Validation Terms** | Tool-state exclusion validator | VAL\_V\_10 | normative | Audit Replay Agent — Specification §8 | Tool-state exclusion validator | attested=true; traceable=true |
| **Evidence Terms** | anchor\_update\_ref | EVID\_ANCHOR\_UPDATE\_REF | normative | Audit Replay Agent — Specification §10 | anchor\_update\_ref | attested=true; traceable=true |
| **Evidence Terms** | Audit Report | CONTRACT\_OUTPUT\_CONTRACT\_OC\_01\_AUDIT\_REPORT | normative | Audit Replay Agent — Specification §7 | Audit Report | attested=true; traceable=true |
| **Evidence Terms** | boot\_or\_verif\_refs | EVID\_BOOT\_OR\_VERIF\_REFS | normative | Audit Replay Agent — Specification §10 | boot\_or\_verif\_refs | attested=true; traceable=true |
| **Evidence Terms** | bundle\_digest | EVID\_BUNDLE\_DIGEST | normative | Audit Replay Agent — Specification §10 | bundle\_digest | attested=true; traceable=true |
| **Evidence Terms** | checkpoint\_refs | EVID\_CHECKPOINT\_REFS | normative | Audit Replay Agent — Specification §10 | checkpoint\_refs | attested=true; traceable=true |
| **Evidence Terms** | hash\_continuity\_refs | EVID\_HASH\_CONTINUITY\_REFS | normative | Audit Replay Agent — Specification §10 | hash\_continuity\_refs | attested=true; traceable=true |
| **Evidence Terms** | hold\_enter\_refs | EVID\_HOLD\_ENTER\_REFS | normative | Audit Replay Agent — Specification §10 | hold\_enter\_refs | attested=true; traceable=true |
| **Evidence Terms** | hold\_exit\_refs | EVID\_HOLD\_EXIT\_REFS | normative | Audit Replay Agent — Specification §10 | hold\_exit\_refs | attested=true; traceable=true |
| **Evidence Terms** | Incident Notice | CONTRACT\_OUTPUT\_CONTRACT\_OC\_03\_INCIDENT\_NOTICE | normative | Audit Replay Agent — Specification §7 | Incident Notice | attested=true; traceable=true |
| **Evidence Terms** | Machine Evidence | CONTRACT\_OUTPUT\_CONTRACT\_OC\_02\_MACHINE\_EVIDENCE | normative | Audit Replay Agent — Specification §7 | Machine Evidence | attested=true; traceable=true |
| **Evidence Terms** | Optional Evidence | CONTRACT\_INPUT\_CONTRACT\_IC\_02\_OPTIONAL\_EVIDENCE | normative | Audit Replay Agent — Specification §7 | Optional Evidence | attested=true; traceable=true |
| **Evidence Terms** | policy\_profile\_id / policy\_hash | EVID\_POLICY\_PROFILE\_ID\_POLICY\_HASH | normative | Audit Replay Agent — Specification §10 | policy\_profile\_id / policy\_hash | attested=true; traceable=true |
| **Evidence Terms** | report\_fields\_ref | EVID\_REPORT\_FIELDS\_REF | normative | Audit Replay Agent — Specification §10 | report\_fields\_ref | attested=true; traceable=true |
| **Evidence Terms** | report\_signature / export\_manifest\_ref | EVID\_REPORT\_SIGNATURE\_EXPORT\_MANIFEST\_REF | normative | Audit Replay Agent — Specification §10 | report\_signature / export\_manifest\_ref | attested=true; traceable=true |
| **Evidence Terms** | rollback\_refs | EVID\_ROLLBACK\_REFS | normative | Audit Replay Agent — Specification §10 | rollback\_refs | attested=true; traceable=true |
| **Evidence Terms** | Session Bundle | CONTRACT\_INPUT\_CONTRACT\_IC\_01\_SESSION\_BUNDLE | normative | Audit Replay Agent — Specification §7 | Session Bundle | attested=true; traceable=true |
| **Evidence Terms** | signature\_refs | EVID\_SIGNATURE\_REFS | normative | Audit Replay Agent — Specification §10 | signature\_refs | attested=true; traceable=true |
| **Evidence Terms** | validator\_outcomes | EVID\_VALIDATOR\_OUTCOMES | normative | Audit Replay Agent — Specification §10 | validator\_outcomes | attested=true; traceable=true |
| **Boundary Terms** | chain of custody | BOUNDARY\_CHAIN\_OF\_CUSTODY | normative | Audit Replay Agent — Specification §1; Audit Replay Agent — Specification §10 | chain of custody | attested=true; traceable=true |
| **Boundary Terms** | freshness anchor | BOUNDARY\_FRESHNESS\_ANCHOR | normative | Audit Replay Agent — Specification §6.1; Audit Replay Agent — Specification §6.2; Audit Replay Agent — Specification §14; Audit Replay Agent — Specification §15 | freshness anchor | attested=true; traceable=true |
| **Boundary Terms** | policy profile | BOUNDARY\_POLICY\_PROFILE | normative | Audit Replay Agent — Specification §3; Audit Replay Agent — Specification §4; Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §10 | policy profile | attested=true; traceable=true |
| **Boundary Terms** | trust store | BOUNDARY\_TRUST\_STORE | normative | Audit Replay Agent — Specification §3; Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §16; Audit Replay Agent — Specification §18 | trust store | attested=true; traceable=true |
| **Boundary Terms** | verification policy | BOUNDARY\_VERIFICATION\_POLICY | normative | Audit Replay Agent — Specification §3; Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §16; Audit Replay Agent — Specification §18 | verification policy | attested=true; traceable=true |
| **Control Terms** | CONSTRAINED | CONTROL\_CONSTRAINED | normative | Audit Replay Agent — Specification §12 | CONSTRAINED | attested=true; traceable=true |
| **Control Terms** | NONCOMPLIANT\_HOLD | CONTROL\_NONCOMPLIANT\_HOLD | normative | Audit Replay Agent — Specification §12 | NONCOMPLIANT\_HOLD | attested=true; traceable=true |
| **Control Terms** | OPEN | CONTROL\_OPEN | normative | Audit Replay Agent — Specification §12 | OPEN | attested=true; traceable=true |
| **Control Terms** | QUARANTINE | CONTROL\_QUARANTINE | normative | Audit Replay Agent — Specification §12 | QUARANTINE | attested=true; traceable=true |
| **Abbreviation Terms** | AXIOM\_SET | ABBR\_AXIOM\_SET | normative | Audit Replay Agent — Specification §10 | AXIOM\_SET | attested=true; traceable=true |
| **Abbreviation Terms** | BAND\_CHANGE | ABBR\_BAND\_CHANGE | normative | Audit Replay Agent — Specification §2 | BAND\_CHANGE | attested=true; traceable=true |
| **Abbreviation Terms** | CPW\_SAMPLE | ABBR\_CPW\_SAMPLE | normative | Audit Replay Agent — Specification §2 | CPW\_SAMPLE | attested=true; traceable=true |
| **Abbreviation Terms** | CSL | ABBR\_CSL | normative | Audit Replay Agent — Specification §2 | CSL | attested=true; traceable=true |
| **Abbreviation Terms** | POLICY\_BIND | ABBR\_POLICY\_BIND | normative | Audit Replay Agent — Specification §10 | POLICY\_BIND | attested=true; traceable=true |
| **Abbreviation Terms** | VERIF\_COUNTER\_ANCHOR | ABBR\_VERIF\_COUNTER\_ANCHOR | normative | Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §18 | VERIF\_COUNTER\_ANCHOR | attested=true; traceable=true |
| **Abbreviation Terms** | VERIF\_EVENT | ABBR\_VERIF\_EVENT | normative | Audit Replay Agent — Specification §7; Audit Replay Agent — Specification §18 | VERIF\_EVENT | attested=true; traceable=true |
| **Abbreviation Terms** | ZSSC | ABBR\_ZSSC | normative | Audit Replay Agent — Specification §2; Audit Replay Agent — Specification §10 | ZSSC | attested=true; traceable=true |
| **Abbreviation Terms** | ZSSC\_ENTER | ABBR\_ZSSC\_ENTER | normative | Audit Replay Agent — Specification §2 | ZSSC\_ENTER | attested=true; traceable=true |
| **Abbreviation Terms** | ZSSC\_EXIT | ABBR\_ZSSC\_EXIT | normative | Audit Replay Agent — Specification §2 | ZSSC\_EXIT | attested=true; traceable=true |
| **Optionality Terms** | Auxiliary indexes / SQLite | OPT\_AUXILIARY\_INDEXES\_SQLITE | implementation\_optional | Audit Replay Agent — Specification §17 | Auxiliary indexes / SQLite | attested=true; traceable=true |
| **Optionality Terms** | NONCOMPLIANT\_HOLD interval in the ledger | OPT\_NONCOMPLIANT\_HOLD\_INTERVAL\_IN\_THE\_LEDGER | implementation\_optional | Audit Replay Agent — Specification §17 | NONCOMPLIANT\_HOLD interval in the ledger | attested=true; traceable=true |
| **Optionality Terms** | Semantic continuity score | OPT\_SEMANTIC\_CONTINUITY\_SCORE | implementation\_optional | Audit Replay Agent — Specification §17 | Semantic continuity score | attested=true; traceable=true |
| **Optionality Terms** | TVC / proof from freshness issuer | OPT\_TVC\_PROOF\_FROM\_FRESHNESS\_ISSUER | implementation\_optional | Audit Replay Agent — Specification §17 | TVC / proof from freshness issuer | attested=true; traceable=true |

Audit Replay Agent
