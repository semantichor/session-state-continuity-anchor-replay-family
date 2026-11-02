# R1.5 Comprehension quote-back — FAM-SSCAR-FI-001 (prolog)

11 load-bearing quotes spanning the 6 component/integrator packs (at least one per pack).

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §2 Agent Overview / Core invariants
  QUOTE: "No restoration is permitted before the full verification sequence completes successfully."

- FILE: Verified_Rehydration_Agent_Conformance_Tests.md
  LOC: §1 Public Test Suite / PT-001 Purpose
  QUOTE: "Verify earliest valid passing-path progression from startup read-only into snapshot lock."

- FILE: Boundary_Defense_Agent_Specification.md
  LOC: Semantic Core Summary / Semantic invariant
  QUOTE: `No boundary artifact acquires execution, persistence, or transport visibility without explicit validation evidence appropriate to its class`

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: §1 Scope and Criticality
  QUOTE: "The implementation shall operate in fail-closed mode, maintain replay and offline reconstruction capability, and permit readmission only under policy and only after audited clearance."

- FILE: Audit_Replay_Agent_Specification.md
  LOC: §19 Assurance Claims / Integrity claim
  QUOTE: "Verdict REPLAYABLE may not be issued without proof of frame-parse validity, signature validity, and hash-chain continuity."

- FILE: Freshness_Portability_Agent_Specification.md
  LOC: §2.1 Normative Capabilities
  QUOTE: "Separates acceptance from restoration: acceptance creates receipt anchoring, while restoration eligibility is granted only for the accepted head."

- FILE: SSCAR_Specification.md
  LOC: §1 Operational Objective and Required Control Coverage
  QUOTE: "No single subordinate control decides family-level replay admissibility on its own"

- FILE: SSCAR_Ambiguity_Register.md
  LOC: D4 AMB-01 disallowed_collapse
  QUOTE: "Replacing the family verdict with an isolated local result."

- FILE: SSCAR_Conformance_Tests.md
  LOC: §8 Minimal Run Note / PASS condition (c)
  QUOTE: "independent third party can reconstruct verdict from FOC-02 + family validator bundle alone, for at least one representative boundary event"

- FILE: SSCAR_Producer_Consumer_Manifest.md
  LOC: Annex A §1 Purpose and Use
  QUOTE: "It describes the wiring that must hold for the family integrator to compose a valid replay-admissibility verdict over its five components."

- FILE: SSCAR_Concept_Identity_Register.md
  LOC: Annex B §1 Purpose and Use
  QUOTE: "This annex prevents the situation in which two components use the same term with different meanings, or two different names for the same operational object."

## Structural cross-checks (S1–S4)

- FILE: Truth_Arbitration_Agent_Specification.md
  LOC: §9 Gate Logic (default / catch-all clause)
  QUOTE: "If no specialized branch applies and the decision path is structurally incomplete"

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §7 Ordering and Verification Sequence (failure ordering)
  QUOTE: "No later step may execute if a prior critical step has failed."

- FILE: Boundary_Defense_Agent_Specification.md
  LOC: Evidence Contract Record / Failure rule
  QUOTE: "Absence of mandatory evidence downgrades the action to non-compliant and blocks compliance-claimed release"

- FILE: Verified_Rehydration_Agent_Specification.md
  LOC: §16 Precedence rules
  QUOTE: "A failed critical validator prevails over operational utility considerations."

## Application probes (AP1–AP3)

- FILE: Freshness_Portability_Agent_Conformance_Tests.md
  LOC: §D VP-GEN-011 No silent preservation (Source state → trigger → target)
  QUOTE: "Any non-source state + invalid trigger combination → S8 REJECTED (fail-closed default)"

- FILE: SSCAR_Specification.md
  LOC: §11 Evidence Contract / FEV-14 contamination_flags / contaminating_ref_set
  QUOTE: "Mandatory for contamination fail-closed cases."

- FILE: SSCAR_README.md
  LOC: README front matter (authoritative-document precedence)
  QUOTE: "Where this README and the specification appear to differ, the specification controls."
