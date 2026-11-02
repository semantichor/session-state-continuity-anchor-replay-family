# R8 Paradigm Note — python / FAM-SSCAR-FI-001

Observational. What `python` did with this family specification.

## What `python` made EASY

The spec's closed finite-state machines — VRA `S0`-`S8`, the family `S0`-`S8` + `SH`/`SR`/`SX`, the TAA 12-variant workflow, FPA `S0`-`S8` — mapped directly onto `enum.Enum` closed vocabularies plus dict-of-callables transition tables keyed on `(state, trigger)` with a structural `match` for the per-class evidence shapes. The spec construct "closed finite-state machine; deterministic, validator-driven transition" is exactly what a `{(State, trigger): handler}` dict expresses, so the forbidden manual `current_state` + `if/elif`-over-event-strings machine never arose; fail-closed defaults (FPA `PR-10` → `REJECTED`, TAA protective default → `FAIL_CLOSED`) are one `dict.get(...) or default` line. The many fixed field sets — the 15-field `FamilyEvidenceBundle` (`FEV-01..FEV-15`), `FOC-01..FOC-05`, each component evidence bundle — became `@dataclass` plus field tuples, and the closed verdict vocabularies became `Enum`s whose identity/equality gave the taxonomy-distinctness observations (`PTS-021`, `PTS-BDA-030`, `FPA-T-08c`) for free.

## What `python` made HARD

`AMB-17` forced two surfaces for one decision: because `REPLAY_INCOMPLETE` and `INCIDENT_ONLY` are verdicts with no workflow state, a single `Enum` state machine cannot return them. The baseline had to carry a separate ordered-rule verdict-emission layer alongside `next_state`, with a non-advancement convention linking them — `python` does not couple the two surfaces automatically, so the distinctness had to be maintained by hand and guarded by a dedicated `family.types` surface. Relatedly, the two-branch fail effects of `FV-03` and `FV-07` (contamination vs policy; integrity vs policy, with a remediability discriminator) could not ride a plain `bool` pass/fail; they needed a `branch` field on the `FamilyValidatorOutcome` dataclass and branch-aware predicates in the verdict layer, so the simplest `python` outcome representation had to be widened to preserve the spec's discriminator.
