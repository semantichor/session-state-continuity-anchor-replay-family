# Inconsistencies Log — FAM-SSCAR-FI-001 (rust)

Apparent tensions encountered during reading were cross-checked against the full SSCAR integrator pack
(Specification, Ambiguity Register, Conformance Tests, Annexes A/B/C, Coverage Matrix) and the five
component packs. Each resolved under complete cross-document reading and is therefore recorded as normal
cross-document derivation (R7), not here:

- The §8 decision rule `FD-05` lists gate impact `S5 → S8`, while §9 enumerates the path `S5 → S6 → S7 → S8`. This resolves: the decision table names the admitted outcome state of the rule, and §9 enumerates the intermediate workflow positions (`S6` entered on FV-08, `S7` on FV-10 and FV-11) that the rule traverses; AMB-16 governs the reuse of verdict tokens inside `FD-NN` labels.
- `FD-06` and `FD-09` both carry `INCIDENT_ONLY`. This resolves under AMB-16 (the `FD-NN` prefix is the rule identity; the shared token names the verdict each rule produces, not a seventh verdict).
- The §4.1 verdict tokens reappear as the state labels `SH NONCOMPLIANT_HOLD` and `SX CONTAMINATION_FAIL_CLOSED`. This resolves under AMB-15 (the unprefixed token is a verdict per §4.1; the prefixed form is a workflow state per §9).

No inconsistencies observed in this NNT run.
