Freshness Portability Agent (FPA-FRESHNESS-PORTABILITY-003)

*Public Test Suite, Fixtures, Oracles, and Minimal Run Note*

| Document type | Public conformance test suite |
| --- | --- |
| **Package basis** | Freshness Portability Agent v1.0 / canonical index v2.0 (FPA-FRESHNESS-PORTABILITY-003) |
| **Issuance date** | 28 April 2026 |

# §A. Input corpus

The following package materials are available and cross-readable for this test suite.

| Source | Used for |
| --- | --- |
| Specification | Overall authority and semantic frame |
| §8 Workflow / State-Transition Record | States S0–S8; 14 triggers |
| §7 Validator Catalogue | VAL-001…VAL-011 with failure actions |
| §6 Decision Table + §14 Semantic Contract | Canonical verdict set |
| §16 Failure Semantics | Protected routing, fail-closed logic |
| §11 Evidence Contract | EVD-001…EVD-017 |
| §13 Gate Logic + §5 Authority Record | Bounded governance enforcement |
| Appendix A (PR-01…PR-14) | Agent-specific Validation Pack |
| D4 Ambiguity Register | 12 lexical normalization records |
| Scenario inventory | Authoritative source of instantiated scenario inventory and statuses |

# §B. Normalized public terms

## Canonical verdict set (closed)

ACCEPT, REJECT, QUARANTINE, RESTORATION\_ELIGIBLE, READMIT, FAIL\_CLOSED.

## States and triggers

States (9): S0 IDLE, S1 RECEIVED, S2 VERIFIED, S3 FRESHNESS\_ELIGIBLE, S4 IRR\_COMMITTED, S5 WATERMARK\_COMMITTED, S6 RESTORATION\_ELIGIBLE, S7 QUARANTINED, S8 REJECTED.

Triggers (14): TransferPacketReceived, StructureValid, StructureInvalid, FreshnessPass, FreshnessFail, EvidencePending, IRRAppended, WatermarkPersisted, RestoreRequest+GenesisConfirmed, RestoreAdmitted, RestoreDenied, ReadmissionApproved, ReadmissionRejected, NewPacket.

## Validators and failure actions

| ID | Validator | Failure action (per §7 / §16) |
| --- | --- | --- |
| VAL-001 | Frame/Envelope | FAIL\_CLOSED → REJECT\_INVALID |
| VAL-002 | SSM Signature | FAIL\_CLOSED → REJECT\_INVALID |
| VAL-003 | Packet Hash | FAIL\_CLOSED → REJECT\_INVALID |
| VAL-004 | Policy Compatibility | REJECT\_INVALID or OPEN\_QUARANTINE\_CASE |
| VAL-005 | Freshness Comparator | REJECT → REJECT\_STALE |
| VAL-006 | IRR Linkage | FAIL\_CLOSED → DENY\_RESTORE |
| VAL-007 | Transport Policy | REJECT\_INVALID or OPEN\_QUARANTINE\_CASE |
| VAL-008 | TVC | REJECT\_INVALID or OPEN\_QUARANTINE\_CASE |
| VAL-009 | Evidence | REJECT\_INVALID or OPEN\_QUARANTINE\_CASE |
| VAL-010 | Genesis Precondition | FAIL\_CLOSED → DENY\_RESTORE |
| VAL-011 | Tool-State Non-Authority | FAIL\_CLOSED → BLOCK\_TOOL\_STATE or OPEN\_QUARANTINE\_CASE (bounded authority control point) |

## Evidence (mandatory vs conditional)

- Always-present (10): decision\_id, agent\_id, source\_id, ledger\_uuid, decision\_object, policy\_id, policy\_version, reason\_code, semantic\_verdict, gate\_class.
- Path-conditional (always for import path) (5): packet\_hash, freshness\_value, watermark\_before, watermark\_after, ssm\_validation\_result.
- Activation-conditional (5): tvc\_validation\_result, evidence\_validation\_result, transport\_validation\_result, irr\_digest, prev\_receipt\_digest.

## Ambiguity normalization (D4)

All 12 D4 records (AMB-001…AMB-012) apply. Critical normalizations preserved:

- RESTORATION\_ELIGIBLE (verdict) ≠ S6 (state) — AMB-001
- REJECT ≠ FAIL\_CLOSED — AMB-003
- Tool-state approval path ≠ BLOCK\_TOOL\_STATE — AMB-012

# §C. Public projection surface

The public test suite is expressed against three public projection surfaces. All three are derivable solely from the public package.

| Surface | Signature | Source authority |
| --- | --- | --- |
| Surface-1 — State machine | next\_state(WorkflowState, TransitionTrigger, validator\_passed: bool) -> WorkflowState | §8 |
| Surface-2 — Evidence bundle | PrincipalEvidenceBundle (20 typed fields covering EVD-001…EVD-017) | §11 |
| Surface-3 — Verdict taxonomy | Closed NormativeVerdict enum (6 tokens) | §6 / §14 / EVD-016 allowed\_values |

Action-token granularity (REJECT\_INVALID / REJECT\_STALE / DENY\_RESTORE / OPEN\_QUARANTINE\_CASE / BLOCK\_TOOL\_STATE) sits below Surface-1 and is the gate-logic / Decision-Table layer per §6 + §11 EVD-015/016/017 + §13 — exported as DECLARATIVE rather than runnable on these surfaces.

# §D. Per-scenario public records

Agent / package version for every record below: FPA-FRESHNESS-PORTABILITY-003 v1.0 / index v2.0 (canonical index package v2.0). Authoritative derivation sources are abbreviated where they recur; see §B.

## Family A — Normal-path conformance

VP-GEN-001 — Initial passing-path public conformance  —  Family A

| Source state → trigger → target | S0 IDLE → TransferPacketReceived → S1 RECEIVED |
| --- | --- |
| **Validator(s)** | None active at boundary entry |
| **Expected normative result** | S1 RECEIVED on Surface-1 |
| **Assertion target** | next\_state(IDLE, TransferPacketReceived, true) == RECEIVED |
| **Authoritative sources** | §8 row S0; authoritative public corpus; VP-GEN-001 |

Source status: PASS    \|    Disposition: RUNNABLE

*Notes:* *Mandatory (every agent). Surface-1 directly exposes the entry transition.*

VP-GEN-002 — Intermediate passing-path public conformance  —  Family A

