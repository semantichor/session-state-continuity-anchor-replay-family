# Truth Arbitration Agent
## Final public-release specification — README

You have received a **specification document package**, distributed free of charge. The Truth Arbitration Agent decides whether a claim's origin and vetting status qualify it for use in a governed decision — not whether the claim is true — and records sufficient evidence for every determination to be reconstructed offline.

The authoritative document is `Truth_Arbitration_Agent_Specification.md`. Where this README and the specification appear to differ, the specification controls.

---

### What this package is, and is not

This package **is** a self-contained, normative, execution-neutral single agent specification, delivered as-is, sufficient for an engineering team to build the agent without further design decisions about agent logic, evidence shape, validator behavior, or failure semantics.

This package **is not** software, SaaS, a managed service, consulting, support, managed operations, or implementation delivery. It does not approve source semantic content, activate tool-state without a separate gate, relax policy, or perform persistent writes during startup verification. It is not a live runtime — nothing in the package executes; everything in the package describes how a conforming executable agent must behave.

---

### What you received

**The specification** — the normative product you implement from:

| File | Role |
| --- | --- |
| `Truth_Arbitration_Agent_Specification.md` | Normative specification. The authoritative document. |
| `Truth_Arbitration_Agent_Semantic_Index.md` | Semantic Index — Human Edition (D1). Canonical glossary of all 167 normative terms. |
| `Truth_Arbitration_Agent_Semantic_Index.yaml` / `Truth_Arbitration_Agent_Semantic_Index.json` | Semantic Index — Structured Edition (D2). The same glossary as data, 1:1 with D1. For tooling. |
| `Truth_Arbitration_Agent_Coverage_Matrix.md` | Semantic Coverage Matrix (D3). Links term categories to the specification's sections. |
| `Truth_Arbitration_Agent_Ambiguity_Register.md` | Ambiguity Register (D4). 15 lexical-overload resolutions. Read before normalization questions arise. |
| `Truth_Arbitration_Agent_Conformance_Tests.md` | Conformance tests you run against your implementation, with fixtures, oracles, and minimal run note. |

**Non-normative material** — accompanies the specification, but is not part of it:

| File | Role |
| --- | --- |
| `Truth_Arbitration_Agent_Whitepaper.html` | Public-facing positioning. Non-normative. |
| `NNT_Companion/` | Non-Normative Tests — demonstration-only evidence that the specification is derivable. Not a reference implementation, and not part of the specification. Do not read it before implementing: read it only after your implementation passes the Conformance Tests. |
| `Truth_Arbitration_Agent_README.md` | This file. Orientation and reading order. |

**Integrity** — how you verify that what you hold is authentic:

| File | Role |
| --- | --- |
| `Truth_Arbitration_Agent_License.md` | The license. |
| `Truth_Arbitration_Agent_Manifest.sha256` | SHA-256 integrity manifest. |
| `verify.md` | Self-audit runbook you run against the package you hold. |

---

### Suggested reading order

1. **This README** — the package's map: what is in it and how the pieces relate.
2. **Integrity check** — run the integrity section of `verify.md` against the Manifest to confirm the package is intact and authentic before reading further.
3. **License** — the terms of use. The license sets out what is free; the reserved uses are not licensed for this package.
4. **Whitepaper** — why the agent exists: problem, outcomes, domains. *(Non-normative — context only; carry no terminology from it into implementation.)*
5. **Specification, front matter and §§1–4** — purpose, scope, authority boundaries, input/output contracts, controlled verdict vocabulary.
6. **Semantic Index — Human Edition (D1)** and **Ambiguity Register (D4)** — the canonical terms and their resolved ambiguities; read before the implementation core to avoid normalization mistakes. The Semantic Index, Semantic Coverage Matrix, and Ambiguity Register are derived views of the specification's own vocabulary — the specification is semantically closed, so they cannot legitimately disagree with it. If you observe a divergence, re-run the integrity check. If the copy is intact, the divergence is a release defect: the specification controls, and you should report it to the source that provided the package.
7. **Specification §§5–12** — ordering sequence, validators, decision table, workflow, gate logic, evidence contract, machine-readable forms. The implementation core.
8. **Specification §§13–16** — conformance requirements, deployment obligations, optionality, reuse note.
9. **Conformance Tests** — fixtures, oracles, and the acceptance criteria your implementation must meet.
10. **Semantic Coverage Matrix (D3)** — cross-check that every term category traces to its sections.
11. **Semantic Index — Structured Edition (D2, YAML/JSON)** — the same glossary as data; consume at implementation time.
12. **NNT companion** — non-normative, demonstration-only evidence that the specification is derivable. Do not read before implementing; read only after your implementation passes the Conformance Tests.
13. **After implementation: verify.md, full runbook** — the package's self-audit: re-run its remaining checks against the package you hold. Your implementation's conformance is established by the Conformance Tests, not by verify.md.

