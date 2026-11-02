# Conformance Tests Audit Replay Agent / ARA-AUDIT-REPLAY-001

*Buyer-facing conformance layer: public test suite, public fixtures, public oracles, and minimal run note.*

## 1. Scope and conformance boundary

This conformance layer comprises the buyer-usable test artifacts: test scenarios, fixtures, oracles, and a minimal run note. The artifacts are derived from the public specification and are sufficient for buyer-side conformance verification.

## 2. Conformance vocabulary

| Workflow states | S0 INGESTED; S1 PARSED; S2 VERIFIED; S3 RECONSTRUCTED; S4 CHECKPOINT\_RESOLVED; S5 REPORT\_READY; S6 READMITTED; SH HOLD\_ACTIVE; SX FAIL\_CLOSED. |
| --- | --- |
| **Triggers/events** | EV\_PARSE\_OK; EV\_SIGNATURE\_FAIL; EV\_CHAIN\_BREAK; EV\_POLICY\_UNRESOLVED; EV\_LASTCLEAN\_FOUND; EV\_ROLLBACK\_REPLAYED; EV\_REPORT\_BOUND; EV\_EVIDENCE\_FAIL; EV\_COUNTER\_REPLAY; EV\_READMISSION\_GRANTED; ROLLBACK; public derived completion triggers for verification/replay-fold/resumption where exposed. |
| **Validators** | V-01 Frame length; V-02 Checksum; V-03 Canonical parse; V-04 Signature; V-05 Hash continuity; V-06 Policy bind; V-07 Checkpoint lineage; V-08 Report sufficiency; V-09 Replay counter / freshness; V-10 Tool-state exclusion. |
| **Canonical verdicts** | REPLAYABLE; PARTIAL; REJECTED; BROKEN; INCIDENT\_ONLY. |
| **Evidence surface** | bundle\_digest; policy\_profile\_id / policy\_hash; validator\_outcomes; hash\_continuity\_refs; signature\_refs; checkpoint\_refs; rollback\_refs; report\_fields\_ref; hold\_enter\_refs; hold\_exit\_refs; anchor\_update\_ref; boot\_or\_verif\_refs; report\_signature / export\_manifest\_ref. |

## 3. Conformance test disposition inventory

| Class | Count | Meaning |
| --- | --- | --- |
| **Runnable** | 22 | Buyer-runnable on exposed state, verdict, evidence, or schema projection surface. |
| **Parameterized** | 1 | Public-usable only inside the bounded parameter envelope authorized by the package. |
| **Declarative** | 4 | Real buyer obligation, but local runnable projection is insufficient because enforcement is bounded elsewhere. |

## 4. Per-scenario conformance records

| Public ID | Status | Class | Expected public result |
| --- | --- | --- | --- |
| **ARA-T001** | PASS | Runnable | S0 -> S1 |
| **ARA-T002** | PASS | Runnable | S2 -> S3 |
| **ARA-T003** | PASS | Runnable | S4 -> S5 and final-output readiness |
| **ARA-T004** | PASS | Runnable | SX; chain break also BROKEN |
| **ARA-T005** | PASS | Runnable | No SX; finalization blocked; INCIDENT\_ONLY or PARTIAL |
| **ARA-T006** | PASS | Runnable | SH HOLD\_ACTIVE; governance escalation outside state machine |
| **ARA-T007** | PASS | Runnable | No SX; rollback INVALID; PARTIAL/REJECTED as applicable |
| **ARA-T008** | PASS | Runnable | Distinct failure routes preserved |
| **ARA-T009** | PASS | Runnable | SX FAIL\_CLOSED |
| **ARA-T010** | PASS | Runnable | SX FAIL\_CLOSED and BROKEN |
| **ARA-T011** | PASS | Runnable | Critical events never silently preserve state |
| **ARA-T012** | PASS | Runnable | S6 READMITTED |
| **ARA-T013** | PASS | Runnable | Remain SH/SX; no inherited access to S2/S4 |
| **ARA-T014** | PASS | Runnable | Remain S5 unless critical override occurs |
| **ARA-T015** | PASS | Runnable | Signed report/export manifest present |
| **ARA-T016** | PASS | Runnable | Mandatory evidence fields present |
| **ARA-T017** | PASS | Runnable | Conditional hold/readmission evidence activated correctly |
| **ARA-T018** | PASS | Runnable | Authorized non-validator producer provenance preserved |
| **ARA-T019** | UNTESTABLE via local next\_state | Declarative | QUARANTINE; no admission to logical reconstruction |
| **ARA-T020** | PASS | Declarative | V-10 tied to gate enforcement, not orphaned |
| **ARA-T021** | PASS | Runnable | Canonical verdict distinct from routing/event/object labels |
| **ARA-T022** | PASS | Runnable | SX distinct from SH; BROKEN distinct from other negatives |
| **ARA-T023** | PARAMETERIZED-OPEN | Parameterized | Bounded parameter envelope preserved |
| **ARA-T024** | PASS | Runnable | Cross-read transition + validator yields S3 -> S4 |
| **ARA-T025** | PASS | Runnable | Readmission obligations derived from scenario + contract |
| **ARA-T026** | PASS | Runnable | Discriminating input/output directly testable |
| **ARA-T027** | PASS | Declarative | Transparent classification, no hidden omission/collapse |

