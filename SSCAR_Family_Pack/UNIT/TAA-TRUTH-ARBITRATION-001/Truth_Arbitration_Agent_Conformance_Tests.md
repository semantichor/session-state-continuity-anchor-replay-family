Truth Arbitration Agent — Public Conformance Tests

Buyer-facing, execution-neutral conformance tests, fixtures, oracles, and minimal run note.

This file contains 27 public conformance records: 25 runnable tests, 1 parameterized test, and 1 declarative integration check. The records are grounded in the public specification and preserve the published conformance-count contract.

# 1. Public test records

This section contains 26 non-declarative conformance records: 25 runnable records and 1 parameterized record.

**Test ID / VP-ID**

**Test kind**

**Normative purpose**

**Input surface / execution surface**

**Assertion set / expected PASS**

**Bounded condition (if any)**

**TAA-PT-001**

**VP-GEN-001**

State-machine projection test

A. Normal-path conformance — Transition output / resulting state

Input: INTAKE ; trigger=INTAKE\_TO\_ROLE\_SCREENING

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: ROLE\_SCREENING

PASS: ROLE\_SCREENING

n/a

**TAA-PT-002**

**VP-GEN-002**

State-machine projection test

A. Normal-path conformance — Transition output / resulting state

Input: EVALUATING ; trigger=EVALUATING\_TO\_CLASSIFYING

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: CLASSIFYING

PASS: CLASSIFYING

n/a

**TAA-PT-003**

**VP-GEN-003**

State-machine projection test

A. Normal-path conformance — State / acceptance route

Input: DECIDED ; trigger=DECIDED\_TO\_HANDOFF\_READY

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: HANDOFF\_READY

PASS: HANDOFF\_READY

n/a

**TAA-PT-004**

**VP-GEN-004**

State-machine projection test

B. Single-validator failure semantics — Failure route / protective state

Input: EVALUATING ; trigger=EVALUATING\_TO\_CLASSIFYING

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: FAIL\_CLOSED

PASS: FAIL\_CLOSED

n/a

**TAA-PT-005**

**VP-GEN-005**

Evidence-bundle assertion

B. Single-validator failure semantics — Verdict and route fidelity (state via next\_state; verdict identity in trigger and evidence bundle)

Input: CONFLICT\_CHECKING ; trigger=CONFLICT\_CHECKING\_TO\_ALLOW\_CONSTRAINED\_DECISION

Execution: PrincipalEvidenceBundle field reads

Assertion: DECIDED + ALLOW\_CONSTRAINED evidence

PASS: DECIDED + ALLOW\_CONSTRAINED evidence

n/a

**TAA-PT-006**

**VP-GEN-006**

State-machine projection test

B. Single-validator failure semantics — Verdict, route, governance output

Input: CONFLICT\_CHECKING ; trigger=CONFLICT\_CHECKING\_TO\_ESCALATE\_DECISION

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: DECIDED + ESCALATE + ESCALATION\_REQUEST evidence

PASS: DECIDED + ESCALATE + ESCALATION\_REQUEST evidence

n/a

**TAA-PT-007**

**VP-GEN-007**

State-machine projection test

B. Single-validator failure semantics — Reclassification action / state combination (RECLASSIFY = action, not verdict)

Input: ROLE\_SCREENING ; trigger=ROLE\_SCREENING\_RECLASSIFY\_TO\_CANONICALIZING

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: CANONICALIZING

PASS: CANONICALIZING

n/a

**TAA-PT-008**

**VP-GEN-008**

State-machine projection test

B. Single-validator failure semantics — Comparative verdict/result assertions

Input: CLASSIFYING / EVALUATING ; trigger=CLASSIFYING\_TO\_DENY\_DECISION ↔ EVALUATING\_TO\_FAIL\_CLOSED

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: DECIDED ≠ FAIL\_CLOSED preserved

PASS: DECIDED ≠ FAIL\_CLOSED preserved

n/a

**TAA-PT-009**

**VP-GEN-009**

State-machine projection test

C. Fail-closed and protection routing — Protection state / fail-closed result

Input: INTAKE ; trigger=STRUCTURAL\_INCOMPLETENESS\_TO\_FAIL\_CLOSED

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: FAIL\_CLOSED

PASS: FAIL\_CLOSED

n/a

**TAA-PT-010**

**VP-GEN-010**

