# R1.5 Comprehension Quote-Back — FAM-SSCAR-FI-001 (bash paradigm)

18 blocks: 11 load-bearing (spanning all 6 packs) + S1–S4 structural cross-checks + AP1–AP3 application probes. Quotes are verbatim from the 68 buyer-facing files; backtick delimiters mark them as spec terms.

## 11 load-bearing quotes (≥1 per pack)

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §16 Precedence rules
  QUOTE: `A failed critical validator prevails over operational utility considerations.`

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §7 Ordering and Verification Sequence
  QUOTE: `Rollback detection has blocking priority over every other restoration rule.`

- FILE: Boundary_Defense_Agent_Specification.md
  LOC: Gate Logic Record (FAIL_CLOSED row)
  QUOTE: `No further substantive boundary action is permitted; an auditable failure is emitted`

- FILE: Boundary_Defense_Agent_Specification.md
  LOC: Semantic Contract Record (BLOCK)
  QUOTE: `The artifact is inadmissible and SHALL NOT mutate governed state or gain boundary visibility.`

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: §12 Failure Semantics and Readmission
  QUOTE: `Readmission loops without progress are forbidden.`

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: §1 Scope and Criticality
  QUOTE: `The implementation shall operate in fail-closed mode, maintain replay and offline reconstruction capability, and permit readmission only under policy and only after audited clearance.`

- FILE: Audit_Replay_Agent_Specification.md
  LOC: §13 Semantic Contract (BROKEN)
  QUOTE: `The integrity chain is not continuous; conclusions about the full history are invalid.`

- FILE: Audit_Replay_Agent_Specification.md
  LOC: §6 Workflow and State Transition Model (states S0–S6/SH/SX)
  QUOTE: `SX is a critical block. S6 is a session readmitted after compliance prerequisites are restored.`

- FILE: Freshness_Portability_Agent_Specification.md
  LOC: §13 Gate Logic (Watermark rule)
  QUOTE: `No watermark advances before receipt append, and no accepted watermark may be decremented.`

- FILE: Freshness_Portability_Agent_Specification.md
  LOC: §1.1 Primary Objectives
  QUOTE: `Deterministic anti-replay protection through a strictly increasing freshness rule.`

- FILE: SSCAR_Specification.md
  LOC: §1 Operational Objective and Required Control Coverage
  QUOTE: `The family verdict is distinct from any local verdict. No single subordinate control decides family-level replay admissibility on its own`

## S1–S4 structural cross-checks

- FILE: Truth_Arbitration_Agent_Conformance_Tests.md
  LOC: S1 — transition-table catch-all/default (TAA-PT-011 / VP-GEN-011, Family C)
  QUOTE: `Protective default outcome / no silent state preservation`

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: S2 — failure-ordering rule (§7)
  QUOTE: `No later step may execute if a prior critical step has failed.`

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: S3 — evidence-contract mandatory-field requirement, all outcomes (§8)
  QUOTE: `Any verdict missing the required closure fields is partial or invalid.`

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: S4 — precedence rule (§16 Precedence rules)
  QUOTE: `The accepted-head-only rule prevails over any local continuity of an unanchored tail.`

## AP1–AP3 application probes (retrieval-at-moment)

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: AP1 — unenumerated (state,trigger) outcome rule (§9 Gate Logic)
  QUOTE: `If no specialized branch applies and the decision path is structurally incomplete, the result shall be FAIL\_CLOSED.`

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: AP2 — negative-outcome (FAIL_CLOSED) evidence mandatory fields (§4.2 Output Contract Record)
  QUOTE: `For FAIL\_CLOSED, the output shall also include inhibit\_flags, root\_reason\_code, cleared\_only\_by, remediation\_class, and, where applicable, escalation\_request\_ref.`

- FILE: SSCAR_README.md
  LOC: AP3 — rule deciding which document prevails on disagreement
  QUOTE: `Where this README and the specification appear to differ, the specification controls.`