## 5. Public Test Suite

**ARA-T001 - Initial parse admission**

| Test kind | Runnable state-transition test |
| --- | --- |
| **Normative purpose** | Initial parse admission |
| **Input surface** | Valid Session Bundle satisfying IC-01; V-01/V-02/V-03 pass |
| **Execution / assertion surface** | next(S0\_INGESTED, EV\_PARSE\_OK, pass) == S1\_PARSED |
| **Expected PASS condition** | State becomes S1 PARSED |
| **Forbidden or bounded condition** | Replay logic must not be entered before parse admission. |

**ARA-T002 - Replay-fold continuation**

| Test kind | Runnable state-transition test |
| --- | --- |
| **Normative purpose** | Replay-fold continuation |
| **Input surface** | S2 VERIFIED with verification prerequisites satisfied |
| **Execution / assertion surface** | next(S2\_VERIFIED, replay\_fold\_complete, pass) == S3\_RECONSTRUCTED |
| **Expected PASS condition** | State becomes S3 RECONSTRUCTED |
| **Forbidden or bounded condition** | Failed replay fold must remain bounded; no invented failure route. |

**ARA-T003 - Report finalization readiness**

| Test kind | Runnable state-transition test |
| --- | --- |
| **Normative purpose** | Report finalization readiness |
| **Input surface** | S4 CHECKPOINT\_RESOLVED; report/evidence binding passes |
| **Execution / assertion surface** | next(S4\_CHECKPOINT\_RESOLVED, EV\_REPORT\_BOUND, pass) == S5\_REPORT\_READY |
| **Expected PASS condition** | State becomes S5 REPORT\_READY |
| **Forbidden or bounded condition** | Report insufficiency blocks finalization and cannot become REPLAYABLE. |

**ARA-T004 - Blocking validator failure**

| Test kind | Runnable failure-routing test |
| --- | --- |
| **Normative purpose** | Blocking validator failure |
| **Input surface** | Any active state with signature failure or chain break |
| **Execution / assertion surface** | EV\_SIGNATURE\_FAIL -> SX\_FAIL\_CLOSED; EV\_CHAIN\_BREAK -> SX\_FAIL\_CLOSED + BROKEN |
| **Expected PASS condition** | Critical failures enter SX; chain break emits BROKEN |
| **Forbidden or bounded condition** | No positive verdict or silent state preservation. |

**ARA-T005 - Constrained report failure**

| Test kind | Runnable output/state non-collapse test |
| --- | --- |
| **Normative purpose** | Constrained report failure |
| **Input surface** | S4 CHECKPOINT\_RESOLVED; report fields insufficient |
| **Execution / assertion surface** | No SX solely due to report insufficiency; finalization blocked |
| **Expected PASS condition** | INCIDENT\_ONLY or PARTIAL, or FINALIZE\_REPORT blocked |
| **Forbidden or bounded condition** | No REPLAYABLE and no generic SX collapse. |

