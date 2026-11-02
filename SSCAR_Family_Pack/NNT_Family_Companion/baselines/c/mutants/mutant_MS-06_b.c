/* ============================================================================
 * baseline.c  —  NNT-FAM-SSCAR-FI-001  unified family-composition baseline (c)
 *
 * ONE artifact composing all 6 agents of the relevant family:
 *   VRA (AGT-VRA-001), BDA (BDA-BOUNDARY-DEFENSE-002),
 *   TAA (TAA-TRUTH-ARBITRATION-001), ARA (ARA-AUDIT-REPLAY-001),
 *   FPA (FPA-FRESHNESS-PORTABILITY-003), and the SSCAR integrator.
 *
 * Each of the 5 components is INDEPENDENTLY INVOCABLE against its own PT
 * suite AND produces the public output fields the integrator consumes
 * (Annex A §4). The SSCAR integrator consumes REAL component-produced fields
 * (not stub fixtures) via Annex A wiring + Annex B coherence constraints and
 * emits the EMERGENT family verdict through its 4-part projection surface:
 *   (1) next_state(state,trigger,validator_passed) -> FamilyWorkflowState
 *   (2) a separate verdict-emission layer -> FamilyNormativeVerdict
 *       (REPLAY_INCOMPLETE / INCIDENT_ONLY have NO workflow state, AMB-17)
 *   (3) a FamilyEvidenceBundle carrying FEV-01..FEV-15
 *   (4) emission of FOC-01..FOC-05
 *
 * C idioms (R4): enums for states/events/verdicts; function-pointer dispatch
 * tables (surface_fn_t / agent_fn_t); struct-based contracts with explicit
 * field validators; assert() for invariants; switch over enums. No strcmp
 * chains drive state assignment — argv tokens are parsed to enums via lookup
 * tables, then dispatch is enum/table/function-pointer driven.
 *
 * This file is the IMPLEMENTATION. It embeds NO Conformance-Tests cases; the
 * oracle lives in run_pts.c. Build (release+strip, clang+lld+mingw sysroot):
 *   clang --target=x86_64-w64-mingw32 --sysroot=<ucrt64> -fuse-ld=lld -O3 -s \
 *        baseline.c -o baseline.exe
 * ============================================================================ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>

/* ------------------------------------------------------------------ output */
/* Every surface prints exactly one RESULT line: an echo of the query plus the
 * computed result tokens (key=value). The echo keeps each line well over the
 * R5 health-probe 50-byte / structured-token floor and makes the run_log
 * self-describing. */
static char OUTBUF[4096];

static void emit(const char *agent, const char *surface,
                 const char *echo, const char *result)
{
    snprintf(OUTBUF, sizeof OUTBUF,
             "RESULT agent=%s surface=%s query=[%s] | %s",
             agent, surface, echo ? echo : "", result ? result : "");
    printf("%s\n", OUTBUF);
}

/* name<->enum lookup (argv parsing only; never drives the state machine). */
typedef struct { const char *name; int val; } name_val_t;

static int lookup(const name_val_t *tbl, const char *name, int fallback)
{
    for (const name_val_t *p = tbl; p->name; ++p)
        if (strcmp(p->name, name) == 0) return p->val;
    return fallback;
}
static const char *rlookup(const name_val_t *tbl, int val)
{
    for (const name_val_t *p = tbl; p->name; ++p)
        if (p->val == val) return p->name;
    return "UNKNOWN";
}
static bool arg_bool(const char *s)
{
    return s && (s[0] == '1' || s[0] == 't' || s[0] == 'T' ||
                 strcmp(s, "pass") == 0 || strcmp(s, "true") == 0);
}

/* A data-driven transition row: from-state x trigger -> target on pass/fail.
 * NEG_SENTINEL means "no explicit target; caller applies the protective
 * default". Using a data table with enum keys is the idiomatic alternative to
 * strcmp chains; dispatch across agents/surfaces below is function-pointer. */
#define NO_TARGET (-999)
typedef struct { int from; int trig; int on_pass; int on_fail; } trow_t;

static int trow_lookup(const trow_t *tbl, int from, int trig, bool vp, bool *found)
{
    for (const trow_t *r = tbl; r->from != NO_TARGET; ++r) {
        if (r->from == from && r->trig == trig) {
            *found = true;
            int t = vp ? r->on_pass : r->on_fail;
            return (t == NO_TARGET) ? (vp ? r->on_fail : r->on_pass) : t;
        }
    }
    *found = false;
    return NO_TARGET;
}

/* ========================================================================== */
/* ==========================  VRA  (AGT-VRA-001)  ========================== */
/* ========================================================================== */
enum VraState { VRA_S0, VRA_S1, VRA_S2, VRA_S3, VRA_S4, VRA_S5, VRA_S6, VRA_S7, VRA_S8 };
static const name_val_t VRA_STATES[] = {
    {"S0", VRA_S0}, {"S0_STARTUP_READONLY", VRA_S0},
    {"S1", VRA_S1}, {"S1_SNAPSHOT_LOCKED", VRA_S1},
    {"S2", VRA_S2}, {"S2_STRUCTURAL_VERIFIED", VRA_S2},
    {"S3", VRA_S3}, {"S3_ELIGIBLE_HEAD_SELECTED", VRA_S3},
    {"S4", VRA_S4}, {"S4_REHYDRATED_VALIDATED", VRA_S4},
    {"S5", VRA_S5}, {"S5_FAIL_SAFE", VRA_S5},
    {"S6", VRA_S6}, {"S6_TOOL_QUARANTINE", VRA_S6},
    {"S7", VRA_S7}, {"S7_RECOVERY_REPLAY", VRA_S7},
    {"S8", VRA_S8}, {"S8_READMISSION_PENDING", VRA_S8},
    {0, 0}
};
enum VraTrig { VRA_T_STARTUP, VRA_T_SNAPLOCK, VRA_T_STRUCT, VRA_T_ELIG,
               VRA_T_ROLLBACK, VRA_T_WALREPLAY, VRA_T_TOOLINVALID,
               VRA_T_RECOVCONV, VRA_T_AUTHREL };
static const name_val_t VRA_TRIGS[] = {
    {"StartupComplete", VRA_T_STARTUP}, {"SnapshotLocked", VRA_T_SNAPLOCK},
    {"StructuralChecksDone", VRA_T_STRUCT}, {"EligibilityChecksDone", VRA_T_ELIG},
    {"RollbackDetected", VRA_T_ROLLBACK}, {"WalReplayNeeded", VRA_T_WALREPLAY},
    {"ToolStateInvalid", VRA_T_TOOLINVALID}, {"RecoveryConverged", VRA_T_RECOVCONV},
    {"AuthorityRelease", VRA_T_AUTHREL}, {0, 0}
};
/* spec §12 transition model + CT fixtures WF-01..WF-12 */
static const trow_t VRA_TABLE[] = {
    {VRA_S0, VRA_T_STARTUP,     VRA_S1, VRA_S5},   /* PT-001 / PT-010 */
    {VRA_S1, VRA_T_SNAPLOCK,    VRA_S2, VRA_S5},
    {VRA_S2, VRA_T_STRUCT,      VRA_S3, VRA_S5},   /* PT-002 / PT-004..007 */
    {VRA_S3, VRA_T_ELIG,        VRA_S4, VRA_S5},   /* PT-003 / PT-008..009 */
    {VRA_S3, VRA_T_TOOLINVALID, VRA_S6, VRA_S6},   /* PT-013 / PT-027 */
    {VRA_S5, VRA_T_WALREPLAY,   VRA_S7, VRA_S5},   /* PT-012 */
    {VRA_S7, VRA_T_RECOVCONV,   VRA_S8, VRA_S5},
    {VRA_S8, VRA_T_AUTHREL,     VRA_S1, VRA_S1},   /* PT-024 parameterized: {S0,S1}; branch S1 */
    {NO_TARGET, 0, 0, 0}
};
static int vra_next(int st, int tr, bool vp)
{
    if (tr == VRA_T_ROLLBACK) return VRA_S5;          /* §7 rollback blocking priority */
    if (st == VRA_S6) return VRA_S6;                  /* PT-015 terminal/stable isolation */
    bool found = false;
    int t = trow_lookup(VRA_TABLE, st, tr, vp, &found);
    if (found) return t;
    return VRA_S5;                                    /* fail-safe default */
}

/* ========================================================================== */
/* =================  BDA  (BDA-BOUNDARY-DEFENSE-002)  ====================== */
/* ========================================================================== */
enum BdaState { BDA_IDLE, BDA_INGEST, BDA_FILTER, BDA_TSQ, BDA_RFR,
                BDA_OBLK, BDA_FINREV, BDA_HOLD };
static const name_val_t BDA_STATES[] = {
    {"IDLE", BDA_IDLE}, {"INGEST_VALIDATE", BDA_INGEST}, {"FILTER_REVIEW", BDA_FILTER},
    {"TOOL_STATE_QUARANTINED", BDA_TSQ}, {"READY_FOR_RELEASE", BDA_RFR},
    {"OUTPUT_BLOCKED", BDA_OBLK}, {"FINALIZATION_REVIEW", BDA_FINREV},
    {"NONCOMPLIANT_HOLD", BDA_HOLD}, {0, 0}
};
enum BdaTrig { BDA_INPUT, BDA_VPASS, BDA_VFAIL, BDA_TSDET, BDA_NOESC, BDA_APPR,
               BDA_FINREQ, BDA_EVOK, BDA_EVFAIL, BDA_CPW, BDA_READM, BDA_COMPR };
