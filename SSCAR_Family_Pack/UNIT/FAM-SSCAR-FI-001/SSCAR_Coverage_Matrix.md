D3 — SSCAR Coverage Matrix

Final integrated coverage matrix for package version 1.1.0. Coverage is derived from the v1.1.0 D1/D2 canonical semantic index and the SSCAR public release.

# Category Summary

| category | entry\_count |
| --- | --- |
| Identity Terms | 10 |
| Boundary Terms | 6 |
| Control Terms | 18 |
| Contract Terms | 9 |
| Family Verdict Terms | 6 |
| Optionality Terms | 3 |
| Family Decision Terms | 19 |
| Family Validation Terms | 12 |
| State Terms | 12 |
| Family Evidence Terms | 15 |
| Family Observability Terms | 6 |
| Family Conformance Scenarios | 10 |
| Family Acceptance Criteria | 8 |
| Machine-Readable Handoff Terms | 3 |
| Abbreviation Terms | 2 |
| TOTAL | 139 |

# Coverage Matrix

| term\_id | preferred\_label | category | normative\_status | source\_ref\_1 | source\_ref\_2 | source\_ref\_3 | related\_terms\_count | synonyms\_count | non\_synonyms\_count | usage\_constraints\_count | attested\_in\_public\_release |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CTRL-16 | Authority source | Identity Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Authority source |  |  | 4 | 0 | 0 | 0 | YES |
| CTRL-17 | Jurisdiction | Identity Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Jurisdiction |  |  | 3 | 0 | 0 | 0 | YES |
| CTRL-18 | Non-jurisdiction | Identity Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Non-jurisdiction |  |  | 3 | 0 | 0 | 0 | YES |
| ID-01 | Session State Continuity \& Anchor Replay Family Integrator | Identity Terms | normative | SSCAR\_Specification Intro table / Display name | SSCAR\_Specification §1 Operational Objective and Required Control Coverage |  | 4 | 1 | 1 | 1 | YES |
| ID-02 | FAM-SSCAR-FI-001 | Identity Terms | normative | SSCAR\_Specification Intro table / Integrator ID |  |  | 1 | 1 | 0 | 1 | YES |
| ID-03 | Normative-critical family integrator | Identity Terms | normative | SSCAR\_Specification Intro table / Integrator class | SSCAR\_Specification §1.1 Criticality |  | 3 | 1 | 0 | 1 | YES |
| ID-04 | family integrator | Identity Terms | normative | SSCAR\_Specification Intro table / Target unit | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Delegated scope |  | 3 | 0 | 1 | 1 | YES |
| ID-05 | Full-closure mode | Identity Terms | normative | SSCAR\_Specification Intro table / Operating mode | SSCAR\_Specification §2 / Family objective clause |  | 4 | 0 | 0 | 1 | YES |
| ID-06 | Family objective clause | Identity Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Family objective clause |  |  | 4 | 1 | 0 | 0 | YES |
| ID-07 | family verdict | Identity Terms | normative | SSCAR\_Specification §1 Operational Objective and Required Control Coverage | SSCAR\_Specification §4.1 Family verdict vocabulary |  | 4 | 0 | 1 | 1 | YES |
| CTRL-01 | family boundary | Boundary Terms | normative | SSCAR\_Specification §1.2 Family boundary | SSCAR\_Specification §2 / Family boundary clause |  | 4 | 0 | 0 | 1 | YES |
| CTRL-02 | Replay boundary | Boundary Terms | normative | SSCAR\_Specification §3.1 Input contract / FIC-02 FamilyReplayRequest |  |  | 4 | 1 | 0 | 0 | YES |
| CTRL-03 | Hold / readmission boundary | Boundary Terms | normative | SSCAR\_Specification §3.1 Input contract / FIC-03 FamilyReadmissionReview |  |  | 4 | 1 | 0 | 0 | YES |
| CTRL-04 | boundary\_validated\_role | Boundary Terms | normative | SSCAR\_Specification §1.4 Cross-domain operating rules |  |  | 4 | 0 | 0 | 1 | YES |
| CTRL-13 | untrusted input | Boundary Terms | normative | SSCAR\_Specification §1.4 Cross-domain operating rules | SSCAR\_Specification §6 Failure Semantics / UNTRUSTED\_ANCHOR\_PROMOTED |  | 4 | 1 | 0 | 0 | YES |
| ID-08 | boundary event | Boundary Terms | normative | SSCAR\_Specification Intro table / Primary role | SSCAR\_Specification §11 Evidence Contract / FEV-02 boundary\_event\_id |  | 3 | 0 | 0 | 0 | YES |
| CTRL-05 | accepted head | Control Terms | normative | SSCAR\_Specification §1.4 Cross-domain operating rules | SSCAR\_Specification §5 Temporal and Ordering Contract | SSCAR\_Specification §11 Evidence Contract / FEV-07 accepted\_head\_digest / linked\_irr\_digest | 4 | 1 | 1 | 1 | YES |
| CTRL-06 | freshness anchor | Control Terms | normative | SSCAR\_Specification §1.4 Cross-domain operating rules | SSCAR\_Specification §5 Temporal and Ordering Contract | SSCAR\_Specification §7 / FV-06 — Freshness / Anchor Strict Increase | 4 | 2 | 0 | 1 | YES |
| CTRL-07 | verified rehydration | Control Terms | normative | SSCAR\_Specification §1.4 Cross-domain operating rules | SSCAR\_Specification §7 / FV-07 — Verified Rehydration Closure | SSCAR\_Specification §17.3 Stable semantic core | 4 | 1 | 0 | 1 | YES |
| CTRL-08 | semantic replay | Control Terms | normative | SSCAR\_Specification Intro / Mission statement | SSCAR\_Specification §5 Temporal and Ordering Contract |  | 3 | 0 | 0 | 1 | YES |
| CTRL-09 | replay reconstruction | Control Terms | normative | SSCAR\_Specification §1.3 Required control coverage | SSCAR\_Specification §7 / FV-08 — Replay Reconstruction Sufficiency | SSCAR\_Specification §17.3 Stable semantic core | 3 | 1 | 0 | 0 | YES |
| CTRL-10 | contamination | Control Terms | normative | SSCAR\_Specification §1.4 Cross-domain operating rules | SSCAR\_Specification §2 / Fail-closed invariant | SSCAR\_Specification §7 / FV-09 — Contamination Absence | 3 | 0 | 0 | 1 | YES |
| CTRL-11 | anti-rollback | Control Terms | normative | SSCAR\_Specification §1.3 Required control coverage | SSCAR\_Specification §5 Temporal and Ordering Contract | SSCAR\_Specification §7 / FV-07 — Verified Rehydration Closure | 3 | 0 | 0 | 0 | YES |
| CTRL-12 | continuity watermark | Control Terms | normative | SSCAR\_Specification §1.3 Required control coverage | SSCAR\_Specification §7 / FV-06 — Freshness / Anchor Strict Increase |  | 3 | 0 | 0 | 0 | YES |
| CTRL-14 | Read-only startup | Control Terms | normative | SSCAR\_Specification §1.2 Family boundary | SSCAR\_Specification §7 / FV-07 — Verified Rehydration Closure |  | 3 | 0 | 0 | 0 | YES |
| CTRL-19 | Fail-closed invariant | Control Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Fail-closed invariant | SSCAR\_Specification §10 Gate Logic |  | 4 | 0 | 0 | 0 | YES |
| DISCLOSURE\_CLASS\_COLLAPSE | DISCLOSURE\_CLASS\_COLLAPSE | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| FAMILY\_EVIDENCE\_INSUFFICIENT | FAMILY\_EVIDENCE\_INSUFFICIENT | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR | FRESHNESS\_REPLAY\_OR\_STALE\_ANCHOR | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| READMISSION\_WITHOUT\_CLOSURE | READMISSION\_WITHOUT\_CLOSURE | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| REHYDRATION\_PREREQ\_FAIL | REHYDRATION\_PREREQ\_FAIL | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| REPLAY\_RECONSTRUCTION\_INCOMPLETE | REPLAY\_RECONSTRUCTION\_INCOMPLETE | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| UNLABELED\_CARRIED\_MECHANISM\_CLAIM | UNLABELED\_CARRIED\_MECHANISM\_CLAIM | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| UNTRUSTED\_ANCHOR\_PROMOTED | UNTRUSTED\_ANCHOR\_PROMOTED | Control Terms | normative | SSCAR\_Specification §6 Failure Semantics |  |  | 1 | 0 | 0 | 0 | YES |
| CTRL-15 | source\_control\_bundles | Contract Terms | normative | SSCAR\_Specification §3.1 Input contract / FIC-01 FamilyContinuityIntake |  |  | 3 | 0 | 0 | 0 | YES |
| FIC-01 | FIC-01 FamilyContinuityIntake | Contract Terms | normative | SSCAR\_Specification §3.1 Input contract |  |  | 3 | 2 | 0 | 0 | YES |
| FIC-02 | FIC-02 FamilyReplayRequest | Contract Terms | normative | SSCAR\_Specification §3.1 Input contract |  |  | 3 | 2 | 0 | 0 | YES |
| FIC-03 | FIC-03 FamilyReadmissionReview | Contract Terms | normative | SSCAR\_Specification §3.1 Input contract |  |  | 3 | 2 | 0 | 0 | YES |
| FOC-01 | FOC-01 FamilyVerdict | Contract Terms | normative | SSCAR\_Specification §3.2 Output contract |  |  | 3 | 2 | 0 | 0 | YES |
| FOC-02 | FOC-02 BoundaryEventEvidenceReport | Contract Terms | normative | SSCAR\_Specification §3.2 Output contract |  |  | 3 | 2 | 0 | 0 | YES |
| FOC-03 | FOC-03 ReplayAdmissionToken | Contract Terms | normative | SSCAR\_Specification §3.2 Output contract |  |  | 3 | 2 | 0 | 0 | YES |
| FOC-04 | FOC-04 ContaminationIncidentNotice | Contract Terms | normative | SSCAR\_Specification §3.2 Output contract |  |  | 3 | 2 | 0 | 0 | YES |
| FOC-05 | FOC-05 FamilyHoldRecord | Contract Terms | normative | SSCAR\_Specification §3.2 Output contract |  |  | 3 | 2 | 0 | 0 | YES |
| CONTAMINATION\_FAIL\_CLOSED | CONTAMINATION\_FAIL\_CLOSED | Family Verdict Terms | normative | SSCAR\_Specification §4.1 Family verdict vocabulary | SSCAR\_Specification §10 Gate Logic |  | 3 | 0 | 0 | 0 | YES |
| INCIDENT\_ONLY | INCIDENT\_ONLY | Family Verdict Terms | normative | SSCAR\_Specification §4.1 Family verdict vocabulary | SSCAR\_Specification §10 Gate Logic |  | 3 | 0 | 0 | 0 | YES |
| NONCOMPLIANT\_HOLD | NONCOMPLIANT\_HOLD | Family Verdict Terms | normative | SSCAR\_Specification §4.1 Family verdict vocabulary | SSCAR\_Specification §10 Gate Logic |  | 3 | 0 | 0 | 0 | YES |
| REPLAY\_ADMISSIBLE | REPLAY\_ADMISSIBLE | Family Verdict Terms | normative | SSCAR\_Specification §4.1 Family verdict vocabulary | SSCAR\_Specification §10 Gate Logic |  | 3 | 0 | 0 | 0 | YES |
| REPLAY\_ADMISSIBLE\_CONSTRAINED | REPLAY\_ADMISSIBLE\_CONSTRAINED | Family Verdict Terms | normative | SSCAR\_Specification §4.1 Family verdict vocabulary | SSCAR\_Specification §10 Gate Logic |  | 3 | 0 | 0 | 0 | YES |
| REPLAY\_INCOMPLETE | REPLAY\_INCOMPLETE | Family Verdict Terms | normative | SSCAR\_Specification §4.1 Family verdict vocabulary | SSCAR\_Specification §10 Gate Logic |  | 3 | 0 | 0 | 0 | YES |
| BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS | BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS | Optionality Terms | normative | SSCAR\_Specification §4.2 Continuity disclosure classes | SSCAR\_Specification §7 / FV-10 — Disclosure Class Preservation |  | 3 | 0 | 0 | 0 | YES |
| BOUNDED\_HANDOFF\_OBLIGATION | BOUNDED\_HANDOFF\_OBLIGATION | Optionality Terms | normative | SSCAR\_Specification §4.2 Continuity disclosure classes | SSCAR\_Specification §7 / FV-10 — Disclosure Class Preservation |  | 3 | 0 | 0 | 0 | YES |
| TRUE\_DEFECT | TRUE\_DEFECT | Optionality Terms | normative | SSCAR\_Specification §4.2 Continuity disclosure classes | SSCAR\_Specification §7 / FV-10 — Disclosure Class Preservation |  | 3 | 0 | 0 | 0 | YES |
| DEC-01 | carried\_claim\_set\_admissibility | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| DEC-02 | anchor\_document\_boundary\_admissibility | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| DEC-03 | accepted\_anchor\_state | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| DEC-04 | verified\_rehydration\_closure | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| DEC-05 | replay\_continuity\_bundle | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| DEC-06 | contamination\_case | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| DEC-07 | continuity\_disclosure\_class | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| DEC-08 | session\_replay\_admissibility | Family Decision Terms | normative | SSCAR\_Specification §2 Semantic Core, Authority, and Boundary Rules / Primary decision objects | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 0 | 0 | 0 | YES |
| FD-01 | FD-01 — ALLOW\_FAMILY\_SCREENING | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-01A | FD-01A — ALLOW\_FAMILY\_SCREENING | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-02 | FD-02 — CARRIED\_CLAIM\_INADMISSIBLE | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 2 | 2 | 0 | 0 | YES |
| FD-03 | FD-03 — LOCK\_ACCEPTED\_ANCHOR\_STATE | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-04 | FD-04 — ALLOW\_REPLAY\_RECONSTRUCTION | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-05 | FD-05 — REPLAY\_ADMISSIBLE or REPLAY\_ADMISSIBLE\_CONSTRAINED | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-06 | FD-06 — INCIDENT\_ONLY | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-07 | FD-07 — NONCOMPLIANT\_HOLD | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-08 | FD-08 — CONTAMINATION\_FAIL\_CLOSED | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-09 | FD-09 — INCIDENT\_ONLY | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FD-10 | FD-10 — READMISSION\_REVIEW\_GRANTED | Family Decision Terms | normative | SSCAR\_Specification §8 Decision Table |  |  | 1 | 2 | 0 | 0 | YES |
| FV-01 | FV-01 — Required Control Coverage | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-02 | FV-02 — Boundary Input Contract | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-03 | FV-03 — Carried Claim Provenance Admissibility | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-04 | FV-04 — Boundary Role Consistency | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-05 | FV-05 — Accepted Head / IRR Linkage | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-06 | FV-06 — Freshness / Anchor Strict Increase | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-07 | FV-07 — Verified Rehydration Closure | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-08 | FV-08 — Replay Reconstruction Sufficiency | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-09 | FV-09 — Contamination Absence | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-10 | FV-10 — Disclosure Class Preservation | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-11 | FV-11 — Family Evidence Closure | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| FV-12 | FV-12 — Family Readmission Closure | Family Validation Terms | normative | SSCAR\_Specification §7 Validator Catalogue |  |  | 1 | 2 | 0 | 0 | YES |
| S0 | S0 FAMILY\_INTAKE | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S1 | S1 SOURCE\_COVERAGE\_ADMITTED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S2 | S2 BOUNDARY\_SCREENED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S3 | S3 PROVENANCE\_CLASSIFIED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S4 | S4 ANCHOR\_LOCKED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S5 | S5 REHYDRATION\_CLOSED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S6 | S6 REPLAY\_RECONSTRUCTED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S7 | S7 REPORT\_READY | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| S8 | S8 REPLAY\_ADMITTED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| SH | SH NONCOMPLIANT\_HOLD | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| SR | SR READMISSION\_REVIEW | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| SX | SX CONTAMINATION\_FAIL\_CLOSED | State Terms | normative | SSCAR\_Specification §9 Workflow and State Transitions |  |  | 2 | 2 | 0 | 0 | YES |
| FEV-01 | FEV-01 family\_decision\_id | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-02 | FEV-02 boundary\_event\_id | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-03 | FEV-03 session\_id / prior\_session\_ref | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-04 | FEV-04 carried\_statement\_refs | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-05 | FEV-05 tsa\_refs / provenance\_refs | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-06 | FEV-06 anchor\_document\_digest / anchor\_document\_ref | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-07 | FEV-07 accepted\_head\_digest / linked\_irr\_digest | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-08 | FEV-08 freshness\_before / freshness\_after / anchor\_update\_ref | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-09 | FEV-09 rehydration\_closure\_ref | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-10 | FEV-10 replay\_refs / checkpoint\_refs / rollback\_refs | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-11 | FEV-11 disclosure\_class\_entries | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-12 | FEV-12 family\_validator\_outcomes | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-13 | FEV-13 hold\_enter\_refs / hold\_exit\_refs | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-14 | FEV-14 contamination\_flags / contaminating\_ref\_set | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FEV-15 | FEV-15 report\_signature / export\_manifest\_ref | Family Evidence Terms | normative | SSCAR\_Specification §11 Evidence Contract | SSCAR\_Specification Appendix A. Decision-Object Traceability Matrix |  | 3 | 2 | 0 | 0 | YES |
| FOR-01 | FOR-01 Material transition observability | Family Observability Terms | normative | SSCAR\_Specification §13 Observability Rules |  |  | 3 | 1 | 0 | 1 | YES |
| FOR-02 | FOR-02 Verdict requires validator outcomes | Family Observability Terms | normative | SSCAR\_Specification §13 Observability Rules |  |  | 3 | 1 | 0 | 1 | YES |
| FOR-03 | FOR-03 Hold records hold\_enter\_refs | Family Observability Terms | normative | SSCAR\_Specification §13 Observability Rules |  |  | 3 | 1 | 0 | 1 | YES |
| FOR-04 | FOR-04 Readmission records hold\_exit and anchor\_update | Family Observability Terms | normative | SSCAR\_Specification §13 Observability Rules |  |  | 4 | 1 | 0 | 1 | YES |
| FOR-05 | FOR-05 Contamination records contaminating\_ref\_set | Family Observability Terms | normative | SSCAR\_Specification §13 Observability Rules |  |  | 3 | 1 | 0 | 1 | YES |
| FOR-06 | FOR-06 Disclosure entries on gaps and handoffs | Family Observability Terms | normative | SSCAR\_Specification §13 Observability Rules |  |  | 5 | 1 | 0 | 1 | YES |
| SC-01 | SC-01 Required control coverage complete | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 2 | 1 | 0 | 1 | YES |
| SC-02 | SC-02 Carried mechanism-level claim lacks tsa\_label or source\_class | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 4 | 1 | 0 | 1 | YES |
| SC-03 | SC-03 Anchor document treated as trusted | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 4 | 1 | 0 | 1 | YES |
| SC-04 | SC-04 Freshness fail or anchor stagnates | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 4 | 1 | 0 | 1 | YES |
| SC-05 | SC-05 Snapshot mismatch or anti-rollback failure | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 4 | 1 | 0 | 1 | YES |
| SC-06 | SC-06 Replay reconstruction incomplete | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 3 | 1 | 0 | 1 | YES |
| SC-07 | SC-07 Unauthorized tool-state in anchor payload | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 3 | 1 | 0 | 1 | YES |
| SC-08 | SC-08 Family closure complete | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 4 | 1 | 0 | 1 | YES |
| SC-09 | SC-09 Disclosure classes collapsed | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 4 | 1 | 0 | 1 | YES |
| SC-10 | SC-10 Hold case with new evidence and anchor update | Family Conformance Scenarios | normative | SSCAR\_Specification §15.2 Reference scenarios |  |  | 4 | 1 | 0 | 1 | YES |
| AC-01 | AC-01 Control-domain coherence | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria |  |  | 2 | 1 | 0 | 1 | YES |
| AC-02 | AC-02 Continuity-bundle admission | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria |  |  | 2 | 1 | 0 | 1 | YES |
| AC-03 | AC-03 Decision-rule full linkage | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria |  |  | 3 | 1 | 0 | 1 | YES |
| AC-04 | AC-04 State-model verdict and remediation coverage | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria |  |  | 3 | 1 | 0 | 1 | YES |
| AC-05 | AC-05 Offline reconstruction of representative event | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria |  |  | 3 | 1 | 0 | 1 | YES |
| AC-06 | AC-06 Negative-path coverage | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria |  |  | 6 | 1 | 0 | 1 | YES |
| AC-07 | AC-07 No critical unresolved gap | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria |  |  | 3 | 1 | 0 | 1 | YES |
| AC-08 | AC-08 Implementation-owned items separated | Family Acceptance Criteria | normative | SSCAR\_Specification §16 Acceptance Criteria | SSCAR\_Specification §17 Implementation Boundaries, Optional Parameters, and Reuse Rules |  | 3 | 1 | 0 | 1 | YES |
| family\_integrator\_id | family\_integrator\_id | Machine-Readable Handoff Terms | normative | SSCAR\_Specification §12 Machine-Readable Form Catalogue |  |  | 3 | 0 | 0 | 1 | YES |
| blocked\_stage | blocked\_stage | Machine-Readable Handoff Terms | normative | SSCAR\_Specification §12 Machine-Readable Form Catalogue | SSCAR\_Specification §3.2 Output contract / FOC-04 ContaminationIncidentNotice |  | 3 | 0 | 0 | 1 | YES |
| readmission\_case\_id | readmission\_case\_id | Machine-Readable Handoff Terms | normative | SSCAR\_Specification §12 Machine-Readable Form Catalogue |  |  | 4 | 0 | 0 | 1 | YES |
| ABBR-01 | IRR | Abbreviation Terms | normative | SSCAR\_Specification §1.3 Required control coverage | SSCAR\_Specification §1.4 Cross-domain operating rules | SSCAR\_Specification §3.2 Output contract / FOC-03 ReplayAdmissionToken | 3 | 0 | 0 | 0 | YES |
| ABBR-02 | LLM | Abbreviation Terms | normative | SSCAR\_Specification Intro table / Primary role | SSCAR\_Specification Intro table / Mission statement |  | 1 | 0 | 0 | 0 | YES |

