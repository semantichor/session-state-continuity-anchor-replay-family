# R1.5 Comprehension Quote-Back — FAM-SSCAR-FI-001 (python)

18 blocks: 11 load-bearing (spanning the 6 packs), S1-S4 structural cross-checks, AP1-AP3 application probes. Quotes are verbatim from the 68 buyer-facing files; delimited in backticks to preserve spec terminology.

## 11 load-bearing quotes (>=1 per pack across the 6 packs)

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §6 Verdict Semantics
  QUOTE: `A conformant implementation must not downgrade DENY, QUARANTINE, or ESCALATE into non-blocking warnings and must not extend ALLOW beyond the declared eligible context`

- FILE: Verified_Rehydration_Agent_Conformance_Tests.md
  LOC: §1 Public Test Suite / PT-001 Purpose
  QUOTE: `Verify earliest valid passing-path progression from startup read-only into snapshot lock`

- FILE: Boundary_Defense_Agent_Specification.md
  LOC: Semantic Core Summary / Semantic invariant
  QUOTE: `No boundary artifact acquires execution, persistence, or transport visibility without explicit validation evidence appropriate to its class`

- FILE: Boundary_Defense_Agent_Conformance_Tests.md
  LOC: §5 Minimal Run Note / PASS condition for this extracted suite
  QUOTE: `All runnable tests pass; all parameterized tests remain within the authorized parameter envelope; all declarative obligations are implemented in bounded architecture locations`

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: §2.3 Central invariant: Boundary-Qualified No Unlabeled Claims
  QUOTE: `No claim may be used for gating, for changing governed state, for populating references in DECISION`

- FILE: Truth_Arbitration_Agent_Conformance_Tests.md
  LOC: §1 Declarative public conformance record (TAA-PT-020-DECL / VP-GEN-020)
  QUOTE: `V-008 ordering / serialization is real distributed enforcement, anchored in §11 Temporal/Ordering Contract and §9 Gate Logic, and not an orphaned validator`

- FILE: Audit_Replay_Agent_Specification.md
  LOC: §13 Semantic Contract / INCIDENT_ONLY
  QUOTE: `Only incident and remediation artifacts are permitted, not a compliant report`

- FILE: Audit_Replay_Agent_Conformance_Tests.md
  LOC: §8 Minimal Run Note / PASS condition
  QUOTE: `All Runnable tests pass; Parameterized tests remain inside the declared parameter envelope; Declarative obligations are implemented or documented in the bounded external/gate surface`

- FILE: Freshness_Portability_Agent_Specification.md
  LOC: §13 Gate Logic / Watermark rule
  QUOTE: `No watermark advances before receipt append, and no accepted watermark may be decremented`

- FILE: Freshness_Portability_Agent_Conformance_Tests.md
  LOC: §H Minimal Run Note / PASS condition for the public suite
  QUOTE: `Every runnable test in §F.R passes its declared assertion. Every parameterized test in §F.P passes for both branches of its bounded parameter envelope`

- FILE: SSCAR_Specification.md
  LOC: §1 Operational Objective and Required Control Coverage
  QUOTE: `The family verdict is distinct from any local verdict. No single subordinate control decides family-level replay admissibility on its own`

## S1-S4 structural cross-checks

- FILE: Freshness_Portability_Agent_Conformance_Tests.md
  LOC: §D Family C / VP-GEN-011 (catch-all / default transition handling)
  QUOTE: `Any non-source state + invalid trigger combination → S8 REJECTED (fail-closed default)`

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §7 Ordering and Verification Sequence (failure-ordering rule)
  QUOTE: `No later step may execute if a prior critical step has failed`

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: §8 Evidence Contract (evidence mandatory-field requirement, all verdicts)
  QUOTE: `For every verdict, the emitted evidence shall include at minimum`

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §16 Precedence rules
  QUOTE: `A failed critical validator prevails over operational utility considerations`

## AP1-AP3 application probes

- FILE: Freshness_Portability_Agent_Specification.md
  LOC: Appendix A Normative Rule Summary / PR-10
  QUOTE: `Agent states are finite and closed, and only validated transitions may be selected externally`

- FILE: SSCAR_Specification.md
  LOC: §13 Observability Rules / FOR-05
  QUOTE: `Every contamination case records contaminating\_ref\_set and blocked\_stage`

- FILE: SSCAR_README.md
  LOC: README front matter (document precedence)
  QUOTE: `Where this README and the specification appear to differ, the specification controls`