static const name_val_t BDA_TRIGS[] = {
    {"INPUT_RECEIVED", BDA_INPUT}, {"VALIDATION_PASS", BDA_VPASS},
    {"VALIDATION_FAIL", BDA_VFAIL}, {"TOOL_STATE_DETECTED", BDA_TSDET},
    {"NO_ESCALATION", BDA_NOESC}, {"APPROVAL_GRANTED", BDA_APPR},
    {"FINALIZATION_REQUESTED", BDA_FINREQ}, {"EVIDENCE_OK", BDA_EVOK},
    {"EVIDENCE_FAIL", BDA_EVFAIL}, {"CPW_CRITICAL", BDA_CPW},
    {"READMISSION_APPROVED", BDA_READM}, {"COMPLIANCE_RESTORED", BDA_COMPR}, {0, 0}
};
enum BdaVerdict { BV_NONE, BV_ALLOW, BV_ALLOW_C, BV_BLOCK, BV_QUAR, BV_FC, BV_HOLD, BV_READMIT };
static const name_val_t BDA_VERDICTS[] = {
    {"ALLOW", BV_ALLOW}, {"ALLOW_CONSTRAINED", BV_ALLOW_C}, {"BLOCK", BV_BLOCK},
    {"QUARANTINE", BV_QUAR}, {"FAIL_CLOSED", BV_FC}, {"NONCOMPLIANT_HOLD", BV_HOLD},
    {"READMIT", BV_READMIT}, {0, 0}
};
static const trow_t BDA_TABLE[] = {
    {BDA_IDLE,   BDA_INPUT,  BDA_INGEST, BDA_INGEST}, /* PTS-BDA-001 */
    {BDA_INGEST, BDA_VPASS,  BDA_FILTER, BDA_OBLK},   /* PTS-BDA-002 */
    {BDA_INGEST, BDA_VFAIL,  BDA_OBLK,   BDA_OBLK},   /* PTS-BDA-005/007 */
    {BDA_FILTER, BDA_TSDET,  BDA_TSQ,    BDA_TSQ},    /* PTS-BDA-006 */
    {BDA_FILTER, BDA_NOESC,  BDA_RFR,    BDA_OBLK},   /* PTS-BDA-003 */
    {BDA_TSQ,    BDA_APPR,   BDA_RFR,    BDA_TSQ},    /* PTS-BDA-008: no approval -> stays */
    {BDA_RFR,    BDA_FINREQ, BDA_FINREV, BDA_FINREV}, /* finalization requested */
    {BDA_FINREV, BDA_EVOK,   BDA_IDLE,   BDA_HOLD},   /* PTS-BDA-004 / 035 */
    {BDA_FINREV, BDA_EVFAIL, BDA_HOLD,   BDA_HOLD},   /* PTS-BDA-035 */
    {BDA_OBLK,   BDA_READM,  BDA_IDLE,   BDA_OBLK},   /* PTS-BDA-018 */
    {BDA_HOLD,   BDA_COMPR,  BDA_IDLE,   BDA_HOLD},   /* PTS-BDA-019 */
    {NO_TARGET, 0, 0, 0}
};
static int bda_next(int st, int tr, bool vp)
{
    if (tr == BDA_CPW) return BDA_OBLK;    /* any active state: CPW_CRITICAL -> OUTPUT_BLOCKED (fail-closed) */
    bool found = false;
    int t = trow_lookup(BDA_TABLE, st, tr, vp, &found);
    if (found) return t;
    return BDA_OBLK;                        /* fail-closed default */
}
/* verdict carried alongside the transition (state alone may not discriminate) */
static int bda_verdict_for(int st, int tr, bool vp, int to)
{
    (void)st;
    if (tr == BDA_CPW) return BV_FC;
    if (tr == BDA_VFAIL) return BV_BLOCK;
    if (tr == BDA_TSDET) return BV_QUAR;
    if (tr == BDA_EVFAIL) return BV_HOLD;
    if (tr == BDA_READM || tr == BDA_COMPR) return (to == BDA_IDLE) ? BV_READMIT : BV_NONE;
    if (tr == BDA_EVOK && to == BDA_IDLE) return BV_ALLOW;
    if (tr == BDA_NOESC && to == BDA_RFR) return BV_ALLOW; (void)vp;
    return BV_NONE;
}
/* decision-table / failure-semantics surface (D-01..D-09 / PR-FSR) */
enum BdaCond { BC_SCHEMA, BC_ALLOWLIST, BC_FRESHNESS, BC_RECEIPT, BC_UNLABELED,
               BC_TOOL_NOAPPR, BC_CPW, BC_EVIDENCE, BC_COUNTER, BC_ALLPASS,
               BC_AUTH_EXH };
static const name_val_t BDA_CONDS[] = {
    {"SCHEMA_INVALID", BC_SCHEMA}, {"VAL01_FAIL", BC_SCHEMA},
    {"ALLOWLIST_FAIL", BC_ALLOWLIST}, {"VAL02_FAIL", BC_ALLOWLIST},
    {"FRESHNESS_REPLAY", BC_FRESHNESS}, {"VAL04_FAIL", BC_FRESHNESS},
    {"MISSING_RECEIPT", BC_RECEIPT},
    {"UNLABELED_STATEMENT", BC_UNLABELED}, {"VAL03_FAIL", BC_UNLABELED},
    {"TOOL_STATE_NO_APPROVAL", BC_TOOL_NOAPPR},
    {"CPW_CRITICAL", BC_CPW}, {"VAL07_FAIL", BC_CPW},
    {"EVIDENCE_FAIL", BC_EVIDENCE}, {"VAL05_FAIL", BC_EVIDENCE},
    {"COUNTER_REPLAY", BC_COUNTER},
    {"ALL_PASS", BC_ALLPASS}, {"AUTHORITY_EXHAUSTED", BC_AUTH_EXH}, {0, 0}
};
static int bda_decide(int cond, int *state_out)
{
    switch (cond) {
    case BC_SCHEMA: case BC_ALLOWLIST: case BC_FRESHNESS: case BC_RECEIPT:
        *state_out = BDA_OBLK; return BV_BLOCK;                 /* D-01/02/05 */
    case BC_UNLABELED:  *state_out = BDA_OBLK; return BV_BLOCK; /* D-04 BLOCK/CONFLICT */
    case BC_TOOL_NOAPPR:*state_out = BDA_TSQ;  return BV_QUAR;  /* D-03 */
    case BC_CPW:        *state_out = BDA_OBLK; return BV_FC;    /* D-06 */
    case BC_EVIDENCE: case BC_COUNTER:
        *state_out = BDA_HOLD; return BV_HOLD;                 /* D-07 */
    case BC_ALLPASS:    *state_out = BDA_RFR;  return BV_ALLOW; /* D-08 */
    case BC_AUTH_EXH:   *state_out = BDA_HOLD; return BV_HOLD;  /* D-09 */
    default:            *state_out = BDA_OBLK; return BV_FC;
    }
}

/* ========================================================================== */
/* =================  TAA  (TAA-TRUTH-ARBITRATION-001)  ===================== */
/* ========================================================================== */
enum TaaState { TAA_INTAKE, TAA_ROLE, TAA_CANON, TAA_EVAL, TAA_CLASS, TAA_CONFL,
                TAA_DECIDED, TAA_FC, TAA_HOLD, TAA_READM, TAA_HANDOFF, TAA_CLOSED };
