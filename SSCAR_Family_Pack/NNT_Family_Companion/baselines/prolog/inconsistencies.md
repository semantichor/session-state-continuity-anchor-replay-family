# Inconsistencies Log — FAM-SSCAR-FI-001 (prolog)

Observed after reading the cited cross-references across the 6 packs and the 3 SSCAR annexes.

## OBS-1 — SR re-entry target for a `policy_snapshot_id`-only change

**Observation**: For an SR (`READMISSION_REVIEW`) re-entry whose readmission bundle changes only
`policy_snapshot_id`, two surfaces state different re-entry targets. The Specification §9 SR exit
branch 2 states the re-entry targets `S5 REHYDRATION_CLOSED` when the bundle changes only
`policy_snapshot_id` or `rehydration_closure_ref`. The Annex A Producer-Consumer Manifest Row 12
groups "policy snapshot" with the boundary fields that target the boundary-screened state, and the
Annex C connector test CT-14 lists case (c) `policy_snapshot_id altered only` among the cases that
"re-enter at the boundary-screened state".

**Locations**:
- `SSCAR_Specification.md:476` — "→ S5 REHYDRATION_CLOSED when the readmission bundle changes only policy_snapshot_id or the verified-rehydration closure".
- `SSCAR_Producer_Consumer_Manifest.md:44` — Row 12: "when the carried payload, anchor document reference, policy snapshot, or component set has changed, re-entry targets boundary-screened state".
- `SSCAR_Family_Connector_Tests.md:212` — CT-14 input case (c) `policy_snapshot_id altered only`, with Assertion 1 placing cases (a)–(d) at the boundary-screened state.

**Cross-references read while reconciling**: the SSCAR README precedence statement
(`SSCAR_README.md:6`, the Specification is the authoritative document); the Annex A self-description
"non-additive and non-modificative with respect to the family integrator specification"
(`SSCAR_Producer_Consumer_Manifest.md:25`); the Annex C self-description that its tests "do not
replace the public test suite of the integrator" (`SSCAR_Family_Connector_Tests.md:262`); and the
integrator Public Test Suite fixture PTS-023 / `PFX-RE-ENTRY-S5` (`SSCAR_Conformance_Tests.md:70`),
which states "only policy_snapshot_id ... changed" grounds the `§9 SR exit branch 2` → S5 mapping.

**Why the reconciliation is reported here rather than only in R7**: the precedence rule and the
annexes' own non-modificative declarations determine the operative value (this baseline follows
§9 / PTS-023: `policy_snapshot_id`-only change → `S5 REHYDRATION_CLOSED`, and CT-14 is judged
against that core-apparatus value). The reconciliation resolves which surface prevails, but the two
surfaces still carry positively different re-entry targets for the same matter on their face; the
observation is recorded for that reason. It is stated as observed; it is not characterized further.
