D4 — Ambiguity Register

*Publishable ambiguities, rejected collapses, and usage clarifications*

| Agent | Boundary Defense Agent |
| --- | --- |
| **Corpus** | Boundary Defense Agent — Specification (Public Release v2.0) |
| **Ambiguity rows** | 14 |
| **Scope** | ambiguities of the specification only |

**Register rule. This register records only ambiguities that arise inside the specification. It does not import external synonym sets and does not compare the package against non-public vocabularies.**

| ID | Focal term | Ambiguous with | Risk type | Clarification | Allowed use | Source sections |
| --- | --- | --- | --- | --- | --- | --- |
| AMB-001 | ALLOW | ALLOW\_CONSTRAINED | adjacent verdicts | ALLOW permits crossing within declared scope; ALLOW\_CONSTRAINED permits crossing under reduced scope, tighter observation, or explicit follow-up review. | Use ALLOW only where no escalation condition remains; use ALLOW\_CONSTRAINED where constrained release is required. | PR-GL, PR-SCR |
| AMB-002 | BLOCK | QUARANTINE | boundary action distinction | BLOCK denies boundary crossing and state mutation; QUARANTINE preserves the artifact for inspection but keeps it non-executable and non-releasable. | Do not substitute QUARANTINE for BLOCK when the specification requires inadmissibility without preservation for inspection. | PR-GL, PR-SCR, PR-FSR |
| AMB-003 | FAIL\_CLOSED | NONCOMPLIANT\_HOLD | escalation vs hold | FAIL\_CLOSED halts substantive boundary progression and emits auditable failure; NONCOMPLIANT\_HOLD is an audit-only posture in which no compliance-claimed finalization is permitted. | Use FAIL\_CLOSED for critical-risk or prerequisite violation; use NONCOMPLIANT\_HOLD for evidence-gate failure or replay-linked hold handling. | PR-GL, PR-SCR, PR-WF |
| AMB-004 | Readmission | READMIT / READMISSION\_APPROVED | control term vs verdict/event | Readmission names the restoration control; READMISSION\_APPROVED is the workflow event; READMIT is the restoration verdict emitted after prerequisites are restored. | Keep the control term, event token, and verdict token distinct in D1 and D2. | PR-OD, PR-WF, PR-SCR |
| AMB-005 | Accepted anchor | accepted head / verif\_counter\_anchor | anchor family | Accepted anchor is the last accepted freshness or verification watermark; accepted head is the stable accepted state kept unchanged on replay or missing receipt; verif\_counter\_anchor is an evidence-contract field for finalization-linked evidence. | Do not collapse these three into a single field or synonym. | PR-OD, PR-DTR, PR-ECR, PR-TOC |
| AMB-006 | evidence\_ok | EVIDENCE\_OK | field vs event | evidence\_ok is a Boolean evidence-gate result; EVIDENCE\_OK is the workflow event that occurs when finalization review passes with evidence\_ok=true and the counter strictly increases. | Use lowercase for the field and uppercase token for the transition event. | PR-OD, PR-WF |
| AMB-007 | tool\_state\_payload | ToolStateEnvelope | decision object vs machine-readable form | tool\_state\_payload is the decision object; ToolStateEnvelope is the structured form that packages it. | Treat the envelope as a record form, not as a synonym for the decision object. | PR-ICR, PR-MFC |
| AMB-008 | Statement record | statement\_usage\_request | record vs request | Statement record is the gate-relevant claim; statement\_usage\_request is the request object that submits statement identity, label, source class, and scope for gate use. | Do not use the request name as the canonical label for the claim itself. | PR-OD, PR-ICR |
| AMB-009 | Boundary artifact | Boundary | object class vs governed surface | Boundary artifact is the object that attempts to cross; Boundary is the logical boundary spanning runtime I/O, persistence commits, and transport of artifacts. | Do not use Boundary as the canonical label for the artifact class. | PR-OD, PR-ASR |
| AMB-010 | approval\_ref | APPROVAL\_GRANTED / APPROVAL\_DENIED | field vs events | approval\_ref is approval evidence; APPROVAL\_GRANTED and APPROVAL\_DENIED are event tokens in the approval path. | Use approval\_ref only for evidence fields or references attached to artifacts. | PR-OCR, PR-WF, PR-SCS |
| AMB-011 | OUTPUT\_BLOCKED | BLOCK | state vs verdict | OUTPUT\_BLOCKED names the blocked workflow state; BLOCK is the semantic verdict token for inadmissibility. | Do not replace the state name with the verdict token in workflow rows or coverage mapping. | PR-WF, PR-SCR |
| AMB-012 | NONCOMPLIANT\_HOLD | NONCOMPLIANT\_HOLD | dual-use token | The same token names both a workflow state and a semantic verdict or gate status. | D1 and D2 keep one canonical entry with an explicit ambiguity note rather than creating two conflicting definitions. | PR-WF, PR-GL, PR-SCR |
| AMB-013 | CPW | CPW\_CRITICAL | abbreviation vs event | CPW is the abbreviation for Crash Proximity Warning; CPW\_CRITICAL is the transition event triggered when the band is CRITICAL. | Do not use CPW as if it were an event token. | PR-OD, PR-WF |
| AMB-014 | boundary\_verdict | BoundaryDecisionRecord | artifact vs form | boundary\_verdict is the output artifact; BoundaryDecisionRecord is the structured form skeleton used to serialize that decision record. | Use the record form only when the machine-readable form catalogue is intended. | PR-OCR, PR-MFC |
