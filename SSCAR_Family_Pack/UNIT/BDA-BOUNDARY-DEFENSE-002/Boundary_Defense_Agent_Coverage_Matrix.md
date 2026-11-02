D3 — Semantic Coverage Matrix

*Matrix linking indexed terms and categories to publishable sections of the authorized corpus*

| Agent | Boundary Defense Agent |
| --- | --- |
| **Corpus** | Boundary Defense Agent — Specification (Public Release v2.0) |
| **Indexed terms** | 106 |
| **Section codes** | 21 |

# Section legend

| Code | Publishable section |
| --- | --- |
| PR-OD | Operational Definitions |
| PR-SCS | Semantic Core Summary |
| PR-ASR | Agent Specification Record |
| PR-AAR | Agent Authority Record |
| PR-ICR | Input Contract Record Set |
| PR-OCR | Output Contract Record Set |
| PR-DTR | Decision Table Record |
| PR-VC | Validator Catalogue |
| PR-WF | Workflow / State-Transition Record |
| PR-GL | Gate Logic Record |
| PR-ECR | Evidence Contract Record |
| PR-MFC | Machine-Readable Form Catalogue |
| PR-SCR | Semantic Contract Record |
| PR-TOC | Temporal / Ordering Contract |
| PR-FSR | Failure Semantics Record |
| PR-AOC | Assumption-to-Obligation Closure |
| PR-IAC | Implementation Acceptance Criteria |
| PR-OR | Optionality Register |
| PR-AP | Assurance Profile |
| PR-VR | Validation Requirements |
| PR-RIN | Reuse and Implementation Note |

# Category coverage summary

| Category | Entries | Source section codes represented |
| --- | --- | --- |
| Identity Terms | 3 | PR-AP, PR-ASR, PR-OD, PR-SCS |
| Boundary Terms | 6 | PR-ASR, PR-ECR, PR-OD, PR-SCS, PR-TOC |
| Control Terms | 9 | PR-AAR, PR-AOC, PR-AP, PR-ASR, PR-DTR, PR-ECR, PR-FSR, PR-ICR, PR-OD, PR-RIN, PR-TOC, PR-VC, PR-WF |
| Abbreviation Terms | 2 | PR-ASR, PR-OD, PR-OR, PR-SCS, PR-VC |
| State Terms | 8 | PR-GL, PR-SCR, PR-SCS, PR-WF |
| Transition Terms | 14 | PR-AAR, PR-FSR, PR-SCS, PR-TOC, PR-WF |
| Decision Terms | 20 | PR-ASR, PR-DTR, PR-ECR, PR-GL, PR-ICR, PR-MFC, PR-OCR, PR-OD, PR-SCR, PR-SCS, PR-WF |
| Validation Terms | 8 | PR-VC, PR-WF |
| Evidence Terms | 32 | PR-AOC, PR-AP, PR-DTR, PR-ECR, PR-FSR, PR-ICR, PR-MFC, PR-OCR, PR-OD, PR-TOC, PR-VC, PR-WF |
| Optionality Terms | 4 | PR-AAR, PR-FSR, PR-OR, PR-TOC |

# Term-to-section matrix register

