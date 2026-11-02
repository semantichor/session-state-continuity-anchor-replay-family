Public Conformance Test Suite

Boundary Defense Agent - Conformance Package

*Public integration-ready artifact*

| Field | Value |
| --- | --- |
| Agent / package | Boundary Defense Agent - Conformance Package |
| Public output classes | Public Test Suite; Public Fixtures; Public Oracles; Minimal Run Note |

## Controlled public-boundary statement

This document contains the buyer-usable conformance test suite.

# 1. Public Conformance Layer - Authoritative Vocabulary

| Category | Public vocabulary |
| --- | --- |
| State set | IDLE; INGEST\_VALIDATE; FILTER\_REVIEW; TOOL\_STATE\_QUARANTINED; READY\_FOR\_RELEASE; OUTPUT\_BLOCKED; FINALIZATION\_REVIEW; NONCOMPLIANT\_HOLD |
| Runnable trigger set | INPUT\_RECEIVED; VALIDATION\_PASS; VALIDATION\_FAIL; TOOL\_STATE\_DETECTED; NO\_ESCALATION; APPROVAL\_GRANTED; FINALIZATION\_REQUESTED; EVIDENCE\_OK; EVIDENCE\_FAIL; CPW\_CRITICAL; READMISSION\_APPROVED; COMPLIANCE\_RESTORED |
| Canonical verdict set | ALLOW; ALLOW\_CONSTRAINED; BLOCK; QUARANTINE; FAIL\_CLOSED; NONCOMPLIANT\_HOLD; READMIT |
| Validator set | VAL-01 Schema; VAL-02 Policy/Allowlist; VAL-03 Statement Provenance; VAL-04 Freshness/Receipt; VAL-05 Evidence Chain; VAL-06 Approval; VAL-07 CPW Band; VAL-08 Reconstruction |
| Mandatory evidence fields | decision\_id; session\_id; boundary\_side; decision\_object; input\_digest; policy\_hash; validator\_results; statement\_refs; verdict; reason\_code; order\_index; hash\_prev; hash\_curr |
| Conditional evidence fields | approval\_ref; evidence\_ref; verif\_counter\_anchor; rollback\_ref |

# 2. Public Test Suite

The following records are integration-ready public conformance tests. They are intentionally technology-neutral and can be implemented against any buyer-visible projection surface that exposes equivalent state, trigger, validator, verdict, and evidence outcomes.

**Test ID**

**Kind**

**Purpose**

**Public test record**

PTS-BDA-001

State transition

Initial passing path

Input: IDLE; INPUT\_RECEIVED; guard always.

Assertion: result is INGEST\_VALIDATE.

PASS: first valid boundary progression.

PTS-BDA-002

State transition

Ingest validation pass

Input: INGEST\_VALIDATE; VALIDATION\_PASS; VAL-01/02/03 pass.

Assertion: result is FILTER\_REVIEW.

PASS: mandatory ingest validators advance the path.

PTS-BDA-003

State transition

Filter review pass

Input: FILTER\_REVIEW; NO\_ESCALATION; VAL-02/04/07 pass; no tool-state risk.

Assertion: result is READY\_FOR\_RELEASE.

PASS: no-escalation path prepares release.

PTS-BDA-004

State transition

Finalization success

Input: FINALIZATION\_REVIEW; EVIDENCE\_OK; VAL-05/08 pass; evidence\_ok=true; counter strictly increases.

Assertion: result is IDLE.

PASS: finalization closes with reconstruction-ready evidence.

PTS-BDA-005

Negative transition

Invalid schema blocks

Input: INGEST\_VALIDATE; VALIDATION\_FAIL; VAL-01 failure.

Assertion: OUTPUT\_BLOCKED and verdict BLOCK.

Forbidden: quarantine, allow, or downstream parsing.

PTS-BDA-006

Negative transition

Disallowed tool-state quarantines

Input: FILTER\_REVIEW; TOOL\_STATE\_DETECTED; VAL-02 elevated tool-state risk.

Assertion: TOOL\_STATE\_QUARANTINED and verdict QUARANTINE.

Forbidden: release or execution before approval.

PTS-BDA-007

Negative transition

Allowlist miss blocks non-tool class