| Source state → trigger → target | S1 RECEIVED → StructureValid → S2 VERIFIED |
| --- | --- |
| **Validator(s)** | VAL-001 Frame/Envelope (passing) |
| **Expected normative result** | S2 VERIFIED on Surface-1 |
| **Assertion target** | next\_state(RECEIVED, StructureValid, true) == VERIFIED |
| **Authoritative sources** | §7 VAL-001; §8 row S1; authoritative public corpus; VP-GEN-002 |

Source status: PASS    \|    Disposition: RUNNABLE

VP-GEN-003 — Terminal success / acceptance path public conformance  —  Family A

| Source state → trigger → target | S6 RESTORATION\_ELIGIBLE → RestoreAdmitted → S0 IDLE (cycle close) |
| --- | --- |
| **Validator(s)** | Restore handoff already admitted |
| **Expected normative result** | S0 IDLE on Surface-1 |
| **Assertion target** | next\_state(RESTORATION\_ELIGIBLE, RestoreAdmitted, true) == IDLE |
| **Authoritative sources** | §8 row S6; §14 RESTORATION\_ELIGIBLE; authoritative public corpus; VP-GEN-003 |

Source status: PASS    \|    Disposition: RUNNABLE

## Family B — Single-validator failure semantics

VP-GEN-004 — Blocking validator failure public conformance  —  Family B

| Source state → trigger → target | S1 RECEIVED → StructureValid (failing) or StructureInvalid → S8 REJECTED |
| --- | --- |
| **Validator(s)** | VAL-001 Frame/Envelope (failing) |
| **Expected normative result** | S8 REJECTED on Surface-1; underlying action token REJECT\_INVALID (declarative, gate-logic layer) |
| **Assertion target** | next\_state(RECEIVED, StructureValid, false) == REJECTED |
| **Authoritative sources** | §7 VAL-001; §16 structure failure; authoritative public corpus; VP-GEN-004 |

Source status: PASS    \|    Disposition: RUNNABLE

*Notes:* *Surface-1 exposes blocking route; action token REJECT\_INVALID belongs to a complementary DECLARATIVE assertion (FPA-D-01).*

VP-GEN-005 — Constrained-allow validator failure public conformance  —  Family B

| Source state → trigger → target | Not applicable |
| --- | --- |
| **Validator(s)** | Not applicable |
| **Expected normative result** | Not applicable |
| **Assertion target** | Not applicable |
| **Authoritative sources** | Absence verified against §6 verdicts and §13 Gate Logic |

Source status: Inapplicable    \|    Disposition: NOT-APPLICABLE

Notes: FPA defines RELEASE / BLOCK / ESCALATION / READMISSION (§13) and ACCEPT / REJECT / QUARANTINE / RESTORATION\_ELIGIBLE / READMIT / FAIL\_CLOSED (§6 verdicts). No constrained-allow class defined. Non-applicability is justified by package authority absence.

VP-GEN-006 — Escalation-triggering validator failure public conformance  —  Family B

| Source state → trigger → target | S2 VERIFIED → EvidencePending → S7 QUARANTINED on validator fail |
| --- | --- |
| **Validator(s)** | VAL-004 Policy / VAL-007 Transport / VAL-008 TVC / VAL-009 Evidence (recoverable failure) |
| **Expected normative result** | S7 QUARANTINED on Surface-1; underlying action token OPEN\_QUARANTINE\_CASE (declarative) |
| **Assertion target** | next\_state(VERIFIED, EvidencePending, false) == QUARANTINED |
| **Authoritative sources** | §7 VAL-004/007/008/009; §8 row S2 EvidencePending; authoritative public corpus; VP-GEN-006 |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-007 — Reclassification-triggering validator failure**  —  Family B

| Source state → trigger → target | Not applicable |
| --- | --- |
| **Validator(s)** | Not applicable |
| **Expected normative result** | Not applicable |
| **Assertion target** | Not applicable |
| **Authoritative sources** | Absence verified against §6 / §13 / §14 |

Source status: Inapplicable    \|    Disposition: NOT-APPLICABLE

*Notes:* *FPA does not define reclassification or semantic-downgrade behavior. Quarantine → Readmission is bounded re-entry, not reclassification of the original verdict.*

VP-GEN-008 — Per-validator semantic non-collapse public conformance  —  Family B

| Source state → trigger → target | (S2, FreshnessFail, true) → REJECTED (REJECT family) vs (S5, RestoreRequest+GenesisConfirmed, false) → REJECTED (FAIL\_CLOSED family) |
| --- | --- |
| **Validator(s)** | VAL-005 vs VAL-006 / VAL-010 |
| **Expected normative result** | State-level both → REJECTED on Surface-1; verdict-level NormativeVerdict::REJECT ≠ NormativeVerdict::FAIL\_CLOSED on Surface-3 (per AMB-003) |
| **Assertion target** | Comparative pair: discriminant inequality at verdict level + state-level reject path for both |
| **Authoritative sources** | §7 VAL-005 / VAL-006 / VAL-010; D4 AMB-003; authoritative public corpus; VP-GEN-008 |

Source status: PASS    \|    Disposition: RUNNABLE

*Notes:* *Surface-3 exposes the verdict discriminant.*

## Family C — Fail-closed and protection routing

VP-GEN-009 — Global fail-closed public conformance  —  Family C

| Source state → trigger → target | S2 VERIFIED → FreshnessPass (with upstream validator fail) → S8 REJECTED |
| --- | --- |
| **Validator(s)** | VAL-002 / VAL-003 (bounded control points evaluated before FreshnessPass) |
| **Expected normative result** | S8 REJECTED on Surface-1 |
| **Assertion target** | next\_state(VERIFIED, FreshnessPass, false) == REJECTED |
| **Authoritative sources** | §7 VAL-002 / VAL-003; §13 Gate Logic / BLOCK; §16; authoritative public corpus; VP-GEN-009 |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-010 — Protection override from non-initial state**  —  Family C

| Source state → trigger → target | S5 WATERMARK\_COMMITTED → RestoreRequest+GenesisConfirmed → S8 REJECTED on validator fail |
| --- | --- |
| **Validator(s)** | VAL-006 / VAL-010 |
| **Expected normative result** | S8 REJECTED on Surface-1 |
| **Assertion target** | next\_state(WATERMARK\_COMMITTED, RestoreRequest\_GenesisConfirmed, false) == REJECTED |
| **Authoritative sources** | §7 VAL-010; §8 row S5; §16 missing GenesisConfirmed; authoritative public corpus; VP-GEN-010 |

