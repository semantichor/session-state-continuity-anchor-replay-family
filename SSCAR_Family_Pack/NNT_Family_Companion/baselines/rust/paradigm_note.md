# Paradigm Note — rust on FAM-SSCAR-FI-001

## What `rust` made easy

The spec's closed vocabularies map directly onto exhaustive `enum`s: the six family verdicts (§4.1), the
twelve workflow states S0–S8/SH/SR/SX (§9), the twelve validators FV-01..FV-12 (§7), and each component's
own state and trigger sets. Because `rust` requires every `match` to be exhaustive, the fail-closed default
arm is not optional — the compiler forces a handler for every unenumerated `(state, trigger)` pair, which is
exactly the §2 fail-closed invariant the integrator demands. AMB-15 and AMB-17 (a verdict token is never a
state token; `REPLAY_INCOMPLETE` / `INCIDENT_ONLY` have no workflow state) were expressed as two separate
types, `FamilyWorkflowState` and `FamilyNormativeVerdict`; the forbidden collapse PTS-021 names becomes a
type error rather than a runtime check. Match guards carried the conditional transitions (for example the
SR re-entry branches keyed on the altered-field trigger) without nested `if` ladders.

## What `rust` made hard

The verdict-emission layer's §10 precedence (contamination before incident before hold before incomplete)
is not a per-variant property the type system can hold; it lives in the ordering of `match` arms inside
`verdict_layer`, and `rust` cannot check that the order matches the gate-logic text — correctness there rests
on the author, not the compiler. The two-branch fail effects of FV-03 and FV-07 forced one spec validator id
to split into two `enum` variants each (`Fv03Contam` / `Fv03Policy`, `Fv07Integrity` / `Fv07Policy`) so the
remediability discriminator could be carried; that one-id-to-two-variants correspondence is a hand-maintained
mapping the compiler cannot tie back to the §7 prose. Representing the emergent family verdict over real
component outputs also meant threading component-produced fields through an explicit `ComponentOutputs`
struct, since `rust` offers no implicit cross-module data flow — the Annex B byte-identity checks had to be
written out as explicit comparisons.