Input: INGEST\_VALIDATE; VALIDATION\_FAIL; VAL-02 allowlist failure.

Assertion: OUTPUT\_BLOCKED and verdict BLOCK.

Forbidden: quarantine substitution where BLOCK is required.

PTS-BDA-008

Negative approval path

Missing approval remains quarantined

Input: TOOL\_STATE\_QUARANTINED; APPROVAL\_GRANTED trigger with VAL-06 fail/no approval evidence.

Assertion: remains TOOL\_STATE\_QUARANTINED.

PASS: no activation without approval\_ref.

PTS-BDA-009

Replay/freshness negative

Non-increasing freshness blocks

Input: freshness \<= accepted\_anchor or equivalent VAL-04 failure.

Assertion: OUTPUT\_BLOCKED; verdict BLOCK; accepted head unchanged.

PASS: replay/downgrade blocked.

PTS-BDA-010

Receipt negative

Missing receipt blocks

Input: missing durable receipt or evidence append condition.

Assertion: OUTPUT\_BLOCKED and verdict BLOCK.

PASS: missing receipt cannot gain visibility or release.

PTS-BDA-011

Declarative evidence conformance

Unlabeled claim blocks and requires conflict evidence

Input: statement\_usage\_request missing tsa\_label or inadmissible source\_class.

Assertion: verdict BLOCK; gate use denied; conflict evidence recorded.

Disposition: EXTRACT-DECLARATIVE.

PTS-BDA-012

Declarative verdict taxonomy

ALLOW vs ALLOW\_CONSTRAINED distinction

Input: canonical verdict vocabulary.

Assertion: ALLOW != ALLOW\_CONSTRAINED; no merge.

PASS: full allow and constrained allow remain distinct.

PTS-BDA-013

Critical override

CPW critical escalation

Input: any active state; CPW\_CRITICAL; VAL-07 detects CRITICAL.

Assertion: OUTPUT\_BLOCKED; FAIL\_CLOSED effect; release/finalization inhibited.

PASS: critical risk overrides normal progression.

PTS-BDA-014

Comparative semantics

Per-validator non-collapse

Input: VAL-01 failure vs VAL-05 failure.

Assertion: VAL-01 -> OUTPUT\_BLOCKED; VAL-05 -> NONCOMPLIANT\_HOLD; outcomes unequal.

PASS: failure semantics remain distinct.

PTS-BDA-015

Fail-closed routing

Global fail-closed rule

Input: FILTER\_REVIEW; CPW\_CRITICAL.

Assertion: OUTPUT\_BLOCKED and fail-closed obligation.

Forbidden: local guard override.

PTS-BDA-016

Protection override

Override from finalization review

Input: FINALIZATION\_REVIEW; CPW\_CRITICAL.

Assertion: OUTPUT\_BLOCKED.

PASS: critical override works late in workflow.

PTS-BDA-017

Protection override

Override from tool-state quarantine

Input: TOOL\_STATE\_QUARANTINED; CPW\_CRITICAL.

Assertion: OUTPUT\_BLOCKED.

PASS: critical override governs quarantine branch.

PTS-BDA-018

Recovery transition

Readmission recovery path

Input: OUTPUT\_BLOCKED; READMISSION\_APPROVED; remediated validators; VAL-08 available where needed.

Assertion: IDLE and READMIT.

PASS: blocked path restored only under proof.

PTS-BDA-019

Hold recovery

Hold-exit recovery path

Input: NONCOMPLIANT\_HOLD; COMPLIANCE\_RESTORED; VAL-05/08 restored; anchor updated.

Assertion: IDLE; hold exit; READMIT.

PASS: hold exits only after evidence prerequisites restored.

PTS-BDA-020

Negative recovery

Recovery refused when prerequisites fail

Input: recovery trigger with guard failure.

Assertion: state remains OUTPUT\_BLOCKED or NONCOMPLIANT\_HOLD.

PASS: failed prerequisites do not reopen path.

PTS-BDA-021

Restoration boundary

Non-inheriting restoration boundary

Input: successful readmission to IDLE followed by shortcut attempt.

Assertion: re-entry must pass through INPUT\_RECEIVED -> INGEST\_VALIDATE.

