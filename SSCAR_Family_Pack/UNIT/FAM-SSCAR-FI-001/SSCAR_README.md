# Session State Continuity & Anchor Replay Family Integrator
## Public Release v1.1.0 — README

You have received a **specification document package**, distributed free of charge. It determines whether an inter-session continuity event is admissible for semantic replay and verified rehydration.

The authoritative document is `SSCAR_Specification.md`. Where this README and the specification appear to differ, the specification controls.

> **This integrator does not operate standalone.** The integrator produces the family-level `session_replay_admissibility` only when composed with all 5 component agent implementations and the three operational connector annexes (A, B, C) included in this package. The integrator is delivered only as part of the Family Pack alongside those component specifications. Implementing the integrator without the components and the connector wiring produces no operational output.

---

### What this package is, and is not

This package **is** a normative, execution-neutral family integrator specification, delivered as-is, sufficient for an engineering team to build the integrator without further design decisions about agent logic, evidence shape, validator behavior, or failure semantics.

This package **is not** software, SaaS, a managed service, consulting, support, managed operations, or implementation delivery. It does not classify external truth, issue policy overrides, grant operator approval for tool-state, perform live restore, move continuity watermarks, substitute local validators, or rewrite accepted history. It is not a live runtime — nothing in the package executes; everything in the package describes how a conforming executable integrator must behave.

---

### What you received

**The specification** — the normative product you implement from:

| File | Role |
| --- | --- |
| `SSCAR_Specification.md` | Normative specification. The authoritative document. |
| `SSCAR_Semantic_Index.md` | Semantic Index — Human Edition (D1). Canonical glossary of all 139 normative terms. |
| `SSCAR_Semantic_Index.yaml` / `SSCAR_Semantic_Index.json` | Semantic Index — Structured Edition (D2). The same glossary as data, 1:1 with D1. For tooling. |
| `SSCAR_Coverage_Matrix.md` | Semantic Coverage Matrix (D3). Links term categories to the specification's sections. |
| `SSCAR_Ambiguity_Register.md` | Ambiguity Register (D4). 17 lexical-overload resolutions. Read before normalization questions arise. |
| `SSCAR_Conformance_Tests.md` | Conformance tests you run against your implementation, with fixtures, oracles, and minimal run note. |
| `SSCAR_Producer_Consumer_Manifest.md` | **Annex A — Producer-Consumer Manifest.** Maps each family validator to producer component, consumed field, pass condition, and failure handling. |
| `SSCAR_Concept_Identity_Register.md` | **Annex B — Concept Identity Register.** Canonical-token reference for cross-component identity, equivalence rules, coherence constraints, and evidence binding. |
| `SSCAR_Family_Connector_Tests.md` | **Annex C — Family Connector Test Suite.** 14 wiring tests you run. |

**Non-normative material** — accompanies the specification, but is not part of it:

| File | Role |
| --- | --- |
| `SSCAR_Whitepaper.html` | Public-facing positioning. Non-normative. |
| `SSCAR_README.md` | This file. Orientation and reading order. |

The integrator's non-normative evidence is the family NNT companion, in the family evidence download: the integrator is exercised there through its public Conformance Tests and Annex C, composed with the five component agents.

**Integrity** — how you verify that what you hold is authentic:

| File | Role |
| --- | --- |
| `SSCAR_Manifest.sha256` | SHA-256 integrity manifest. |
| `verify.md` | Self-audit runbook you run against the package you hold. |

---

### Suggested reading order

1. **This README** — the package's map: what is in it and how the pieces relate.
2. **Integrity check** — run the integrity section of `verify.md` against the Manifest to confirm the package is intact and authentic before reading further.
3. **License** — the integrator carries no license of its own. It is delivered only as part of the Family Pack, and the family license covers it.
4. **Whitepaper** — why the family exists: problem, outcomes, domains. *(Non-normative — context only; carry no terminology from it into implementation.)*
5. **Specification, front matter and §§1–4** — purpose, scope, authority boundaries, input/output contracts, controlled verdict vocabulary.
6. **Semantic Index — Human Edition (D1)** and **Ambiguity Register (D4)** — the canonical terms and their resolved ambiguities; read before the implementation core to avoid normalization mistakes. The Semantic Index, Semantic Coverage Matrix, and Ambiguity Register are derived views of the specification's own vocabulary — the specification is semantically closed, so they cannot legitimately disagree with it. If you observe a divergence, re-run the integrity check. If the copy is intact, the divergence is a release defect: the specification controls, and you should report it to the source that provided the package.
7. **Specification §§5–13** — ordering sequence, validators, decision table, workflow, gate logic, evidence contract, machine-readable forms. The implementation core.
8. **Specification §§14–17** — conformance requirements, deployment obligations, public conformance scenarios, optionality, reuse note.
9. **Connector annexes A, B and C** — the wiring between components: what each component must expose to the integrator and what the integrator may assume.
10. **Conformance Tests** — fixtures, oracles, and the acceptance criteria your implementation must meet.
11. **Semantic Coverage Matrix (D3)** — cross-check that every term category traces to its sections.
12. **Semantic Index — Structured Edition (D2, YAML/JSON)** — the same glossary as data; consume at implementation time.
13. **Family NNT companion** — in the family evidence download: non-normative, demonstration-only evidence that the specification is derivable. Do not read before implementing; read only after your implementation passes the Conformance Tests.
14. **After implementation: verify.md, full runbook** — the package's self-audit: re-run its remaining checks against the package you hold. Your implementation's conformance is established by the Conformance Tests, not by verify.md.

---

### What the specification guarantees

6 structural properties, defined in spec §17.3 Stable semantic core and elaborated through the failure semantics, workflow, gate logic, and evidence contract sections:

