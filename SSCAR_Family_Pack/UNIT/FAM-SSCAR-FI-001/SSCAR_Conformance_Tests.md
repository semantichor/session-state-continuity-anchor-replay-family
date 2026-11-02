# 3. Source extraction summary

### Canonical verdict set (six)

REPLAY\_ADMISSIBLE · REPLAY\_ADMISSIBLE\_CONSTRAINED · REPLAY\_INCOMPLETE · NONCOMPLIANT\_HOLD · CONTAMINATION\_FAIL\_CLOSED · INCIDENT\_ONLY

### State set (twelve)

S0 FAMILY\_INTAKE · S1 SOURCE\_COVERAGE\_ADMITTED · S2 BOUNDARY\_SCREENED · S3 PROVENANCE\_CLASSIFIED · S4 ANCHOR\_LOCKED · S5 REHYDRATION\_CLOSED · S6 REPLAY\_RECONSTRUCTED · S7 REPORT\_READY · S8 REPLAY\_ADMITTED · SH NONCOMPLIANT\_HOLD · SR READMISSION\_REVIEW · SX CONTAMINATION\_FAIL\_CLOSED

### Validators (twelve)

FV-01 Required Control Coverage · FV-02 Boundary Input Contract · FV-03 Carried Claim Provenance Admissibility · FV-04 Boundary Role Consistency · FV-05 Accepted Head / IRR Linkage · FV-06 Freshness / Anchor Strict Increase · FV-07 Verified Rehydration Closure · FV-08 Replay Reconstruction Sufficiency · FV-09 Contamination Absence · FV-10 Disclosure Class Preservation · FV-11 Family Evidence Closure · FV-12 Family Readmission Closure

### Mandatory evidence fields (fifteen)

FEV-01 family\_decision\_id · FEV-02 boundary\_event\_id · FEV-03 session\_id / prior\_session\_ref · FEV-04 carried\_statement\_refs · FEV-05 tsa\_refs / provenance\_refs · FEV-06 anchor\_document\_digest / anchor\_document\_ref · FEV-07 accepted\_head\_digest / linked\_irr\_digest · FEV-08 freshness\_before / freshness\_after / anchor\_update\_ref · FEV-09 rehydration\_closure\_ref · FEV-10 replay\_refs / checkpoint\_refs / rollback\_refs · FEV-11 disclosure\_class\_entries · FEV-12 family\_validator\_outcomes · FEV-13 hold\_enter\_refs / hold\_exit\_refs · FEV-14 contamination\_flags / contaminating\_ref\_set · FEV-15 report\_signature / export\_manifest\_ref

### D4 normalization in force

AMB-01..AMB-17. AMB-15 / AMB-16 / AMB-17 govern verdict-token reuse in state and decision-rule labels and the projection-signaling rule for INCIDENT\_ONLY / REPLAY\_INCOMPLETE.

# 5. Public Test Suite — pts\_sscar\_v1\_1\_0

Crosses public boundary as buyer-runnable code-level tests against the buyer's integration of the SSCAR specification.

21 buyer-runnable tests in total: 19 runnable plus 2 parameterized (PTS-007, PTS-023). 7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here.