**ARA-T006 - Evidence failure hold/escalation**

| Test kind | Runnable hold-routing test |
| --- | --- |
| **Normative purpose** | Evidence failure hold/escalation |
| **Input surface** | Any active state; required verification evidence missing/invalid |
| **Execution / assertion surface** | EV\_EVIDENCE\_FAIL -> SH\_HOLD\_ACTIVE |
| **Expected PASS condition** | State becomes SH HOLD\_ACTIVE; compliant finalization blocked |
| **Forbidden or bounded condition** | Escalation/governance is outside workflow-state value. |

**ARA-T007 - Checkpoint reclassification**

| Test kind | Runnable non-collapse + output oracle |
| --- | --- |
| **Normative purpose** | Checkpoint reclassification |
| **Input surface** | S3 RECONSTRUCTED; LASTCLEAN/checkpoint lineage fails |
| **Execution / assertion surface** | No SX solely from checkpoint-unverified; rollback INVALID or partial path |
| **Expected PASS condition** | Rollback sequence INVALID or equivalent bounded output |
| **Forbidden or bounded condition** | No REPLAYABLE and no generic SX collapse. |

**ARA-T008 - Per-validator semantic non-collapse**

| Test kind | Runnable comparative oracle |
| --- | --- |
| **Normative purpose** | Per-validator semantic non-collapse |
| **Input surface** | Failure cases for V-04, V-05, V-07, V-08, V-09 |
| **Execution / assertion surface** | Signature -> SX; chain -> SX + BROKEN; counter -> SH; checkpoint -> invalid; report -> blocked/partial/incident-only |
| **Expected PASS condition** | All failure routes remain distinct |
| **Forbidden or bounded condition** | No uniform catch-all failure bucket. |

**ARA-T009 - Global fail-closed**

| Test kind | Runnable fail-closed test |
| --- | --- |
| **Normative purpose** | Global fail-closed |
| **Input surface** | Any active state; signature failure |
| **Execution / assertion surface** | EV\_SIGNATURE\_FAIL -> SX\_FAIL\_CLOSED |
| **Expected PASS condition** | SX FAIL\_CLOSED |
| **Forbidden or bounded condition** | No acceptance/reconstruction after signature failure. |

**ARA-T010 - Protection override from non-initial state**

| Test kind | Runnable override test |
| --- | --- |
| **Normative purpose** | Protection override from non-initial state |
| **Input surface** | S4 CHECKPOINT\_RESOLVED; chain break |
| **Execution / assertion surface** | next(S4, EV\_CHAIN\_BREAK, fail) == SX\_FAIL\_CLOSED + BROKEN |
| **Expected PASS condition** | Maximum-protection route |
| **Forbidden or bounded condition** | No continuing toward S5. |

**ARA-T011 - No silent preservation for critical signals**

| Test kind | Runnable critical-event sweep |
| --- | --- |
| **Normative purpose** | No silent preservation for critical signals |
| **Input surface** | All workflow states; critical trigger set |
| **Execution / assertion surface** | signature/chain -> SX; evidence/counter -> SH; policy unresolved -> BLOCKED or SX |
| **Expected PASS condition** | No critical signal silently preserves current state |
| **Forbidden or bounded condition** | Policy unresolved may be parameterized. |

**ARA-T012 - Controlled recovery path**

| Test kind | Runnable readmission test |
| --- | --- |
| **Normative purpose** | Controlled recovery path |
| **Input surface** | SH or SX; readmission evidence present |
| **Execution / assertion surface** | EV\_READMISSION\_GRANTED(pass) -> S6\_READMITTED |
| **Expected PASS condition** | S6 READMITTED only with prerequisites satisfied |
| **Forbidden or bounded condition** | No direct jump to normal state. |

**ARA-T013 - Non-inheriting restoration**

| Test kind | Runnable restoration-boundary test |
| --- | --- |
| **Normative purpose** | Non-inheriting restoration |
| **Input surface** | SH or SX; missing/invalid readmission evidence |
| **Execution / assertion surface** | Failed readmission remains SH or SX |
| **Expected PASS condition** | No permission inheritance |
| **Forbidden or bounded condition** | No jump to S2/S4 without proof. |

