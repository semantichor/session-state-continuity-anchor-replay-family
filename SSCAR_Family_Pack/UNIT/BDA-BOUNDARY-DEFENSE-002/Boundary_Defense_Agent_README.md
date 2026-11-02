# Boundary Defense Agent
## Public Release v2.0 — README

You have received a **specification document package**, distributed free of charge. This package defines a fail-closed boundary-control agent that validates, filters, quarantines, blocks, and conditionally releases artifacts crossing controlled runtime, persistence, or transport boundaries.

The authoritative document is `Boundary_Defense_Agent_Specification.md`. Where this README and the specification appear to differ, the specification controls.

---

### What this package is, and is not

This package **is** a self-contained, normative, execution-neutral single agent specification, delivered as-is, sufficient for an engineering team to build the agent without further design decisions about agent logic, evidence shape, validator behavior, or failure semantics.

This package **is not** software, SaaS, a managed service, consulting, support, managed operations, or implementation delivery. It does not approve source semantic content, activate tool-state without a separate gate, relax policy, or perform persistent writes during startup verification. It is not a live runtime — nothing in the package executes; everything in the package describes how a conforming executable agent must behave.

---

### What you received

**The specification** — the normative product you implement from:

| File | Role |
| --- | --- |
| `Boundary_Defense_Agent_Specification.md` | Normative specification. The authoritative document. |
| `Boundary_Defense_Agent_Semantic_Index.md` | Semantic Index — Human Edition (D1). Canonical glossary of all 106 normative terms. |
| `Boundary_Defense_Agent_Semantic_Index.yaml` / `Boundary_Defense_Agent_Semantic_Index.json` | Semantic Index — Structured Edition (D2). The same glossary as data, 1:1 with D1. For tooling. |
| `Boundary_Defense_Agent_Coverage_Matrix.md` | Semantic Coverage Matrix (D3). Links term categories to the specification's sections. |
| `Boundary_Defense_Agent_Ambiguity_Register.md` | Ambiguity Register (D4). 14 lexical-overload resolutions. Read before normalization questions arise. |
| `Boundary_Defense_Agent_Conformance_Tests.md` | Conformance tests you run against your implementation, with fixtures, oracles, and minimal run note. |

**Non-normative material** — accompanies the specification, but is not part of it:

| File | Role |
| --- | --- |
| `Boundary_Defense_Agent_Whitepaper.html` | Public-facing positioning. Non-normative. |
| `NNT_Companion/` | Non-Normative Tests — demonstration-only evidence that the specification is derivable. Not a reference implementation, and not part of the specification. Do not read it before implementing: read it only after your implementation passes the Conformance Tests. |
| `Boundary_Defense_Agent_README.md` | This file. Orientation and reading order. |

**Integrity** — how you verify that what you hold is authentic:

| File | Role |
| --- | --- |
| `Boundary_Defense_Agent_License.md` | The license. |
| `Boundary_Defense_Agent_Manifest.sha256` | SHA-256 integrity manifest. |
| `verify.md` | Self-audit runbook you run against the package you hold. |

---

### Suggested reading order

1. **This README** — the package's map: what is in it and how the pieces relate.
2. **Integrity check** — run the integrity section of `verify.md` against the Manifest to confirm the package is intact and authentic before reading further.
3. **License** — the terms of use. The license sets out what is free; the reserved uses are not licensed for this package.
4. **Whitepaper** — why the agent exists: problem, outcomes, domains. *(Non-normative — context only; carry no terminology from it into implementation.)*
5. **Specification, front matter through Output Contract Record Set (`PR-OD` through `PR-OCR`)** — purpose, scope, principles, authority boundaries, input/output contracts, controlled verdict vocabulary.
6. **Semantic Index — Human Edition (D1)** and **Ambiguity Register (D4)** — the canonical terms and their resolved ambiguities; read before the implementation core to avoid normalization mistakes. The Semantic Index, Semantic Coverage Matrix, and Ambiguity Register are derived views of the specification's own vocabulary — the specification is semantically closed, so they cannot legitimately disagree with it. If you observe a divergence, re-run the integrity check. If the copy is intact, the divergence is a release defect: the specification controls, and you should report it to the source that provided the package.
7. **Specification Decision Table Record through Machine-Readable Form Catalogue (`PR-DTR` through `PR-MFC`)** — validators, decision table, workflow, gate logic, evidence contract, machine-readable forms. The implementation core.
8. **Specification Semantic Contract Record through Reuse and Implementation Note (`PR-SCR` through `PR-RIN`)** — semantic verdict meanings, temporal ordering, failure semantics, assumptions-to-obligations, acceptance criteria, optionality, assurance profile, validation requirements, reuse note.
9. **Conformance Tests** — fixtures, oracles, and the acceptance criteria your implementation must meet.
10. **Semantic Coverage Matrix (D3)** — cross-check that every term category traces to its sections.
11. **Semantic Index — Structured Edition (D2, YAML/JSON)** — the same glossary as data; consume at implementation time.
12. **NNT companion** — non-normative, demonstration-only evidence that the specification is derivable. Do not read before implementing; read only after your implementation passes the Conformance Tests.
13. **After implementation: verify.md, full runbook** — the package's self-audit: re-run its remaining checks against the package you hold. Your implementation's conformance is established by the Conformance Tests, not by verify.md.

---

### What the specification guarantees

5 structural assurance properties, defined in the specification's Assurance Profile (`PR-AP`) and elaborated through the failure semantics, workflow, gate logic, and evidence contract sections:

1. **Fixed identity and authority boundary.** Agent name, role, scope, and non-authority zones are fixed.
2. **Boundary-governed exchange.** No artifact crosses the governed boundary without contract evaluation.
3. **Decision sufficiency.** Every verdict is linked to validators and evidence fields.
4. **Deterministic fail-closed degradation.** Critical risk, replay, evidence failure, and tool-state ambiguity produce deterministic blocking, quarantine, rollback, or hold behavior rather than silent or ambiguous behavior.
5. **Replay and reconstruction sufficiency.** Accepted-head visibility and append-only or tamper-evident evidence support offline reconstruction.

The whitepaper summarizes these externally as four outcomes: every crossing governed, inputs classified, outputs gated, and boundary lockable. These are properties of the specification. They are not warranties about a delivered running system.

---

### What your team must produce

Per the specification's Reuse and Implementation Note (`PR-RIN`), Assumption-to-Obligation Closure (`PR-AOC`), and Implementation Acceptance Criteria (`PR-IAC`), your engineering team builds or declares 10 implementation-side deployment artifacts from this specification:

1. **Versioned schema catalogue** for boundary payload classes, with `schema_id` bound in every input envelope.
2. **Policy profile registry** with stable active policy profiles and `policy_hash` binding in decision and evidence records.
3. **Artifact and tool allowlist/classification policy** for admissibility, elevated-risk classes, and constrained release.
4. **Operator approval channel** for tool-state activation, including `approval_ref` production and validation.
5. **Evidence provider / external assurance integration** for compliance-claimed finalization and persisted release claims.
6. **Append-only or tamper-evident evidence ledger** with externally checkable continuity and `hash_prev` / `hash_curr` equivalents.
7. **Accepted-head / accepted-anchor store** for replay, freshness, source binding, and transport/persistence anchor checks.
8. **Implementation projection surface** exposing state, trigger, verdict, validator, and evidence outcomes for conformance testing.
9. **Implementation-side mechanism selections** for cryptographic primitive suite, storage backend, and persistence substrate.
10. **Operational handoff materials** for operator UI/workflow, throughput budgets, runbooks, escalation routes, and release governance.

The specification is complete enough that none of these requires interpretation of ambiguous prose. Specification `PR-IAC` criteria `HC-01` through `HC-06` set the acceptance criteria your implementation must meet.

---

### How to verify your implementation conforms

The Conformance Tests document contains 36 test records anchored to the specification: 31 directly runnable on the agent's projection surface, 1 parameterized against operator-declared inputs, and 4 declarative checks verified at integration level. Each record cites the specification authority that grounds it, the input fixture that drives it, and the oracle that defines pass and fail. The Minimal Run Note declares the projection surface, input types, assertion result types, and the conformance condition for the suite as a whole.

Run the suite against your implementation. A fully conformant implementation passes the 31 runnable tests, satisfies the 1 parameterized test under your declared parameter envelopes, and attests the 4 declarative checks at your release-acceptance gate.

---

### How the agent is deployed by your team

The agent has a single deployment scope: all ingress and egress artifacts that cross the controlled boundary of the critical core, including tool-state payloads and finalization-relevant persistence or transport requests. It is implemented and operated by your engineering and operations teams as a boundary-control agent for ingress, egress, persistence, and transport-adjacent artifact exchange. Composing this agent with others from the same library, including as a component within a family integrator, is specified in the relevant family pack — a separate package with its own documents and terms.

In all cases, deployment is performed by your engineering and operations teams. This package is not the deployer.

---

### How to read the package when a question arises

The package is closed on what it must close and deliberately open on what your operating context must close. When implementing or running the agent, edge cases will arise. Read them in this order:

1. **The specification rules first.** If the specification, decision table, gate logic, evidence contract, or validator catalogue resolves the case — apply that rule. The canonical verdicts in `PR-SCS`, `PR-GL`, and `PR-SCR`, together with the fail-closed rules in `PR-ASR`, `PR-DTR`, and `PR-FSR`, cover most situations directly.
2. **Operator-declared parameters second.** Where the specification leaves a parameter to your declaration — cadences, procedures, mechanisms, routes, roles, storage, cryptographic primitive suite, throughput budget, or operator workflow — your policy declarations are the authority. Close the case in that policy.
3. **Your own governance third.** Where neither the specification nor an operator-declared parameter applies, the case belongs to your release governance, security authority, or human auditor, consistent with the specification's Agent Authority Record (`PR-AAR`). The agent does not adjudicate beyond its scope.

If you find yourself reconstructing the agent's central decision logic to answer an edge case, stop — this is a signal that one of the three layers above has not been applied. The package is built so that no reconstruction of core decision logic is needed on your side.

---

### Authority boundary

The Boundary Defense Agent's authority is defined by the specification together with active operator policy. It may validate, classify, filter, block, quarantine, release validated artifacts, request finalization evidence checks, and emit decision and evidence records. It may not execute tools by virtue of restored state alone; bypass the evidence gate; rewrite accepted history; override operator approval requirements; or claim truth for unlabeled or inadmissible statements. Its escalation path is: Boundary Defense Agent -> human/operator approval channel -> external assurance component -> implementation layer.

This boundary is normative (`PR-AAR` and `PR-IAC` criterion `HC-05`) and cannot be overridden by integration choices.

---

### Versioning

| Field | Value |
| --- | --- |
| Specification version | Public Release v2.0 |
| Index version (D1 / D2 / D3 / D4) | v2.0 |
| Term count (D1 / D2 / D3) | 106 |
| Ambiguity entries (D4) | 14 |
| Conformance test records | 36 |

If any field above does not match the corresponding metadata in the files you opened, contact the source that provided the package to obtain the correct release. Do not implement against a version-mismatched package.

---

### Support model

This document package is distributed free of charge and delivered as-is. No support, consulting, implementation, or operational services are included or offered. Your engineering team owns implementation, deployment, operation, and maintenance.

---

*End of README.*
