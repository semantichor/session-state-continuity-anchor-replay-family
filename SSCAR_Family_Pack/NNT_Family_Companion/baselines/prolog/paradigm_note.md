# Paradigm Note — prolog

Observational. What `prolog` did with this specification.

## 1. What `prolog` made EASY

The spec construct is the state-transition table (SSCAR §9; VRA §12; FPA §8; etc.),
a relation from `(state, trigger, validator_passed)` to a next state. `prolog` represents
this directly as Horn clauses — `fsm_fam(From, Trigger, VP, To)` as a set of facts/rules
read by unification, with no explicit conditional. The §10 gate-logic exclusivity ("if FV-02,
FV-03, FV-07, or FV-09 fails in blocking mode, the verdict is `CONTAMINATION_FAIL_CLOSED`")
maps onto ordered clauses closed with cut (`!`): the blocking-trigger clauses are placed first
and cut, so the resolver cannot fall through to a weaker clause. The fail-closed default of
each component machine ("No later step may execute if a prior critical step has failed", VRA §7)
is a single final catch-all clause. Letting the resolver derive the next state from the clause
set, rather than hand-coding branches, kept the per-component machines and the family machine
close to the tabular form of the spec.

## 2. What `prolog` made HARD

The spec construct is AMB-17: `REPLAY_INCOMPLETE` and `INCIDENT_ONLY` are family verdicts with
no workflow state, signalled by non-advancement plus verdict-layer emission. A single `prolog`
relation `fsm_fam/4` resolves to a state, so it cannot itself return these verdict-layer tokens;
the verdict-emission layer had to be a separate relation (`fam_vmap/2`) and the state machine a
non-advancement (identity) clause. `prolog` is untyped, so the PTS-021 requirement that
`FamilyWorkflowState` and `FamilyNormativeVerdict` be non-interconvertible has no compile-time
support here — it is held only by keeping the two as separate predicates and separate output
keys, a discipline the language does not enforce. The paired-comparison records (PT-014, PTS-008,
PTS-022) also needed more than one goal resolution, since a single clause yields one answer; the
runner drives the multiple goals and compares their captured outputs.