Source status: PASS    \|    Disposition: RUNNABLE

VP-GEN-011 — No silent preservation public conformance  —  Family C

| Source state → trigger → target | Any non-source state + invalid trigger combination → S8 REJECTED (fail-closed default) |
| --- | --- |
| **Validator(s)** | Closed-state-machine validation per Appendix A PR-10 |
| **Expected normative result** | S8 REJECTED on Surface-1; never silent preservation |
| **Assertion target** | next\_state(IRR\_COMMITTED, FreshnessPass, true) == REJECTED (representative invalid combination) |
| **Authoritative sources** | §8 closed transitions; Appendix A PR-10; authoritative public corpus; VP-GEN-011 |

Source status: PASS    \|    Disposition: RUNNABLE

## Family D — Recovery, readmission, restoration

VP-GEN-012 — Controlled recovery path public conformance  —  Family D

| Source state → trigger → target | S7 QUARANTINED → ReadmissionApproved → S2 VERIFIED |
| --- | --- |
| **Validator(s)** | Readmission novelty basis (caller-validated outside Surface-1) |
| **Expected normative result** | S2 VERIFIED on Surface-1 |
| **Assertion target** | next\_state(QUARANTINED, ReadmissionApproved, true) == VERIFIED |
| **Authoritative sources** | §6 DT-07; §8 row S7; §13 READMISSION; authoritative public corpus; VP-GEN-012 |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-013 — Non-inheriting restoration boundary**  —  Family D

| Source state → trigger → target | S5 WATERMARK\_COMMITTED → S6 RESTORATION\_ELIGIBLE → S0 IDLE |
| --- | --- |
| **Validator(s)** | VAL-006 IRR Linkage; VAL-010 Genesis Precondition |
| **Expected normative result** | Restore admission bounded to S6 then returns to S0; no automatic tool-state activation; no inheritance of acceptance permissions beyond the restore-admission-token scope |
| **Assertion target** | Dual on Surface-1: WATERMARK\_COMMITTED + RestoreRequest+GenesisConfirmed → RESTORATION\_ELIGIBLE then RESTORATION\_ELIGIBLE + RestoreAdmitted → IDLE; plus declarative non-inheritance assertion (FPA-D-02) |
| **Authoritative sources** | §13 restore rule; §22 non-authority zones; D4 AMB-012; authoritative public corpus; VP-GEN-013 |

Source status: PASS    \|    Disposition: RUNNABLE + DECLARATIVE

*Notes:* *State cycle is runnable on Surface-1; non-inheritance to tool-state is a declarative buyer obligation.*

## Family E — Terminal-role and closure integrity

**VP-GEN-014 — Terminal state integrity**  —  Family E

| Source state → trigger → target | S8 REJECTED + non-NewPacket trigger → still S8 REJECTED |
| --- | --- |
| **Validator(s)** | Closed-state-machine validation per PR-10 |
| **Expected normative result** | S8 REJECTED preserved unless explicit NewPacket reopen authority is presented |
| **Assertion target** | next\_state(REJECTED, FreshnessPass, true) == REJECTED |
| **Authoritative sources** | §8 row S8; Appendix A PR-10; authoritative public corpus; VP-GEN-014 |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-015 — Closure artifact completeness**  —  Family E

| Source state → trigger → target | Terminal-deny / FAIL\_CLOSED restore-deny path |
| --- | --- |
| **Validator(s)** | GateVerdict emitter, Gate Logic Record, Decision Table producers |
| **Expected normative result** | PrincipalEvidenceBundle for the deny path contains all 10 mandatory fields + reason\_code = DENY\_RESTORE + semantic\_verdict = FAIL\_CLOSED + gate\_class = BLOCK |
| **Assertion target** | Evidence-bundle completeness on Surface-2 + verdict identity on Surface-3 |
| **Authoritative sources** | §10 OC-01; §11 Evidence Contract; §13 Gate Logic; authoritative public corpus; VP-GEN-015 |

Source status: PASS    \|    Disposition: RUNNABLE

## Family F — Evidence completeness

**VP-GEN-016 — Mandatory evidence bundle completeness**  —  Family F

| Source state → trigger → target | Representative ACCEPT verdict |
| --- | --- |
| **Validator(s)** | VAL-002…VAL-009 (passing) |
| **Expected normative result** | All 10 always-present fields populated; all 5 import-path fields populated |
| **Assertion target** | Bundle assertion on Surface-2; verdict on Surface-3 = ACCEPT; gate\_class = RELEASE |
| **Authoritative sources** | §11 Evidence Contract; §7 Validator Catalogue; authoritative public corpus; VP-GEN-016 |

Source status: PASS    \|    Disposition: RUNNABLE

*Notes:* *Mandatory for every agent.*

**VP-GEN-017A — Conditional TVC field activation**  —  Family F

| Activation | Active policy requires TVC (per §3 + OPT-001) |
| --- | --- |
| **Expected normative result** | tvc\_validation\_result is Some(...) on activation; None otherwise |
| **Assertion target** | Bundle field presence on Surface-2 conditional on policy parameter |
| **Authoritative sources** | §3 TVC; §11 tvc\_validation\_result; §19 OPT-001 |

Source status: PASS    \|    Disposition: PARAMETRIC

*Notes:* *Bounded parameter envelope: policy\_requires\_TVC.*

**VP-GEN-017B — Conditional Evidence.bin field activation**  —  Family F

| Activation | Active policy requires Evidence.bin (per §3 + OPT-002) |
| --- | --- |
| **Expected normative result** | evidence\_validation\_result is Some(...) on activation; None otherwise |
| **Assertion target** | Bundle field presence on Surface-2 conditional on policy parameter |
| **Authoritative sources** | §3 Evidence.bin; §11 evidence\_validation\_result; §19 OPT-002 |

Source status: PASS    \|    Disposition: PARAMETRIC

*Notes:* *Bounded parameter envelope: policy\_requires\_Evidence\_bin.*

**VP-GEN-017C — Conditional Transport field activation**  —  Family F

| Activation | Designated source / boundary requires transport confirmation (per §19 OPT-003) |
| --- | --- |
| **Expected normative result** | transport\_validation\_result is Some(...) on activation; None otherwise |
| **Assertion target** | Bundle field presence on Surface-2 conditional on transport parameter |
| **Authoritative sources** | §7 VAL-007; §11 transport\_validation\_result; §19 OPT-003 |