| Test ID | Kind | Normative purpose | Input surface | Execution surface | Assertion set | PASS condition | Blocking / bounded condition |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PTS-001 | unit / state-transition | Initial passing-path entry | (current=S0, trigger=Fv01Pass, validator\_passed=true) | next\_state | result == S1 SOURCE\_COVERAGE\_ADMITTED | exact match | — |
| PTS-002 | unit / state-transition | Intermediate passing-path | (S2, Fv03Pass, true) | next\_state | result == S3 PROVENANCE\_CLASSIFIED | exact match | — |
| PTS-003 | integration / verdict-emission | Terminal acceptance | Complete closure path (FV-01..FV-12 pass; bundle complete) | next\_state + verdict-emission | (a) state==S8; (b) verdict==REPLAY\_ADMISSIBLE; (c) FOC-01 produced | all three exact | If disclosure\_class\_entries non-empty → REPLAY\_ADMISSIBLE\_CONSTRAINED instead |
| PTS-004a | unit / contamination routing | Blocking validator failure (FV-02 boundary input) | (S1, Fv02AndFv04Pass, false) + FV-02 fail | next\_state | result == SX | exact | — |
| PTS-004b | unit / contamination routing | Blocking validator failure (FV-03 contamination) | (S2, UnlabeledMechanismLevelCarriedClaim, \_) | next\_state | result == SX | exact | — |
| PTS-006 | unit / hold routing | Escalation-class failure (FV-06 freshness replay → SH → readmission) | (S3, FreshnessReplay, \_) | next\_state + verdict-emission | (a) state==SH; (b) verdict==NONCOMPLIANT\_HOLD; (c) FOC-05 with hold\_enter\_refs + pending\_requirements | all three exact | — |
| PTS-007 | parameterized / reclassification | FV-04 local reclassification branch | Bounded envelope: explanatory-only payload reclassification policy | Buyer's reclassification policy hook | Family flow blocks at S2 with no verdict change AND policy executes within envelope | both | Policy advancing state without explicit reclassification → fail-closed |
| PTS-008 | comparative / oracle | Per-validator semantic non-collapse | (S3, FreshnessReplay) vs (any, CriticalContamination) | next\_state | first → SH; second → SX; routes ≠ | distinctness | — |
| PTS-009 | unit / fail-closed override | Global fail-closed invariant | (S3, CriticalContamination, \_); (S5, \_); (S0, \_) | next\_state | result == SX from every starting state | uniform SX | — |
| PTS-010 | unit / non-initial override | Protection override from non-initial state | (S5, AntiRollbackFailure, \_) | next\_state | result == SX | exact | — |
| PTS-011 | unit / no-silent-preservation | Critical conditions force routing | (S3, ChainBreak, \_) and (S3, UntrustedAnchorPromoted, \_) | next\_state | result == SX (NOT current state) | exact | — |
| PTS-012 | unit / recovery path | Controlled recovery SH → SR | (SH, HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate, true) | next\_state | result == SR | exact | FV-12 fail → remain SH |
| PTS-013 | unit / non-inheritance | Non-inheriting restoration | (SR, ReadmissionBundleChangedCarriedPayload, true) | next\_state | result == S2 (boundary screening RE-EXECUTED, prior verdict NOT inherited) | exact + no short-circuit | — |
| PTS-014 | unit / terminal integrity | Terminal states behave terminal | (S8, Handoff, \_) and (SX, IncidentOnlyOutput, \_) | next\_state | both stay in terminal state | both exact | — |
| PTS-016 | integration / evidence-completeness | Mandatory evidence bundle | Complete closure path | FamilyEvidenceBundle | All FEV-01..FEV-15 populated per §11 | 15-of-15 | Missing field → invalid |
| PTS-017a | integration / conditional evidence | Unlabeled-claim activation | (S2, UnlabeledMechanismLevelCarriedClaim) | FOC-04 ContaminationIncidentNotice | tsa\_refs, blocked\_stage, contaminating\_ref\_set populated | 3-of-3 | — |
| PTS-017b | integration / conditional evidence | Freshness-replay activation | (S3, FreshnessReplay) | FOC-05 FamilyHoldRecord | freshness\_before, freshness\_after, hold\_enter\_refs populated | 3-of-3 | — |
| PTS-017d | integration / conditional evidence | New-evidence-plus-anchor-update | (SH, new closure bundle + anchor update) | FOC-05 + FEV-08/13 | hold\_exit\_refs, anchor\_update\_ref populated and strictly increasing | both | anchor\_update\_ref not strictly increasing → fail-closed |
| PTS-018 | integration / non-validator-producer | Authorized bounded producer (FOC-04, FOC-05) | Contamination path / hold path | Buyer's FOC-04/FOC-05 emission | Required fields per FOR-01..FOR-06 | per-field exact | — |
| PTS-021 | unit / type-system fidelity | State label vs verdict token are distinct types | Compile-time type check | FamilyWorkflowState vs FamilyNormativeVerdict enums | Two types not implicitly convertible | type-discipline | — |
| PTS-022 | comparative / oracle | NONCOMPLIANT\_HOLD ≠ CONTAMINATION\_FAIL\_CLOSED at routing | (S3, FreshnessReplay) vs (any, CriticalContamination) | next\_state + verdict-emission | first → (SH, NONCOMPLIANT\_HOLD); second → (SX, CONTAMINATION\_FAIL\_CLOSED); pairs distinct | distinctness | — |
| PTS-023 | parameterized / SR re-entry | Bounded delegated branch (5 SR exit triggers) | Bounded envelope: which fields changed (carried\_payload/anchor\_document\_ref/source\_control\_bundles → S2; policy\_snapshot\_id/rehydration\_closure\_ref → S5) | next\_state from SR | Re-entry target matches the field-set discriminator; no third re-entry point invented | exact target per branch | Third re-entry point attempt → bounded violation |
| PTS-024 | derivation-discipline | Test correctly derives from Transition Table + FV-07 jointly | Documented derivation: §9 S4 entry + §7 FV-07 catalogue | Static proof | Test's source state, trigger, validator references map to both authorities | dual-source presence | — |
| PTS-025 | integration / cross-derived evidence | Anti-rollback contamination case | (rehydration point, AntiRollbackFailure) | next\_state + FOC-04 + Evidence | rehydration\_closure\_ref, anchor\_document\_ref, family\_validator\_outcomes populated; verdict CONTAMINATION\_FAIL\_CLOSED | exact | — |
| PTS-026 | meta / projection-adequacy | Projection adequacy for blocking-routing | (S1, Fv02AndFv04Pass, false) | next\_state | Direct projection surfaces SX (adequate granularity) | exact | — |

