# Freshness Portability Agent
## v1.0 — README

You have received a **specification document package**, distributed free of charge. It defines a strict freshness-governed boundary agent for import acceptance, receipt anchoring, watermark advancement, restoration eligibility, quarantine, and readmission across sources and devices.

The authoritative document is `Freshness_Portability_Agent_Specification.md`. Where this README and the specification appear to differ, the specification controls.

---

### What this package is, and is not

This package **is** a self-contained, normative, execution-neutral single agent specification, delivered as-is, sufficient for an engineering team to build the agent without further design decisions about agent logic, evidence shape, validator behavior, or failure semantics.

This package **is not** software, SaaS, a managed service, consulting, support, managed operations, or implementation delivery. It does not approve source semantic content, activate tool-state without a separate gate, relax policy, or perform persistent writes during startup verification. It is not a live runtime — nothing in the package executes; everything in the package describes how a conforming executable agent must behave.

---

### What you received

**The specification** — the normative product you implement from:

| File | Role |
| --- | --- |
| `Freshness_Portability_Agent_Specification.md` | Normative specification. The authoritative document. |
| `Freshness_Portability_Agent_Semantic_Index.md` | Semantic Index — Human Edition (D1). Canonical glossary of all 121 normative terms. |
| `Freshness_Portability_Agent_Semantic_Index.yaml` / `Freshness_Portability_Agent_Semantic_Index.json` | Semantic Index — Structured Edition (D2). The same glossary as data, 1:1 with D1. For tooling. |
| `Freshness_Portability_Agent_Coverage_Matrix.md` | Semantic Coverage Matrix (D3). Links term categories to the specification's sections. |
| `Freshness_Portability_Agent_Ambiguity_Register.md` | Ambiguity Register (D4). 12 lexical-overload resolutions. Read before normalization questions arise. |
| `Freshness_Portability_Agent_Conformance_Tests.md` | Conformance tests you run against your implementation, with fixtures, oracles, and minimal run note. |

**Non-normative material** — accompanies the specification, but is not part of it:

| File | Role |
| --- | --- |
| `Freshness_Portability_Agent_Whitepaper.html` | Public-facing positioning. Non-normative. |
| `NNT_Companion/` | Non-Normative Tests — demonstration-only evidence that the specification is derivable. Not a reference implementation, and not part of the specification. Do not read it before implementing: read it only after your implementation passes the Conformance Tests. |
| `Freshness_Portability_Agent_README.md` | This file. Orientation and reading order. |

**Integrity** — how you verify that what you hold is authentic:

| File | Role |
| --- | --- |
| `Freshness_Portability_Agent_License.md` | The license. |
| `Freshness_Portability_Agent_Manifest.sha256` | SHA-256 integrity manifest. |
| `verify.md` | Self-audit runbook you run against the package you hold. |

---

### Suggested reading order

1. **This README** — the package's map: what is in it and how the pieces relate.
2. **Integrity check** — run the integrity section of `verify.md` against the Manifest to confirm the package is intact and authentic before reading further.
3. **License** — the terms of use. The license sets out what is free; the reserved uses are not licensed for this package.
4. **Whitepaper** — why the agent exists: problem, outcomes, domains. *(Non-normative — context only; carry no terminology from it into implementation.)*
5. **Specification, front matter, §§1–6 and §§9–10** — purpose, scope, principles, authority boundaries, decision table, input/output contracts, and controlled verdict vocabulary.
6. **Semantic Index — Human Edition (D1)** and **Ambiguity Register (D4)** — the canonical terms and their resolved ambiguities; read before the implementation core to avoid normalization mistakes. The Semantic Index, Semantic Coverage Matrix, and Ambiguity Register are derived views of the specification's own vocabulary — the specification is semantically closed, so they cannot legitimately disagree with it. If you observe a divergence, re-run the integrity check. If the copy is intact, the divergence is a release defect: the specification controls, and you should report it to the source that provided the package.
7. **Specification §§7–15** — validators, workflow, evidence contract, machine-readable forms, gate logic, semantic contract, and ordering rules. The implementation core.
8. **Specification §§16–22 and Appendix A** — failure semantics, execution obligations, acceptance criteria, optionality, assurance, validation summary, reuse note, and normative rule summary.
9. **Conformance Tests** — fixtures, oracles, and the acceptance criteria your implementation must meet.
10. **Semantic Coverage Matrix (D3)** — cross-check that every term category traces to its sections.
11. **Semantic Index — Structured Edition (D2, YAML/JSON)** — the same glossary as data; consume at implementation time.
12. **NNT companion** — non-normative, demonstration-only evidence that the specification is derivable. Do not read before implementing; read only after your implementation passes the Conformance Tests.
13. **After implementation: verify.md, full runbook** — the package's self-audit: re-run its remaining checks against the package you hold. Your implementation's conformance is established by the Conformance Tests, not by verify.md.

---

### What the specification guarantees

4 public-facing structural properties, grounded in spec §§1.1, 2.1, 13, 15, and Appendix A and elaborated through the failure semantics, workflow, gate logic, and evidence contract sections:

1. **Freshness strictly increases per source.** The implementation must compare incoming freshness against the stored acceptance watermark and accept only newer values within the scoped `source_id` / `ledger_uuid` context.
2. **Replay is deterministically rejected.** A packet whose freshness is stale relative to the watermark is rejected without receipt emission or watermark update.
3. **Temporal ordering is preserved across device boundaries.** Ordering is based on freshness monotonicity and receipt-linked watermark advancement, not wall-clock timestamp.
4. **Cross-device portability remains safe under ordering guarantees.** The agent supports portability without device-bound counters while preserving receipt anchoring, restore eligibility boundaries, and fail-closed behavior.

These are properties of the specification. They are not warranties about a delivered running system.

---

### What your team must produce

Per spec §17 Implementation Assumptions and Execution Obligations, §18 Execution Acceptance Criteria, and §22 Reuse and Limitations, 8 deployment artifacts or implementation closures are built by your engineering team from this specification:

1. **Source identity binding.** A concrete mechanism for stable, verifiable `source_id` and `ledger_uuid` binding.
2. **Policy and trust configuration.** A concrete `policy_id` / `policy_version` profile, algorithm identifiers, and trust-anchor material for `SSM`, `TVC`, and `Evidence.bin` where applicable.
3. **Watermark store.** A monotonic persistence layer with anti-rollback properties and no decrement/rewrite path.
4. **Append-only receipt journal.** A durable IRR journal implementing receipt anchoring, accepted-head linkage, and previous-receipt linkage.
5. **Validator implementation map.** Execution-layer mappings for `VAL-001` through `VAL-011` and their specified failure effects.
6. **Restore-boundary integration.** A restore-admission path that checks valid IRR linkage and `GenesisConfirmed`, emits only the admission token, and does not execute restore inside this agent.
7. **Evidence and observability pipeline.** Logging, event, or audit instrumentation for every field in the Evidence Contract.
8. **Runtime conformance plan.** Tests and release-gate checks for fail-closed behavior, stale replay, recovery/idempotence, optionality envelopes, and declarative authority obligations.

The specification is complete enough that none of these requires interpretation of ambiguous prose.

---

### How to verify your implementation conforms

The Conformance Tests document contains 41 test records anchored to the specification: 30 directly runnable on the agent's projection surface, 5 parameterized against operator-declared inputs, and 6 declarative checks verified at integration level. Each record cites the specification authority that grounds it, the input fixture that drives it, and the oracle that defines pass and fail. The Minimal Run Note declares the projection surface, input types, assertion result types, and the conformance condition for the suite as a whole.

Run the suite against your implementation. A fully conformant implementation passes the 30 runnable tests, satisfies the 5 parameterized tests under your declared parameter envelopes, and attests the 6 declarative checks at your release-acceptance gate.

---

### How the agent is deployed by your team

The agent has a single deployment scope: strictly increasing freshness acceptance across sources and devices, including import acceptance, receipt anchoring, watermark advancement, restore eligibility, quarantine, and readmission. It is implemented and operated by your engineering and operations teams as an execution-neutral boundary gate between the import channel, receipt journal, restore service, operator boundary, and policy layer. Composing this agent with others from the same library, including as a component within a family integrator, is specified in the relevant family pack — a separate package with its own documents and terms.

In all cases, deployment is performed by your engineering and operations teams. This package is not the deployer.

---

### How to read the package when a question arises

The package is closed on what it must close and deliberately open on what your operating context must close. When implementing or running the agent, edge cases will arise. Read them in this order:

1. **The specification rules first.** If the specification, decision table, gate logic, evidence contract, or validator catalogue resolves the case — apply that rule. The canonical verdicts (§§6, 13, and 14) and the dominant fail-closed rule (§16) cover most situations directly.
2. **Operator-declared parameters second.** Where the specification leaves a parameter to your declaration — policy requirements, transport requirements, trust anchors, storage mechanisms, observability channels, or source-specific activation rules — your policy declarations are the authority. Close the case in that policy.
3. **Your own governance third.** Where neither the specification nor an operator-declared parameter applies, the case belongs to your release governance, security authority, or human auditor — exactly as the specification's authority boundary (§5) requires. The agent does not adjudicate beyond its scope.

If you find yourself reconstructing the agent's central decision logic to answer an edge case, stop — this is a signal that one of the three layers above has not been applied. The package is built so that no reconstruction of core decision logic is needed on your side.

---

### Authority boundary

Authority derives only from the rules in the specification and the local policy snapshot identified by `policy_id` and `policy_version` on the evaluated decision path. The agent may evaluate freshness, emit semantic gate verdicts, request receipt append, request watermark advancement, declare restoration eligibility, and quarantine or readmit cases. It may not activate tools, override policy, execute restore, decrement or rewrite watermarks, administer trust anchors, or reinterpret freshness acceptance as permission for any out-of-scope action.

This boundary is normative and cannot be overridden by integration choices.

---

### Versioning

| Field | Value |
| --- | --- |
| Specification version | v1.0 |
| Index version (D1 / D2 / D3 / D4) | v2.0 |
| Term count (D1 / D2 / D3) | 121 |
| Ambiguity entries (D4) | 12 |
| Conformance test records | 41 |

If any field above does not match the corresponding metadata in the files you opened, contact the source that provided the package to obtain the correct release. Do not implement against a version-mismatched package.

---

### Support model

This document package is distributed free of charge and delivered as-is. No support, consulting, implementation, or operational services are included or offered. Your engineering team owns implementation, deployment, operation, and maintenance.

---

*End of README.*