| Term ID | Preferred label | Category | Status | Source section codes |
| --- | --- | --- | --- | --- |
| IDT-001 | Boundary Defense Agent | Identity Terms | normative | PR-SCS, PR-ASR, PR-AP |
| IDT-002 | boundary-control agent | Identity Terms | normative | PR-OD, PR-ASR |
| IDT-003 | critical core | Identity Terms | normative | PR-ASR |
| BND-002 | Boundary | Boundary Terms | normative | PR-ASR |
| BND-001 | Boundary artifact | Boundary Terms | normative | PR-OD, PR-SCS |
| BND-003 | controlled boundary | Boundary Terms | normative | PR-OD, PR-ASR |
| BND-005 | persistence commits | Boundary Terms | normative | PR-ASR, PR-TOC |
| BND-004 | runtime I/O | Boundary Terms | normative | PR-SCS, PR-ASR |
| BND-006 | transport of artifacts | Boundary Terms | normative | PR-ASR, PR-ECR |
| CTL-002 | accepted-head visibility | Control Terms | normative | PR-AOC, PR-AP, PR-RIN |
| CTL-004 | allowlist | Control Terms | normative | PR-ASR, PR-VC, PR-FSR |
| CTL-008 | append-only evidence ledger | Control Terms | normative | PR-ASR, PR-ECR |
| CTL-006 | authority limit / budget | Control Terms | normative | PR-AAR, PR-DTR, PR-FSR |
| CTL-003 | evidence gate | Control Terms | normative | PR-OD, PR-WF, PR-AAR |
| CTL-009 | Fail-closed policy | Control Terms | normative | PR-ASR, PR-DTR, PR-FSR |
| CTL-007 | human/operator approval channel | Control Terms | normative | PR-AAR |
| CTL-005 | policy profile | Control Terms | normative | PR-ICR, PR-AOC |
| CTL-001 | Readmission | Control Terms | normative | PR-OD, PR-AAR, PR-WF, PR-TOC |
| ABR-001 | CPW | Abbreviation Terms | normative | PR-OD, PR-VC, PR-OR |
| ABR-002 | I/O | Abbreviation Terms | normative | PR-SCS, PR-ASR |
| STA-003 | FILTER\_REVIEW | State Terms | normative | PR-SCS, PR-WF |
| STA-007 | FINALIZATION\_REVIEW | State Terms | normative | PR-SCS, PR-WF |
| STA-001 | IDLE | State Terms | normative | PR-SCS, PR-WF |
| STA-002 | INGEST\_VALIDATE | State Terms | normative | PR-SCS, PR-WF |
| STA-008 | NONCOMPLIANT\_HOLD | State Terms | normative | PR-SCS, PR-WF, PR-GL, PR-SCR |
| STA-006 | OUTPUT\_BLOCKED | State Terms | normative | PR-SCS, PR-WF |
| STA-005 | READY\_FOR\_RELEASE | State Terms | normative | PR-SCS, PR-WF |
| STA-004 | TOOL\_STATE\_QUARANTINED | State Terms | normative | PR-SCS, PR-WF |
| TRN-007 | APPROVAL\_DENIED | Transition Terms | normative | PR-SCS, PR-AAR |
| TRN-006 | APPROVAL\_GRANTED | Transition Terms | normative | PR-SCS, PR-WF |
| TRN-014 | COMPLIANCE\_RESTORED | Transition Terms | normative | PR-WF |
| TRN-011 | COUNTER\_REPLAY | Transition Terms | normative | PR-SCS, PR-TOC, PR-FSR |
| TRN-012 | CPW\_CRITICAL | Transition Terms | normative | PR-SCS, PR-WF, PR-FSR |
| TRN-010 | EVIDENCE\_FAIL | Transition Terms | normative | PR-SCS, PR-WF |
| TRN-009 | EVIDENCE\_OK | Transition Terms | normative | PR-SCS, PR-WF |
| TRN-008 | FINALIZATION\_REQUESTED | Transition Terms | normative | PR-WF |
| TRN-001 | INPUT\_RECEIVED | Transition Terms | normative | PR-SCS, PR-WF |
| TRN-005 | NO\_ESCALATION | Transition Terms | normative | PR-WF |
| TRN-013 | READMISSION\_APPROVED | Transition Terms | normative | PR-SCS, PR-WF |
| TRN-004 | TOOL\_STATE\_DETECTED | Transition Terms | normative | PR-WF |
| TRN-003 | VALIDATION\_FAIL | Transition Terms | normative | PR-SCS, PR-WF |
| TRN-002 | VALIDATION\_PASS | Transition Terms | normative | PR-SCS, PR-WF |
| DEC-001 | ALLOW | Decision Terms | normative | PR-SCS, PR-GL, PR-SCR |
| DEC-002 | ALLOW\_CONSTRAINED | Decision Terms | normative | PR-SCS, PR-GL, PR-SCR |
| DEC-003 | BLOCK | Decision Terms | normative | PR-SCS, PR-GL, PR-SCR |
| DEC-012 | boundary\_verdict | Decision Terms | normative | PR-OCR, PR-DTR, PR-ECR |
| DEC-018 | BoundaryDecisionRecord | Decision Terms | normative | PR-MFC, PR-OCR, PR-ECR |
| DEC-020 | BoundaryIncidentRecord | Decision Terms | normative | PR-MFC, PR-OCR |
| DEC-016 | BoundaryInputEnvelope | Decision Terms | normative | PR-MFC, PR-ICR |
| DEC-005 | FAIL\_CLOSED | Decision Terms | normative | PR-SCS, PR-GL, PR-SCR |
| DEC-010 | finalization\_request | Decision Terms | normative | PR-SCS, PR-ICR, PR-WF |
| DEC-019 | FinalizationRequestEnvelope | Decision Terms | normative | PR-MFC, PR-ICR |
| DEC-015 | incident\_report | Decision Terms | normative | PR-OCR, PR-DTR |
| DEC-007 | ingress\_request | Decision Terms | normative | PR-SCS, PR-ICR, PR-WF |
| DEC-009 | output\_release\_request | Decision Terms | normative | PR-SCS, PR-ASR, PR-GL |
| DEC-004 | QUARANTINE | Decision Terms | normative | PR-SCS, PR-GL, PR-SCR |
| DEC-013 | quarantine\_notice | Decision Terms | normative | PR-OCR, PR-DTR, PR-WF |
| DEC-006 | READMIT | Decision Terms | normative | PR-SCS, PR-GL, PR-SCR |
| DEC-014 | release\_notice | Decision Terms | normative | PR-OCR, PR-WF |
| DEC-011 | statement\_usage\_request | Decision Terms | normative | PR-SCS, PR-ICR, PR-DTR |
| DEC-008 | tool\_state\_payload | Decision Terms | normative | PR-SCS, PR-OD, PR-ICR, PR-WF |
| DEC-017 | ToolStateEnvelope | Decision Terms | normative | PR-MFC, PR-ICR |
| VAL-006 | Approval Validator | Validation Terms | normative | PR-VC, PR-WF |
| VAL-007 | CPW Band Validator | Validation Terms | normative | PR-VC, PR-WF |
| VAL-005 | Evidence Chain Validator | Validation Terms | normative | PR-VC, PR-WF |
| VAL-004 | Freshness / Receipt Validator | Validation Terms | normative | PR-VC, PR-WF |
| VAL-002 | Policy / Allowlist Validator | Validation Terms | normative | PR-VC, PR-WF |
| VAL-008 | Reconstruction Validator | Validation Terms | normative | PR-VC, PR-WF |
| VAL-001 | Schema Validator | Validation Terms | normative | PR-VC, PR-WF |
| VAL-003 | Statement Provenance Validator | Validation Terms | normative | PR-VC, PR-WF |
| EVI-005 | Accepted anchor | Evidence Terms | normative | PR-OD, PR-DTR, PR-TOC |
| EVI-006 | accepted head | Evidence Terms | normative | PR-DTR, PR-VC, PR-FSR, PR-AOC, PR-AP |
| EVI-031 | activation\_requirements | Evidence Terms | normative | PR-OCR |
| EVI-026 | approval\_ref | Evidence Terms | normative | PR-OCR, PR-ECR, PR-WF |
| EVI-015 | boundary\_side | Evidence Terms | normative | PR-ECR |
| EVI-032 | decision\_object | Evidence Terms | normative | PR-ECR |
| EVI-009 | decision\_id | Evidence Terms | normative | PR-OCR, PR-ECR, PR-MFC |
| EVI-007 | evidence\_ok | Evidence Terms | normative | PR-OD, PR-DTR, PR-VC, PR-TOC |
| EVI-012 | evidence\_ref | Evidence Terms | normative | PR-ECR, PR-VC |
| EVI-030 | fail\_reason | Evidence Terms | normative | PR-OCR, PR-MFC |
| EVI-025 | hash\_curr | Evidence Terms | normative | PR-ECR |
| EVI-024 | hash\_prev | Evidence Terms | normative | PR-ECR |
| EVI-028 | hold\_refs | Evidence Terms | normative | PR-OCR |
| EVI-016 | input\_digest | Evidence Terms | normative | PR-OCR, PR-ECR |
| EVI-020 | measurement\_ref | Evidence Terms | normative | PR-ICR, PR-MFC |
| EVI-023 | order\_index | Evidence Terms | normative | PR-ECR, PR-TOC, PR-MFC |
| EVI-017 | payload\_digest | Evidence Terms | normative | PR-ICR, PR-MFC |
| EVI-018 | policy\_hash | Evidence Terms | normative | PR-ICR, PR-OCR, PR-AOC |
| EVI-022 | reason\_code | Evidence Terms | normative | PR-OCR, PR-ECR |
| EVI-027 | release\_scope | Evidence Terms | normative | PR-OCR, PR-DTR |
| EVI-029 | rollback\_ref | Evidence Terms | normative | PR-OCR, PR-ECR, PR-TOC |
| EVI-014 | session\_id | Evidence Terms | normative | PR-ECR |
| EVI-004 | source\_class | Evidence Terms | normative | PR-OD, PR-ICR, PR-DTR |
| EVI-019 | state\_hash | Evidence Terms | normative | PR-ICR, PR-MFC |
| EVI-001 | Statement record | Evidence Terms | normative | PR-OD, PR-ICR |
| EVI-002 | statement\_id | Evidence Terms | normative | PR-OD, PR-ICR, PR-TOC |
| EVI-011 | statement\_refs | Evidence Terms | normative | PR-OCR, PR-ECR, PR-TOC |
| EVI-003 | tsa\_label | Evidence Terms | normative | PR-OD, PR-ICR, PR-DTR |
| EVI-010 | validator\_results | Evidence Terms | normative | PR-OCR, PR-WF, PR-ECR |
| EVI-021 | verdict | Evidence Terms | normative | PR-OCR, PR-ECR, PR-VC |
| EVI-008 | VERIF\_COUNTER | Evidence Terms | normative | PR-OD, PR-DTR, PR-TOC |
| EVI-013 | verif\_counter\_anchor | Evidence Terms | normative | PR-ECR |
| OPT-002 | CPW numeric profile | Optionality Terms | implementation\_optional | PR-OR |
| OPT-001 | External assurance component | Optionality Terms | implementation\_optional | PR-OR, PR-AAR |
| OPT-003 | Operator approval for non-tool artifacts | Optionality Terms | implementation\_optional | PR-OR |
| OPT-004 | Rollback operation | Optionality Terms | implementation\_optional | PR-OR, PR-TOC, PR-FSR |