Forbidden: direct release authority inherited from restoration.

PTS-BDA-022

Artifact completeness

Closure artifact completeness

Input: boundary\_verdict or release-linked artifact.

Assertion: decision\_id, verdict, reason\_code, validator\_results, statement\_refs, input\_digest present.

PASS: reconstructable boundary decision artifact.

PTS-BDA-023

Evidence completeness

Mandatory evidence bundle completeness

Input: representative accepted boundary decision.

Assertion: all 13 mandatory evidence fields present.

PASS: third party can reconstruct decision and authorization.

PTS-BDA-024

Conditional evidence

Conditional approval evidence

Input: tool-state activation path.

Assertion: approval\_ref present.

PASS: no compliance-claimed tool activation without approval evidence.

PTS-BDA-025

Conditional evidence

Conditional finalization evidence

Input: finalization path.

Assertion: evidence\_ref and verif\_counter\_anchor present.

PASS: finalization has external assurance evidence.

PTS-BDA-026

Conditional evidence

Conditional rollback evidence

Input: recovery/fail-closed path with rollback action.

Assertion: rollback\_ref present when rollback action is claimed.

PASS: rollback claim is evidence-backed.

PTS-BDA-027

Producer conformance

Authorized non-validator producer grounding

Input: evidence fields produced by authorized non-validator producers.

Assertion: producer authority is explicit; no orphaned evidence.

Disposition: EXTRACT-DECLARATIVE.

PTS-BDA-028

Governance enforcement

VAL-07 governance override

Input: READY\_FOR\_RELEASE; CPW\_CRITICAL; local validator\_passed=true.

Assertion: OUTPUT\_BLOCKED.

PASS: critical governance override defeats local progression.

PTS-BDA-029

Enforcement conformance

Distributed enforcement legitimacy

Input: Validator Catalogue plus workflow/gate logic.

Assertion: VAL-01..VAL-08 each have bounded enforcement point.

Disposition: EXTRACT-DECLARATIVE.

PTS-BDA-030

Verdict taxonomy

Canonical verdict fidelity

Input: canonical verdict set.

Assertion: exactly seven verdicts; all pairwise distinct.

PASS: no non-canonical verdict leakage.

PTS-BDA-031

Semantic separation

Negative outcome separation

Input: negative verdict/state outputs.

Assertion: BLOCK != QUARANTINE; FAIL\_CLOSED != NONCOMPLIANT\_HOLD; OUTPUT\_BLOCKED != NONCOMPLIANT\_HOLD.

PASS: no flattening.

PTS-BDA-032

Parameterized test

Bounded delegated choices

Input: policy/context envelope.

Assertion: D-02/D-03, D-08, and D-09 choices stay within authorized canonical outcomes.

Disposition: EXTRACT-PARAMETERIZED.

PTS-BDA-033

Cross-reference test

Transition-plus-validator derivation

Input: CPW\_CRITICAL scenario.

Assertion: VAL-07 critical band maps to OUTPUT\_BLOCKED and FAIL\_CLOSED.

PASS: trigger and validator semantics agree.

PTS-BDA-034

Cross-reference evidence test

Evidence-plus-scenario derivation

Input: tool-state approval path.

Assertion: approval\_ref required when tool-state activation proceeds.

PASS: evidence activation follows scenario authority.

PTS-BDA-035

Projection discrimination

Adequate projection granularity

Input: FINALIZATION\_REVIEW + EVIDENCE\_OK vs EVIDENCE\_FAIL.

Assertion: first -> IDLE; second -> NONCOMPLIANT\_HOLD.

PASS: projection exposes distinction.

PTS-BDA-036

Projection limitation

Transparent projection limitation

Input: ALLOW vs ALLOW\_CONSTRAINED at state projection.

Assertion: state route may be identical; verdict semantics remain distinct downstream.

Disposition: EXTRACT-DECLARATIVE.

# 3. Public Fixture Records