Source status: PASS    \|    Disposition: PARAMETRIC

*Notes:* *Bounded parameter envelope: transport\_required.*

**VP-GEN-017D — Receipt linkage evidence activation**  —  Family F

| Activation | ACCEPT path requires IRR linkage; restore path requires linked head |
| --- | --- |
| **Expected normative result** | irr\_digest and prev\_receipt\_digest both Some(...) on accept / restore-eligible verdicts |
| **Assertion target** | Bundle field presence on Surface-2 |
| **Authoritative sources** | §11 EVD-014; §13 receipt rule; §15 canonical sequence |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-018 — Authorized non-validator producer evidence**  —  Family F

| Producers | GateVerdict emitter (decision\_id), agent binding (agent\_id), input parsing (source\_id, ledger\_uuid), decision dispatcher (decision\_object), watermark store + WatermarkUpdate path (watermark\_before / watermark\_after), gate-logic mapping (reason\_code), Gate Logic Record (gate\_class) |
| --- | --- |
| **Expected normative result** | Every non-validator-produced field is populated and grounded |
| **Assertion target** | Bundle assertion on Surface-2 against §11 producer attribution |
| **Authoritative sources** | §11 Evidence Contract; §13 Gate Logic; authoritative public corpus; VP-GEN-018 |

Source status: PASS    \|    Disposition: RUNNABLE

## Family G — Gate-logic and governance enforcement

**VP-GEN-019 — Gate-logic-only validator enforcement**  —  Family G

| Validator(s) | VAL-011 Tool-State Non-Authority |
| --- | --- |
| **Issue** | §7 designates VAL-011 as a Bounded authority control point; §8 deliberately omits S5/S6 → S7 transitions because tool-state activation is outside agent authority per §19. No ToolStateActivationRequested trigger exists in Surface-1. |
| **Expected normative result** | ToolStateActivationRequested → BLOCK\_TOOL\_STATE or OPEN\_QUARANTINE\_CASE at gate-logic / authority-control layer |
| **Assertion target** | Declarative buyer obligation FPA-D-03 |
| **Authoritative sources** | §7 VAL-011; §13 BLOCK\_TOOL\_STATE; §19 OPT-005 |

Source status: UNTESTABLE    \|    Disposition: DECLARATIVE

*Notes:* *Buyer obligation to enforce VAL-011 at the gate-logic layer is real and bounded by §7 + §13 + §19.*

**VP-GEN-020 — Distributed-enforcement legitimacy**  —  Family G

| Validator(s) | VAL-011 (cross-referenced) |
| --- | --- |
| **Issue** | Confirms VAL-011 enforcement is real distributed enforcement — not an orphan. §7 bounded authority control point + §13 BLOCK\_TOOL\_STATE action + §19 OPT-005 + AMB-012 jointly bound it. |
| **Expected normative result** | Distributed enforcement legitimately covers the VAL-011 obligation |
| **Assertion target** | Declarative legitimacy assertion FPA-D-04 |
| **Authoritative sources** | §7 VAL-011; §13; §19 OPT-005; D4 AMB-012 |

Source status: PASS    \|    Disposition: DECLARATIVE

*Notes:* *Companion to VP-GEN-019; distinguishes legitimate distributed enforcement from a true gap.*

## Family H — Verdict-semantics preservation

**VP-GEN-021 — Canonical verdict fidelity (state-label collision)**  —  Family H

| Tokens | NormativeVerdict::RESTORATION\_ELIGIBLE (verdict) ≠ WorkflowState::RESTORATION\_ELIGIBLE (S6 state label) |
| --- | --- |
| **Authoritative sources** | §8 S6; §14 RESTORATION\_ELIGIBLE verdict; D4 AMB-001 |
| **Expected normative result** | Type-system separation; both members independently inhabited |
| **Assertion target** | Existence of both on Surfaces 1 and 3; type discriminants distinct |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-022 — Negative-outcome semantic separation**  —  Family H

| Tokens | NormativeVerdict::REJECT ≠ NormativeVerdict::FAIL\_CLOSED (per AMB-003) |
| --- | --- |
| **Authoritative sources** | §14 REJECT and FAIL\_CLOSED; §16 Failure Semantics; D4 AMB-003 |
| **Expected normative result** | Type discriminants distinct |
| **Assertion target** | Discriminant comparison on Surface-3 |

Source status: PASS    \|    Disposition: RUNNABLE

## Family I — Delegated-choice handling

**VP-GEN-023 — Bounded delegated branch (policy-conditioned validators)**  —  Family I

| Branches | VAL-004 / VAL-007 / VAL-008 / VAL-009 — recoverable failure routes to S7 (EvidencePending trigger); non-recoverable routes to S8 (FreshnessFail trigger) |
| --- | --- |
| **Bounded parameter envelope** | recoverable: bool per failure event; policy\_requires\_TVC, policy\_requires\_Evidence\_bin, transport\_required |
| **Authoritative sources** | §7 policy-conditioned failure routes; §19 Optionality Register; authoritative public corpus; VP-GEN-023 |

Source status: PARAMETERIZED-OPEN    \|    Disposition: PARAMETRIC

*Notes:* *Never flatten to a single guessed branch.*

## Family J — Cross-reference derivation

**VP-GEN-024 — Transition + Validator derivation**  —  Family J

| Cross-reading required | §7 VAL-005 (FreshnessPass guard) + §8 row S2 |
| --- | --- |
| **Expected normative result** | VERIFIED + FreshnessPass + true → FRESHNESS\_ELIGIBLE |
| **Assertion target** | next\_state(VERIFIED, FreshnessPass, true) == FRESHNESS\_ELIGIBLE |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-025 — Evidence + Scenario derivation**  —  Family J

| Cross-reading required | §11 evidence\_validation\_result + §19 Evidence.bin activation rule |
| --- | --- |
| **Expected normative result** | When policy activates Evidence.bin and the case enters S7 via EvidencePending, the bundle carries evidence\_validation\_result = Some(...), semantic\_verdict = QUARANTINE, gate\_class = ESCALATION |
| **Authoritative sources** | §11 EVD-012; §19 OPT-002; authoritative public corpus; VP-GEN-025 |