# Checkpoint

| verification\_item | status | basis |
| --- | --- | --- |
| Package metadata aligned to v1.1.0 | PASS | package\_version, generation date, and entry\_count updated |
| D1 / D2 / D3 term universe identical | PASS | D1, D2-JSON, D2-YAML, and D3 use the same 139-entry term set |
| All indexed terms textually attested | PASS | source\_refs point to SSCAR\_Specification |
| Decision-object Appendix A linkage complete | PASS | DEC-02 and DEC-06 are covered by Appendix A after SPEC-1 |
| D2-JSON and D2-YAML entry sets identical | PASS | same term\_id order and same entry\_count |
| D2-YAML empty lists explicit | PASS | empty list fields are serialized as \[\] instead of null |
| All non-vocabulary normative items indexed | PASS | FOR-01..06, SC-01..10, AC-01..08 indexed under supplementary categories |
| Machine-readable handoff residue closed | PASS | family\_integrator\_id, blocked\_stage, and readmission\_case\_id indexed under Machine-Readable Handoff Terms |
| D4 ambiguity closure aligned | PASS | AMB-15..17 distinguish verdict tokens used in state and decision-rule labels |
| Execution-neutral open items bounded | PASS | open items remain within §17 implementation boundaries and do not alter the stable semantic core |
| Final category summary total | PASS | Total categories = 15; total entries = 139 |