# 6. Public Fixtures

| Fixture ID | Scenario linkage | Fixture class | Required fields | Optional bounded fields | Source authority |
| --- | --- | --- | --- | --- | --- |
| PFX-INTAKE-PASS-1 | PTS-001, PTS-002, PTS-016 | Passing-path intake bundle | FIC-01: source\_control\_bundles, carried\_payload, anchor\_document\_ref, accepted\_head\_digest (prior session linkage), tsa\_refs, provenance\_refs | none beyond §3.1 | §3.1 FIC-01 FamilyContinuityIntake |
| PFX-CONTAM-FV02 | PTS-004a | Contaminated-anchor bundle (FV-02 fail) | FIC-01 with anchor\_document\_ref invalid or untrusted; carried\_payload references unauthorized artifact | none | §7 FV-02 + §6 Failure Semantics |
| PFX-CONTAM-FV03 | PTS-004b | Unlabeled-mechanism bundle (FV-03 contamination branch) | carried\_statement with missing tsa\_label OR missing source\_class OR mechanism-level claim without explicit reclassification | none | §7 FV-03 + AMB-04 |
| PFX-FRESHNESS-REPLAY | PTS-006, PTS-008, PTS-017b, PTS-022 | Freshness-replay bundle | accepted\_head\_digest with freshness\_before ≥ freshness\_after (non-strict-increase) | bounded policy\_snapshot\_id | §7 FV-06 |
| PFX-CRITICAL-CONTAM | PTS-009, PTS-022 | Critical-contamination trigger | One of: anti-rollback failure indicator, chain break indicator, untrusted-anchor promotion attempt | none | §7 FV-09 + §8 FD-08 |
| PFX-ANTIROLLBACK-S5 | PTS-010, PTS-025 | Anti-rollback at rehydration point | rehydration\_closure\_ref present; anchor\_document\_ref shows rollback attempt against locked accepted\_head | none | §7 FV-07 non-remediable + §8 FD-08 |
| PFX-CHAINBREAK-S3 | PTS-011 | Chain-break / untrusted-anchor at S3 | accepted\_head\_digest with broken IRR linkage OR anchor\_document\_ref promoted without FV-02/04 closure | none | §7 FV-09 + §8 FD-08 |
| PFX-HOLD-CASE | PTS-012, PTS-018 | Hold-case bundle | SH state; pending\_requirements populated; new closure bundle with anchor\_update\_ref strictly increasing | bounded policy\_snapshot\_id update | §3.1 FIC-03 FamilyReadmissionReview |
| PFX-RE-ENTRY-S2 | PTS-013, PTS-023 | Readmission bundle changing boundary-relevant fields | SR state; one or more of: changed carried\_payload, changed anchor\_document\_ref, changed source\_control\_bundles | none | §9 SR exit branch 1 |
| PFX-RE-ENTRY-S5 | PTS-023 | Readmission bundle changing only policy/rehydration | SR state; only policy\_snapshot\_id OR only rehydration\_closure\_ref changed; prior accepted\_head\_digest valid | none | §9 SR exit branch 2 |
| PFX-COMPLETE-CLOSURE | PTS-003, PTS-014, PTS-016, PTS-021 | Complete-closure bundle (all validators pass) | All FIC-01..FIC-03 contracts satisfied; all FV-01..FV-12 pass; all FEV-01..FEV-15 populated | optional disclosure\_class\_entries (drives constrained vs unconstrained verdict) | §11 + §16 AC-05 |
| PFX-CONSTRAINED-CLOSURE | PTS-003 (constrained branch) | Closure with non-empty disclosure\_class\_entries | As PFX-COMPLETE-CLOSURE plus disclosure\_class\_entries containing at least one BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS or BOUNDED\_HANDOFF\_OBLIGATION entry | none | §4.2 + AMB-02 + AMB-10/11 |