State-machine projection test

C. Fail-closed and protection routing — Override behavior from non-initial state

Input: CLASSIFYING ; trigger=POLICY\_SNAPSHOT\_DRIFT\_TO\_FAIL\_CLOSED

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: FAIL\_CLOSED

PASS: FAIL\_CLOSED

n/a

**TAA-PT-011**

**VP-GEN-011**

State-machine projection test

C. Fail-closed and protection routing — Protective default outcome / no silent state preservation

Input: EVALUATING ; trigger=CONFLICT\_CHECKING\_TO\_ALLOW\_DECISION (invalid from EVALUATING)

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: FAIL\_CLOSED

PASS: FAIL\_CLOSED

n/a

**TAA-PT-012**

**VP-GEN-012**

State-machine projection test

D. Recovery, readmission, restoration — Re-entry state chain / result

Input: FAIL\_CLOSED → NONCOMPLIANT\_HOLD ; trigger=FAIL\_CLOSED\_TO\_NONCOMPLIANT\_HOLD ; NONCOMPLIANT\_HOLD\_TO\_READMISSION\_PENDING

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: NONCOMPLIANT\_HOLD then READMISSION\_PENDING

PASS: NONCOMPLIANT\_HOLD then READMISSION\_PENDING

n/a

**TAA-PT-013**

**VP-GEN-013**

State-machine projection test

D. Recovery, readmission, restoration — Boundary-preserving re-entry behavior

Input: READMISSION\_PENDING ; trigger=READMISSION\_PENDING\_TO\_ROLE\_SCREENING

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: ROLE\_SCREENING (no inheritance to ALLOW / HANDOFF\_READY)

PASS: ROLE\_SCREENING (no inheritance to ALLOW / HANDOFF\_READY)

n/a

**TAA-PT-014**

**VP-GEN-014**

State-machine projection test

E. Terminal-role and closure integrity — Terminal integrity assertion

Input: CLOSED ; trigger=Any non-reopen trigger

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: CLOSED preserved

PASS: CLOSED preserved

n/a

**TAA-PT-015**

**VP-GEN-015**

Evidence-bundle assertion

E. Terminal-role and closure integrity — Closure artifact completeness

Input: Evidence bundle / handoff artifact ; PrincipalEvidenceBundle fixture

Execution: PrincipalEvidenceBundle field reads

Assertion: semantic\_closure / evidence\_closure / failure\_closure / policy\_snapshot\_closure populated

PASS: semantic\_closure / evidence\_closure / failure\_closure / policy\_snapshot\_closure populated

n/a

**TAA-PT-016**

**VP-GEN-016**

Evidence-bundle assertion

F. Evidence completeness — Mandatory field presence

Input: Evidence bundle ; PrincipalEvidenceBundle fixture

Execution: PrincipalEvidenceBundle field reads

Assertion: All §8 mandatory fields present

PASS: All §8 mandatory fields present

n/a

**TAA-PT-017**

**VP-GEN-017**

Evidence-bundle assertion

F. Evidence completeness — Conditional evidence completeness

Input: Evidence bundle (ALLOW\_CONSTRAINED path) ; PrincipalEvidenceBundle fixture

Execution: PrincipalEvidenceBundle field reads

Assertion: Conditional conflict fields populated (mode/strength/confidence/coverage/compared\_claim\_set\_ref/residual\_risk\_statement)

PASS: Conditional conflict fields populated (mode/strength/confidence/coverage/compared\_claim\_set\_ref/residual\_risk\_statement)

n/a

**TAA-PT-018**

**VP-GEN-018**

Evidence-bundle assertion

F. Evidence completeness — Producer grounding and field presence

Input: Evidence bundle (FAIL\_CLOSED + escalation path) ; PrincipalEvidenceBundle fixture

Execution: PrincipalEvidenceBundle field reads

Assertion: ESCALATION\_REQUEST fields grounded (request\_id, failure\_ref, required\_actor\_role, required\_evidence, status)

PASS: ESCALATION\_REQUEST fields grounded (request\_id, failure\_ref, required\_actor\_role, required\_evidence, status)

n/a

**TAA-PT-019**

**VP-GEN-019**

State-machine projection test

G. Gate-logic and governance enforcement — Governance output / failure result

Input: DECIDED ; trigger=CLEARANCE\_ARTIFACT\_MISSING\_TO\_FAIL\_CLOSED

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: FAIL\_CLOSED