Source status: PASS    \|    Disposition: PARAMETRIC

*Notes:* *Bounded parameter envelope: policy\_requires\_Evidence\_bin.*

## Family K — Code-projection discrimination

**VP-GEN-026 — Adequate projection granularity**  —  Family K

| Direct transition surfaced on Surface-1 | FRESHNESS\_ELIGIBLE + IRRAppended + true → IRR\_COMMITTED |
| --- | --- |
| **Authoritative sources** | §8 S3; §13 receipt rule |

Source status: PASS    \|    Disposition: RUNNABLE

**VP-GEN-027 — Transparent untestability / restored testability**  —  Family K

| Issue | VAL-011 tool-state authority edge — projection surface gap (no ToolStateActivationRequested trigger in Surface-1) |
| --- | --- |
| **Companion declarative obligation** | FPA-D-03 |

Source status: UNTESTABLE    \|    Disposition: DECLARATIVE

*Notes:* *Transparently recorded as projection-surface limitation.*

# §F. Public Test Records (Section 8.2)

## §F.R — Runnable tests (Surface-1, Surface-2, Surface-3)

| Test ID | Test kind | Normative purpose / scenario | Assertion (PASS condition) |
| --- | --- | --- | --- |
| FPA-T-01 | state-machine | Boundary entry (VP-GEN-001) | next\_state(IDLE, TransferPacketReceived, true) == RECEIVED |
| FPA-T-02 | state-machine | Mid-path progression (VP-GEN-002) | next\_state(RECEIVED, StructureValid, true) == VERIFIED |
| FPA-T-03 | state-machine | Cycle close on restore (VP-GEN-003) | next\_state(RESTORATION\_ELIGIBLE, RestoreAdmitted, true) == IDLE |
| FPA-T-04 | state-machine | Blocking validator failure (VP-GEN-004) | next\_state(RECEIVED, StructureValid, false) == REJECTED AND next\_state(RECEIVED, StructureInvalid, true) == REJECTED |
| FPA-T-06 | state-machine | Recoverable escalation (VP-GEN-006) | next\_state(VERIFIED, EvidencePending, false) == QUARANTINED |
| FPA-T-08a | state-machine | REJECT path (VP-GEN-008) | next\_state(VERIFIED, FreshnessFail, true) == REJECTED |
| FPA-T-08b | state-machine | FAIL\_CLOSED restore-deny path (VP-GEN-008) | next\_state(WATERMARK\_COMMITTED, RestoreRequest\_GenesisConfirmed, false) == REJECTED |
| FPA-T-08c | taxonomy | Verdict non-collapse (VP-GEN-008, VP-GEN-022) | discriminant(REJECT) ≠ discriminant(FAIL\_CLOSED) |
| FPA-T-09 | state-machine | Pre-FreshnessPass validator failure (VP-GEN-009) | next\_state(VERIFIED, FreshnessPass, false) == REJECTED |
| FPA-T-10 | state-machine | Override from non-initial state (VP-GEN-010) | next\_state(WATERMARK\_COMMITTED, RestoreRequest\_GenesisConfirmed, false) == REJECTED |
| FPA-T-11 | state-machine | No silent preservation (VP-GEN-011) | next\_state(IRR\_COMMITTED, FreshnessPass, true) == REJECTED (fail-closed default) |
| FPA-T-12 | state-machine | Readmission recovery (VP-GEN-012) | next\_state(QUARANTINED, ReadmissionApproved, true) == VERIFIED |
| FPA-T-13a | state-machine | Restore eligibility (VP-GEN-013) | next\_state(WATERMARK\_COMMITTED, RestoreRequest\_GenesisConfirmed, true) == RESTORATION\_ELIGIBLE |
| FPA-T-13b | state-machine | Restore admit returns to IDLE (VP-GEN-013) | next\_state(RESTORATION\_ELIGIBLE, RestoreAdmitted, true) == IDLE |
| FPA-T-14 | state-machine | Terminal preservation (VP-GEN-014) | next\_state(REJECTED, FreshnessPass, true) == REJECTED |
| FPA-T-15 | evidence + verdict | Closure artifact for restore-deny (VP-GEN-015) | Mandatory fields populated; reason\_code == "DENY\_RESTORE"; semantic\_verdict == FAIL\_CLOSED; gate\_class == "BLOCK" |
| FPA-T-16 | evidence + verdict | Mandatory evidence bundle (VP-GEN-016, ACCEPT) | All 10 mandatory + 5 import-path fields populated; semantic\_verdict == ACCEPT; gate\_class == "RELEASE" |
| FPA-T-17D | evidence | Receipt linkage activation (VP-GEN-017D) | irr\_digest is Some; prev\_receipt\_digest is Some on accept path |
| FPA-T-18 | evidence | Authorized non-validator producers (VP-GEN-018) | All bundled non-validator-produced fields populated and grounded |
| FPA-T-21 | taxonomy | Verdict / state label disambiguation (VP-GEN-021) | Both members independently inhabited; type discriminants distinct |
| FPA-T-24 | state-machine | Cross-reference derivation (VP-GEN-024) | next\_state(VERIFIED, FreshnessPass, true) == FRESHNESS\_ELIGIBLE |
| FPA-T-26 | state-machine | Direct transition adequacy (VP-GEN-026) | next\_state(FRESHNESS\_ELIGIBLE, IRRAppended, true) == IRR\_COMMITTED |
| FPA-T-PR-01 | state-machine | Stale freshness rejects (FPA-PR-01) | next\_state(VERIFIED, FreshnessFail, true) == REJECTED |
| FPA-T-PR-02 | sequence | IRR before watermark (FPA-PR-02) | (FRESHNESS\_ELIGIBLE, IRRAppended, true) → IRR\_COMMITTED AND (IRR\_COMMITTED, WatermarkPersisted, true) → WATERMARK\_COMMITTED AND (FRESHNESS\_ELIGIBLE, WatermarkPersisted, true) → REJECTED |
| FPA-T-PR-03 | state-machine | Restore eligibility on linked head + GenesisConfirmed (FPA-PR-03) | Same as FPA-T-13a |
| FPA-T-PR-09 | state-machine | GenesisConfirmed mandatory for S6 (FPA-PR-09) | (WATERMARK\_COMMITTED, RestoreRequest\_GenesisConfirmed, true) → RESTORATION\_ELIGIBLE AND (..., false) → REJECTED |
| FPA-T-PR-10 | state-machine | Closed state machine rejects invalid combinations (FPA-PR-10) | next\_state(IDLE, RestoreAdmitted, true) == REJECTED |
| FPA-T-PR-12 | state-machine | Readmission only from QUARANTINED (FPA-PR-12) | (QUARANTINED, ReadmissionApproved, true) → VERIFIED AND (IDLE, ReadmissionApproved, true) → REJECTED |
| FPA-T-PR-13 | sequence | Ordering via FreshnessPass + IRRAppended (FPA-PR-13) | Both equalities of FPA-T-24 and FPA-T-26 |
| FPA-T-PR-14 | state-machine | Watermark non-decrement (FPA-PR-14) | next\_state(IRR\_COMMITTED, WatermarkPersisted, false) == REJECTED |