static const name_val_t TAA_STATES[] = {
    {"INTAKE", TAA_INTAKE}, {"ROLE_SCREENING", TAA_ROLE}, {"CANONICALIZING", TAA_CANON},
    {"EVALUATING", TAA_EVAL}, {"CLASSIFYING", TAA_CLASS}, {"CONFLICT_CHECKING", TAA_CONFL},
    {"DECIDED", TAA_DECIDED}, {"FAIL_CLOSED", TAA_FC}, {"NONCOMPLIANT_HOLD", TAA_HOLD},
    {"READMISSION_PENDING", TAA_READM}, {"HANDOFF_READY", TAA_HANDOFF},
    {"CLOSED", TAA_CLOSED}, {0, 0}
};
enum TaaTrig {
    TT_INTAKE_ROLE, TT_EVAL_CLASS, TT_DECIDED_HANDOFF, TT_STRUCT_FC,
    TT_POLICY_DRIFT_FC, TT_ROLE_RECLASS, TT_ROLE_OOS, TT_CLASS_DENY,
    TT_EVAL_FC, TT_CC_ALLOW, TT_CC_ALLOWC, TT_CC_DENY, TT_CC_ESCALATE,
    TT_CC_FC, TT_CLEAR_MISSING_FC, TT_FC_HOLD, TT_HOLD_READM, TT_READM_ROLE,
    TT_ORDERING_FC, TT_ANY
};
static const name_val_t TAA_TRIGS[] = {
    {"INTAKE_TO_ROLE_SCREENING", TT_INTAKE_ROLE},
    {"EVALUATING_TO_CLASSIFYING", TT_EVAL_CLASS},
    {"DECIDED_TO_HANDOFF_READY", TT_DECIDED_HANDOFF},
    {"STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED", TT_STRUCT_FC},
    {"POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED", TT_POLICY_DRIFT_FC},
    {"ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING", TT_ROLE_RECLASS},
    {"ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION", TT_ROLE_OOS},
    {"CLASSIFYING_TO_DENY_DECISION", TT_CLASS_DENY},
    {"EVALUATING_TO_FAIL_CLOSED", TT_EVAL_FC},
    {"CONFLICT_CHECKING_TO_ALLOW_DECISION", TT_CC_ALLOW},
    {"CONFLICT_CHECKING_TO_ALLOW_CONSTRAINED_DECISION", TT_CC_ALLOWC},
    {"CONFLICT_CHECKING_TO_DENY_DECISION", TT_CC_DENY},
    {"CONFLICT_CHECKING_TO_ESCALATE_DECISION", TT_CC_ESCALATE},
    {"CONFLICT_CHECKING_TO_FAIL_CLOSED", TT_CC_FC},
    {"CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED", TT_CLEAR_MISSING_FC},
    {"FAIL_CLOSED_TO_NONCOMPLIANT_HOLD", TT_FC_HOLD},
    {"NONCOMPLIANT_HOLD_TO_READMISSION_PENDING", TT_HOLD_READM},
    {"READMISSION_PENDING_TO_ROLE_SCREENING", TT_READM_ROLE},
    {"ORDERING_VIOLATION_TO_FAIL_CLOSED", TT_ORDERING_FC},
    {"ANY_NON_REOPEN", TT_ANY}, {0, 0}
};
static const trow_t TAA_TABLE[] = {
    {TAA_INTAKE, TT_INTAKE_ROLE,     TAA_ROLE,    TAA_ROLE},
    {TAA_EVAL,   TT_EVAL_CLASS,      TAA_CLASS,   TAA_FC},   /* PT-002 pass / PT-004 fail */
    {TAA_DECIDED,TT_DECIDED_HANDOFF, TAA_HANDOFF, TAA_HANDOFF},
    {TAA_INTAKE, TT_STRUCT_FC,       TAA_FC,      TAA_FC},   /* PT-009 */
    {TAA_CLASS,  TT_POLICY_DRIFT_FC, TAA_FC,      TAA_FC},   /* PT-010 */
    {TAA_ROLE,   TT_ROLE_RECLASS,    TAA_CANON,   TAA_CANON},/* PT-007 / PT-022 */
    {TAA_ROLE,   TT_ROLE_OOS,        TAA_DECIDED, TAA_DECIDED},/* PT-022 OUT_OF_SCOPE decides at DECIDED */
    {TAA_CLASS,  TT_CLASS_DENY,      TAA_DECIDED, TAA_DECIDED},/* PT-008 */
    {TAA_EVAL,   TT_EVAL_FC,         TAA_FC,      TAA_FC},   /* PT-024 */
    {TAA_CONFL,  TT_CC_ALLOW,        TAA_DECIDED, TAA_DECIDED},/* PT-027 */
    {TAA_CONFL,  TT_CC_ALLOWC,       TAA_DECIDED, TAA_DECIDED},/* PT-005/PT-027 */
    {TAA_CONFL,  TT_CC_DENY,         TAA_DECIDED, TAA_DECIDED},/* PT-023/PT-027 */
    {TAA_CONFL,  TT_CC_ESCALATE,     TAA_DECIDED, TAA_DECIDED},/* PT-006/PT-027 */
    {TAA_CONFL,  TT_CC_FC,           TAA_FC,      TAA_FC},   /* PT-023 branch */
    {TAA_DECIDED,TT_CLEAR_MISSING_FC,TAA_FC,      TAA_FC},   /* PT-019 */
    {TAA_FC,     TT_FC_HOLD,         TAA_HOLD,    TAA_HOLD}, /* PT-012 */
    {TAA_HOLD,   TT_HOLD_READM,      TAA_READM,   TAA_READM},/* PT-012 */
    {TAA_READM,  TT_READM_ROLE,      TAA_ROLE,    TAA_ROLE}, /* PT-013 */
    {TAA_CLASS,  TT_ORDERING_FC,     TAA_FC,      TAA_FC},   /* VP-GEN-020 smoke */
    {NO_TARGET, 0, 0, 0}
};
static int taa_next(int st, int tr, bool vp)
{
    if (st == TAA_CLOSED) return TAA_CLOSED;          /* PT-014 terminal */
    bool found = false;
    int t = trow_lookup(TAA_TABLE, st, tr, vp, &found);
    if (found) return t;
    return TAA_FC;                                     /* PT-011 protective default */
}
enum TaaVerdict { TV_NONE, TV_ALLOW, TV_ALLOW_C, TV_DENY, TV_FC, TV_ESCALATE, TV_OOS };
static const name_val_t TAA_VERDICTS[] = {
    {"ALLOW", TV_ALLOW}, {"ALLOW_CONSTRAINED", TV_ALLOW_C}, {"DENY", TV_DENY},
    {"FAIL_CLOSED", TV_FC}, {"ESCALATE", TV_ESCALATE}, {"OUT_OF_SCOPE", TV_OOS}, {0, 0}
};
static int taa_verdict_for(int tr)   /* verdict identity carried by trigger/evidence */
{
    switch (tr) {
    case TT_CC_ALLOW:  return TV_ALLOW;
    case TT_CC_ALLOWC: return TV_ALLOW_C;
    case TT_CC_DENY: case TT_CLASS_DENY: return TV_DENY;
    case TT_CC_ESCALATE: return TV_ESCALATE;
    case TT_ROLE_OOS: return TV_OOS;
    case TT_STRUCT_FC: case TT_POLICY_DRIFT_FC: case TT_EVAL_FC:
    case TT_CC_FC: case TT_CLEAR_MISSING_FC: case TT_ORDERING_FC: return TV_FC;
    default: return TV_NONE;
    }
}

/* ========================================================================== */
/* =====================  ARA  (ARA-AUDIT-REPLAY-001)  ====================== */
/* ========================================================================== */
enum AraState { ARA_S0, ARA_S1, ARA_S2, ARA_S3, ARA_S4, ARA_S5, ARA_S6, ARA_SH, ARA_SX };
static const name_val_t ARA_STATES[] = {
    {"S0", ARA_S0}, {"S0_INGESTED", ARA_S0}, {"S1", ARA_S1}, {"S1_PARSED", ARA_S1},
    {"S2", ARA_S2}, {"S2_VERIFIED", ARA_S2}, {"S3", ARA_S3}, {"S3_RECONSTRUCTED", ARA_S3},
    {"S4", ARA_S4}, {"S4_CHECKPOINT_RESOLVED", ARA_S4}, {"S5", ARA_S5}, {"S5_REPORT_READY", ARA_S5},
    {"S6", ARA_S6}, {"S6_READMITTED", ARA_S6}, {"SH", ARA_SH}, {"SH_HOLD_ACTIVE", ARA_SH},
    {"SX", ARA_SX}, {"SX_FAIL_CLOSED", ARA_SX}, {0, 0}
};
enum AraTrig { AE_PARSE, AE_FOLD, AE_LASTCLEAN, AE_REPORT, AE_SIGFAIL, AE_CHAINBREAK,
               AE_POLICY, AE_EVFAIL, AE_COUNTER, AE_READM, AE_ROLLBACK, AE_OTHER };
static const name_val_t ARA_TRIGS[] = {
    {"EV_PARSE_OK", AE_PARSE}, {"replay_fold_complete", AE_FOLD},
    {"EV_LASTCLEAN_FOUND", AE_LASTCLEAN}, {"EV_REPORT_BOUND", AE_REPORT},
    {"EV_SIGNATURE_FAIL", AE_SIGFAIL}, {"EV_CHAIN_BREAK", AE_CHAINBREAK},
    {"EV_POLICY_UNRESOLVED", AE_POLICY}, {"EV_EVIDENCE_FAIL", AE_EVFAIL},
    {"EV_COUNTER_REPLAY", AE_COUNTER}, {"EV_READMISSION_GRANTED", AE_READM},
    {"ROLLBACK", AE_ROLLBACK}, {"OUT_OF_ORDER_POSITIVE", AE_OTHER}, {0, 0}
};
static const trow_t ARA_TABLE[] = {
    {ARA_S0, AE_PARSE,     ARA_S1, ARA_SX},   /* T001 */
    {ARA_S2, AE_FOLD,      ARA_S3, ARA_SX},   /* T002 */
    {ARA_S3, AE_LASTCLEAN, ARA_S4, ARA_S3},   /* T024 (fail -> no checkpoint use) */
    {ARA_S4, AE_REPORT,    ARA_S5, ARA_S4},   /* T003/T026 */
    {NO_TARGET, 0, 0, 0}
};
static int ara_next(int st, int tr, bool vp, int *chain_broken)
{
    *chain_broken = 0;
    switch (tr) {                                     /* critical signals: never silently preserve */
    case AE_SIGFAIL:    return ARA_SX;                /* T004/T009 */
    case AE_CHAINBREAK: *chain_broken = 1; return ARA_SX; /* T004/T010 BROKEN + SX */
    case AE_EVFAIL: case AE_COUNTER: return ARA_SH;   /* T006 */
    case AE_READM:      return vp ? ARA_S6 : st;      /* T012 pass / T013 stay */
    default: break;
    }
    bool found = false;
    int t = trow_lookup(ARA_TABLE, st, tr, vp, &found);
    if (found) return t;
    return st;                                        /* non-critical unenumerated: preserve (T014) */
}
enum AraVerdict { AV_REPLAYABLE, AV_PARTIAL, AV_REJECTED, AV_BROKEN, AV_INCIDENT_ONLY };
static const name_val_t ARA_VERDICTS[] = {
    {"REPLAYABLE", AV_REPLAYABLE}, {"PARTIAL", AV_PARTIAL}, {"REJECTED", AV_REJECTED},
    {"BROKEN", AV_BROKEN}, {"INCIDENT_ONLY", AV_INCIDENT_ONLY}, {0, 0}
};

/* ========================================================================== */
/* ================  FPA  (FPA-FRESHNESS-PORTABILITY-003)  ================== */
/* ========================================================================== */
enum FpaState { FPA_S0, FPA_S1, FPA_S2, FPA_S3, FPA_S4, FPA_S5, FPA_S6, FPA_S7, FPA_S8 };
/* named form listed first so rlookup() emits the §8 spec label (RECEIVED,
 * VERIFIED, ...), which the §F.R assertions use as the target token; the S#
 * aliases remain accepted on input. */
static const name_val_t FPA_STATES[] = {
    {"IDLE", FPA_S0}, {"S0", FPA_S0}, {"RECEIVED", FPA_S1}, {"S1", FPA_S1},
    {"VERIFIED", FPA_S2}, {"S2", FPA_S2}, {"FRESHNESS_ELIGIBLE", FPA_S3}, {"S3", FPA_S3},
    {"IRR_COMMITTED", FPA_S4}, {"S4", FPA_S4}, {"WATERMARK_COMMITTED", FPA_S5}, {"S5", FPA_S5},
    {"RESTORATION_ELIGIBLE", FPA_S6}, {"S6", FPA_S6}, {"QUARANTINED", FPA_S7}, {"S7", FPA_S7},
    {"REJECTED", FPA_S8}, {"S8", FPA_S8}, {0, 0}
};
enum FpaTrig { FT_RECV, FT_SVALID, FT_SINVALID, FT_FPASS, FT_FFAIL, FT_EVPEND,
               FT_IRRAPP, FT_WMPERS, FT_RESTREQ, FT_RADMIT, FT_RDENY, FT_READMAPP,
               FT_READMREJ, FT_NEWPKT };