PASS: FAIL\_CLOSED

n/a

**TAA-PT-021**

**VP-GEN-021**

Evidence-bundle assertion

H. Verdict-semantics preservation — Verdict-set fidelity (no extras, no omissions; RECLASSIFY excluded)

Input: Verdict enum surface ; PrincipalEvidenceBundle fixture

Execution: PrincipalEvidenceBundle field reads

Assertion: Canonical six-verdict set

PASS: Canonical six-verdict set

n/a

**TAA-PT-022**

**VP-GEN-022**

State-machine projection test

H. Verdict-semantics preservation — Routing-action-vs-verdict separation

Input: ROLE\_SCREENING ; trigger=ROLE\_SCREENING\_RECLASSIFY\_TO\_CANONICALIZING ↔ ROLE\_SCREENING\_TO\_OUT\_OF\_SCOPE\_DECISION

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: RECLASSIFY routes to CANONICALIZING; OUT\_OF\_SCOPE decides at DECIDED

PASS: RECLASSIFY routes to CANONICALIZING; OUT\_OF\_SCOPE decides at DECIDED

n/a

**TAA-PT-023**

**VP-GEN-023**

Parameterized state-machine + evidence test

I. Delegated-choice handling — Bounded parameterization assertion

Input: CONFLICT\_CHECKING ; trigger=CONFLICT\_CHECKING\_TO\_DENY\_DECISION ↔ CONFLICT\_CHECKING\_TO\_FAIL\_CLOSED

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: DENY or FAIL\_CLOSED according to severity

PASS: DENY or FAIL\_CLOSED according to severity (per bound parameter envelope)

Bounded delegated parameterization required: severity threshold (§6 DO-005). Forbidden to flatten into single-branch behavior.

**TAA-PT-024**

**VP-GEN-024**

State-machine projection test

J. Cross-reference derivation — Derivation requires Transition Table + Validator Catalogue cross-read

Input: EVALUATING ; trigger=EVALUATING\_TO\_FAIL\_CLOSED

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: FAIL\_CLOSED

PASS: FAIL\_CLOSED

n/a

**TAA-PT-025**

**VP-GEN-025**

Evidence-bundle assertion

J. Cross-reference derivation — Derivation requires Evidence Contract + scenario rule cross-read

Input: Evidence bundle (ALLOW\_CONSTRAINED) ; PrincipalEvidenceBundle fixture

Execution: PrincipalEvidenceBundle field reads

Assertion: Conditional conflict evidence and ALLOW\_CONSTRAINED route

PASS: Conditional conflict evidence and ALLOW\_CONSTRAINED route

n/a

**TAA-PT-026**

**VP-GEN-026**

State-machine projection test

K. Code-projection discrimination — Adequate projection granularity

Input: ROLE\_SCREENING / CONFLICT\_CHECKING ; trigger=Multiple transition triggers

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: Adequate routing projection across major paths

PASS: Adequate routing projection across major paths

n/a

**TAA-PT-027**

**VP-GEN-027**

State-machine projection test

K. Code-projection discrimination — Projection-surface exception logged

Input: CONFLICT\_CHECKING ; trigger=CONFLICT\_CHECKING\_TO\_{ALLOW\|ALLOW\_CONSTRAINED\|DENY\|ESCALATE}\_DECISION

Execution: next\_state(current, trigger, validator\_passed) → WorkflowState

Assertion: All four verdict-producing routes share DECIDED state; verdict identity carried by trigger/evidence (not by state alone)

PASS: All four verdict-producing routes share DECIDED state; verdict identity carried by trigger/evidence (not by state alone)

Runnable test of state collapse + bundle-level verdict identity. Bounded projection exception explicitly recorded in oracle (forbidden output: state-only verdict discrimination).

### Declarative public conformance record