| Fixture ID | Scenario linkage | Fixture class | Required fields | Optional bounded fields | Source authority | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| FX-BDA-001 | PTS-BDA-001..004 | Valid workflow transition fixture | current\_state; trigger; validator\_results where applicable | none | PR-WF | Used for normal-path transitions. |
| FX-BDA-002 | PTS-BDA-005 | Invalid schema fixture | artifact\_type; source\_id; policy\_profile\_id; payload\_digest; invalid/missing schema\_id | none | CONTRACT-IN-001 | Expected BLOCK. |
| FX-BDA-003 | PTS-BDA-006..007 | Allowlist/tool-state fixture | tool\_manifest; tool\_ids; claimed\_permissions; payload\_digest; allowlist classification | approval\_ref absent/present by scenario | CONTRACT-IN-002; VAL-02 | Distinguishes block vs quarantine paths. |
| FX-BDA-004 | PTS-BDA-008 | Missing approval fixture | tool-state payload with no valid approval\_ref | none | VAL-06 | Expected quarantine persistence. |
| FX-BDA-005 | PTS-BDA-009..010 | Freshness/receipt failure fixture | accepted anchor; freshness value; receipt/evidence append flag | source-specific anchor if deployed | VAL-04; D-05 | Expected BLOCK. |
| FX-BDA-006 | PTS-BDA-011 | Statement provenance failure fixture | statement\_id; missing tsa\_label or inadmissible source\_class; scope\_id | none | CONTRACT-IN-004; VAL-03 | Expected BLOCK / CONFLICT. |
| FX-BDA-007 | PTS-BDA-013..017, 028, 033 | CPW critical fixture | active state; cpw\_band=CRITICAL | rollback checkpoint if available | VAL-07; D-06; PR-WF | Expected OUTPUT\_BLOCKED + FAIL\_CLOSED. |
| FX-BDA-008 | PTS-BDA-004, 019, 025, 035 | Finalization success fixture | op\_type; state\_hash; policy\_hash; measurement\_ref; evidence\_ok=true; VERIF\_COUNTER > anchor | evidence\_ref; verif\_counter\_anchor | CONTRACT-IN-003; VAL-05/08 | Expected successful return to IDLE. |
| FX-BDA-009 | PTS-BDA-014, 019, 020, 035 | Evidence failure / replay fixture | finalization request with evidence\_ok=false or VERIF\_COUNTER \<= anchor | incident\_report fields | D-07; VAL-05 | Expected NONCOMPLIANT\_HOLD. |
| FX-BDA-010 | PTS-BDA-018..021 | Readmission/restoration fixture | prior blocked/held state; remediation refs; validator restoration proof | approval/evidence anchors where required | Readmission triggers; PR-WF | Expected controlled return to IDLE only. |
| FX-BDA-011 | PTS-BDA-022..027 | Evidence bundle fixture | 13 mandatory evidence fields | 4 conditional fields as activated | PR-ECR | Used for evidence completeness tests. |
| FX-BDA-012 | PTS-BDA-032 | Parameterized routing fixture | policy profile; decision object class; bounded branch selector | CPW numeric profile / approval policy where relevant | D-02/D-03, D-08, D-09 | Branches must stay within canonical outcomes. |

# 4. Public Oracle Records