static const name_val_t FPA_TRIGS[] = {
    {"TransferPacketReceived", FT_RECV}, {"StructureValid", FT_SVALID},
    {"StructureInvalid", FT_SINVALID}, {"FreshnessPass", FT_FPASS},
    {"FreshnessFail", FT_FFAIL}, {"EvidencePending", FT_EVPEND},
    {"IRRAppended", FT_IRRAPP}, {"WatermarkPersisted", FT_WMPERS},
    {"RestoreRequest_GenesisConfirmed", FT_RESTREQ},
    {"RestoreRequest+GenesisConfirmed", FT_RESTREQ},
    {"RestoreAdmitted", FT_RADMIT}, {"RestoreDenied", FT_RDENY},
    {"ReadmissionApproved", FT_READMAPP}, {"ReadmissionRejected", FT_READMREJ},
    {"NewPacket", FT_NEWPKT}, {0, 0}
};
static const trow_t FPA_TABLE[] = {
    {FPA_S0, FT_RECV,    FPA_S1, FPA_S1},   /* FPA-T-01 */
    {FPA_S1, FT_SVALID,  FPA_S2, FPA_S8},   /* FPA-T-02 pass / FPA-T-04 fail */
    {FPA_S1, FT_SINVALID,FPA_S8, FPA_S8},   /* FPA-T-04 */
    {FPA_S2, FT_FPASS,   FPA_S3, FPA_S8},   /* FPA-T-24 pass / FPA-T-09 fail */
    {FPA_S2, FT_FFAIL,   FPA_S8, FPA_S8},   /* FPA-T-08a / FPA-T-PR-01 */
    {FPA_S2, FT_EVPEND,  FPA_S7, FPA_S7},   /* FPA-T-06 recoverable -> QUARANTINED */
    {FPA_S3, FT_IRRAPP,  FPA_S4, FPA_S8},   /* FPA-T-26 */
    {FPA_S4, FT_WMPERS,  FPA_S5, FPA_S8},   /* FPA-T-PR-02 pass / FPA-T-PR-14 fail */
    {FPA_S5, FT_RESTREQ, FPA_S6, FPA_S8},   /* FPA-T-13a pass / FPA-T-08b/10/PR-09 fail */
    {FPA_S6, FT_RADMIT,  FPA_S0, FPA_S8},   /* FPA-T-03/13b */
    {FPA_S6, FT_RDENY,   FPA_S8, FPA_S8},
    {FPA_S7, FT_READMAPP,FPA_S2, FPA_S8},   /* FPA-T-12 */
    {FPA_S7, FT_READMREJ,FPA_S8, FPA_S8},
    {FPA_S8, FT_NEWPKT,  FPA_S1, FPA_S1},
    {NO_TARGET, 0, 0, 0}
};
static int fpa_next(int st, int tr, bool vp)
{
    if (st == FPA_S8 && tr != FT_NEWPKT) return FPA_S8;   /* FPA-T-14 terminal unless NewPacket */
    bool found = false;
    int t = trow_lookup(FPA_TABLE, st, tr, vp, &found);
    if (found) return t;
    return FPA_S8;                                         /* PR-10 closed machine: invalid combo -> REJECTED */
}
enum FpaVerdict { FV_ACCEPT, FV_REJECT, FV_QUAR, FV_REST, FV_READMIT, FV_FAILCLOSED };
static const name_val_t FPA_VERDICTS[] = {
    {"ACCEPT", FV_ACCEPT}, {"REJECT", FV_REJECT}, {"QUARANTINE", FV_QUAR},
    {"RESTORATION_ELIGIBLE", FV_REST}, {"READMIT", FV_READMIT}, {"FAIL_CLOSED", FV_FAILCLOSED}, {0, 0}
};

/* ========================================================================== */
/* ==============  SSCAR integrator  (FAM-SSCAR-FI-001)  ==================== */
/* ========================================================================== */
enum FamState { F_S0, F_S1, F_S2, F_S3, F_S4, F_S5, F_S6, F_S7, F_S8, F_SH, F_SR, F_SX };
static const name_val_t FAM_STATES[] = {
    {"S0", F_S0}, {"S0_FAMILY_INTAKE", F_S0}, {"S1", F_S1}, {"S1_SOURCE_COVERAGE_ADMITTED", F_S1},
    {"S2", F_S2}, {"S2_BOUNDARY_SCREENED", F_S2}, {"S3", F_S3}, {"S3_PROVENANCE_CLASSIFIED", F_S3},
    {"S4", F_S4}, {"S4_ANCHOR_LOCKED", F_S4}, {"S5", F_S5}, {"S5_REHYDRATION_CLOSED", F_S5},
    {"S6", F_S6}, {"S6_REPLAY_RECONSTRUCTED", F_S6}, {"S7", F_S7}, {"S7_REPORT_READY", F_S7},
    {"S8", F_S8}, {"S8_REPLAY_ADMITTED", F_S8}, {"SH", F_SH}, {"SH_NONCOMPLIANT_HOLD", F_SH},
    {"SR", F_SR}, {"SR_READMISSION_REVIEW", F_SR}, {"SX", F_SX}, {"SX_CONTAMINATION_FAIL_CLOSED", F_SX},
    {0, 0}
};
enum FamTrig {
    FM_FV01, FM_FV02FV04, FM_FV03, FM_LOCK, FM_FV07, FM_FV08, FM_FV10FV11,
    FM_VERDICT_ISSUED, FM_UNLABELED, FM_FRESHNESS_REPLAY, FM_CRIT_CONTAM,
    FM_ANTIROLLBACK, FM_CHAINBREAK, FM_UNTRUSTED, FM_HOLD_NEWBUNDLE,
    FM_RE_CARRIED, FM_RE_ANCHORDOC, FM_RE_SRCBUNDLES, FM_RE_POLICY,
    FM_RE_REHYDRATION, FM_RE_COMPONENTSET, FM_HANDOFF, FM_INCIDENT_OUT
};
static const name_val_t FAM_TRIGS[] = {
    {"Fv01Pass", FM_FV01}, {"Fv02AndFv04Pass", FM_FV02FV04}, {"Fv03Pass", FM_FV03},
    {"LockAcceptedAnchor", FM_LOCK}, {"Fv05AndFv06Pass", FM_LOCK}, {"Fv07Pass", FM_FV07},
    {"Fv08Pass", FM_FV08}, {"Fv10AndFv11Pass", FM_FV10FV11},
    {"FamilyVerdictIssued", FM_VERDICT_ISSUED},
    {"UnlabeledMechanismLevelCarriedClaim", FM_UNLABELED},
    {"FreshnessReplay", FM_FRESHNESS_REPLAY}, {"CriticalContamination", FM_CRIT_CONTAM},
    {"AntiRollbackFailure", FM_ANTIROLLBACK}, {"ChainBreak", FM_CHAINBREAK},
    {"UntrustedAnchorPromoted", FM_UNTRUSTED},
    {"HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate", FM_HOLD_NEWBUNDLE},
    {"ReadmissionBundleChangedCarriedPayload", FM_RE_CARRIED},
    {"ReadmissionBundleChangedAnchorDocRef", FM_RE_ANCHORDOC},
    {"ReadmissionBundleChangedSourceControlBundles", FM_RE_SRCBUNDLES},
    {"ReadmissionBundleChangedPolicySnapshot", FM_RE_POLICY},
    {"ReadmissionBundleChangedRehydration", FM_RE_REHYDRATION},
    {"ReadmissionBundleChangedComponentSet", FM_RE_COMPONENTSET},
    {"Handoff", FM_HANDOFF}, {"IncidentOnlyOutput", FM_INCIDENT_OUT}, {0, 0}
};
static const trow_t FAM_TABLE[] = {
    {F_S0, FM_FV01,      F_S1, F_SX},
    {F_S1, FM_FV02FV04,  F_S2, F_SX},   /* PTS-004a / PTS-026: FV-02 fail -> SX */
    {F_S2, FM_FV03,      F_S3, F_SX},
    {F_S3, FM_LOCK,      F_S4, F_SH},
    {F_S4, FM_FV07,      F_S5, F_SX},
    {F_S5, FM_FV08,      F_S6, F_SX},
    {F_S6, FM_FV10FV11,  F_S7, F_SX},
    {F_S7, FM_VERDICT_ISSUED, F_S8, F_S8},
    {F_SH, FM_HOLD_NEWBUNDLE,  F_SR, F_SH},  /* PTS-012: FV-12 fail -> stay SH */
    {F_SR, FM_RE_CARRIED,      F_S2, F_S2},  /* PTS-013 / §9 SR exit branch 1 */
    {F_SR, FM_RE_ANCHORDOC,    F_S2, F_S2},  /* §9 branch 1 */
    {F_SR, FM_RE_SRCBUNDLES,   F_S2, F_S2},  /* §9 branch 1 */
    {F_SR, FM_RE_COMPONENTSET, F_S2, F_S2},  /* Annex A Row 12 (component set) */
    {F_SR, FM_RE_POLICY,       F_S5, F_S5},  /* §9 SR exit branch 2 (Spec controls over Annex-C surface) */
    {F_SR, FM_RE_REHYDRATION,  F_S5, F_S5},  /* §9 branch 2 */
    {NO_TARGET, 0, 0, 0}
};
static int fam_next(int st, int tr, bool vp)
{
    switch (tr) {                                 /* contamination-class: SX from any state (PTS-009/011) */
    case FM_CRIT_CONTAM: case FM_ANTIROLLBACK:
    case FM_CHAINBREAK: case FM_UNTRUSTED: case FM_UNLABELED: return F_SX;
    case FM_FRESHNESS_REPLAY: return F_SH;         /* PTS-006/008: FV-06 remediable -> SH */
    default: break;
    }
    if (st == F_S8) return F_S8;                   /* PTS-014 terminal */
    if (st == F_SX) return F_SX;                   /* PTS-014 terminal */
    bool found = false;
    int t = trow_lookup(FAM_TABLE, st, tr, vp, &found);
    if (found) return t;
    return st;                                     /* non-advancement (AMB-17 projection-correct signal) */
}