| Record ID / VP-ID | TAA-PT-020-DECL  /  VP-GEN-020 |
| --- | --- |
| **Record kind** | Declarative conformance claim (not a buyer-runnable unit test) |
| **Normative purpose** | Distributed-enforcement legitimacy: V-008 ordering / serialization is real distributed enforcement, anchored in §11 Temporal/Ordering Contract and §9 Gate Logic, and not an orphaned validator. |
| **Buyer obligation** | Implement ordering enforcement at the runtime layer via explicit serialization or snapshot-at-intake + compare-and-commit (AMB-011). Override surface in next\_state may be smoke-tested but is not the substantive public conformance obligation. |
| **Authoritative sources** | TAA §5, §9, §11, §12; AMB-011 |
| **Expected PASS condition** | Implementation runtime preserves ordering invariant under concurrent intake; ordering-violation detection routes through the override mechanism to FAIL\_CLOSED; smoke-test of next\_state(CLASSIFYING, ORDERING\_VIOLATION\_TO\_FAIL\_CLOSED, true) → FAIL\_CLOSED is permitted but not sufficient. |
| **Forbidden** | Treating V-008 as orphaned because enforcement is non-transition-form; bypassing serialization at the runtime layer. |

# 2. Public fixture records

Fixture count: 4.

### TAA-FX-BASE-EVIDENCE

**Scenario linkage**

VP-GEN-003, 015, 016, 021, 026 (and any test that consumes a normal-path bundle)

**Fixture class**

Mandatory-evidence baseline bundle (PASS path)

**Required fields**

decision\_id, statement\_id\_list, verdict=ALLOW, reason\_code, tsa\_label, source\_class=TRAINED, source\_ref, boundary\_validated\_role=mechanism\_level, role\_validation\_result, policy\_snapshot\_id, policy\_hash\_ref, scope\_id, turn\_id, order\_ref, logical\_timestamp

validator\_refs (V-001…V-008), gate\_impact, evidence\_ref\_list

semantic\_closure, evidence\_closure, failure\_closure, policy\_snapshot\_closure (all 'closed')

**Optional bounded fields**

canonical\_text, statement\_id (if MRF-STATEMENT included)

**Source authority**

TAA §4.2 Output Contract; §8 Evidence Contract; §10 MRF Catalogue

**Notes**

Baseline ALLOW-path bundle; concrete string values are execution-neutral placeholders. Buyer substitutes deployment-specific values without changing semantic obligations.

### TAA-FX-ALLOW-CONSTRAINED-EVIDENCE

**Scenario linkage**

VP-GEN-005, 017, 025

**Fixture class**

Conditional-evidence bundle (ALLOW\_CONSTRAINED activation)

**Required fields**

All baseline mandatory fields with verdict=ALLOW\_CONSTRAINED, reason\_code='DO-006\_HEURISTIC\_CONFLICT\_UNCLOSED', validator\_refs=\[V-006B\]

conflict\_check\_mode, conflict\_check\_strength, conflict\_check\_confidence, conflict\_check\_coverage\_scope, compared\_claim\_set\_ref, residual\_risk\_statement

gate\_impact='conditional\_progress\_only'

**Optional bounded fields**

confidence-scale concrete vocabulary (policy-profile bounded)

**Source authority**

TAA §8 Evidence Contract; §9 Gate Logic; AMB-007

**Notes**

Forbidden: simple ALLOW below threshold (§9 / AMB-007). Conflict qualifiers are mandatory when verdict=ALLOW\_CONSTRAINED via V-006B.

### TAA-FX-FAIL-CLOSED-ESCALATION-EVIDENCE

**Scenario linkage**

VP-GEN-018, 019

**Fixture class**

FAIL\_CLOSED with external-clearance bundle

**Required fields**

verdict=FAIL\_CLOSED, reason\_code=UNLABELED\_CLAIM (or equivalent root\_reason\_code)

inhibit\_flags, root\_reason\_code, clearance\_needed='true', cleared\_only\_by, remediation\_class

escalation\_request\_ref, request\_id, failure\_ref, required\_actor\_role, required\_evidence, status

gate\_impact='local\_progress\_blocked'

**Optional bounded fields**

concrete actor identity (bounded handoff specialization)

**Source authority**

TAA §10 MRF-FAIL\_CLOSED, MRF-ESCALATION\_REQUEST; §12 Failure Semantics; §9 Gate Logic

**Notes**

Authorized non-validator producer (MRF Catalogue) is the emission point for ESCALATION\_REQUEST; failure-class enforcement is routed via override.

### TAA-FX-CLEARANCE-RESPONSE

**Scenario linkage**

VP-GEN-012, 013 (recovery/readmission)

**Fixture class**

Clearance-response bundle for re-entry

**Required fields**

All FAIL\_CLOSED / NONCOMPLIANT\_HOLD bundle fields