## §F.P — Parametric tests (bounded delegated branches)

| Test ID | Bounded parameter envelope | Branch behavior | Source authority |
| --- | --- | --- | --- |
| FPA-T-17A | policy\_requires\_TVC: bool | When true: bundle.tvc\_validation\_result is Some(...); when false: None permissible | §3, §19 OPT-001, §11 EVD-011 |
| FPA-T-17B | policy\_requires\_Evidence\_bin: bool | When true: bundle.evidence\_validation\_result is Some(...); when false: None permissible | §3, §19 OPT-002, §11 EVD-012 |
| FPA-T-17C | transport\_required: bool | When true: bundle.transport\_validation\_result is Some(...); when false: None permissible | §19 OPT-003, §11 EVD-013 |
| FPA-T-23 | recoverable: bool per failure event for VAL-004/007/008/009 | When true: trigger = EvidencePending → S7 QUARANTINED; when false: trigger = FreshnessPass + validator\_passed=false → S8 REJECTED | §7 VAL-004 / 007 / 008 / 009 |
| FPA-T-25 | policy\_requires\_Evidence\_bin: bool | When true on EvidencePending path: bundle.evidence\_validation\_result is Some(...) and verdict = QUARANTINE, gate\_class = ESCALATION | §7 VAL-009, §11 EVD-012, §19 OPT-002 |

## §F.D — Declarative obligations (not locally runnable on the published surface)

| Decl ID | Buyer obligation | Reason public-runnable does not apply | Source authority |
| --- | --- | --- | --- |
| FPA-D-01 | The gate-logic emitter MUST emit reason\_code ∈ {APPEND\_IRR, REJECT\_INVALID, REJECT\_STALE, OPEN\_QUARANTINE\_CASE, ISSUE\_RESTORE\_ADMISSION\_TOKEN, DENY\_RESTORE, REENTER\_VERIFIED, BLOCK\_TOOL\_STATE} per §6 Decision Table mapping. | Action-token granularity is the gate-logic layer; the published Surface-1 (next\_state -> WorkflowState) does not return action tokens by design. | §6 DT-01…DT-08; §11 EVD-015 |
| FPA-D-02 | Restore admission MUST NOT activate tool-state automatically. Freshness acceptance never authorizes tool-state activation. | Tool-state authority lives outside agent authority per §19 OPT-005; cross-surface enforcement. | §13 restore rule; §19 OPT-005; §22 non-authority zones; D4 AMB-012 |
| FPA-D-03 | The gate-logic / authority-control layer MUST enforce VAL-011: any ToolStateActivationRequested == true MUST result in BLOCK\_TOOL\_STATE (FAIL\_CLOSED) or OPEN\_QUARANTINE\_CASE per §7 VAL-011. | No ToolStateActivationRequested trigger in Surface-1 by §8 design (tool-state outside §8). VP-GEN-019 / 027 source status = UNTESTABLE on Surface-1. | §7 VAL-011 (Bounded authority control point); §13 BLOCK\_TOOL\_STATE; §19 OPT-005 |
| FPA-D-04 | Distributed enforcement of VAL-011 is real enforcement, not an orphaned validator. | VP-GEN-020 — bounded distributed legitimacy assertion across §7 + §13 + §19 + AMB-012. | §7 VAL-011; §13; §19 OPT-005; D4 AMB-012 |
| FPA-D-05 | Watermark store MUST be monotonic per source. Rollback attempts against the watermark MUST be rejected with a security finding (§16). | §16 Failure Semantics row 9 specifies a security finding alongside REJECT\_INVALID; the security-finding emission is at the gate-logic / observability layer. | §15 freshness monotonicity; §16; FPA-PR-14 |
| FPA-D-06 | The IRR journal MUST be append-only. Acceptance is not effective until durable IRR append; the watermark advances only after IRR append. | Two-step effectivity is enforced by sequence rule in §15; surface enforcement requires journal substrate beyond Surface-1. | §15 canonical sequence; §13 receipt rule; OC-02 IRRAppendRequest |

# §G. Public Fixture and Oracle Records (Sections 8.3 \& 8.4)

## §G.F — Public fixtures

| Fixture ID | Scenario linkage | Fixture class | Required fields | Optional bounded fields | Source authority |
| --- | --- | --- | --- | --- | --- |
| FPA-F-AcceptPacket | VP-GEN-001 / 002 / 016 / 017D / 018; FPA-T-16 | TransferPacket (IC-01) | head\_digest, packet\_hash, source\_id, ledger\_uuid, freshness\_value (> watermark\[source\_id\]), policy\_id, policy\_version, ssm signature | TVC, Evidence.bin, Transport metadata (per active policy) | §9 IC-01; §11 |
| FPA-F-StalePacket | VP-GEN-022; FPA-T-PR-01 | TransferPacket | As above, with freshness\_value ≤ watermark\[source\_id\] | As above | §9 IC-01; §15 |
| FPA-F-MalformedPacket | VP-GEN-004; FPA-T-04 | TransferPacket | Structurally invalid envelope | n/a | §9 IC-01; §7 VAL-001 |
| FPA-F-RestoreRequest | VP-GEN-003 / 013; FPA-T-13a / FPA-T-PR-03 | RestoreRequest (IC-02) | Linked accepted\_head\_digest, GenesisConfirmed = true, IRR reference | restore\_scope (per package authority) | §9 IC-02 |
| FPA-F-RestoreRequest\_NoGenesis | VP-GEN-010; FPA-T-PR-09 | RestoreRequest | As above, with GenesisConfirmed = false | n/a | §9 IC-02; §7 VAL-010 |
| FPA-F-QuarantineReview | VP-GEN-012; FPA-T-12 | QuarantineReviewRequest (IC-03) | quarantine\_case\_id, novelty basis (new evidence or new policy) | n/a | §9 IC-03; §13 READMISSION |
| FPA-F-RecoverableUncertainty | VP-GEN-006; FPA-T-06; FPA-T-23 | TransferPacket + classification | Required policy / evidence / transport item flagged pending | recoverable = true | §7 VAL-004 / 007 / 008 / 009 |
| FPA-F-AcceptBundle | VP-GEN-016 / 017D / 018; FPA-T-16 / FPA-T-17D / FPA-T-18 | PrincipalEvidenceBundle | 10 mandatory + 5 import-path fields | tvc / evidence / transport conditional fields | §11 |
| FPA-F-DenyRestoreBundle | VP-GEN-015; FPA-T-15 | PrincipalEvidenceBundle | 10 mandatory; reason\_code = "DENY\_RESTORE"; semantic\_verdict = FAIL\_CLOSED; gate\_class = "BLOCK" | n/a | §11; §6 DT-06 |
| FPA-F-QuarantineBundle | VP-GEN-025; FPA-T-25 | PrincipalEvidenceBundle | 10 mandatory; semantic\_verdict = QUARANTINE; gate\_class = "ESCALATION"; evidence\_validation\_result = Some | n/a | §11; §6 DT-04 |