1. Family verdict vocabulary and disclosure classes remain fixed.
2. Contamination definition and fail-closed behavior remain fixed.
3. Strict monotonic anchor requirement and accepted-head linkage remain fixed.
4. Verified rehydration precedes semantic replay.
5. Replay sufficiency and offline reconstructibility remain required.
6. Disclosure-class preservation and evidence closure remain required.

These are properties of the specification. They are not warranties about a delivered running system.

---

### What your team must produce

Per spec §17 Implementation Boundaries, Optional Parameters, and Reuse Rules and §16 Acceptance Criteria, 6 deployment artifacts your engineering team builds from this specification:

1. A conforming executable family integrator implementing the workflow states, validator catalogue, decision table, gate logic, and fail-closed verdict emission.
2. Component wiring and adapters for Audit Replay Agent (ARA), Boundary Defense Agent (BDA), Freshness Portability Agent (FPA), Truth Arbitration Agent (TAA), and Verified Rehydration Agent (VRA), using Annex A producer-consumer wiring and Annex B canonical-token identity rules.
3. Boundary intake, replay-request, readmission-review, and output projections for FIC-01 through FIC-03 and FOC-01 through FOC-05.
4. An evidence assembly and export pipeline producing FEV-01 through FEV-15, including BoundaryEventEvidenceReport, report_signature, and export_manifest_ref.
5. An operator-declared implementation profile covering cryptographic suite, storage backend, serialization, operator workflow, optional assurance and attestation controls, and any downstream rollback action.
6. A conformance harness and release-acceptance record running the public test suite and all Annex C connector tests.

The specification is complete enough that none of these requires interpretation of ambiguous prose. Spec §16 AC-01 through AC-08 set the acceptance criteria your implementation must meet.

---

### How to verify your implementation conforms

The Conformance Tests document contains 28 test records anchored 1:1 to the specification: 19 directly runnable on the integrator's projection surface, 2 parameterized against operator-declared inputs, and 7 declarative checks verified at integration level. Each record cites the specification authority that grounds it, the input fixture that drives it, and the oracle that defines pass and fail. The Minimal Run Note declares the projection surface, input types, assertion result types, and the conformance condition for the suite as a whole.

Run the suite against your implementation. A fully conformant implementation passes the 19 runnable tests, satisfies the 2 parameterized tests under your declared parameter envelopes, and attests the 7 declarative checks at your release-acceptance gate.

In addition, Annex C contains 14 wiring tests you run that verify correct connection of components to the integrator at the family layer. Each wiring test declares its input surface, execution surface, assertion set, PASS condition, and forbidden semantic collapse. A fully conformant family implementation passes the integrator's Conformance Tests (above) AND all 14 wiring tests in Annex C. Failure at either level is a family conformance failure.

---

### How the family is deployed by your team

The integrator has a single deployment scope: a high-audit continuity environment with offline replay, cross-session handoff, and possible model change. It is implemented and operated by your engineering and operations teams as a normative-critical family integrator that composes local component outcomes into a fail-closed family replay-admissibility verdict and an offline-reconstructible boundary-event evidence report. The integrator is delivered only in the Family Pack alongside the 5 component agent specifications and the three operational connector annexes; it is not sold or operated independently.

In all cases, deployment is performed by your engineering and operations teams. This package is not the deployer.

---

### How to read the package when a question arises

The package is closed on what it must close and deliberately open on what your operating context must close. When implementing or running the integrator, edge cases will arise. Read them in this order:

1. **The specification rules first.** If the specification, decision table, gate logic, evidence contract, or validator catalogue resolves the case — apply that rule. The canonical verdicts (§4.1 and §10) and the dominant fail-closed rule (§10) cover most situations directly.
2. **Operator-declared parameters second.** Where the specification leaves a parameter to your declaration — cadences, procedures, mechanisms, routes, roles — your policy declarations are the authority. Close the case in that policy.
3. **Your own governance third.** Where neither the specification nor an operator-declared parameter applies, the case belongs to your release governance, security authority, or human auditor — exactly as the specification's authority boundary (§2) requires. The integrator does not adjudicate beyond its scope.

If you find yourself reconstructing the integrator's central decision logic to answer an edge case, stop — this is a signal that one of the three layers above has not been applied. The package is built so that no reconstruction of core decision logic is needed on your side.

---

### Authority boundary

The integrator has finite, fail-closed authority over boundary cleanliness, carried-claim provenance admissibility, accepted-head and anchor validation, verified rehydration closure, replay continuity and admissibility, and boundary-event evidence reporting. It may compose local outcomes into a family verdict, validate cross-domain closure, block family replay, open hold and readmission review, and issue a boundary-event evidence report. It may not classify external truth, issue policy overrides, approve tool-state, execute restore, move continuity watermarks, substitute local validators, or rewrite accepted history.

This boundary is normative (spec §2 and §16 AC-08) and cannot be overridden by integration choices.

The family-level authority of the integrator does not override the authority boundaries of the 5 component agents; each component's authority boundary is stated in that component's specification and applies at the component level only.

---

### Versioning

| Field | Value |
| --- | --- |
| Specification version | Public Release v1.1.0 |
| Index version (D1 / D2 / D3 / D4) | v1.1.0 |
| Term count (D1 / D2 / D3) | 139 |
| Ambiguity entries (D4) | 17 |
| Conformance test records | 28 |
| Connector tests (Annex C) | 14 |

If any field above does not match the corresponding metadata in the files you opened, contact the source that provided the package to obtain the correct release. Do not implement against a version-mismatched package.

---

### Support model

This document package is distributed free of charge and delivered as-is. No support, consulting, implementation, or operational services are included or offered. Your engineering team owns implementation, deployment, operation, and maintenance.

---

*End of README.*
