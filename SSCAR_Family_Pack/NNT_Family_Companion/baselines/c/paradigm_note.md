# Paradigm Note — c

Observational. What `c` did with this spec.

## What `c` made EASY

The closed state machines mapped almost one-to-one onto `c`'s native constructs. Each spec transition table (VRA §12, BDA PR-WF, TAA §5.1, ARA §6, FPA §8, SSCAR §9) became an `enum` for states, an `enum` for triggers, and a static data table of transition rows `{from, trigger, on_pass, on_fail}` scanned by `trow_lookup`, with the agent- and surface-level dispatch done through function-pointer tables (`agent_fn_t AGENTS[]`). The fail-closed defaults the specs demand (VRA S5, FPA REJECTED per PR-10, TAA FAIL_CLOSED per PT-011) fell out naturally as the `else` arm after the table scan. `assert()` over the enum verdict layer let the §10 gate-precedence ladder be checked at process start (`self_invariants`), so a mis-ordered branch surfaces immediately rather than as a silent wrong verdict. The six-value verdict set and the §7 two-branch fail effects (FV-03, FV-07) expressed cleanly as a `switch` with an explicit discriminator field.

## What `c` made HARD

The EMERGENT family verdict resisted the single value-returning function `c` makes natural. §4.1 defines six verdicts, two of which (`REPLAY_INCOMPLETE`, `INCIDENT_ONLY`) have no workflow state (AMB-17), so a `next_state(...) -> FamilyWorkflowState` function physically cannot return them. The spec's verdict-is-not-state distinction forced two separate surfaces — `fam_next` returning `enum FamState` and `fam_verdict` returning `enum FamVerdict` over a `fv_outcomes_t` struct — and deliberate care NOT to collapse the two enums into one return type, which `c` would otherwise invite. `c`'s absence of a native string/set type also made the CLI token-to-enum parsing and the evidence field-presence surfaces (FEV-01..FEV-15, the 13 BDA mandatory fields) verbose: name/enum lookup arrays plus `strcat`-built field lists stand in for what the spec states as sets.