**ARA-T014 - Terminal state integrity**

| Test kind | Runnable terminal integrity test |
| --- | --- |
| **Normative purpose** | Terminal state integrity |
| **Input surface** | S5 REPORT\_READY; out-of-order positive trigger |
| **Execution / assertion surface** | State remains S5 unless critical failure signal occurs |
| **Expected PASS condition** | No implicit reopen/regression |
| **Forbidden or bounded condition** | No unauthorized return to earlier normal states. |

**ARA-T015 - Closure artifact completeness**

| Test kind | Runnable evidence/artifact test |
| --- | --- |
| **Normative purpose** | Closure artifact completeness |
| **Input surface** | Final audit report and machine evidence export |
| **Execution / assertion surface** | report signature and export manifest present; chain-of-custody binding present |
| **Expected PASS condition** | Final output has report/export integrity evidence |
| **Forbidden or bounded condition** | No final report without export integrity proof. |

**ARA-T016 - Mandatory evidence bundle completeness**

| Test kind | Runnable evidence completeness test |
| --- | --- |
| **Normative purpose** | Mandatory evidence bundle completeness |
| **Input surface** | Evidence bundle for REPLAYABLE or finalizable output |
| **Execution / assertion surface** | mandatory and conditionally activated evidence fields present |
| **Expected PASS condition** | All required evidence fields present and bound |
| **Forbidden or bounded condition** | No positive verdict without minimum evidence. |

**ARA-T017 - Conditional evidence activation**

| Test kind | Runnable conditional evidence test |
| --- | --- |
| **Normative purpose** | Conditional evidence activation |
| **Input surface** | NONCOMPLIANT\_HOLD / readmission case |
| **Execution / assertion surface** | hold\_enter\_refs; hold\_exit\_refs; anchor\_update\_ref under activation |
| **Expected PASS condition** | Conditional fields present when activated |
| **Forbidden or bounded condition** | No readmission without hold-exit and updated anchor. |

**ARA-T018 - Authorized non-validator producer evidence**

| Test kind | Runnable producer-grounding test |
| --- | --- |
| **Normative purpose** | Authorized non-validator producer evidence |
| **Input surface** | Input/export/readmission governance evidence |
| **Execution / assertion surface** | producer provenance explicitly bounded |
| **Expected PASS condition** | Non-validator evidence producers explicit and bounded |
| **Forbidden or bounded condition** | No orphaned evidence producer. |

**ARA-T019 - Gate-only tool-state enforcement**

| Test kind | Declarative public conformance check |
| --- | --- |
| **Normative purpose** | Gate-only tool-state enforcement |
| **Input surface** | Unauthorized tool-state artifact |
| **Execution / assertion surface** | V-10 failure yields QUARANTINE; artifact not injected into reconstruction |
| **Expected PASS condition** | Gate layer isolates artifact and emits incident/audit handling |
| **Forbidden or bounded condition** | No admission into replay core. |

**ARA-T020 - Distributed enforcement legitimacy**

| Test kind | Declarative cross-reference check |
| --- | --- |
| **Normative purpose** | Distributed enforcement legitimacy |
| **Input surface** | Validator catalogue + gate logic |
| **Execution / assertion surface** | V-10 maps to QUARANTINE with permitted/prohibited actions |
| **Expected PASS condition** | Distributed enforcement real and bounded |
| **Forbidden or bounded condition** | Do not treat absence from next\_state as no enforcement. |

**ARA-T021 - Canonical verdict fidelity**

| Test kind | Runnable schema/taxonomy test |
| --- | --- |
| **Normative purpose** | Canonical verdict fidelity |
| **Input surface** | Verdict schema / machine evidence / report output |
| **Execution / assertion surface** | canonical verdict set remains closed; routing/object labels do not enlarge it |
| **Expected PASS condition** | Taxonomy preservation |
| **Forbidden or bounded condition** | No verdict leakage from BLOCKED/FINALIZABLE/VALID/RECONSTRUCTABLE. |