clearance\_response\_ref, request\_id, actor\_id, actor\_role, evidence\_refs, clearance\_verdict, clearance\_epoch

**Optional bounded fields**

clearance\_epoch concrete value (deployment-policy bounded)

**Source authority**

TAA §10 MRF-CLEARANCE\_RESPONSE; §12.1 clearance criteria

**Notes**

Re-entry MUST NOT inherit ALLOW; clearance\_verdict='root\_cause\_closed' is the bounded permitting condition.

# 3. Public oracle records

One oracle per scenario family. Forbidden-output column protects against semantic collapse on the public surface.

**Oracle ID**

**Scenario linkage**

**Expected result**

**Expected state / output**

**Expected evidence / bounded envelope**

**Forbidden outputs / forbidden semantic collapse**

**TAA-OR-A-NORMAL**

VP-GEN-001, 002, 003

Normal-path workflow advance

INTAKE→ROLE\_SCREENING; EVALUATING→CLASSIFYING; DECIDED→HANDOFF\_READY

Baseline mandatory bundle plus four-closure (MRF-HANDOFF-CHECK) at HANDOFF\_READY

Bounded envelope: n/a

FAIL\_CLOSED on a fully-passing path; HANDOFF\_READY without four-closure complete.

**TAA-OR-B-FAILURE-SEPARATION**

VP-GEN-004, 005, 006, 007, 008

Per-validator distinct outcomes preserved

FAIL\_CLOSED ≠ DECIDED+DENY ≠ DECIDED+ALLOW\_CONSTRAINED ≠ DECIDED+ESCALATE ≠ CANONICALIZING (RECLASSIFY action)

Per-path bundle with verdict in trigger and evidence; ESCALATION\_REQUEST evidence on ESCALATE

Bounded envelope: Authorized external actor identity is bounded handoff specialization.

Collapse of distinct failure outcomes into a uniform result; verdict identity reduced to state alone.

**TAA-OR-C-PROTECTION**

VP-GEN-009, 010, 011

Critical blocking forces FAIL\_CLOSED from any current state; no silent state preservation

FAIL\_CLOSED

FAIL\_CLOSED bundle with inhibit\_flags, root\_reason\_code, gate\_impact='local\_progress\_blocked'

Bounded envelope: n/a

Silent preservation of current state for unspecified critical combinations; ALLOW emitted under structural-incompleteness.

**TAA-OR-D-RECOVERY**

VP-GEN-012, 013

Bounded recovery; non-inheriting re-entry

FAIL\_CLOSED → NONCOMPLIANT\_HOLD → READMISSION\_PENDING → ROLE\_SCREENING

Clearance-response bundle (TAA-FX-CLEARANCE-RESPONSE)

Bounded envelope: readmission\_budget value bounded by deployment policy.

Re-entry directly to DECIDED or HANDOFF\_READY; ALLOW inherited across readmission.

**TAA-OR-E-TERMINAL**

VP-GEN-014, 015

Terminal CLOSED preserved; closure artifact complete

CLOSED absorbs any non-reopen trigger; HANDOFF\_READY requires four-closure

semantic\_closure / evidence\_closure / failure\_closure / policy\_snapshot\_closure all 'closed' for HANDOFF\_READY

Bounded envelope: Concrete closure-string values are field-level specialization.

Reopen of CLOSED without explicit reopen authority; HANDOFF\_READY emitted with missing closure field.

**TAA-OR-F-EVIDENCE**

VP-GEN-016, 017, 018

Mandatory and conditional evidence fields populated; authorized non-validator producers preserved

n/a (bundle assertion)

All §8 minimum fields; conditional conflict fields when verdict=ALLOW\_CONSTRAINED via V-006B; ESCALATION\_REQUEST fields for FAIL\_CLOSED + external clearance

Bounded envelope: Concrete reason\_code names, actor identities, status vocabulary are bounded specialization.

Bundle missing any mandatory field; conditional evidence absent under attested activation; non-validator producer treated as orphaned.

**TAA-OR-G-GOVERNANCE**

VP-GEN-019 (runnable), VP-GEN-020 (declarative)

Distributed enforcement is real enforcement, not orphaned validator

Override forces FAIL\_CLOSED from any current state (V-009 missing artifact; V-008 ordering violation)