## §G.O — Public oracles

| Oracle ID | Scenario linkage | Expected normative result | Expected state / output | Expected evidence fields | Bounded parameter envelope | Forbidden outputs / forbidden semantic collapse |
| --- | --- | --- | --- | --- | --- | --- |
| FPA-O-Accept | VP-GEN-001 / 002 / 016; FPA-T-01 / 02 / 16 | ACCEPT verdict | Progression S0 → S1 → S2 → S3 → S4 → S5; RELEASE gate class | 10 mandatory + 5 import-path fields populated; reason\_code corresponds to APPEND\_IRR per §6 token | TVC / Evidence / Transport per policy | NEVER bypass IRR append before watermark advance; NEVER advance watermark without durable IRR; NEVER emit ACCEPT with stale freshness |
| FPA-O-RejectStale | VP-GEN-022; FPA-T-PR-01 | REJECT verdict | S2 → S8 | reason\_code corresponds to REJECT\_STALE per §6 DT-02 | n/a | NEVER classify stale freshness as FAIL\_CLOSED (AMB-003); NEVER advance watermark on REJECT |
| FPA-O-RejectInvalid | VP-GEN-004 / 009; FPA-T-04 / 09 | FAIL\_CLOSED verdict | S1 or S2 → S8 | reason\_code corresponds to REJECT\_INVALID per §6 DT-03 | n/a | NEVER suppress reason; NEVER append IRR for invalid input |
| FPA-O-Quarantine | VP-GEN-006 / 025; FPA-T-06 / FPA-T-25 | QUARANTINE verdict | S2 → S7 | gate\_class = "ESCALATION"; reason\_code corresponds to OPEN\_QUARANTINE\_CASE per §6 DT-04; QuarantineCaseRecord emitted (OC-05 / MF-04) | recoverable = true; activating policy specified | NEVER conflate QUARANTINE with REJECT (AMB-002, AMB-003) |
| FPA-O-RestoreEligible | VP-GEN-013 / 003; FPA-T-13a / 13b / FPA-T-PR-03 | RESTORATION\_ELIGIBLE verdict, then closure to IDLE | S5 → S6 → S0 | RestoreAdmissionToken (OC-04) emitted; reason\_code corresponds to ISSUE\_RESTORE\_ADMISSION\_TOKEN | restore\_scope per policy | NEVER activate tool-state; NEVER permit restore without GenesisConfirmed and linked IRR (FPA-D-02, FPA-D-03) |
| FPA-O-DenyRestore | VP-GEN-010 / 015; FPA-T-10 / 15 | FAIL\_CLOSED verdict | S5 → S8 | reason\_code = "DENY\_RESTORE"; semantic\_verdict = FAIL\_CLOSED; gate\_class = "BLOCK" | n/a | NEVER substitute REJECT for FAIL\_CLOSED on missing IRR or missing GenesisConfirmed (AMB-003) |
| FPA-O-Readmit | VP-GEN-012; FPA-T-12 | READMIT verdict | S7 → S2 | ReadmissionDecisionRecord emitted (MF-05); gate\_class = "READMISSION" | Novelty basis required | NEVER readmit from non-S7 state; readmission only via QuarantineReviewRequest |
| FPA-O-VerdictTaxonomy | VP-GEN-021 / 022; FPA-T-21 / FPA-T-08c | Type-system separation | Distinct discriminants for verdict tokens; verdict / state / gate\_class / reason\_code never collapsed | semantic\_verdict ∈ closed 6-set | n/a | NEVER reuse verdict token as state label, action token, or gate class without D4 normalization |

# §H. Minimal Run Note (Section 8.5)

**Projection surface required (publishable):**

- Surface-1 — next\_state(WorkflowState, TransitionTrigger, validator\_passed: bool) -> WorkflowState, with the 9-state and 14-trigger enumerations from §8.
- Surface-2 — PrincipalEvidenceBundle with all 17 EVD-001…EVD-017 fields (joint labels permitted to be split into 20 fields per §11 producer attribution).
- Surface-3 — Closed NormativeVerdict enum with the 6-token set from §6 / EVD-016 allowed\_values.

**Input types required:**

WorkflowState, TransitionTrigger, bool (for validator\_passed), and the bounded parameter envelope flags policy\_requires\_TVC, policy\_requires\_Evidence\_bin, transport\_required, recoverable (where parameterized tests apply).

**Assertion result types required:**

- WorkflowState equality (Surface-1).
- PrincipalEvidenceBundle field presence and value-equality on closed-set fields (Surface-2).
- NormativeVerdict discriminant equality / inequality (Surface-3).

PASS condition for the public suite:

Every runnable test in §F.R passes its declared assertion. Every parameterized test in §F.P passes for both branches of its bounded parameter envelope. Every declarative obligation in §F.D is documented in the buyer's conformance record as a non-runnable but required obligation.

**Bounded external obligations not locally runnable:**