---

### What the specification guarantees

4 structural properties, defined across spec §2.2, §6–§9, and §12, and elaborated through the failure semantics, workflow, gate logic, and evidence contract sections:

1. **G.01 — Every claim classified before admission.** No claim can influence a governed decision without first being classified by origin. Claims from different origins are subject to different admission rules. The classification is mandatory, recorded, and enforced — not advisory.
2. **G.02 — Every verdict auditable.** When the agent admits, denies, or blocks a claim, it records enough evidence for the determination to be fully reconstructed offline — by an auditor, a regulator, or a forensic investigator — without access to the system's runtime state.
3. **G.03 — Contradictions caught before the decision.** When claims from different origins contradict each other, the agent detects the conflict before the claims can influence the governed operation. The verdict reflects what was found — and what was not checked.
4. **G.04 — Failures blocked, not degraded.** When admission requirements cannot be met, the system blocks progress and escalates. It does not silently degrade. It does not permit the decision to proceed with reduced confidence. It stops, records why, and specifies what is required to resume.

These are properties of the specification. They are not warranties about a delivered running system.

---

### What your team must produce

Per spec §16 Reuse and Adaptation Guidance and §15 Conformance Conditions, 5 implementation deliverables your engineering team builds from this specification:

1. **The conformant implementation of the agent** — the executable that realizes the §5 state model, the §6 decision table, the §7 validator catalogue, the §9 gate logic, and the §8 evidence contract.
2. **An operator policy profile** binding the bounded parameters the specification deliberately leaves to your declaration: deterministic canonicalization rules and `semantic_normalization_profile` (§2.1, §13); concrete `reason_code` naming and machine-readable form serialization (§16.2); the V-006A severity threshold (§6 DO-005); the V-006B confidence threshold and conflict-formalism scales (§6 DO-006, §13); the `readmission_budget` value and clearance criteria (§12.1); and authorized external-actor identities for `ESCALATION_REQUEST` and `CLEARANCE_RESPONSE` (§10, §12).
3. **A runtime ordering and policy-snapshot layer** — explicit serialization or snapshot-at-intake plus compare-and-commit (per §11 and AMB-011); snapshot freeze at intake; V-007 drift detection and restart under the new snapshot.
4. **An evidence archive** sufficient for offline reconstruction — every emitted `DECISION`, `FAIL_CLOSED`, `ESCALATION_REQUEST`, `CLEARANCE_RESPONSE`, `CHECKPOINT`, and `ROLLBACK` record retained per §5.2, §8 and §10, replayable without runtime state.
5. **A conformance-verification record** — the Conformance Tests run against your implementation under your declared policy profile, attesting all runnable and parameterized tests and confirming the declarative integration check.

The specification is complete enough that none of these requires interpretation of ambiguous prose. Spec §15 Conformance Conditions sets the five acceptance criteria your implementation must meet; this README numbers them IAC-1 through IAC-5 for reference:

- **IAC-1.** All mandatory fields across the Semantic Contract, Authority Model, Input and Output Contracts, State Model, Gate Logic, Failure Semantics, and Evidence Contract are present and populated.
- **IAC-2.** The Decision Table and Validator Catalogue jointly cover all declared decision objects and do not leave relevant combinations unresolved.
- **IAC-3.** The implementation supports role-bypass handling, formal conflict handling, heuristic conflict handling, `ALLOW_CONSTRAINED`, `ESCALATION_REQUEST`, clearance response, and terminal handling at readmission-budget exhaustion.
- **IAC-4.** Offline reconstruction is possible from emitted evidence alone, including role reclassification, conflict qualifiers, policy-snapshot data, and clearance-driven remediation.
- **IAC-5.** No open inconsistency remains in boundary handling, validator semantics, policy-snapshot semantics, conflict closure, fail-closed escalation, replay, or readmission semantics.

---

### How to verify your implementation conforms

The Conformance Tests document contains 27 test records anchored 1:1 to the specification: 25 directly runnable on the agent's projection surface, 1 parameterized against operator-declared inputs, and 1 declarative check verified at integration level. Each record cites the specification authority that grounds it, the input fixture that drives it, and the oracle that defines pass and fail. The Minimal Run Note declares the projection surface, input types, assertion result types, and the conformance condition for the suite as a whole.

Run the suite against your implementation. A fully conformant implementation passes the 25 runnable tests, satisfies the 1 parameterized test under your declared parameter envelopes, and attests the 1 declarative check at your release-acceptance gate.

---

### How the agent is deployed by your team

The agent has a single deployment scope: **Standalone — one agent operating as an independent provenance arbitration gate within a specific system you already run, with no agent-level dependencies on other agents in the SEMANTICHOR library**. It is implemented and operated by your engineering and operations teams as **a self-contained provenance arbitration and admissibility gate for mechanism-level claims, sitting in front of any governed decision that consumes those claims**. Composing this agent with others from the same library, including as a component within a family integrator, is specified in the relevant family pack — a separate package with its own documents and terms.

In all cases, deployment is performed by your engineering and operations teams. This package is not the deployer.

---

### How to read the package when a question arises

The package is closed on what it must close and deliberately open on what your operating context must close. When implementing or running the agent, edge cases will arise. Read them in this order:

1. **The specification rules first.** If the specification, decision table, gate logic, evidence contract, or validator catalogue resolves the case — apply that rule. The canonical verdicts (§2.2) and the dominant fail-closed rule (§9, with §1 declaring the operating posture) cover most situations directly.
2. **Operator-declared parameters second.** Where the specification leaves a parameter to your declaration — cadences, procedures, mechanisms, routes, roles — your policy declarations are the authority. Close the case in that policy.
3. **Your own governance third.** Where neither the specification nor an operator-declared parameter applies, the case belongs to your release governance, security authority, or human auditor — exactly as the specification's authority boundary (§3) requires. The agent does not adjudicate beyond its scope.

If you find yourself reconstructing the agent's central decision logic to answer an edge case, stop — this is a signal that one of the three layers above has not been applied. The package is built so that no reconstruction of core decision logic is needed on your side.

---

### Authority boundary

Truth Arbitration Agent is a closed normative agent that adjudicates only source provenance, labeling, conflict status, and admissibility for mechanism-level claims. It does not determine full material truth, validate software implementation correctness, or act as an autonomous substantive content source. The agent's identity is restricted to the rule set and the active policy snapshot; it does not authorize any decision outside that scope.

This boundary is normative (spec §3, and §15 as listed above under IAC-5) and cannot be overridden by integration choices.

---

### Versioning

| Field | Value |
| --- | --- |
| Specification version | Final public-release specification |
| Index version (D1 / D2 / D3 / D4) | v2.0 |
| Term count (D1 / D2 / D3) | 167 |
| Ambiguity entries (D4) | 15 |
| Conformance test records | 27 |

If any field above does not match the corresponding metadata in the files you opened, contact the source that provided the package to obtain the correct release. Do not implement against a version-mismatched package.

---

### Support model

This document package is distributed free of charge and delivered as-is. No support, consulting, implementation, or operational services are included or offered. Your engineering team owns implementation, deployment, operation, and maintenance.

---

*End of README.*
