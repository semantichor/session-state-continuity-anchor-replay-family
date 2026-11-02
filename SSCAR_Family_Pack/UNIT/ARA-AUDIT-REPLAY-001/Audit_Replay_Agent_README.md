# Audit Replay Agent
## README

You have received a **specification document package**, distributed free of charge. It defines `ARA-AUDIT-REPLAY-001`, an offline audit/replay/verification agent for deterministic reconstruction of ledger-backed sessions, hash-chain continuity validation, checkpoint and rollback replay, and evidence-sufficient audit reporting.

The authoritative document is `Audit_Replay_Agent_Specification.md`. Where this README and the specification appear to differ, the specification controls.

---

### What this package is, and is not

This package **is** a self-contained, normative, execution-neutral single agent specification, delivered as-is, sufficient for an engineering team to build the agent without further design decisions about agent logic, evidence shape, validator behavior, or failure semantics.

This package **is not** software, SaaS, a managed service, consulting, support, managed operations, or implementation delivery. It does not approve source semantic content, activate tool-state without a separate gate, relax policy, or perform persistent writes during startup verification. It is not a live runtime — nothing in the package executes; everything in the package describes how a conforming executable agent must behave.

---

### What you received

**The specification** — the normative product you implement from:

| File | Role |
| --- | --- |
| `Audit_Replay_Agent_Specification.md` | Normative specification. The authoritative document. |
| `Audit_Replay_Agent_Semantic_Index.md` | Semantic Index — Human Edition (D1). Canonical glossary of all 86 normative terms. |
| `Audit_Replay_Agent_Semantic_Index.yaml` / `Audit_Replay_Agent_Semantic_Index.json` | Semantic Index — Structured Edition (D2). The same glossary as data, 1:1 with D1. For tooling. |
| `Audit_Replay_Agent_Coverage_Matrix.md` | Semantic Coverage Matrix (D3). Links term categories to the specification's sections. |
| `Audit_Replay_Agent_Ambiguity_Register.md` | Ambiguity Register (D4). 14 lexical-overload resolutions. Read before normalization questions arise. |
| `Audit_Replay_Agent_Conformance_Tests.md` | Conformance tests you run against your implementation, with fixtures, oracles, and minimal run note. |

**Non-normative material** — accompanies the specification, but is not part of it:

| File | Role |
| --- | --- |
| `Audit_Replay_Agent_Whitepaper.html` | Public-facing positioning. Non-normative. |
| `NNT_Companion/` | Non-Normative Tests — demonstration-only evidence that the specification is derivable. Not a reference implementation, and not part of the specification. Do not read it before implementing: read it only after your implementation passes the Conformance Tests. |
| `Audit_Replay_Agent_README.md` | This file. Orientation and reading order. |

**Integrity** — how you verify that what you hold is authentic:

| File | Role |
| --- | --- |
| `Audit_Replay_Agent_License.md` | The license. |
| `Audit_Replay_Agent_Manifest.sha256` | SHA-256 integrity manifest. |
| `verify.md` | Self-audit runbook you run against the package you hold. |

---

### Suggested reading order

1. **This README** — the package's map: what is in it and how the pieces relate.
2. **Integrity check** — run the integrity section of `verify.md` against the Manifest to confirm the package is intact and authentic before reading further.
3. **License** — the terms of use. The license sets out what is free; the reserved uses are not licensed for this package.
4. **Whitepaper** — why the agent exists: problem, outcomes, domains. *(Non-normative — context only; carry no terminology from it into implementation.)*
5. **Specification, front matter and §§1–7** — purpose, scope, authority boundaries, workflow and state transitions, input/output contracts, controlled verdict vocabulary, and the self-contained interpretation boundary.
6. **Semantic Index — Human Edition (D1)** and **Ambiguity Register (D4)** — the canonical terms and their resolved ambiguities; read before the implementation core to avoid normalization mistakes. The Semantic Index, Semantic Coverage Matrix, and Ambiguity Register are derived views of the specification's own vocabulary — the specification is semantically closed, so they cannot legitimately disagree with it. If you observe a divergence, re-run the integrity check. If the copy is intact, the divergence is a release defect: the specification controls, and you should report it to the source that provided the package.
7. **Specification §§8–15** — validators, decision table, evidence contract, machine-readable forms, gate logic, semantic contract, ordering rules, failure semantics. The implementation core.
8. **Specification §§16–21** — assumptions and derived obligations, optional features, observability requirements, assurance claims, minimum verification scenarios, reuse and dependency notes.
9. **Conformance Tests** — fixtures, oracles, and the acceptance criteria your implementation must meet.
10. **Semantic Coverage Matrix (D3)** — cross-check that every term category traces to its sections.
11. **Semantic Index — Structured Edition (D2, YAML/JSON)** — the same glossary as data; consume at implementation time.
12. **NNT companion** — non-normative, demonstration-only evidence that the specification is derivable. Do not read before implementing; read only after your implementation passes the Conformance Tests.
13. **After implementation: verify.md, full runbook** — the package's self-audit: re-run its remaining checks against the package you hold. Your implementation's conformance is established by the Conformance Tests, not by verify.md.

---

### What the specification guarantees

5 structural properties, defined in spec §19 and elaborated through the failure semantics, workflow, gate logic, and evidence contract sections:

1. **Identity and boundary are explicit.** The agent is delimited by identity, role, authority, boundary, and output contracts.
2. **Replay is offline-auditable.** The specified artifacts permit reconstruction of state and history without live access to the underlying system.
3. **Integrity is constitutive.** Verdict `REPLAYABLE` may not be issued without proof of frame-parse validity, signature validity where required, and hash-chain continuity.
4. **Critical failure is observable and bounded.** Every critical failure produces `FAIL_CLOSED`, `NONCOMPLIANT_HOLD`, or an explicit negative verdict. Silent failure is not permitted.
5. **Deployment limits remain external.** Deployment controls and external verification remain the responsibility of the deployment owner or external assurance component; their absence must be reported as an explicit gap, not masked.

These are properties of the specification. They are not warranties about a delivered running system.

---

### What your team must produce

Per spec §21 Reuse and Dependency Notes, §18 Observability Requirements, and §20 Minimum Verification Scenarios, at least 7 deployment artifacts are produced by your engineering and operations teams from this public package:

1. A conforming executable implementation of the Audit Replay Agent.
2. An active policy profile with resolvable `policy_profile_id` / `policy_hash` bindings.
3. A compatible trust store or verification policy for signature and provenance checks.
4. Session-bundle ingestion and export handling for records admitted by the public specification and your declared deployment policy.
5. Validator implementations for `V-01` through `V-10`, with validator outcomes linked to evidence references.
6. Output generation for `OC-01` Audit Report, `OC-02` Machine Evidence, and `OC-03` Incident Notice, including report signature or export-manifest linkage.
7. Release-gate use of the public test suite, fixtures, oracles, and minimal run note.

The public specification does not expose a separately named "Implementation Acceptance Criteria" section. For implementation acceptance, use spec §20 and the public conformance suite `ARA-T001` through `ARA-T027`. The acceptance surface is closed by the specification rules, the public tests, and your declared operator parameters.

---

### How to verify your implementation conforms

The Conformance Tests document contains 27 test records anchored to the specification: 22 directly runnable on the agent's projection surface, 1 parameterized against operator-declared inputs, and 4 declarative checks verified at integration level. Each record cites the specification authority that grounds it, the input fixture that drives it, and the oracle that defines pass and fail. The Minimal Run Note declares the projection surface, input types, assertion result types, and the conformance condition for the suite as a whole.

Run the suite against your implementation. A fully conformant implementation passes the 22 runnable tests, satisfies the 1 parameterized test under your declared parameter envelope, and attests the 4 declarative checks at your release-acceptance gate.

---

### How the agent is deployed by your team

The agent has a single deployment scope: offline audit/replay/verification of ledger-backed session artifacts in high-audit environments, including offline or air-gapped environments where signed export, chain of custody, policy binding, and optional external assurance integration are required. It is implemented and operated by your engineering and operations teams as a canonical audit/replay/verification component that reconstructs session state, verifies hash continuity, evaluates checkpoint and rollback lineage, and emits audit outputs. Composing this agent with others from the same library, including as a component within a family integrator, is specified in the relevant family pack — a separate package with its own documents and terms.

In all cases, deployment is performed by your engineering and operations teams. This package is not the deployer.

---

### How to read the package when a question arises

The package is closed on what it must close and deliberately open on what your operating context must close. When implementing or running the agent, edge cases will arise. Read them in this order:

1. **The specification rules first.** If the specification, decision table, gate logic, evidence contract, or validator catalogue resolves the case — apply that rule. The canonical verdicts in spec §§5, 11, and 13, together with the dominant fail-closed rule in spec §§2, 12, and 15, cover most situations directly.
2. **Operator-declared parameters second.** Where the specification leaves a parameter to your declaration — compute ceilings, time/memory limits, policy-resolved branches, trust-store setup, assurance routing, and deployment controls — your policy declarations are the authority. Close the case in that policy.
3. **Your own governance third.** Where neither the specification nor an operator-declared parameter applies, the case belongs to your release governance, security authority, deployment owner, external verifier, or human auditor — exactly as the specification's authority boundary (§4) requires. The agent does not adjudicate beyond its scope.

If you find yourself reconstructing the agent's central decision logic to answer an edge case, stop — this is a signal that one of the three layers above has not been applied. The package is built so that no reconstruction of core decision logic is needed on your side.

---

### Authority boundary

The agent's authority source is the active policy profile, admitted input package, validator catalogue, and evidence contract. Its delegated scope is framing, checksum, and parsing verification; signature and hash-continuity verification; state reconstruction; checkpoint, rollback, and report reconstruction. It does not create or modify session axioms, rewrite the ledger, approve new imports, replace a human operator for deployment exceptions, or override policy-defined compute, time, and memory ceilings.

This boundary is normative (spec §4 and reinforced by spec §21) and cannot be overridden by integration choices.

---

### Versioning

| Field | Value |
| --- | --- |
| Specification version | Released; agent version unspecified in package metadata |
| Index version (D1 / D2 / D3 / D4) | v2.0 |
| Term count (D1 / D2 / D3) | 86 |
| Ambiguity entries (D4) | 14 |
| Conformance test records | 27 |

If any field above does not match the corresponding metadata in the files you opened, contact the source that provided the package to obtain the correct release. Do not implement against a version-mismatched package.

---

### Support model

This document package is distributed free of charge and delivered as-is. No support, consulting, implementation, or operational services are included or offered. Your engineering team owns implementation, deployment, operation, and maintenance.

---

*End of README.*