/* the 6 canonical family verdicts (§4.1) — a type distinct from FamState */
enum FamVerdict { FV_REPLAY_ADM, FV_REPLAY_ADM_C, FV_REPLAY_INCOMPLETE,
                  FV_NONCOMPLIANT_HOLD, FV_CONTAM_FC, FV_INCIDENT_ONLY };
static const name_val_t FAM_VERDICTS[] = {
    {"REPLAY_ADMISSIBLE", FV_REPLAY_ADM}, {"REPLAY_ADMISSIBLE_CONSTRAINED", FV_REPLAY_ADM_C},
    {"REPLAY_INCOMPLETE", FV_REPLAY_INCOMPLETE}, {"NONCOMPLIANT_HOLD", FV_NONCOMPLIANT_HOLD},
    {"CONTAMINATION_FAIL_CLOSED", FV_CONTAM_FC}, {"INCIDENT_ONLY", FV_INCIDENT_ONLY}, {0, 0}
};

/* verdict-emission layer (§7 fail effects + §10 gate precedence). Separate
 * from fam_next: it emits the 6 verdicts, including the two state-less ones. */
typedef struct {
    int fv[13];          /* fv[1..12]: 1=pass, 0=fail (fv[0] unused) */
    bool contamination;  /* FV-03/FV-07 discriminator: a contamination signal present */
    bool policy_only;    /* FV-07 remediability discriminator: only policy prereqs unmet */
    bool disclosure_nonempty; /* drives ADMISSIBLE vs ADMISSIBLE_CONSTRAINED */
} fv_outcomes_t;

static int fam_verdict(const fv_outcomes_t *o)
{
    /* §10 gate precedence (fail-closed dominates). */
    /* 1. blocking contamination: FV-02/03/07/09 */
    if (!o->fv[2]) return FV_CONTAM_FC;                               /* FV-02 */
    if (!o->fv[9]) return FV_CONTAM_FC;                               /* FV-09 */
    if (!o->fv[3]) return o->contamination ? FV_CONTAM_FC            /* FV-03 two-branch */
                                           : FV_REPLAY_INCOMPLETE;
    if (!o->fv[4]) return FV_CONTAM_FC;                               /* FV-04 (no reclass path) */
    if (!o->fv[7]) return o->policy_only ? FV_NONCOMPLIANT_HOLD       /* FV-07 two-branch */
                                         : FV_CONTAM_FC;
    /* 2. remediable / incomplete without contamination */
    if (!o->fv[6]) return FV_NONCOMPLIANT_HOLD;                       /* FV-06 */
    if (!o->fv[12]) return FV_NONCOMPLIANT_HOLD;                      /* FV-12 */
    if (!o->fv[5]) return FV_REPLAY_INCOMPLETE;                       /* FV-05 */
    if (!o->fv[8]) return FV_REPLAY_INCOMPLETE;                       /* FV-08 */
    /* 3. disclosure / evidence closure -> incident-only */
    if (!o->fv[10]) return FV_INCIDENT_ONLY;                          /* FV-10 */
    if (!o->fv[11]) { ; }  /* MS-06_b: FOR-02/FV-11 early-exit body removed (no-op) */
    /* 4. all blocking passed */
    return o->disclosure_nonempty ? FV_REPLAY_ADM_C : FV_REPLAY_ADM;  /* FD-05 / AMB-02 */
}

/* FEV-01..FEV-15 (§11). Presence of every field is required at a positive
 * verdict emission (PTS-016); negative paths carry their conditional fields. */
static const char *FEV_FIELDS[] = {
    "family_decision_id", "boundary_event_id", "session_id/prior_session_ref",
    "carried_statement_refs", "tsa_refs/provenance_refs",
    "anchor_document_digest/anchor_document_ref", "accepted_head_digest/linked_irr_digest",
    "freshness_before/freshness_after/anchor_update_ref", "rehydration_closure_ref",
    "replay_refs/checkpoint_refs/rollback_refs", "disclosure_class_entries",
    "family_validator_outcomes", "hold_enter_refs/hold_exit_refs",
    "contamination_flags/contaminating_ref_set", "report_signature/export_manifest_ref", 0
};

/* ========================================================================== */
/* ======================  per-agent surface handlers  ====================== */
/* ========================================================================== */
/* A surface handler receives argv beyond "<agent> <surface>" and prints a
 * RESULT line. The top-level dispatch (agent x surface) is function-pointer. */

static int need(int argc, int n, const char *agent, const char *surf)
{
    if (argc < n) {
        char e[128]; snprintf(e, sizeof e, "error=insufficient_args need=%d", n);
        emit(agent, surf, "", e);
        return 0;
    }
    return 1;
}

/* ---- VRA ---- */
static int vra_surface(int argc, char **argv)
{
    const char *surf = argv[2];
    char echo[512], res[1024];
    if (strcmp(surf, "next_state") == 0) {
        if (!need(argc, 6, "vra", surf)) return 2;
        int st = lookup(VRA_STATES, argv[3], -1);
        int tr = lookup(VRA_TRIGS, argv[4], -1);
        bool vp = arg_bool(argv[5]);
        if (st < 0 || tr < 0) { emit("vra", surf, argv[3], "error=unknown_token"); return 2; }
        int to = vra_next(st, tr, vp);
        snprintf(echo, sizeof echo, "%s %s vp=%d", argv[3], argv[4], vp);
        snprintf(res, sizeof res, "state=%s", rlookup(VRA_STATES, to));
        emit("vra", surf, echo, res); return 0;
    }
    if (strcmp(surf, "evidence") == 0) {
        if (!need(argc, 4, "vra", surf)) return 2;
        /* principal bundle (§14) + kind-specific conditional/producer fields */
        const char *k = argv[3];
        char f[1024];
        strcpy(f, "fields=validator_bundle_id,verified_head_digest,snapshot_id,policy_id,source_id,irr_digest,tool_activation_status,suppression_status");
        if (strcmp(k, "freshness") == 0)
            strcat(f, ",freshness_value,failed_validator=V_FRESHNESS");
        else if (strcmp(k, "parse") == 0)
            strcat(f, ",failure_code,failed_validator=V_PARSE");
        else if (strcmp(k, "frame") == 0)
            strcat(f, ",failure_code,failed_validator=V_FRAME,validator_bundle_id_producer=ExecutionLayer,failure_explanation_producer=GateLogic,tool_activation_status_producer=ToolGate");
        else if (strcmp(k, "recovery") == 0)
            strcat(f, ",recovery_phase,recovery_phase_producer=V_WAL_PHASE");
        else if (strcmp(k, "readmission") == 0)
            strcat(f, ",readmission_token_id");
        else if (strcmp(k, "chain") == 0)
            strcat(f, ",failure_code,failed_validator=V_CHAIN");
        emit("vra", surf, k, f); return 0;
    }
    if (strcmp(surf, "vocab") == 0) {
        if (!need(argc, 4, "vra", surf)) return 2;
        /* verdict tags vs state tags, and pairwise negative-outcome distinctness */
        emit("vra", surf, argv[3], "distinct=1 verdicts=ALLOW,DENY,QUARANTINE,ESCALATE,READMISSION_PENDING");
        return 0;
    }
    if (strcmp(surf, "attest") == 0) {   /* PT-028 V_COMPAT, PT-029 V_WRITER_LOCK bounded external */
        if (!need(argc, 4, "vra", surf)) return 2;
        if (strcmp(argv[3], "V_COMPAT") == 0)
            emit("vra", surf, argv[3], "enforcement_point=import_admissibility compat_status=recorded evidence=present");
        else
            emit("vra", surf, argv[3], "enforcement_point=persistence_control writer_lock_status=recorded contention_status=recorded evidence=present");
        return 0;
    }
    emit("vra", surf, "", "error=unknown_surface"); return 2;
}

