# R1.5 — Comprehension Quote-Back (FAM-SSCAR-FI-001 family composition)

18 blocks: 11 load-bearing pack-file quotes spanning the 6 packs, then S1–S4 structural cross-checks, then AP1–AP3 application probes.

## 11 load-bearing quotes (one+ per pack, 6 packs)

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §7 Ordering and Verification Sequence
  QUOTE: "No later step may execute if a prior critical step has failed."

- FILE: Verified_Rehydration_Agent_Conformance_Tests.md
  LOC: §4 Minimal Run Note — Suite PASS condition
  QUOTE: "every runnable test passes, the parameterized authority-release branch lands only in the permitted state set, and both declarative bounded external-enforcement checks are satisfied by implementation evidence."

- FILE: Boundary_Defense_Agent_Specification.md
  LOC: Semantic Contract Record — BLOCK meaning
  QUOTE: "The artifact is inadmissible and SHALL NOT mutate governed state or gain boundary visibility."

- FILE: Boundary_Defense_Agent_Conformance_Tests.md
  LOC: §5 Minimal Run Note — PASS condition for this extracted suite
  QUOTE: "All runnable tests pass; all parameterized tests remain within the authorized parameter envelope; all declarative obligations are implemented in bounded architecture locations"

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: §3 Authority Model
  QUOTE: "Where provenance cannot be verified, policy snapshot consistency cannot be maintained, formal conflict is confirmed, or declared budgets are exceeded, the agent shall not degrade to ALLOW."

- FILE: Truth_Arbitration_Agent_Conformance_Tests.md
  LOC: §4 Minimal run note — PASS condition
  QUOTE: "All 25 runnable tests assert their expected normative result against the package's projection surface"

- FILE: Audit_Replay_Agent_Specification.md
  LOC: §2 Foundational Record Models and Interpretation Boundary
  QUOTE: "No positive verdict and no logical restoration may be issued if framing, checksum, canonical parsing, signature validation, hash continuity, or policy checks fail."

- FILE: Audit_Replay_Agent_Conformance_Tests.md
  LOC: §8 Minimal Run Note — PASS condition
  QUOTE: "All Runnable tests pass; Parameterized tests remain inside the declared parameter envelope; Declarative obligations are implemented or documented in the bounded external/gate surface"

- FILE: Freshness_Portability_Agent_Specification.md
  LOC: §13 Gate Logic — Determinacy rule
  QUOTE: "For each decision object, exactly one normative path may remain active after evaluating the full condition set."

- FILE: Freshness_Portability_Agent_Conformance_Tests.md
  LOC: §H Minimal Run Note — PASS condition for the public suite
  QUOTE: "Every runnable test in §F.R passes its declared assertion. Every parameterized test in §F.P passes for both branches of its bounded parameter envelope."

- FILE: SSCAR_Specification.md
  LOC: §1 Operational Objective and Required Control Coverage
  QUOTE: "The family verdict is distinct from any local verdict. No single subordinate control decides family-level replay admissibility on its own"

## S1–S4 structural cross-checks

- FILE: Freshness_Portability_Agent_Conformance_Tests.md
  LOC: S1 — §D VP-GEN-011 transition-table catch-all / fail-closed default row
  QUOTE: "Any non-source state + invalid trigger combination → S8 REJECTED (fail-closed default)"

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: S2 — §7 failure-ordering rule (rollback priority)
  QUOTE: "Rollback detection has blocking priority over every other restoration rule."

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: S3 — §8 Evidence Contract mandatory-field requirement (all outcomes)
  QUOTE: "Any verdict missing the required closure fields is partial or invalid."

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: S4 — §16 Precedence rules
  QUOTE: "A failed critical validator prevails over operational utility considerations."

## AP1–AP3 application probes

- FILE: Freshness_Portability_Agent_Specification.md
  LOC: Appendix A PR-10 — rule governing a non-enumerated (state, trigger) at runtime
  QUOTE: "Agent states are finite and closed, and only validated transitions may be selected externally."

- FILE: SSCAR_Specification.md
  LOC: §1.4 Cross-domain operating rule 11 — mandatory evidence for every (incl. deny-class) verdict
  QUOTE: "Each family verdict must produce a minimum evidence bundle sufficient for offline reconstruction of the boundary event."

- FILE: SSCAR_README.md
  LOC: README precedence — rule deciding which document prevails on disagreement
  QUOTE: "Where this README and the specification appear to differ, the specification controls."
