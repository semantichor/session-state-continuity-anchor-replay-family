D4 — Ambiguity Register

Freshness Portability Agent \| Lexical and role clarifications

This register resolves ambiguity records, rejected collapses, and role distinctions using only the indexed public vocabulary.

| Authorized public corpus | Freshness\_Portability\_Agent\_Specification |
| --- | --- |
| **Ambiguity records** | 12 |

| ID | Terms at issue | Register type | Allowed interpretation | Disallowed collapse | Controlling source |
| --- | --- | --- | --- | --- | --- |
| AMB-001 | RESTORATION\_ELIGIBLE | duplicate label | Treat as a semantic verdict only when the context is §6, §13, or §14 and the path emits ISSUE\_RESTORE\_ADMISSION\_TOKEN. | Do not collapse the verdict with state S6 of the same label. | §8; §14 |
| AMB-002 | QUARANTINE / QUARANTINED / Quarantine case / QuarantineCaseRecord | near-identity cluster | Use QUARANTINE for the verdict, QUARANTINED for state S7, Quarantine case for the suspended case concept, and QuarantineCaseRecord for the output record. | Do not substitute one layer for another. | §3; §8; §10; §14 |
| AMB-003 | REJECT / FAIL\_CLOSED | close outcomes | Use REJECT when the packet is rejected as stale or invalid on the current packet path; use FAIL\_CLOSED when blocked effect is the governing semantic outcome. | Do not treat FAIL\_CLOSED as a synonym of REJECT. | §6; §14; §16 |
| AMB-004 | Import Receipt Record (IRR) / IRRAppendRequest / AcceptanceReceiptRecord | artifact lineage | Use IRR for the append-only receipt concept, IRRAppendRequest for the emitted append request, and AcceptanceReceiptRecord for the machine-readable form. | Do not merge the concept, the request, and the form into one label. | §3; §10; §12 |
| AMB-005 | RestoreRequest / restoration request | boundary object vs lexical variant | Use RestoreRequest as the boundary contract and restoration request as the decision-object wording on the restore path. | Do not infer a second restore artifact when the concept is the same request path. | §4; §6; §9 |
| AMB-006 | readmit\_quarantine / READMIT / READMISSION / ReadmissionDecisionRecord | readmission stack | Use readmit\_quarantine for the decision object, READMIT for the verdict, READMISSION for the gate class, and ReadmissionDecisionRecord for the machine-readable form. | Do not flatten decision, verdict, gate class, and record into one term. | §6; §12; §13; §14 |
| AMB-007 | TVC / Evidence.bin | optional artifacts | Treat both as optional by default and mandatory only when required by the active policy. | Do not assume either artifact is always mandatory. | §3; §19 |
| AMB-008 | source\_id / ledger\_uuid | identity pair | Use source\_id as the stable source identity and ledger\_uuid as the bound ledger identity. | Do not swap source scope with ledger identity. | §3; §11 |
| AMB-009 | packet\_hash / head\_digest / accepted\_head\_digest / linked\_irr\_digest | digest family | Use packet\_hash for the transferred packet, head\_digest for TransferPacket, accepted\_head\_digest for accepted-head linkage, and linked\_irr\_digest for restore-admission linkage. | Do not reuse one digest label across all digest roles. | §9; §10; §11; §12 |
| AMB-010 | semantic\_verdict / GateVerdict / gate\_class / decision\_object | decision record fields | GateVerdict is the output record. semantic\_verdict, gate\_class, and decision\_object are fields or dimensions carried by the record. | Do not treat record name and embedded fields as interchangeable. | §10; §11 |
| AMB-011 | freshness\_value / freshness\_new / watermark\[source\_id\] / watermark\_stored | freshness comparison cluster | Use freshness\_value for the evidence field, freshness\_new for the compared incoming value, and watermark\[source\_id\] or watermark\_stored for the stored reference used by the comparator. | Do not compress the incoming and stored sides of the monotonic comparison into one variable. | §2.1; §6; §7; §11 |
| AMB-012 | Tool-state approval path / BLOCK\_TOOL\_STATE | authority edge | Use Tool-state approval path for the optionality item outside agent authority and BLOCK\_TOOL\_STATE for the blocking action applied when the boundary is violated. | Do not infer that freshness acceptance authorizes tool-state activation. | §7; §13; §19 |

| Package checkpoint | Status |
| --- | --- |
| D1 present | PASS |
| D2-YAML present | PASS |
| D2-JSON present | PASS |
| D3 present | PASS |
| D4 present | PASS |
| D1 and D2 aligned on indexed labels | PASS |
| All entries trace to the authorized public corpus | PASS |
| All entries are textually attested in the public specification | PASS |
| Package cross-linked by term\_id and preferred\_label | PASS |