**ARA-T022 - Negative outcome separation**

| Test kind | Runnable comparative oracle |
| --- | --- |
| **Normative purpose** | Negative outcome separation |
| **Input surface** | Chain break, counter replay, rejection/incident paths |
| **Execution / assertion surface** | BROKEN != REJECTED; SX != SH; INCIDENT\_ONLY != FAIL\_CLOSED |
| **Expected PASS condition** | Separate negative semantics |
| **Forbidden or bounded condition** | No uniform negative bucket. |

**ARA-T023 - Bounded delegated branch**

| Test kind | Parameterized public test |
| --- | --- |
| **Normative purpose** | Bounded delegated branch |
| **Input surface** | Unresolved policy; readmission resumption destination |
| **Execution / assertion surface** | EV\_POLICY\_UNRESOLVED yields BLOCKED or SX; S6 resumes to S2 or S4 under declared conditions |
| **Expected PASS condition** | Chosen branch inside documented parameter envelope |
| **Forbidden or bounded condition** | No unbounded third branch or author-dependent decision. |

**ARA-T024 - Transition-plus-validator derivation**

| Test kind | Runnable cross-reference test |
| --- | --- |
| **Normative purpose** | Transition-plus-validator derivation |
| **Input surface** | S3; usable checkpoint with LASTCLEAN before FAIL\_CLOSED and verifiable state hash |
| **Execution / assertion surface** | EV\_LASTCLEAN\_FOUND(pass) -> S4\_CHECKPOINT\_RESOLVED |
| **Expected PASS condition** | S3 -> S4 only when V-07 satisfied |
| **Forbidden or bounded condition** | No checkpoint use without lineage validation. |

**ARA-T025 - Evidence-plus-scenario derivation**

| Test kind | Runnable conditional evidence derivation test |
| --- | --- |
| **Normative purpose** | Evidence-plus-scenario derivation |
| **Input surface** | HOLD\_ACTIVE-to-READMITTED scenario |
| **Execution / assertion surface** | readmission requires hold\_exit\_refs, anchor\_update\_ref, resolvable policy, revalidation evidence |
| **Expected PASS condition** | Readmission evidence closure |
| **Forbidden or bounded condition** | No readmission without evidence closure. |

**ARA-T026 - Adequate projection granularity**

| Test kind | Runnable projection adequacy test |
| --- | --- |
| **Normative purpose** | Adequate projection granularity |
| **Input surface** | S4; report sufficient |
| **Execution / assertion surface** | EV\_REPORT\_BOUND(pass) -> S5\_REPORT\_READY |
| **Expected PASS condition** | Direct state result surfaced |
| **Forbidden or bounded condition** | Direct projection sufficient; no auxiliary verification required. |

**ARA-T027 - Transparent exception handling**

| Test kind | Declarative exception/classification record |
| --- | --- |
| **Normative purpose** | Transparent exception handling |
| **Input surface** | V-10 gate-only path; delegated policy/resumption branches |
| **Execution / assertion surface** | V-10 exported declaratively; V-06/S6 exported parameterized |
| **Expected PASS condition** | No hidden omission; no semantic collapse |
| **Forbidden or bounded condition** | Do not present untestable gate logic as workflow transition. |

## 6. Public Fixtures