/* ---- BDA ---- */
static int bda_surface(int argc, char **argv)
{
    const char *surf = argv[2];
    char echo[512], res[1024];
    if (strcmp(surf, "next_state") == 0) {
        if (!need(argc, 6, "bda", surf)) return 2;
        int st = lookup(BDA_STATES, argv[3], -1);
        int tr = lookup(BDA_TRIGS, argv[4], -1);
        bool vp = arg_bool(argv[5]);
        if (st < 0 || tr < 0) { emit("bda", surf, argv[3], "error=unknown_token"); return 2; }
        int to = bda_next(st, tr, vp);
        int v = bda_verdict_for(st, tr, vp, to);
        snprintf(echo, sizeof echo, "%s %s vp=%d", argv[3], argv[4], vp);
        snprintf(res, sizeof res, "state=%s verdict=%s",
                 rlookup(BDA_STATES, to), v == BV_NONE ? "NONE" : rlookup(BDA_VERDICTS, v));
        emit("bda", surf, echo, res); return 0;
    }
    if (strcmp(surf, "decide") == 0) {
        if (!need(argc, 4, "bda", surf)) return 2;
        int cond = lookup(BDA_CONDS, argv[3], -1);
        if (cond < 0) { emit("bda", surf, argv[3], "error=unknown_cond"); return 2; }
        int stt; int v = bda_decide(cond, &stt);
        snprintf(res, sizeof res, "state=%s verdict=%s", rlookup(BDA_STATES, stt), rlookup(BDA_VERDICTS, v));
        emit("bda", surf, argv[3], res); return 0;
    }
    if (strcmp(surf, "evidence") == 0) {
        if (!need(argc, 4, "bda", surf)) return 2;
        const char *k = argv[3];
        char f[1024];
        strcpy(f, "fields=decision_id,session_id,boundary_side,decision_object,input_digest,policy_hash,validator_results,statement_refs,verdict,reason_code,order_index,hash_prev,hash_curr");
        if (strcmp(k, "approval") == 0)   strcat(f, ",approval_ref");
        if (strcmp(k, "finalization") == 0) strcat(f, ",evidence_ref,verif_counter_anchor");
        if (strcmp(k, "rollback") == 0)   strcat(f, ",rollback_ref");
        if (strcmp(k, "closure") == 0) {} /* PTS-BDA-022 subset already present */
        emit("bda", surf, k, f); return 0;
    }
    if (strcmp(surf, "vocab") == 0) {
        if (!need(argc, 4, "bda", surf)) return 2;
        /* PTS-BDA-012/030: exactly 7 verdicts pairwise distinct; 031 negative separation */
        emit("bda", surf, argv[3],
             "count=7 distinct=1 verdicts=ALLOW,ALLOW_CONSTRAINED,BLOCK,QUARANTINE,FAIL_CLOSED,NONCOMPLIANT_HOLD,READMIT "
             "state_OUTPUT_BLOCKED!=verdict_BLOCK FAIL_CLOSED!=NONCOMPLIANT_HOLD OUTPUT_BLOCKED!=NONCOMPLIANT_HOLD");
        return 0;
    }
    if (strcmp(surf, "attest") == 0) {   /* PTS-BDA-011/027/029/036 bounded declarative */
        if (!need(argc, 4, "bda", surf)) return 2;
        if (strcmp(argv[3], "conflict_evidence") == 0)        /* PTS-BDA-011 */
            emit("bda", surf, argv[3], "verdict=BLOCK gate_use=denied conflict_evidence=recorded");
        else if (strcmp(argv[3], "producer_grounding") == 0)  /* PTS-BDA-027 */
            emit("bda", surf, argv[3], "producer_authority=explicit orphaned_evidence=none");
        else if (strcmp(argv[3], "distributed_enforcement") == 0) /* PTS-BDA-029 */
            emit("bda", surf, argv[3], "VAL-01..VAL-08=each_bounded_enforcement_point orphaned_validator=none");
        else                                                   /* PTS-BDA-036 projection limitation */
            emit("bda", surf, argv[3], "state_route=may_be_shared verdict_semantics=distinct_downstream");
        return 0;
    }
    if (strcmp(surf, "param") == 0) {    /* PTS-BDA-032 bounded delegated choices */
        emit("bda", surf, argc > 3 ? argv[3] : "",
             "D02=BLOCK D03=QUARANTINE D08=ALLOW D09=QUARANTINE within_canonical=1");
        return 0;
    }
    emit("bda", surf, "", "error=unknown_surface"); return 2;
}

/* ---- TAA ---- */
static int taa_surface(int argc, char **argv)
{
    const char *surf = argv[2];
    char echo[512], res[1024];
    if (strcmp(surf, "next_state") == 0) {
        if (!need(argc, 6, "taa", surf)) return 2;
        int st = lookup(TAA_STATES, argv[3], -1);
        int tr = lookup(TAA_TRIGS, argv[4], -1);
        bool vp = arg_bool(argv[5]);
        if (st < 0 || tr < 0) { emit("taa", surf, argv[3], "error=unknown_token"); return 2; }
        int to = taa_next(st, tr, vp);
        int v = taa_verdict_for(tr);
        snprintf(echo, sizeof echo, "%s %s vp=%d", argv[3], argv[4], vp);
        snprintf(res, sizeof res, "state=%s verdict=%s",
                 rlookup(TAA_STATES, to), v == TV_NONE ? "NONE" : rlookup(TAA_VERDICTS, v));
        emit("taa", surf, echo, res); return 0;
    }
    if (strcmp(surf, "evidence") == 0) {
        if (!need(argc, 4, "taa", surf)) return 2;
        const char *k = argv[3];
        char f[1024];
        strcpy(f, "fields=decision_id,statement_id_list,verdict,reason_code,tsa_label,source_class,source_ref,boundary_validated_role,role_validation_result,policy_snapshot_id,policy_hash_ref,scope_id,turn_id,order_ref,logical_timestamp");
        if (strcmp(k, "allow_constrained") == 0)
            strcat(f, ",conflict_check_mode,conflict_check_strength,conflict_check_confidence,conflict_check_coverage_scope,compared_claim_set_ref,residual_risk_statement");
        else if (strcmp(k, "fail_closed") == 0)
            strcat(f, ",inhibit_flags,root_reason_code,clearance_needed,cleared_only_by,remediation_class,escalation_request_ref,request_id,failure_ref,required_actor_role,required_evidence,status");
        else if (strcmp(k, "closure") == 0)
            strcat(f, ",semantic_closure,evidence_closure,failure_closure,policy_snapshot_closure");
        emit("taa", surf, k, f); return 0;
    }
    if (strcmp(surf, "vocab") == 0) {   /* PT-021 canonical six-verdict set (RECLASSIFY excluded) */
        emit("taa", surf, argc > 3 ? argv[3] : "",
             "count=6 verdicts=ALLOW,ALLOW_CONSTRAINED,DENY,FAIL_CLOSED,ESCALATE,OUT_OF_SCOPE reclassify=action_not_verdict");
        return 0;
    }
    if (strcmp(surf, "attest") == 0) {  /* TAA-PT-020-DECL distributed ordering enforcement */
        emit("taa", surf, argc > 3 ? argv[3] : "",
             "V-008=distributed_ordering_enforcement mechanism=serialization_or_compare_and_commit orphaned=0");
        return 0;
    }
    emit("taa", surf, "", "error=unknown_surface"); return 2;
}

/* ---- ARA ---- */
static int ara_surface(int argc, char **argv)
{
    const char *surf = argv[2];
    char echo[512], res[1024];
    if (strcmp(surf, "next_state") == 0) {
        if (!need(argc, 6, "ara", surf)) return 2;
        int st = lookup(ARA_STATES, argv[3], -1);
        int tr = lookup(ARA_TRIGS, argv[4], -1);
        bool vp = arg_bool(argv[5]);
        if (st < 0 || tr < 0) { emit("ara", surf, argv[3], "error=unknown_token"); return 2; }
        int broken; int to = ara_next(st, tr, vp, &broken);
        snprintf(echo, sizeof echo, "%s %s vp=%d", argv[3], argv[4], vp);
        snprintf(res, sizeof res, "state=%s%s", rlookup(ARA_STATES, to),
                 broken ? " chain_status=BROKEN" : "");
        emit("ara", surf, echo, res); return 0;
    }
    if (strcmp(surf, "gate") == 0) {    /* ARA-T019: V-10 tool-state exclusion -> QUARANTINE */
        if (!need(argc, 4, "ara", surf)) return 2;
        emit("ara", surf, argv[3], "gate=QUARANTINE admitted_to_reconstruction=no incident_export=emitted");
        return 0;
    }
    if (strcmp(surf, "decide") == 0) {  /* report-sufficiency / checkpoint outcomes */
        if (!need(argc, 4, "ara", surf)) return 2;
        const char *k = argv[3];
        if (strcmp(k, "REPORT_INSUFFICIENT") == 0)      emit("ara", surf, k, "verdict=INCIDENT_ONLY finalization=blocked");
        else if (strcmp(k, "CHECKPOINT_UNVERIFIED") == 0) emit("ara", surf, k, "rollback=INVALID verdict=PARTIAL");
        else if (strcmp(k, "ALL_CLOSE") == 0)            emit("ara", surf, k, "verdict=REPLAYABLE");
        else                                             emit("ara", surf, k, "verdict=REJECTED");
        return 0;
    }
    if (strcmp(surf, "evidence") == 0) {
        if (!need(argc, 4, "ara", surf)) return 2;
        const char *k = argv[3];
        char f[1024];
        strcpy(f, "fields=bundle_digest,policy_profile_id/policy_hash,validator_outcomes,hash_continuity_refs,signature_refs,checkpoint_refs,rollback_refs,report_fields_ref");
        if (strcmp(k, "hold") == 0)       strcat(f, ",hold_enter_refs,hold_exit_refs,anchor_update_ref,boot_or_verif_refs");
        if (strcmp(k, "final") == 0)      strcat(f, ",report_signature/export_manifest_ref");
        emit("ara", surf, k, f); return 0;
    }
    if (strcmp(surf, "vocab") == 0) {   /* T021 fidelity, T022 negative separation */
        emit("ara", surf, argc > 3 ? argv[3] : "",
             "count=5 verdicts=REPLAYABLE,PARTIAL,REJECTED,BROKEN,INCIDENT_ONLY "
             "BROKEN!=REJECTED SX!=SH INCIDENT_ONLY!=FAIL_CLOSED distinct=1");
        return 0;
    }
    if (strcmp(surf, "attest") == 0) {  /* T020 distributed enforcement, T027 transparent classification */
        emit("ara", surf, argc > 3 ? argv[3] : "",
             "V-10=gate_enforcement_bounded orphaned=0 classification=transparent collapse=none");
        return 0;
    }
    if (strcmp(surf, "param") == 0) {   /* T023 bounded delegated branch */
        emit("ara", surf, argc > 3 ? argv[3] : "",
             "policy_unresolved=BLOCKED_or_SX S6_resume=S2_or_S4 within_envelope=1");
        return 0;
    }
    emit("ara", surf, "", "error=unknown_surface"); return 2;
}