FPA-D-01 through FPA-D-06. These are declarative buyer obligations enforced at gate-logic / authority-control / observability / journal layers that are explicitly bounded by §6 / §7 / §13 / §15 / §16 / §19 / §22 of the public package and AMB-003 / AMB-012 of D4.

| Coverage axis | Required closure | Observed in public suite | Result |
| --- | --- | --- | --- |
| State coverage | All 9 states (S0–S8) appear as source / target of at least one public assertion | Surface-1 tests cover S0 → S1, S1 → S2 / S8, S2 → S3 / S7 / S8, S3 → S4, S4 → S5, S5 → S6 / S8, S6 → S0 / S8, S7 → S2 / S8, S8 → S1; FPA-T-14 also covers S8 self-preservation | PASS |
| Trigger coverage | All 14 triggers exercised | TransferPacketReceived (T-01); StructureValid (T-02, T-04); StructureInvalid (T-04); FreshnessPass (T-09, T-24); FreshnessFail (T-08a, T-PR-01); EvidencePending (T-06); IRRAppended (T-26); WatermarkPersisted (T-PR-02, T-PR-14); RestoreRequest+GenesisConfirmed (T-08b / T-10 / T-13a / T-PR-03 / T-PR-09); RestoreAdmitted (T-03, T-13b); RestoreDenied (covered via T-10 / T-PR-09 fail path); ReadmissionApproved (T-12, T-PR-12); ReadmissionRejected (covered via FPA-D-01 declarative); NewPacket (covered via §8 row S8 → S1, attestable in Surface-1) | PASS |
| Validator coverage | All 11 validators (VAL-001…VAL-011) referenced | T-04 (VAL-001); T-09 (VAL-002, VAL-003); T-23 / T-06 (VAL-004); T-PR-01 / T-08a (VAL-005); T-08b / T-10 (VAL-006); T-23 / T-06 (VAL-007); T-17A / T-23 (VAL-008); T-17B / T-25 / T-23 (VAL-009); T-PR-09 / T-10 (VAL-010); FPA-D-03 / FPA-D-04 declarative (VAL-011) | PASS |
| Verdict coverage | All 6 canonical verdicts represented in oracles | ACCEPT (FPA-O-Accept); REJECT (FPA-O-RejectStale, FPA-O-RejectInvalid); QUARANTINE (FPA-O-Quarantine); RESTORATION\_ELIGIBLE (FPA-O-RestoreEligible); FAIL\_CLOSED (FPA-O-DenyRestore); READMIT (FPA-O-Readmit) | PASS |
| Gate class coverage | All 4 gate classes (RELEASE, BLOCK, ESCALATION, READMISSION) represented | RELEASE (FPA-O-Accept); BLOCK (FPA-O-DenyRestore, FPA-O-RejectInvalid); ESCALATION (FPA-O-Quarantine); READMISSION (FPA-O-Readmit) | PASS |
| Mandatory evidence coverage | All 10 always-present + 5 import-path EVD entries asserted | FPA-T-16, FPA-T-15, FPA-F-AcceptBundle / FPA-F-DenyRestoreBundle | PASS |
| Conditional evidence coverage | All 5 activation-conditional EVD entries asserted | FPA-T-17A (TVC), FPA-T-17B (Evidence.bin), FPA-T-17C (Transport), FPA-T-17D (IRR linkage); FPA-T-25 (Evidence.bin under quarantine) | PASS |
| Distributed enforcement coverage | VAL-011 / tool-state authority edge surfaced declaratively | FPA-D-03 + FPA-D-04 (per VP-GEN-019 / 020) | PASS |
| Delegated-choice coverage | Bounded delegated branches surfaced as parameterized | FPA-T-17A / B / C, FPA-T-23, FPA-T-25 (4 distinct bounded parameter envelopes) | PASS |
| Projection-surface exception coverage | Untestable scenarios transparently recorded | VP-GEN-019, VP-GEN-027 → FPA-D-03 declarative | PASS |
| Inapplicability discipline | Inapplicable scenarios omitted with package-grounded justification | VP-GEN-005 (no constrained-allow), VP-GEN-007 (no reclassification) | PASS |
| Agent-specific Validation Pack coverage | All 14 PR scenarios from Appendix A represented | PR-01 (FPA-T-PR-01); PR-02 (FPA-T-PR-02); PR-03 (FPA-T-PR-03); PR-04 (UNTESTABLE on Surface-1, declarative obligation FPA-D-06); PR-05A / B (T-09); PR-05C / E / F (T-06 + T-23); PR-05D (T-09); PR-06 (FPA-T-18 / FPA-F-AcceptBundle agent\_id + source\_id + ledger\_uuid + decision\_object + policy\_id / version); PR-07 (FPA-D-03); PR-08 (T-09 + FPA-D-01); PR-09 (FPA-T-PR-09); PR-10 (FPA-T-PR-10); PR-11 (FPA-T-16); PR-12 (FPA-T-PR-12); PR-13 (FPA-T-PR-13); PR-14 (FPA-T-PR-14 + FPA-D-05) | PASS |
| Surface-leakage check | No tests, fixtures, oracles, or run-note items expose process provenance. | Confirmed; only public §-anchors and D4 entries cited | PASS |

# §I. Final public conformance result

| Gate | Result |
| --- | --- |
| Source-status preservation from accepted source inventory | PRESERVED — every per-scenario record carries the scenario status without alteration |
| Scenario-status preservation | PRESERVED — every per-scenario record carries its scenario status without alteration |
| Disposition mapping | COMPLIANT — PASS → RUNNABLE / PARAMETRIC / DECLARATIVE; PARAMETERIZED-OPEN → PARAMETRIC; UNTESTABLE → DECLARATIVE only with bounded buyer obligation; Inapplicable → NOT-APPLICABLE |
| Surface-provenance containment | HELD — published content comprises Public Test Suite (§F.R, §F.P), Public Fixtures (§G.F), Public Oracles (§G.O), Declarative Obligations (§F.D), and Minimal Run Note (§H) |
| Suite-level completeness audit | None |
| Blocked public records (FAIL or true defect) | None |

PUBLIC CONFORMANCE TEST SUITE AUTHORIZED

The Freshness Portability Agent (FPA-FRESHNESS-PORTABILITY-003 v1.0 / index v2.0) public conformance test layer comprises 30 runnable tests, 5 parameterized tests, 6 declarative obligations, 10 fixtures, and 8 oracles. It is buyer-usable as an autosufficiency test layer.