| Oracle ID | Scenario linkage | Expected normative result | Expected state / output / artifact | Expected evidence fields | Bounded parameter envelope | Forbidden outputs / forbidden semantic collapse |
| --- | --- | --- | --- | --- | --- | --- |
| OR-BDA-001 | PTS-BDA-001 | Valid entry | INGEST\_VALIDATE | ingress request record | none | No direct release from IDLE. |
| OR-BDA-002 | PTS-BDA-002 | Validation pass | FILTER\_REVIEW | validator\_results for VAL-01/02/03 | none | No skip to release. |
| OR-BDA-003 | PTS-BDA-003 | No escalation | READY\_FOR\_RELEASE | release notice prepared; validator update | policy scope allowed | No release if tool-state risk exists. |
| OR-BDA-004 | PTS-BDA-004 | Finalization success | IDLE; release/commit records | evidence bundle; evidence\_ref/counter when finalization claimed | finalization assurance path | No finalization without counter increase. |
| OR-BDA-005 | PTS-BDA-005, 007, 009, 010 | Blocking failures | OUTPUT\_BLOCKED; verdict BLOCK | boundary verdict; failed validator set | none | No quarantine substitution where block required. |
| OR-BDA-006 | PTS-BDA-006, 008 | Quarantine handling | TOOL\_STATE\_QUARANTINED; verdict QUARANTINE | quarantine notice; activation requirements; approval if present | approval policy | No executable/releasable tool state before approval. |
| OR-BDA-007 | PTS-BDA-011 | Statement conflict | BLOCK / CONFLICT | conflict evidence; statement refs; reason code | none | No gate use of unlabeled/inadmissible claim. |
| OR-BDA-008 | PTS-BDA-012, 030 | Verdict fidelity | Seven canonical verdicts only | verdict field carries canonical token | none | No extra verdicts; no collapse of ALLOW and ALLOW\_CONSTRAINED. |
| OR-BDA-009 | PTS-BDA-013, 015, 016, 017, 028, 033 | CPW critical | OUTPUT\_BLOCKED; FAIL\_CLOSED; inhibit release/finalization | incident/fail-closed artifact; optional rollback\_ref | CPW numeric profile may vary; CRITICAL handling fixed | No local progression after CRITICAL. |
| OR-BDA-010 | PTS-BDA-014, 031, 035 | Negative semantic separation | BLOCK path differs from hold path | reason code + validator results distinguish cause | none | No uniform failure collapse. |
| OR-BDA-011 | PTS-BDA-018..021 | Readmission/restoration | READMIT-controlled return to IDLE only | remediation refs; restored anchors/evidence | approval/evidence prerequisites as required | No restored execution authority by state alone. |
| OR-BDA-012 | PTS-BDA-022..027, 034 | Evidence completeness | Reconstructable decision/evidence bundle | all mandatory + activated conditional fields | producers may be validator or bounded non-validator | No orphaned evidence; no hidden optionality. |
| OR-BDA-013 | PTS-BDA-029 | Distributed enforcement | Each validator has bounded enforcement location | validator or authorized producer record | architecture-specific producer identity | No orphaned validator. |
| OR-BDA-014 | PTS-BDA-032 | Delegated branch envelope | Authorized branch stays within canonical outcomes | policy hash / branch rationale | D-02/D-03, D-08, D-09 only | No guessed branch outside package authority. |
| OR-BDA-015 | PTS-BDA-036 | Projection limitation | State-level route may be shared; verdict semantics remain distinct | downstream verdict/evidence artifact must preserve distinction | projection surface may vary | No semantic collapse due to projection convenience. |

# 5. Minimal Run Note

| Field | Public run note |
| --- | --- |
| Projection surface required | A buyer-visible state transition surface equivalent to next\_state(current\_state, trigger, guard\_result), or an implementation surface exposing equivalent state, trigger, validator, verdict, and evidence outcomes. |
| Input types required | Workflow state; trigger/event; validator pass/fail bundle; decision object kind; policy profile/hash; evidence gate result; accepted anchor/counter data; approval reference where required; statement provenance fields. |
| Assertion result types required | Resulting workflow state; canonical verdict; required output artifact; evidence bundle completeness; conditional evidence activation; bounded parameter branch outcome. |
| PASS condition for this extracted suite | All runnable tests pass; all parameterized tests remain within the authorized parameter envelope; all declarative obligations are implemented in bounded architecture locations; all OMIT-INAPPLICABLE entries remain genuinely absent semantic classes; no FAIL or true defect appears. |
| Bounded external obligations not locally runnable | Conflict-evidence emission for VAL-03; authorized non-validator producer grounding; distributed enforcement legitimacy where not exposed by local transition function; bounded policy selection for BLOCK/QUARANTINE, ALLOW/ALLOW\_CONSTRAINED, and QUARANTINE/NONCOMPLIANT\_HOLD; fail-closed artifact emission and optional rollback artifact where implemented outside local state projection. |

| Authorized public output set | Status |
| --- | --- |
| Public Test Suite: PTS-BDA-001 through PTS-BDA-036 | AUTHORIZED |
| Public Fixtures: FX-BDA-001 through FX-BDA-012 | AUTHORIZED |
| Public Oracles: OR-BDA-001 through OR-BDA-015 | AUTHORIZED |
| Minimal Run Note | AUTHORIZED |