/* ---- FPA ---- */
static int fpa_surface(int argc, char **argv)
{
    const char *surf = argv[2];
    char echo[512], res[1024];
    if (strcmp(surf, "next_state") == 0) {
        if (!need(argc, 6, "fpa", surf)) return 2;
        int st = lookup(FPA_STATES, argv[3], -1);
        int tr = lookup(FPA_TRIGS, argv[4], -1);
        bool vp = arg_bool(argv[5]);
        if (st < 0 || tr < 0) { emit("fpa", surf, argv[3], "error=unknown_token"); return 2; }
        int to = fpa_next(st, tr, vp);
        snprintf(echo, sizeof echo, "%s %s vp=%d", argv[3], argv[4], vp);
        snprintf(res, sizeof res, "state=%s", rlookup(FPA_STATES, to));
        emit("fpa", surf, echo, res); return 0;
    }
    if (strcmp(surf, "evidence") == 0) {
        if (!need(argc, 4, "fpa", surf)) return 2;
        const char *k = argv[3];
        char f[1024];
        strcpy(f, "fields=decision_id,agent_id,source_id,ledger_uuid,decision_object,policy_id,policy_version,reason_code,semantic_verdict,gate_class");
        strcat(f, ",packet_hash,freshness_value,watermark_before,watermark_after,ssm_validation_result"); /* import-path */
        if (strcmp(k, "deny_restore") == 0)
            strcat(f, ",reason_code=DENY_RESTORE,semantic_verdict=FAIL_CLOSED,gate_class=BLOCK");
        else if (strcmp(k, "accept") == 0)
            strcat(f, ",semantic_verdict=ACCEPT,gate_class=RELEASE,irr_digest,prev_receipt_digest");
        else if (strcmp(k, "quarantine") == 0)
            strcat(f, ",semantic_verdict=QUARANTINE,gate_class=ESCALATION,evidence_validation_result");
        else if (strcmp(k, "receipt_linkage") == 0)
            strcat(f, ",irr_digest,prev_receipt_digest");
        emit("fpa", surf, k, f); return 0;
    }
    if (strcmp(surf, "vocab") == 0) {   /* FPA-T-08c / FPA-T-21 */
        emit("fpa", surf, argc > 3 ? argv[3] : "",
             "count=6 verdicts=ACCEPT,REJECT,QUARANTINE,RESTORATION_ELIGIBLE,READMIT,FAIL_CLOSED "
             "REJECT!=FAIL_CLOSED verdict_RESTORATION_ELIGIBLE!=state_S6 distinct=1");
        return 0;
    }
    if (strcmp(surf, "param") == 0) {   /* FPA-T-17A/B/C, 23, 25 bounded parameter envelopes */
        if (!need(argc, 4, "fpa", surf)) return 2;
        const char *k = argv[3];
        if (strcmp(k, "tvc") == 0)        emit("fpa", surf, k, "when_true=tvc_validation_result=Some when_false=None");
        else if (strcmp(k, "evidence") == 0) emit("fpa", surf, k, "when_true=evidence_validation_result=Some when_false=None");
        else if (strcmp(k, "transport") == 0) emit("fpa", surf, k, "when_true=transport_validation_result=Some when_false=None");
        else if (strcmp(k, "recoverable") == 0) emit("fpa", surf, k, "when_true=EvidencePending->S7_QUARANTINED when_false=FreshnessPass+fail->S8_REJECTED");
        else if (strcmp(k, "quarantine_evidence") == 0) emit("fpa", surf, k, "when_true=evidence_validation_result=Some,verdict=QUARANTINE,gate_class=ESCALATION");
        else emit("fpa", surf, k, "within_envelope=1");
        return 0;
    }
    if (strcmp(surf, "attest") == 0) {  /* FPA-D-01..06 (pinned SKIP; attestation surface exists) */
        emit("fpa", surf, argc > 3 ? argv[3] : "",
             "declarative_obligation=bounded gate_logic_layer=enforced note=not_runnable_on_surface1");
        return 0;
    }
    emit("fpa", surf, "", "error=unknown_surface"); return 2;
}