FAIL\_CLOSED bundle with appropriate root\_reason\_code

Bounded envelope: Serialization vs compare-and-commit (§11) is execution-neutral implementation choice.

Treating V-008 / V-009 as orphaned because they enforce outside transition guards; bypassing override mechanism.

**TAA-OR-H-VERDICT-FIDELITY**

VP-GEN-021, 022

Canonical six verdicts only; routing actions and verdicts taxonomically separated

Verdict ∈ {ALLOW, ALLOW\_CONSTRAINED, DENY, FAIL\_CLOSED, ESCALATE, OUT\_OF\_SCOPE}; RECLASSIFY routes to CANONICALIZING (action), OUT\_OF\_SCOPE decides at DECIDED (verdict)

n/a (taxonomy assertion)

Bounded envelope: n/a

Adding non-canonical verdicts (e.g., RECLASSIFY, NONCOMPLIANT\_HOLD, PERMANENT\_BLOCK) to the verdict set; flattening RECLASSIFY into a verdict.

**TAA-OR-I-DELEGATED**

VP-GEN-023

Bounded delegated branch (V-006A severity threshold) preserved with explicit parameterization

DENY or FAIL\_CLOSED according to bound severity threshold parameter

Per-branch bundle with conflict-check qualifiers

Bounded envelope: severity\_threshold ∈ buyer-policy domain (§6 DO-005 'according to severity'); explicit binding required at run time.

Flattening into a single-branch outcome; running without binding the parameter; treating policy choice as unbounded openness.

**TAA-OR-J-DERIVATION**

VP-GEN-024, 025

Correct test derivation requires multi-source cross-read

FAIL\_CLOSED (V-024); ALLOW\_CONSTRAINED with conditional evidence (V-025)

Cross-derived bundle

Bounded envelope: Confidence-scale concrete vocabulary policy-bounded.

Deriving the test from a single source (Transition Table only or Validator Catalogue only); evidence assertion without scenario-rule cross-read.

**TAA-OR-K-PROJECTION**

VP-GEN-026 (adequate), VP-GEN-027 (bounded exception)

Adequate routing projection where direct; bounded projection exception where verdict-producing routes share DECIDED state

Multi-trigger transitions assertable directly; CONFLICT\_CHECKING\_TO\_{ALLOW\|ALLOW\_CONSTRAINED\|DENY\|ESCALATE}\_DECISION all → DECIDED

Verdict identity carried in trigger and evidence bundle, not state alone

Bounded envelope: Projection-surface exception logged: state-only output cannot distinguish ALLOW / DENY / ESCALATE in CONFLICT\_CHECKING; trigger identity carries verdict branch.

Treating shared DECIDED state as semantic collapse; demanding distinct WorkflowState variants per verdict.

# 4. Minimal run note

| Projection surface required | next\_state(current: WorkflowState, trigger: TransitionTrigger, validator\_passed: bool) → WorkflowState; PrincipalEvidenceBundle struct. |
| --- | --- |
| **Input types required** | WorkflowState (12 variants); TransitionTrigger (29 variants including 5 cross-state blocking triggers); validator\_passed: bool; PrincipalEvidenceBundle (mandatory + path-conditional fields per §8). |
| **Assertion result types required** | WorkflowState equality; PrincipalEvidenceBundle field presence and value equality; canonical-verdict-set membership; comparative non-equality across paths. |
| **PASS condition for this extracted suite** | All 25 runnable tests assert their expected normative result against the package's projection surface; the 1 parameterized test (VP-GEN-023 / TAA-PT-023) asserts both branches when the severity threshold parameter is bound; the 1 declarative record (VP-GEN-020 / TAA-PT-020-DECL) is preserved as a buyer obligation rather than a runnable assertion. |
| **Bounded external obligations not locally runnable** | TAA-PT-020-DECL: ordering enforcement is distributed across §11 Temporal/Ordering Contract and §9 Gate Logic; buyer must satisfy this through serialization or snapshot-at-intake + compare-and-commit (AMB-011) at the runtime layer. \| ESCALATION\_REQUEST emission via §10 MRF Catalogue: override-detection is runnable; actual artifact emission lives at the Output Contract / MRF layer (authorized non-validator producer). \| V-007 restart under the new snapshot (§11): bounded handoff at the orchestration layer; not narrowed by this public conformance suite to a specific implementation cycle. |