# 7. Public Oracles

**Oracle ID**

**Scenario linkage**

**Expected normative result**

**Expected state / output / artifact / evidence fields**

**Forbidden outputs / forbidden semantic collapse**

ORC-VERDICT-SET

PTS-021, PTS-003

One of exactly six: REPLAY\_ADMISSIBLE, REPLAY\_ADMISSIBLE\_CONSTRAINED, REPLAY\_INCOMPLETE, NONCOMPLIANT\_HOLD, CONTAMINATION\_FAIL\_CLOSED, INCIDENT\_ONLY

FOC-01 FamilyVerdict.family\_verdict ∈ canonical six; family\_validator\_outcomes non-empty (FOR-02)

(a) Any FD-NN label as a verdict (forbidden — AMB-16);

(b) any SH/SX prefixed state label as a verdict (forbidden — AMB-15);

(c) any S0..S8 state as a verdict (forbidden — AMB-15);

(d) any seventh verdict.

ORC-CONSTRAINED-DELTA

PTS-003

If disclosure\_class\_entries non-empty AND closure otherwise valid → REPLAY\_ADMISSIBLE\_CONSTRAINED; else REPLAY\_ADMISSIBLE. Bounded envelope: disclosure\_class taxonomy (TRUE\_DEFECT / BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS / BOUNDED\_HANDOFF\_OBLIGATION).

Verdict layer; disclosure\_class\_entries content drives the differentiation

Collapsing constrained into unconstrained with classified restrictions still active (forbidden — AMB-02)

ORC-FAIL-CLOSED-MATRIX

PTS-004a/b, PTS-009, PTS-010, PTS-011

Critical contamination → CONTAMINATION\_FAIL\_CLOSED from any state

SX; contamination\_flags, contaminating\_ref\_set, blocked\_stage populated

Routing critical contamination to SH instead of SX (forbidden — AMB-03)

ORC-HOLD-VS-FAIL-CLOSED

PTS-006, PTS-008, PTS-022

Remediable failure → NONCOMPLIANT\_HOLD; contamination → CONTAMINATION\_FAIL\_CLOSED (semantically distinct)

SH vs SX (distinct routes); hold\_enter\_refs vs contaminating\_ref\_set

Treating hold as fail-closed or vice versa (forbidden — AMB-03)

ORC-VERDICT-LAYER-EMISSION

declarative records

(a) FV-08 fail → REPLAY\_INCOMPLETE at verdict layer; (b) FV-10/FV-11 fail / disclosure-class collapse / evidence-closure fail → INCIDENT\_ONLY at verdict layer

Verdict layer (no dedicated workflow state); family\_validator\_outcomes showing failed validator(s); FOC-02 BoundaryEventEvidenceReport for incident path

(a) Inventing INCIDENT\_ONLY or REPLAY\_INCOMPLETE workflow states (forbidden — AMB-17);

(b) substituting state advancement when verdict-layer emission is required (forbidden — AC-04).

ORC-NON-INHERITANCE

PTS-013, PTS-023

Re-entry MUST NOT inherit prior admissible verdict; boundary screening MUST be re-executed when boundary-relevant fields changed

SR → S2 (3 branches) or SR → S5 (2 branches), exhaustive and mutually exclusive; hold\_exit\_refs, anchor\_update\_ref (strictly increasing)