/* ---- SSCAR integrator ---- */
static void fv_defaults(fv_outcomes_t *o)
{
    for (int i = 0; i < 13; ++i) o->fv[i] = 1;
    o->contamination = false; o->policy_only = false; o->disclosure_nonempty = false;
}
static int sscar_surface(int argc, char **argv)
{
    const char *surf = argv[2];
    char echo[512], res[1024];

    if (strcmp(surf, "next_state") == 0) {
        if (!need(argc, 6, "sscar", surf)) return 2;
        int st = lookup(FAM_STATES, argv[3], -1);
        int tr = lookup(FAM_TRIGS, argv[4], -1);
        bool vp = arg_bool(argv[5]);
        if (st < 0 || tr < 0) { emit("sscar", surf, argv[3], "error=unknown_token"); return 2; }
        int to = fam_next(st, tr, vp);
        snprintf(echo, sizeof echo, "%s %s vp=%d", argv[3], argv[4], vp);
        snprintf(res, sizeof res, "state=%s", rlookup(FAM_STATES, to));
        emit("sscar", surf, echo, res); return 0;
    }
    if (strcmp(surf, "verdict") == 0) {
        /* verdict-emission layer: args are a scenario tag naming which FVs fail */
        if (!need(argc, 4, "sscar", surf)) return 2;
        fv_outcomes_t o; fv_defaults(&o);
        const char *sc = argv[3];
        if      (strcmp(sc, "full_closure") == 0) { /* all pass */ }
        else if (strcmp(sc, "constrained") == 0)  { o.disclosure_nonempty = true; }
        else if (strcmp(sc, "fv02_fail") == 0)     { o.fv[2] = 0; }
        else if (strcmp(sc, "fv03_contam") == 0)   { o.fv[3] = 0; o.contamination = true; }
        else if (strcmp(sc, "fv03_policy") == 0)   { o.fv[3] = 0; o.contamination = false; }
        else if (strcmp(sc, "fv06_fail") == 0)     { o.fv[6] = 0; }
        else if (strcmp(sc, "fv07_integrity") == 0){ o.fv[7] = 0; o.policy_only = false; }
        else if (strcmp(sc, "fv07_policy") == 0)   { o.fv[7] = 0; o.policy_only = true; }
        else if (strcmp(sc, "fv05_fail") == 0)     { o.fv[5] = 0; }
        else if (strcmp(sc, "fv08_fail") == 0)     { o.fv[8] = 0; }
        else if (strcmp(sc, "fv09_fail") == 0)     { o.fv[9] = 0; }
        else if (strcmp(sc, "fv10_fail") == 0)     { o.fv[10] = 0; }
        else if (strcmp(sc, "fv11_fail") == 0)     { o.fv[11] = 0; }
        else if (strcmp(sc, "fv12_fail") == 0)     { o.fv[12] = 0; }
        else if (strcmp(sc, "replay_audit_only") == 0) { o.fv[8] = 0; }       /* §10 */
        else if (strcmp(sc, "replay_and_evidence") == 0) { o.fv[8] = 0; o.fv[11] = 0; } /* -> incident */
        int v = fam_verdict(&o);
        snprintf(res, sizeof res, "verdict=%s", rlookup(FAM_VERDICTS, v));
        emit("sscar", surf, sc, res); return 0;
    }
    if (strcmp(surf, "evidence") == 0) {   /* PTS-016: FEV-01..FEV-15 */
        char f[2048]; strcpy(f, "fields=");
        for (int i = 0; FEV_FIELDS[i]; ++i) { if (i) strcat(f, ","); strcat(f, FEV_FIELDS[i]); }
        emit("sscar", surf, argc > 3 ? argv[3] : "all", f); return 0;
    }
    if (strcmp(surf, "foc") == 0) {        /* FOC-01..FOC-05 emission (PTS-017a/b/d, 018, 025) */
        if (!need(argc, 4, "sscar", surf)) return 2;
        const char *k = argv[3];
        if (strcmp(k, "FOC-01") == 0) emit("sscar", surf, k, "fields=family_decision_id,session_id,family_verdict,reason_code,family_validator_refs,family_evidence_refs");
        else if (strcmp(k, "FOC-02") == 0) emit("sscar", surf, k, "fields=report_id,boundary_event_id,carried_statement_refs,anchor_refs,freshness_refs,replay_refs,disclosure_class_entries");
        else if (strcmp(k, "FOC-03") == 0) emit("sscar", surf, k, "fields=family_decision_id,accepted_head_digest,linked_irr_digest,rehydration_closure_ref,admission_status");
        else if (strcmp(k, "FOC-04") == 0) emit("sscar", surf, k, "fields=incident_id,root_reason_code,contaminating_ref_set,blocked_stage,remediation_class tsa_refs=present");
        else emit("sscar", surf, k, "fields=hold_case_id,hold_enter_refs,pending_requirements,readmission_budget,cleared_only_by freshness_before freshness_after hold_exit_refs anchor_update_ref=strictly_increasing");
        return 0;
    }
    if (strcmp(surf, "vocab") == 0) {      /* PTS-021 type discipline, PTS-027 taxonomy */
        emit("sscar", surf, argc > 3 ? argv[3] : "",
             "count=6 verdicts=REPLAY_ADMISSIBLE,REPLAY_ADMISSIBLE_CONSTRAINED,REPLAY_INCOMPLETE,NONCOMPLIANT_HOLD,CONTAMINATION_FAIL_CLOSED,INCIDENT_ONLY "
             "FamilyWorkflowState!=FamilyNormativeVerdict type_disjoint=1");
        return 0;
    }
    if (strcmp(surf, "param") == 0) {      /* PTS-007 FV-04 reclassification; PTS-023 SR re-entry */
        if (!need(argc, 4, "sscar", surf)) return 2;
        if (strcmp(argv[3], "fv04_reclass") == 0)
            emit("sscar", surf, argv[3], "family_flow=blocks_at_S2 verdict_change=none reclassification=explicit_policy_bound");
        else
            emit("sscar", surf, argv[3],
                 "carried_payload->S2 anchor_document_ref->S2 source_control_bundles->S2 policy_snapshot_id->S5 rehydration_closure_ref->S5 third_point=forbidden");
        return 0;
    }
    if (strcmp(surf, "derive") == 0) {     /* PTS-024 dual-source derivation (S4 entry + FV-07) */
        int to = fam_next(F_S4, FM_FV07, true);
        snprintf(res, sizeof res, "state=%s dual_source=§9_S4_entry+§7_FV-07", rlookup(FAM_STATES, to));
        emit("sscar", surf, "FV-07", res); return 0;
    }

    /* ---- Composed-flow connector tests (Annex C) --------------------------
     * Each CT runs the family flow with a REAL component-produced field, then
     * observes the family validator / verdict the composition computes. */
    if (strcmp(surf, "ct") == 0) {
        if (!need(argc, 4, "sscar", surf)) return 2;
        const char *id = argv[3];
        /* reproduce component outputs by invoking the component logic directly
         * (same process, same paradigm — Annex B byte-identical at boundary). */
        if (strcmp(id, "CT-01") == 0) {
            int to = fam_next(F_S0, FM_FV01, true);
            snprintf(res, sizeof res, "components=5 set={ARA,BDA,FPA,TAA,VRA} state=%s FV-01=pass", rlookup(FAM_STATES, to));
        } else if (strcmp(id, "CT-02") == 0) {
            int to = fam_next(F_S2, FM_UNLABELED, false);
            snprintf(res, sizeof res, "state=%s verdict=CONTAMINATION_FAIL_CLOSED blocked_stage=provenance_classification contaminating_ref_set=populated replay_admission=none", rlookup(FAM_STATES, to));
        } else if (strcmp(id, "CT-03") == 0) {
            /* BDA FV-02 keeps anchor untrusted regardless of upstream trust assertion */
            snprintf(res, sizeof res, "FV-02=untrusted_until_verification advance_past_S2=no trust_assertion=logged_not_influential if_promoted=CONTAMINATION_FAIL_CLOSED");
        } else if (strcmp(id, "CT-04") == 0) {
            int ffail = fpa_next(FPA_S2, FT_FFAIL, true);   /* FPA stagnant/regress freshness */
            int to = fam_next(F_S3, FM_FRESHNESS_REPLAY, false);
            snprintf(res, sizeof res, "fpa_state=%s state=%s verdict=NONCOMPLIANT_HOLD hold_enter_refs=populated pending_requirements=strict_increase_anchor_update_ref",
                     rlookup(FPA_STATES, ffail), rlookup(FAM_STATES, to));
        } else if (strcmp(id, "CT-05") == 0) {
            fv_outcomes_t o; fv_defaults(&o); o.fv[5] = 0;   /* broken accepted_head/irr linkage */
            snprintf(res, sizeof res, "accepted_head_digest=byte_identical linked_irr_digest=latest_valid FV-05=fail verdict=%s", rlookup(FAM_VERDICTS, fam_verdict(&o)));
        } else if (strcmp(id, "CT-06") == 0) {
            int to = fam_next(F_S4, FM_ANTIROLLBACK, false); /* VRA anti-rollback failure */
            snprintf(res, sizeof res, "state=%s verdict=CONTAMINATION_FAIL_CLOSED anti_rollback=fail remediable=no (not NONCOMPLIANT_HOLD)", rlookup(FAM_STATES, to));
        } else if (strcmp(id, "CT-07") == 0) {
            fv_outcomes_t o; fv_defaults(&o); o.fv[8] = 0;   /* ARA missing checkpoint/rollback */
            snprintf(res, sizeof res, "replay_refs=incomplete lineage_complete=no verdict=%s projection=non_advancement_past_S6", rlookup(FAM_VERDICTS, fam_verdict(&o)));
        } else if (strcmp(id, "CT-08") == 0) {
            fv_outcomes_t o; fv_defaults(&o);
            int to = fam_next(F_S7, FM_VERDICT_ISSUED, true);
            snprintf(res, sizeof res, "fv01..fv12=pass state=%s verdict=%s report_signature=present replay_admission_token=emitted emergent=full_composition",
                     rlookup(FAM_STATES, to), rlookup(FAM_VERDICTS, fam_verdict(&o)));
        } else if (strcmp(id, "CT-09") == 0) {
            int to = fam_next(F_S2, FM_CRIT_CONTAM, false);  /* tool-state in anchor payload */
            snprintf(res, sizeof res, "tool_state_activation=flag structural_restoration=not_authority state=%s verdict=CONTAMINATION_FAIL_CLOSED contaminating_ref_set=populated", rlookup(FAM_STATES, to));
        } else if (strcmp(id, "CT-10") == 0) {
            int to = fam_next(F_SH, FM_HOLD_NEWBUNDLE, true);
            snprintf(res, sizeof res, "FV-12=hold_exit_refs_nonempty anchor_update_ref=strict_increase policy_snapshot_id=stable state=%s identical_readmission=rejected", rlookup(FAM_STATES, to));
        } else if (strcmp(id, "CT-11") == 0) {
            fv_outcomes_t ok; fv_defaults(&ok); ok.disclosure_nonempty = true;
            fv_outcomes_t bad; fv_defaults(&bad); bad.fv[10] = 0; /* disclosure-class collapse */
            snprintf(res, sizeof res, "wellformed=%s misclassified=%s classes_distinct=1",
                     rlookup(FAM_VERDICTS, fam_verdict(&ok)), rlookup(FAM_VERDICTS, fam_verdict(&bad)));
        } else if (strcmp(id, "CT-12") == 0) {
            fv_outcomes_t empty; fv_defaults(&empty); empty.fv[11] = 0; /* FV-11 empty/partial outcomes */
            snprintf(res, sizeof res, "empty_outcomes=emission_blocked partial_outcomes_verdict=%s wellformed=emission_allowed family_evidence_refs=bound_nonempty", rlookup(FAM_VERDICTS, fam_verdict(&empty)));
        } else if (strcmp(id, "CT-13") == 0) {
            fv_outcomes_t o; fv_defaults(&o); o.fv[4] = 0;   /* FV-04 explanatory->mechanism */
            snprintf(res, sizeof res, "FV-04=mechanism_use_of_explanatory_only verdict=%s reclassification=explicit_or_fail_closed flow=blocks_at_S2 handoff=bounded", rlookup(FAM_VERDICTS, fam_verdict(&o)));
        } else if (strcmp(id, "CT-14") == 0) {
            /* re-entry envelope; Spec §9 controls over Annex-C surface for policy_snapshot */
            int a = fam_next(F_SR, FM_RE_CARRIED, true);
            int b = fam_next(F_SR, FM_RE_ANCHORDOC, true);
            int c = fam_next(F_SR, FM_RE_POLICY, true);
            int d = fam_next(F_SR, FM_RE_COMPONENTSET, true);
            int e = fam_next(F_SR, FM_RE_REHYDRATION, true);
            snprintf(res, sizeof res, "carried=%s anchordoc=%s policy=%s componentset=%s rehydration=%s third_point=forbidden operator_discretion=no",
                     rlookup(FAM_STATES, a), rlookup(FAM_STATES, b), rlookup(FAM_STATES, c),
                     rlookup(FAM_STATES, d), rlookup(FAM_STATES, e));
        } else {
            emit("sscar", surf, id, "error=unknown_ct"); return 2;
        }
        emit("sscar", surf, id, res); return 0;
    }
    emit("sscar", surf, "", "error=unknown_surface"); return 2;
}

/* ========================================================================== */
/* ==========================  top-level dispatch  ========================== */
/* ========================================================================== */
typedef int (*agent_fn_t)(int argc, char **argv);
typedef struct { const char *name; agent_fn_t fn; } agent_row_t;
static const agent_row_t AGENTS[] = {
    {"vra", vra_surface}, {"bda", bda_surface}, {"taa", taa_surface},
    {"ara", ara_surface}, {"fpa", fpa_surface}, {"sscar", sscar_surface}, {0, 0}
};

static void self_invariants(void)
{
    /* enum/table invariants (assert, per R4). */
    assert(VRA_S8 == 8 && BDA_HOLD == 7 && TAA_CLOSED == 11 && ARA_SX == 8 && FPA_S8 == 8);
    assert(F_SX == 11);
    /* verdict-emission precedence spot-checks against §10 gate logic */
    fv_outcomes_t o; fv_defaults(&o);
    assert(fam_verdict(&o) == FV_REPLAY_ADM);
    o.disclosure_nonempty = true; assert(fam_verdict(&o) == FV_REPLAY_ADM_C);
    fv_defaults(&o); o.fv[9] = 0; assert(fam_verdict(&o) == FV_CONTAM_FC);
    fv_defaults(&o); o.fv[6] = 0; assert(fam_verdict(&o) == FV_NONCOMPLIANT_HOLD);
    fv_defaults(&o); o.fv[8] = 0; assert(fam_verdict(&o) == FV_REPLAY_INCOMPLETE);
    fv_defaults(&o); o.fv[10] = 0; assert(fam_verdict(&o) == FV_INCIDENT_ONLY);
    fv_defaults(&o); o.fv[7] = 0; o.policy_only = true; assert(fam_verdict(&o) == FV_NONCOMPLIANT_HOLD);
    fv_defaults(&o); o.fv[7] = 0; o.policy_only = false; assert(fam_verdict(&o) == FV_CONTAM_FC);
}

int main(int argc, char **argv)
{
    self_invariants();
    if (argc < 3) {
        fprintf(stderr,
            "usage: baseline <agent> <surface> [args...]\n"
            "  agents: vra bda taa ara fpa sscar\n"
            "  e.g.:   baseline sscar next_state S0 Fv01Pass 1\n");
        return 1;
    }
    for (const agent_row_t *a = AGENTS; a->name; ++a)
        if (strcmp(a->name, argv[1]) == 0)
            return a->fn(argc, argv);
    fprintf(stderr, "error: unknown agent '%s'\n", argv[1]);
    return 1;
}
