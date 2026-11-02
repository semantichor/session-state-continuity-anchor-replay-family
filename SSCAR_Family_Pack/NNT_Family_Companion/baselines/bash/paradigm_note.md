# R8 Paradigm Note — `bash` and FAM-SSCAR-FI-001

Observational; what `bash` did with this spec, not a comparison.

## What `bash` made easy

The spec's state-event machines (VRA §12 transition model, BDA Workflow/State-Transition Record, TAA §5.1, ARA §6, FPA §8, and the SSCAR §9 twelve-state workflow) map almost one-to-one onto `case` pattern dispatch. A `case "$state" in … esac` with a nested `case "$trigger" in … esac` reproduces each transition table row directly, and the spec's fail-closed catch-all (VRA "No later step may execute", FPA "no silent preservation", SSCAR §10) becomes the single `*)` arm — the default that every unenumerated `(state, trigger)` falls through to. TAA's compound `X_TO_Y` triggers were handled naturally by glob patterns on the joined `"$state|$trigger"` string, e.g. `*_TO_FAIL_CLOSED)`, so the whole family of fail-closed-routing triggers collapses to one pattern. `trap … ERR` gave an explicit fail-closed path for unexpected command errors, matching the spec's fail-closed invariant. Parameter substitution (`${x:-default}`) carried the optional/conditional evidence fields cleanly.

## What `bash` made hard

`bash` has no typed records or enums, so the structural separations the spec is most careful about had to be carried as string conventions rather than types. The AMB-17 rule — `REPLAY_INCOMPLETE` and `INCIDENT_ONLY` are verdicts with no workflow state — could not ride on `next_state` (which returns only a state token); it required a separate verdict-emission function and a non-advancement convention, since a `case` returning a `FamilyWorkflowState` string literally cannot return those tokens. The verdict-vs-state disjointness (AMB-15, PTS-021) is a type property that `bash` can only assert by comparing strings, not enforce. The fifteen-field `FamilyEvidenceBundle` and cross-component byte-identity (Annex B CC-01: FPA `accepted_head_digest` equals the VRA head) had to be flat `key=value` lines and literal-string equality under `case`, and the FV-06 strict-increase check needed an arithmetic `[ -gt ]` guard outside the `case` idiom.