(a) Auto-re-allow without re-screening (forbidden — §13 boundary contract);

(b) inventing a third re-entry point (forbidden — §9 SR explicit clause).

ORC-EVIDENCE-COMPLETENESS

PTS-016

All 15 mandatory FEV fields present at any positive family verdict emission

FamilyEvidenceBundle; FEV-01..FEV-15 (decomposed sub-fields)

Verdict emission without FEV-12 family\_validator\_outcomes (forbidden — FOR-02)

ORC-CONDITIONAL-EVIDENCE

PTS-017a/b/d

Activation condition → conditional evidence field present

FOC-04 (contamination), FOC-05 (hold/readmission); tsa\_refs+blocked\_stage+contaminating\_ref\_set (017a); freshness\_before/after+hold\_enter\_refs (017b); hold\_exit\_refs+anchor\_update\_ref (017d)

Activation without required conditional fields (forbidden — §11)

ORC-FOC-PRODUCERS

PTS-018; declarative record

FOC-04 ContaminationIncidentNotice and FOC-05 FamilyHoldRecord are bounded but legitimate evidence producers

FOC-04 / FOC-05 emitted at the appropriate junction; per-FOC required fields per §3.2

Treating FOC-04/05 as orphaned or invalid producers (forbidden — Appendix A authorization)

ORC-DISTRIBUTED-LEGITIMACY

declarative record

SH → SR ONLY with new closure bundle + anchor update; FV-12 readmission closure enforced through governance gate FD-10, not transition guard alone

SR entry conditions; hold\_exit\_refs + anchor\_update\_ref

Treating FV-12 as orphaned because not a transition guard (forbidden — distributed enforcement is real)

ORC-TERMINAL-INTEGRITY

PTS-014

S8 and SX are terminal absent explicit reopen authority

self-loop on Handoff (S8) and IncidentOnlyOutput (SX)

Auto-reopen of S8 / SX without explicit package authority (forbidden — §9 + §10)

# 8. Minimal Run Note

| Projection surface required | Buyer's implementation must expose: (a) next\_state(current\_state, trigger, validator\_passed) -> FamilyWorkflowState; (b) a verdict-emission layer that produces FamilyNormativeVerdict from validator outcomes per AC-04 and AMB-17; (c) FamilyEvidenceBundle with all FEV-01..FEV-15 fields; (d) FOC-01..FOC-05 output emission per §3.2. |
| --- | --- |
| **Input types required** | FamilyWorkflowState (12 variants); FamilyTransitionTrigger (per §9 entry/exit + §8 atomic decision-table conditions); FamilyValidatorId (FV-01..FV-12); FamilyValidatorOutcome { id, status: Pass / Fail, evidence\_ref }; ContinuityDisclosureClass { TRUE\_DEFECT, BOUNDED\_EXECUTION\_NEUTRAL\_OPENNESS, BOUNDED\_HANDOFF\_OBLIGATION }; bounded fixture types per Section 6. |
| **Assertion result types required** | Boolean equality on FamilyWorkflowState; boolean equality on FamilyNormativeVerdict; field-presence checks on FamilyEvidenceBundle and FOC-NN structs; comparative distinctness checks on routing pairs; type-system compile-time checks on enum disjointness (PTS-021). |
| **PASS condition for this extracted suite** | (a) All 21 buyer-runnable tests in Section 5 PASS; (b) all 11 declarative oracles in Section 7 are implemented in the buyer's verdict-emission layer per the listed authority references; (c) AC-05 offline-reconstruction requirement satisfied (independent third party can reconstruct verdict from FOC-02 + family validator bundle alone, for at least one representative boundary event). |
| **Bounded external obligations not locally runnable** | (1) Verdict-emission layer correctness for REPLAY\_INCOMPLETE / INCIDENT\_ONLY / REPLAY\_ADMISSIBLE\_CONSTRAINED differentiation (declarative). (2) FV-04 local-reclassification policy hook (parameterized —). (3) SR re-entry discriminator policy beyond the 5 declared branches is FORBIDDEN; deployment may NOT introduce a third re-entry point (parameterized —). (4) Disclosure-class preservation in evidence assembly is enforced through Gate Logic + observability FOR-01..FOR-06; buyer integration must surface these (declarative —). |