| Fixture ID | Linkage | Class | Required fields / authority |
| --- | --- | --- | --- |
| **FIX-ARA-001** | T001/T016 | Valid Session Bundle | ledger\_uuid; session\_id; record stream; policy\_profile\_id; source\_id; hash head/tail; signature refs. IC-01 admission fixture. |
| **FIX-ARA-002** | T001 | Corrupted Structural Bundle | malformed frame length; checksum mismatch; invalid canonical parse. Record-level denial fixture. |
| **FIX-ARA-003** | T004/T009/T010 | Chain Break Bundle | valid entry state plus broken hash\_prev/hash\_curr continuity; hash-break proof. Expected BROKEN + SX. |
| **FIX-ARA-004** | T004/T009 | Signature Failure Bundle | invalid or missing required signature under policy; signature/trust-store refs. Expected SX FAIL\_CLOSED. |
| **FIX-ARA-005** | T024/T007 | Checkpoint Lineage Bundle | LASTCLEAN candidate; checkpoint refs; state hash; optional rollback refs. Pass -> S4; fail -> rollback invalid/partial. |
| **FIX-ARA-006** | T005/T015/T016 | Report Evidence Bundle | report fields; decisions; checkpoints; continuity; limitations; report signature/export manifest. |
| **FIX-ARA-007** | T006/T017/T025 | Hold/Readmission Bundle | hold enter refs; hold exit refs; updated anchor; policy binding; optional VERIF\_EVENT / VERIF\_COUNTER\_ANCHOR. |
| **FIX-ARA-008** | T019/T020 | Tool-State Artifact Fixture | unauthorized tool-state artifact; optional incident export metadata. Must trigger QUARANTINE. |
| **FIX-ARA-009** | T018 | Authorized Producer Evidence Fixture | input-contract evidence; export-governance evidence; readmission-governance evidence. |
| **FIX-ARA-010** | T023 | Delegated Policy Fixture | policy parameter for unresolved policy route and readmission destination; policy profile selector. |

## 7. Public Oracles

| Oracle ID | Linkage | Expected result | Forbidden collapse |
| --- | --- | --- | --- |
| **ORA-ARA-001** | T001 | Valid parse permits first transition; expected S1 PARSED | No direct reconstruction before parse. |
| **ORA-ARA-002** | T002 | Verified state reconstructs; expected S3 RECONSTRUCTED after replay fold complete | No skip from S1 to S3. |
| **ORA-ARA-003** | T003/T015 | Final report ready; expected S5 REPORT\_READY and OC-01/OC-02 eligibility | No final output without evidence binding. |
| **ORA-ARA-004** | T004/T009/T010 | Critical failure protected; expected SX FAIL\_CLOSED and BROKEN for chain break | No positive verdict. |
| **ORA-ARA-005** | T005 | Report insufficiency bounded; expected INCIDENT\_ONLY or PARTIAL; finalization blocked | Must not collapse into REPLAYABLE. |
| **ORA-ARA-006** | T006/T017 | Evidence/counter failure hold; expected SH HOLD\_ACTIVE; compliant finalization blocked | Not SX unless separate critical trigger. |
| **ORA-ARA-007** | T007/T024 | Checkpoint invalidity bounded; expected rollback INVALID or PARTIAL/incident path | No automatic chain/signature fail-closed collapse. |
| **ORA-ARA-008** | T008/T022 | Non-collapse oracle; expected distinct outputs for failure classes | No uniform failure bucket. |
| **ORA-ARA-009** | T012/T013/T025 | Readmission closure; S6 READMITTED only after proof | No inherited S2/S4 privileges without resumption. |
| **ORA-ARA-010** | T019/T020 | Tool-state exclusion; expected QUARANTINE and isolated audit/incident export | No injection into replay core. |
| **ORA-ARA-011** | T021 | Canonical verdict fidelity; expected closed canonical verdict set | No verdict leakage. |
| **ORA-ARA-012** | T023 | Delegated branch envelope; policy BLOCKED or SX; S6 -> S2/S4 | No unbounded third branch. |

## 8. Minimal Run Note

| Projection surface required | Workflow state transition surface; validator outcome surface; verdict/output surface; evidence-bundle surface; gate-logic surface for QUARANTINE. |
| --- | --- |
| **Input types required** | Session Bundle; Optional Evidence when policy activates bound verification; validator outcomes; checkpoint/rollback/report/hold/readmission/export evidence. |
| **Assertion result types required** | State equality; verdict/output equality; evidence field presence; forbidden-output assertions; bounded-parameter conformance. |
| **PASS condition** | All Runnable tests pass; Parameterized tests remain inside the declared parameter envelope; Declarative obligations are implemented or documented in the bounded external/gate surface; no forbidden semantic collapse occurs. |
| **Bounded external obligations not locally runnable** | V-10 / QUARANTINE gate-logic enforcement; escalation/governance handling; deployment-policy selection for unresolved policy route; policy selection for S6 controlled resumption target. |
