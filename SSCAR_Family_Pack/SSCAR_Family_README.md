# SSCAR Family
## Public release — README

You have received a **family specification package**, distributed free of charge. It defines the normative boundary and decision logic of the SSCAR family: its component agents, its family integrator, and the composed family-level verdict that none of the components produces alone.

The authoritative documents are the specifications of the component agents and of the family integrator. Where this README and any specification appear to differ, the specification controls.

---

### What this package is, and is not

This package **is** a self-contained, normative, execution-neutral family specification, delivered as-is, sufficient for an engineering team to build the family — each component agent and the integrator that composes them — without further design decisions about agent logic, composition order, evidence shape, validator behavior, or failure semantics.

This package **is not** software, SaaS, a managed service, consulting, support, managed operations, or implementation delivery. It is not a live runtime — nothing in the package executes; everything in the package describes how a conforming executable family must behave.

The family capability is **emergent**: it arises only from the complete composition of all component agents together with the integrator and its connector annexes. No component produces it alone, and no subset of components produces it.

---

### What you received

**The family** — the normative product you implement from:

| Path | Role |
| --- | --- |
| `UNIT/AGT-VRA-001/` | Verified Rehydration Agent — component agent. Its own specification, indexes, ambiguity register and conformance tests, with its own README, Whitepaper, License and Manifest. |
| `UNIT/FPA-FRESHNESS-PORTABILITY-003/` | Freshness Portability Agent — component agent. Its own specification, indexes, ambiguity register and conformance tests, with its own README, Whitepaper, License and Manifest. |
| `UNIT/BDA-BOUNDARY-DEFENSE-002/` | Boundary Defense Agent — component agent. Its own specification, indexes, ambiguity register and conformance tests, with its own README, Whitepaper, License and Manifest. |
| `UNIT/TAA-TRUTH-ARBITRATION-001/` | Truth Arbitration Agent — component agent. Its own specification, indexes, ambiguity register and conformance tests, with its own README, Whitepaper, License and Manifest. |
| `UNIT/ARA-AUDIT-REPLAY-001/` | Audit Replay Agent — component agent. Its own specification, indexes, ambiguity register and conformance tests, with its own README, Whitepaper, License and Manifest. |
| `UNIT/FAM-SSCAR-FI-001/` | Session State Continuity & Anchor Replay Family Integrator — family integrator. Its own specification, indexes, ambiguity register and conformance tests, with its own README, Whitepaper and Manifest. It additionally carries the connector annexes (`SSCAR_Concept_Identity_Register.md`, `SSCAR_Family_Connector_Tests.md`, `SSCAR_Producer_Consumer_Manifest.md`), which define what each component exposes to the composition and what the composition may assume. No component carries these. |
| `NNT_Family_Companion/` | Non-Normative Tests for the composed family. Demonstration-only evidence that the family is derivable; not a reference implementation, and not part of the specification. |

**Integrity** — how you verify that what you hold is authentic:

| File | Role |
| --- | --- |
| `SSCAR_Family_License.md` | The license for this family package. |
| `SSCAR_Family_Manifest.sha256` | Family-level SHA-256 manifest: each unit's own Manifest, direct hashes of the unit files those Manifests do not cover, and the family-level files. Two-level integrity. |
| `verify.md` | Self-audit runbook you run against the package you hold. |

Every unit is carried unchanged — the same files, byte for byte, as that unit's own package. Each unit's README describes that package, including an NNT companion and a `verify.md` that the unit does not carry here. A component agent is verified by the `verify.md` of its own package. The family integrator has no package of its own: it is verified here, in composition, by the family `verify.md`, which also verifies that every unit you hold is intact and is the package it names. The composed family's non-normative evidence is `NNT_Family_Companion/`.

The package as a whole, and every use of the composed family, is governed by `SSCAR_Family_License.md`. The License carried inside a component's unit is that agent's own license: it governs the agent when it is used on its own, outside the composition, and is accepted separately, as that License states.

---

### Suggested reading order

1. **This README** — the package's map: what is in it and how the pieces relate.
2. **Integrity check** — run the integrity section of `verify.md` against the Family Manifest to confirm the package is intact and authentic before reading further.
3. **License** — the terms of use. The license sets out what is free; the reserved uses are not licensed for this package.
4. **The family whitepaper** — `UNIT/FAM-SSCAR-FI-001/SSCAR_Whitepaper.html`, shipped inside the integrator's unit; there is no separate family-level copy. Why the family exists: problem, outcomes, domains. *(Non-normative — context only; carry no terminology from it into implementation.)*
5. **The integrator specification** — read it before the components. It defines the composition: which component verdicts enter, in what order, under what preconditions, and how the family-level verdict is formed. Reading the components first invites the assumption that the family is their sum; it is not.
6. **Each component specification, in the order the integrator composes them** — with each component's Semantic Index and Ambiguity Register read before its implementation core, exactly as that component's own README directs.
7. **The connector annexes** — the wiring between components: what each component must expose to the integrator and what the integrator may assume.
8. **Conformance Tests, per component and for the family** — the component suites establish each component's conformance; the family suite establishes the composition. A family that passes every component suite and fails the family suite is not conformant.
9. **NNT companion** — non-normative, demonstration-only evidence that the family is derivable. Do not read before implementing; read only after your implementation passes the Conformance Tests.
10. **After implementation: `verify.md`, full runbook** — the package's self-audit: re-run its remaining checks against the package you hold. Your implementation's conformance is established by the Conformance Tests, not by `verify.md`.

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

### Composition is not optional

The component specifications in this package are the same normative documents distributed as standalone agent packages. What this package adds is the integrator, the connector annexes, and the composed conformance suite — that is, the family-level guarantee.

Implementing the components without the integrator produces conforming components and no family. Implementing the integrator against components that do not pass their own conformance suites produces a composition with no foundation. Neither is a conforming family, and neither carries the family-level verdict.

---

### Support model

This document package is distributed free of charge and delivered as-is. No support, consulting, implementation, or operational services are included or offered. Your engineering team owns implementation, deployment, operation, and maintenance.

---

*End of README.*
