/* ============================================================================
 * run_pts.c  —  NNT-FAM-SSCAR-FI-001  conformance runner (c paradigm)
 *
 * Drives the unified family baseline across the PINNED canonical 231-record set
 * (7 suites: VRA PT-*, BDA PTS-BDA-*, TAA TAA-PT-*, TAA VP-GEN-*, ARA ARA-T*,
 * FPA (FPA-T and FPA-D), SSCAR PTS, Annex-C CT), live-executes each non-SKIP
 * record through the toolchain-built baseline, compares captured stdout against
 * the spec-derived oracle, and writes pt_results.json + pt_run_log.txt.
 *
 * RELOCATABLE: resolves the baseline as "baseline.exe" in its own directory
 * (GetModuleFileName) unless overridden by argv[1]; writes its outputs to the
 * current working directory unless overridden by argv[2]. FAILS CLOSED: if the
 * baseline cannot be started it names the missing path, exits non-zero, and
 * writes NO pt_results.json (a ledger of FAILs against a missing baseline is
 * not a reproduction).
 *
 * The runner embeds the fixtures + oracles (it is the oracle); the baseline
 * embeds no test cases. Re-running this runner against the delivered baseline
 * reproduces the delivered pt_results.json statuses.
 *
 * Build (release+strip, clang+lld+mingw sysroot) to the attested path:
 *   clang --target=x86_64-w64-mingw32 --sysroot=<ucrt64> -fuse-ld=lld -O3 -s \
 *        run_pts.c -o run_pts.exe
 * ============================================================================ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#ifdef _WIN32
#include <windows.h>
#define POPEN _popen
#define PCLOSE _pclose
#define PATHSEP '\\'
#else
#define POPEN popen
#define PCLOSE pclose
#define PATHSEP '/'
#endif

/* ----- record table ----------------------------------------------------- */
typedef struct {
    const char *id;
    const char *cat;    /* runnable | parameterized | declarative | connector */
    const char *disp;   /* RUN | SKIP */
    const char *args;   /* baseline args; multiple invocations separated by " ;; " */
    const char *expect; /* required substrings, separated by " && " (all must appear) */
    const char *cite;   /* SKIP only: owning-pack disposition basis (verbatim clause) */
} rec_t;

/* SKIP citation strings (owning-pack disposition surfaces, verbatim fragments) */
#define CITE_TAA20 "TAA Conformance Tests record-kind: \"Declarative conformance claim (not a buyer-runnable unit test)\"; Minimal run note: \"the 1 declarative record (VP-GEN-020 / TAA-PT-020-DECL) is preserved as a buyer obligation rather than a runnable assertion.\""
#define CITE_FPAD  "FPA Conformance Tests §F.D \"Declarative obligations (not locally runnable on the published surface)\"; §H Minimal Run Note: \"Bounded external obligations not locally runnable: FPA-D-01 through FPA-D-06.\""
#define CITE_BDA27 "BDA Conformance Tests §5 Minimal Run Note, 'Bounded external obligations not locally runnable': \"authorized non-validator producer grounding\"."
#define CITE_BDA29 "BDA Conformance Tests §5 Minimal Run Note, 'Bounded external obligations not locally runnable': \"distributed enforcement legitimacy where not exposed by local transition function\"."
#define CITE_SSCAR "SSCAR Conformance Tests §5 closed enumeration: \"7 declarative records (PTS-005, PTS-015, PTS-019, PTS-020, PTS-027, plus the verdict-layer subsets of PTS-004 and PTS-017) are listed in §7 Public Oracles rather than here.\""

static const rec_t RECS[] = {
/* ---------------- VRA  (PT-001..029) ---------------- */
{"PT-001","runnable","RUN","vra next_state S0 StartupComplete 1","state=S1",""},
{"PT-002","runnable","RUN","vra next_state S2 StructuralChecksDone 1","state=S3",""},
{"PT-003","runnable","RUN","vra next_state S3 EligibilityChecksDone 1","state=S4",""},
{"PT-004","runnable","RUN","vra next_state S2 StructuralChecksDone 0","state=S5",""},
{"PT-005","runnable","RUN","vra next_state S2 StructuralChecksDone 0","state=S5",""},
{"PT-006","runnable","RUN","vra next_state S2 StructuralChecksDone 0","state=S5",""},
{"PT-007","runnable","RUN","vra next_state S2 StructuralChecksDone 0","state=S5",""},
{"PT-008","runnable","RUN","vra next_state S3 EligibilityChecksDone 0","state=S5",""},
{"PT-009","runnable","RUN","vra next_state S3 EligibilityChecksDone 0","state=S5",""},
{"PT-010","runnable","RUN","vra next_state S0 StartupComplete 0","state=S5",""},
{"PT-011","runnable","RUN","vra next_state S3 RollbackDetected 1","state=S5",""},
{"PT-012","runnable","RUN","vra next_state S5 WalReplayNeeded 1","state=S7",""},
{"PT-013","runnable","RUN","vra next_state S3 ToolStateInvalid 1","state=S6",""},
{"PT-014","runnable","RUN","vra next_state S3 ToolStateInvalid 1 ;; vra next_state S3 EligibilityChecksDone 1","state=S6 && state=S4",""},
{"PT-015","runnable","RUN","vra next_state S6 StartupComplete 1","state=S6",""},
{"PT-016","runnable","RUN","vra evidence chain","validator_bundle_id && verified_head_digest && snapshot_id",""},
{"PT-017","runnable","RUN","vra evidence freshness","validator_bundle_id && verified_head_digest && snapshot_id && policy_id && source_id && freshness_value && irr_digest && tool_activation_status",""},
{"PT-018","runnable","RUN","vra evidence parse","failure_code && failed_validator && suppression_status",""},
{"PT-019","runnable","RUN","vra evidence recovery","recovery_phase && recovery_phase_producer",""},
{"PT-020","runnable","RUN","vra evidence readmission","readmission_token_id",""},
{"PT-021","runnable","RUN","vra evidence frame","validator_bundle_id_producer=ExecutionLayer && failure_explanation_producer=GateLogic && tool_activation_status_producer=ToolGate",""},
{"PT-022","runnable","RUN","vra vocab verdict_vs_state","distinct=1",""},
{"PT-023","runnable","RUN","vra vocab negative","distinct=1",""},
{"PT-024","parameterized","RUN","vra next_state S8 AuthorityRelease 1","state=S1",""},
{"PT-025","runnable","RUN","vra evidence freshness","freshness_value && policy_id && failed_validator=V_FRESHNESS",""},
{"PT-026","runnable","RUN","vra evidence recovery","recovery_phase && recovery_phase_producer=V_WAL_PHASE",""},
{"PT-027","runnable","RUN","vra next_state S3 ToolStateInvalid 1","state=S6",""},
{"PT-028","declarative","RUN","vra attest V_COMPAT","enforcement_point=import_admissibility && evidence=present",""},
{"PT-029","declarative","RUN","vra attest V_WRITER_LOCK","writer_lock_status=recorded && evidence=present",""},

/* ---------------- BDA  (PTS-BDA-001..036) ---------------- */
{"PTS-BDA-001","runnable","RUN","bda next_state IDLE INPUT_RECEIVED 1","state=INGEST_VALIDATE",""},
{"PTS-BDA-002","runnable","RUN","bda next_state INGEST_VALIDATE VALIDATION_PASS 1","state=FILTER_REVIEW",""},
{"PTS-BDA-003","runnable","RUN","bda next_state FILTER_REVIEW NO_ESCALATION 1","state=READY_FOR_RELEASE",""},
{"PTS-BDA-004","runnable","RUN","bda next_state FINALIZATION_REVIEW EVIDENCE_OK 1","state=IDLE",""},
{"PTS-BDA-005","runnable","RUN","bda next_state INGEST_VALIDATE VALIDATION_FAIL 1","state=OUTPUT_BLOCKED && verdict=BLOCK",""},
{"PTS-BDA-006","runnable","RUN","bda next_state FILTER_REVIEW TOOL_STATE_DETECTED 1","state=TOOL_STATE_QUARANTINED && verdict=QUARANTINE",""},
{"PTS-BDA-007","runnable","RUN","bda next_state INGEST_VALIDATE VALIDATION_FAIL 1","state=OUTPUT_BLOCKED && verdict=BLOCK",""},
{"PTS-BDA-008","runnable","RUN","bda next_state TOOL_STATE_QUARANTINED APPROVAL_GRANTED 0","state=TOOL_STATE_QUARANTINED",""},
{"PTS-BDA-009","runnable","RUN","bda decide FRESHNESS_REPLAY","state=OUTPUT_BLOCKED && verdict=BLOCK",""},
{"PTS-BDA-010","runnable","RUN","bda decide MISSING_RECEIPT","state=OUTPUT_BLOCKED && verdict=BLOCK",""},
{"PTS-BDA-011","declarative","RUN","bda attest conflict_evidence","verdict=BLOCK && conflict_evidence=recorded",""},
{"PTS-BDA-012","runnable","RUN","bda vocab verdict_fidelity","ALLOW_CONSTRAINED && count=7",""},
{"PTS-BDA-013","runnable","RUN","bda next_state FILTER_REVIEW CPW_CRITICAL 1","state=OUTPUT_BLOCKED && verdict=FAIL_CLOSED",""},
{"PTS-BDA-014","runnable","RUN","bda decide VAL01_FAIL ;; bda decide VAL05_FAIL","verdict=BLOCK && verdict=NONCOMPLIANT_HOLD",""},
{"PTS-BDA-015","runnable","RUN","bda next_state FILTER_REVIEW CPW_CRITICAL 1","state=OUTPUT_BLOCKED && verdict=FAIL_CLOSED",""},
{"PTS-BDA-016","runnable","RUN","bda next_state FINALIZATION_REVIEW CPW_CRITICAL 1","state=OUTPUT_BLOCKED",""},
{"PTS-BDA-017","runnable","RUN","bda next_state TOOL_STATE_QUARANTINED CPW_CRITICAL 1","state=OUTPUT_BLOCKED",""},
{"PTS-BDA-018","runnable","RUN","bda next_state OUTPUT_BLOCKED READMISSION_APPROVED 1","state=IDLE && verdict=READMIT",""},
{"PTS-BDA-019","runnable","RUN","bda next_state NONCOMPLIANT_HOLD COMPLIANCE_RESTORED 1","state=IDLE && verdict=READMIT",""},
{"PTS-BDA-020","runnable","RUN","bda next_state OUTPUT_BLOCKED READMISSION_APPROVED 0","state=OUTPUT_BLOCKED",""},
{"PTS-BDA-021","runnable","RUN","bda next_state IDLE INPUT_RECEIVED 1","state=INGEST_VALIDATE",""},
{"PTS-BDA-022","runnable","RUN","bda evidence closure","decision_id && verdict && reason_code && validator_results && statement_refs && input_digest",""},
{"PTS-BDA-023","runnable","RUN","bda evidence mandatory","decision_id && session_id && boundary_side && decision_object && input_digest && policy_hash && validator_results && statement_refs && verdict && reason_code && order_index && hash_prev && hash_curr",""},
{"PTS-BDA-024","runnable","RUN","bda evidence approval","approval_ref",""},
{"PTS-BDA-025","runnable","RUN","bda evidence finalization","evidence_ref && verif_counter_anchor",""},
{"PTS-BDA-026","runnable","RUN","bda evidence rollback","rollback_ref",""},
{"PTS-BDA-027","declarative","SKIP","","",CITE_BDA27},
{"PTS-BDA-028","runnable","RUN","bda next_state READY_FOR_RELEASE CPW_CRITICAL 1","state=OUTPUT_BLOCKED",""},
{"PTS-BDA-029","declarative","SKIP","","",CITE_BDA29},
{"PTS-BDA-030","runnable","RUN","bda vocab fidelity","count=7 && distinct=1",""},
{"PTS-BDA-031","runnable","RUN","bda vocab separation","FAIL_CLOSED!=NONCOMPLIANT_HOLD && OUTPUT_BLOCKED!=NONCOMPLIANT_HOLD",""},
{"PTS-BDA-032","parameterized","RUN","bda param","within_canonical=1",""},
{"PTS-BDA-033","runnable","RUN","bda decide CPW_CRITICAL","state=OUTPUT_BLOCKED && verdict=FAIL_CLOSED",""},
{"PTS-BDA-034","runnable","RUN","bda evidence approval","approval_ref",""},
{"PTS-BDA-035","runnable","RUN","bda next_state FINALIZATION_REVIEW EVIDENCE_OK 1 ;; bda next_state FINALIZATION_REVIEW EVIDENCE_FAIL 1","state=IDLE && state=NONCOMPLIANT_HOLD",""},
{"PTS-BDA-036","declarative","RUN","bda attest projection_limitation","state_route=may_be_shared && verdict_semantics=distinct_downstream",""},

/* ---------------- TAA  (TAA-PT-001..027) ---------------- */
{"TAA-PT-001","runnable","RUN","taa next_state INTAKE INTAKE_TO_ROLE_SCREENING 1","state=ROLE_SCREENING",""},
{"TAA-PT-002","runnable","RUN","taa next_state EVALUATING EVALUATING_TO_CLASSIFYING 1","state=CLASSIFYING",""},
{"TAA-PT-003","runnable","RUN","taa next_state DECIDED DECIDED_TO_HANDOFF_READY 1","state=HANDOFF_READY",""},
{"TAA-PT-004","runnable","RUN","taa next_state EVALUATING EVALUATING_TO_CLASSIFYING 0","state=FAIL_CLOSED",""},
{"TAA-PT-005","runnable","RUN","taa evidence allow_constrained","conflict_check_mode && residual_risk_statement",""},
{"TAA-PT-006","runnable","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ESCALATE_DECISION 1 ;; taa evidence fail_closed","state=DECIDED && verdict=ESCALATE && escalation_request_ref",""},
{"TAA-PT-007","runnable","RUN","taa next_state ROLE_SCREENING ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING 1","state=CANONICALIZING",""},
{"TAA-PT-008","runnable","RUN","taa next_state CLASSIFYING CLASSIFYING_TO_DENY_DECISION 1 ;; taa next_state EVALUATING EVALUATING_TO_FAIL_CLOSED 1","state=DECIDED && state=FAIL_CLOSED",""},
{"TAA-PT-009","runnable","RUN","taa next_state INTAKE STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"TAA-PT-010","runnable","RUN","taa next_state CLASSIFYING POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"TAA-PT-011","runnable","RUN","taa next_state EVALUATING CONFLICT_CHECKING_TO_ALLOW_DECISION 1","state=FAIL_CLOSED",""},
{"TAA-PT-012","runnable","RUN","taa next_state FAIL_CLOSED FAIL_CLOSED_TO_NONCOMPLIANT_HOLD 1 ;; taa next_state NONCOMPLIANT_HOLD NONCOMPLIANT_HOLD_TO_READMISSION_PENDING 1","state=NONCOMPLIANT_HOLD && state=READMISSION_PENDING",""},
{"TAA-PT-013","runnable","RUN","taa next_state READMISSION_PENDING READMISSION_PENDING_TO_ROLE_SCREENING 1","state=ROLE_SCREENING",""},
{"TAA-PT-014","runnable","RUN","taa next_state CLOSED ANY_NON_REOPEN 1","state=CLOSED",""},
{"TAA-PT-015","runnable","RUN","taa evidence closure","semantic_closure && evidence_closure && failure_closure && policy_snapshot_closure",""},
{"TAA-PT-016","runnable","RUN","taa evidence base","decision_id && statement_id_list && verdict && reason_code && tsa_label && source_class && boundary_validated_role && policy_snapshot_id && scope_id && turn_id && order_ref",""},
{"TAA-PT-017","runnable","RUN","taa evidence allow_constrained","conflict_check_mode && conflict_check_strength && conflict_check_confidence && conflict_check_coverage_scope && compared_claim_set_ref && residual_risk_statement",""},
{"TAA-PT-018","runnable","RUN","taa evidence fail_closed","request_id && failure_ref && required_actor_role && required_evidence && status",""},
{"TAA-PT-019","runnable","RUN","taa next_state DECIDED CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"TAA-PT-020","declarative","SKIP","","",CITE_TAA20},
{"TAA-PT-021","runnable","RUN","taa vocab verdict_set","count=6 && reclassify=action_not_verdict",""},
{"TAA-PT-022","runnable","RUN","taa next_state ROLE_SCREENING ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING 1 ;; taa next_state ROLE_SCREENING ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION 1","state=CANONICALIZING && state=DECIDED && verdict=OUT_OF_SCOPE",""},
{"TAA-PT-023","parameterized","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_DENY_DECISION 1 ;; taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_FAIL_CLOSED 1","verdict=DENY && state=FAIL_CLOSED",""},
{"TAA-PT-024","runnable","RUN","taa next_state EVALUATING EVALUATING_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"TAA-PT-025","runnable","RUN","taa evidence allow_constrained","conflict_check_mode && residual_risk_statement",""},
{"TAA-PT-026","runnable","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_DECISION 1","state=DECIDED",""},
{"TAA-PT-027","runnable","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_DECISION 1 ;; taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_DENY_DECISION 1 ;; taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ESCALATE_DECISION 1","verdict=ALLOW && verdict=DENY && verdict=ESCALATE && state=DECIDED",""},

/* ---------------- TAA VP-GEN sub-suite (VP-GEN-001..027) ---------------- */
{"VP-GEN-001","runnable","RUN","taa next_state INTAKE INTAKE_TO_ROLE_SCREENING 1","state=ROLE_SCREENING",""},
{"VP-GEN-002","runnable","RUN","taa next_state EVALUATING EVALUATING_TO_CLASSIFYING 1","state=CLASSIFYING",""},
{"VP-GEN-003","runnable","RUN","taa next_state DECIDED DECIDED_TO_HANDOFF_READY 1","state=HANDOFF_READY",""},
{"VP-GEN-004","runnable","RUN","taa next_state EVALUATING EVALUATING_TO_CLASSIFYING 0","state=FAIL_CLOSED",""},
{"VP-GEN-005","runnable","RUN","taa evidence allow_constrained","conflict_check_mode && residual_risk_statement",""},
{"VP-GEN-006","runnable","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ESCALATE_DECISION 1 ;; taa evidence fail_closed","state=DECIDED && verdict=ESCALATE && escalation_request_ref",""},
{"VP-GEN-007","runnable","RUN","taa next_state ROLE_SCREENING ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING 1","state=CANONICALIZING",""},
{"VP-GEN-008","runnable","RUN","taa next_state CLASSIFYING CLASSIFYING_TO_DENY_DECISION 1 ;; taa next_state EVALUATING EVALUATING_TO_FAIL_CLOSED 1","state=DECIDED && state=FAIL_CLOSED",""},
{"VP-GEN-009","runnable","RUN","taa next_state INTAKE STRUCTURAL_INCOMPLETENESS_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"VP-GEN-010","runnable","RUN","taa next_state CLASSIFYING POLICY_SNAPSHOT_DRIFT_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"VP-GEN-011","runnable","RUN","taa next_state EVALUATING CONFLICT_CHECKING_TO_ALLOW_DECISION 1","state=FAIL_CLOSED",""},
{"VP-GEN-012","runnable","RUN","taa next_state FAIL_CLOSED FAIL_CLOSED_TO_NONCOMPLIANT_HOLD 1 ;; taa next_state NONCOMPLIANT_HOLD NONCOMPLIANT_HOLD_TO_READMISSION_PENDING 1","state=NONCOMPLIANT_HOLD && state=READMISSION_PENDING",""},
{"VP-GEN-013","runnable","RUN","taa next_state READMISSION_PENDING READMISSION_PENDING_TO_ROLE_SCREENING 1","state=ROLE_SCREENING",""},
{"VP-GEN-014","runnable","RUN","taa next_state CLOSED ANY_NON_REOPEN 1","state=CLOSED",""},
{"VP-GEN-015","runnable","RUN","taa evidence closure","semantic_closure && evidence_closure && failure_closure && policy_snapshot_closure",""},
{"VP-GEN-016","runnable","RUN","taa evidence base","decision_id && statement_id_list && verdict && reason_code && tsa_label && source_class && boundary_validated_role && policy_snapshot_id && scope_id && turn_id && order_ref",""},
{"VP-GEN-017","runnable","RUN","taa evidence allow_constrained","conflict_check_mode && conflict_check_strength && conflict_check_confidence && conflict_check_coverage_scope && compared_claim_set_ref && residual_risk_statement",""},
{"VP-GEN-018","runnable","RUN","taa evidence fail_closed","request_id && failure_ref && required_actor_role && required_evidence && status",""},
{"VP-GEN-019","runnable","RUN","taa next_state DECIDED CLEARANCE_ARTIFACT_MISSING_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"VP-GEN-020","declarative","SKIP","","",CITE_TAA20},
{"VP-GEN-021","runnable","RUN","taa vocab verdict_set","count=6 && reclassify=action_not_verdict",""},
{"VP-GEN-022","runnable","RUN","taa next_state ROLE_SCREENING ROLE_SCREENING_RECLASSIFY_TO_CANONICALIZING 1 ;; taa next_state ROLE_SCREENING ROLE_SCREENING_TO_OUT_OF_SCOPE_DECISION 1","state=CANONICALIZING && state=DECIDED && verdict=OUT_OF_SCOPE",""},
{"VP-GEN-023","parameterized","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_DENY_DECISION 1 ;; taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_FAIL_CLOSED 1","verdict=DENY && state=FAIL_CLOSED",""},
{"VP-GEN-024","runnable","RUN","taa next_state EVALUATING EVALUATING_TO_FAIL_CLOSED 1","state=FAIL_CLOSED",""},
{"VP-GEN-025","runnable","RUN","taa evidence allow_constrained","conflict_check_mode && residual_risk_statement",""},
{"VP-GEN-026","runnable","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_DECISION 1","state=DECIDED",""},
{"VP-GEN-027","runnable","RUN","taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ALLOW_DECISION 1 ;; taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_DENY_DECISION 1 ;; taa next_state CONFLICT_CHECKING CONFLICT_CHECKING_TO_ESCALATE_DECISION 1","verdict=ALLOW && verdict=DENY && verdict=ESCALATE && state=DECIDED",""},

/* ---------------- ARA  (ARA-T001..027) ---------------- */
{"ARA-T001","runnable","RUN","ara next_state S0_INGESTED EV_PARSE_OK 1","state=S1",""},
{"ARA-T002","runnable","RUN","ara next_state S2_VERIFIED replay_fold_complete 1","state=S3",""},
{"ARA-T003","runnable","RUN","ara next_state S4_CHECKPOINT_RESOLVED EV_REPORT_BOUND 1","state=S5",""},
{"ARA-T004","runnable","RUN","ara next_state S2_VERIFIED EV_SIGNATURE_FAIL 1 ;; ara next_state S2_VERIFIED EV_CHAIN_BREAK 0","state=SX && chain_status=BROKEN",""},
{"ARA-T005","runnable","RUN","ara decide REPORT_INSUFFICIENT","finalization=blocked",""},
{"ARA-T006","runnable","RUN","ara next_state S2_VERIFIED EV_EVIDENCE_FAIL 1","state=SH",""},
{"ARA-T007","runnable","RUN","ara decide CHECKPOINT_UNVERIFIED","rollback=INVALID",""},
{"ARA-T008","runnable","RUN","ara next_state S2_VERIFIED EV_SIGNATURE_FAIL 1 ;; ara next_state S2_VERIFIED EV_CHAIN_BREAK 1 ;; ara next_state S2_VERIFIED EV_COUNTER_REPLAY 1","state=SX && chain_status=BROKEN && state=SH",""},
{"ARA-T009","runnable","RUN","ara next_state S2_VERIFIED EV_SIGNATURE_FAIL 1","state=SX",""},
{"ARA-T010","runnable","RUN","ara next_state S4_CHECKPOINT_RESOLVED EV_CHAIN_BREAK 0","state=SX && chain_status=BROKEN",""},
{"ARA-T011","runnable","RUN","ara next_state S3_RECONSTRUCTED EV_SIGNATURE_FAIL 1 ;; ara next_state S3_RECONSTRUCTED EV_EVIDENCE_FAIL 1","state=SX && state=SH",""},
{"ARA-T012","runnable","RUN","ara next_state SH_HOLD_ACTIVE EV_READMISSION_GRANTED 1","state=S6",""},
{"ARA-T013","runnable","RUN","ara next_state SH_HOLD_ACTIVE EV_READMISSION_GRANTED 0","state=SH",""},
{"ARA-T014","runnable","RUN","ara next_state S5_REPORT_READY OUT_OF_ORDER_POSITIVE 1","state=S5",""},
{"ARA-T015","runnable","RUN","ara evidence final","report_signature",""},
{"ARA-T016","runnable","RUN","ara evidence base","bundle_digest && validator_outcomes && hash_continuity_refs && checkpoint_refs && rollback_refs",""},
{"ARA-T017","runnable","RUN","ara evidence hold","hold_enter_refs && hold_exit_refs && anchor_update_ref",""},
{"ARA-T018","runnable","RUN","ara evidence base","validator_outcomes && report_fields_ref",""},
{"ARA-T019","declarative","RUN","ara gate V10","gate=QUARANTINE && admitted_to_reconstruction=no",""},
{"ARA-T020","declarative","RUN","ara attest distributed","orphaned=0",""},
{"ARA-T021","runnable","RUN","ara vocab fidelity","count=5 && distinct=1",""},
{"ARA-T022","runnable","RUN","ara vocab separation","BROKEN!=REJECTED && SX!=SH && INCIDENT_ONLY!=FAIL_CLOSED",""},
{"ARA-T023","parameterized","RUN","ara param","within_envelope=1",""},
{"ARA-T024","runnable","RUN","ara next_state S3_RECONSTRUCTED EV_LASTCLEAN_FOUND 1","state=S4",""},
{"ARA-T025","runnable","RUN","ara evidence hold","hold_exit_refs && anchor_update_ref",""},
{"ARA-T026","runnable","RUN","ara next_state S4_CHECKPOINT_RESOLVED EV_REPORT_BOUND 1","state=S5",""},
{"ARA-T027","declarative","RUN","ara attest transparent","classification=transparent && collapse=none",""},

/* ---------------- FPA  (FPA-T-* / FPA-D-*) ---------------- */
{"FPA-D-01","declarative","SKIP","","",CITE_FPAD},
{"FPA-D-02","declarative","SKIP","","",CITE_FPAD},
{"FPA-D-03","declarative","SKIP","","",CITE_FPAD},
{"FPA-D-04","declarative","SKIP","","",CITE_FPAD},
{"FPA-D-05","declarative","SKIP","","",CITE_FPAD},
{"FPA-D-06","declarative","SKIP","","",CITE_FPAD},
{"FPA-T-01","runnable","RUN","fpa next_state IDLE TransferPacketReceived 1","state=RECEIVED",""},
{"FPA-T-02","runnable","RUN","fpa next_state RECEIVED StructureValid 1","state=VERIFIED",""},
{"FPA-T-03","runnable","RUN","fpa next_state RESTORATION_ELIGIBLE RestoreAdmitted 1","state=IDLE",""},
{"FPA-T-04","runnable","RUN","fpa next_state RECEIVED StructureValid 0 ;; fpa next_state RECEIVED StructureInvalid 1","state=REJECTED",""},
{"FPA-T-06","runnable","RUN","fpa next_state VERIFIED EvidencePending 0","state=QUARANTINED",""},
{"FPA-T-08a","runnable","RUN","fpa next_state VERIFIED FreshnessFail 1","state=REJECTED",""},
{"FPA-T-08b","runnable","RUN","fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed 0","state=REJECTED",""},
{"FPA-T-08c","runnable","RUN","fpa vocab taxonomy","REJECT!=FAIL_CLOSED",""},
{"FPA-T-09","runnable","RUN","fpa next_state VERIFIED FreshnessPass 0","state=REJECTED",""},
{"FPA-T-10","runnable","RUN","fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed 0","state=REJECTED",""},
{"FPA-T-11","runnable","RUN","fpa next_state IRR_COMMITTED FreshnessPass 1","state=REJECTED",""},
{"FPA-T-12","runnable","RUN","fpa next_state QUARANTINED ReadmissionApproved 1","state=VERIFIED",""},
{"FPA-T-13a","runnable","RUN","fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed 1","state=RESTORATION_ELIGIBLE",""},
{"FPA-T-13b","runnable","RUN","fpa next_state RESTORATION_ELIGIBLE RestoreAdmitted 1","state=IDLE",""},
{"FPA-T-14","runnable","RUN","fpa next_state REJECTED FreshnessPass 1","state=REJECTED",""},
{"FPA-T-15","runnable","RUN","fpa evidence deny_restore","reason_code=DENY_RESTORE && semantic_verdict=FAIL_CLOSED && gate_class=BLOCK",""},
{"FPA-T-16","runnable","RUN","fpa evidence accept","semantic_verdict=ACCEPT && gate_class=RELEASE && decision_id && packet_hash",""},
{"FPA-T-17A","parameterized","RUN","fpa param tvc","tvc_validation_result=Some",""},
{"FPA-T-17B","parameterized","RUN","fpa param evidence","evidence_validation_result=Some",""},
{"FPA-T-17C","parameterized","RUN","fpa param transport","transport_validation_result=Some",""},
{"FPA-T-17D","runnable","RUN","fpa evidence receipt_linkage","irr_digest && prev_receipt_digest",""},
{"FPA-T-18","runnable","RUN","fpa evidence accept","decision_id && gate_class && watermark_before",""},
{"FPA-T-21","runnable","RUN","fpa vocab labels","verdict_RESTORATION_ELIGIBLE!=state_S6",""},
{"FPA-T-23","parameterized","RUN","fpa param recoverable","when_true=EvidencePending->S7_QUARANTINED",""},
{"FPA-T-24","runnable","RUN","fpa next_state VERIFIED FreshnessPass 1","state=FRESHNESS_ELIGIBLE",""},
{"FPA-T-25","parameterized","RUN","fpa param quarantine_evidence","verdict=QUARANTINE && gate_class=ESCALATION",""},
{"FPA-T-26","runnable","RUN","fpa next_state FRESHNESS_ELIGIBLE IRRAppended 1","state=IRR_COMMITTED",""},
{"FPA-T-PR-01","runnable","RUN","fpa next_state VERIFIED FreshnessFail 1","state=REJECTED",""},
{"FPA-T-PR-02","runnable","RUN","fpa next_state FRESHNESS_ELIGIBLE IRRAppended 1 ;; fpa next_state IRR_COMMITTED WatermarkPersisted 1 ;; fpa next_state FRESHNESS_ELIGIBLE WatermarkPersisted 1","state=IRR_COMMITTED && state=WATERMARK_COMMITTED && state=REJECTED",""},
{"FPA-T-PR-03","runnable","RUN","fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed 1","state=RESTORATION_ELIGIBLE",""},
{"FPA-T-PR-09","runnable","RUN","fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed 1 ;; fpa next_state WATERMARK_COMMITTED RestoreRequest_GenesisConfirmed 0","state=RESTORATION_ELIGIBLE && state=REJECTED",""},
{"FPA-T-PR-10","runnable","RUN","fpa next_state IDLE RestoreAdmitted 1","state=REJECTED",""},
{"FPA-T-PR-12","runnable","RUN","fpa next_state QUARANTINED ReadmissionApproved 1 ;; fpa next_state IDLE ReadmissionApproved 1","state=VERIFIED && state=REJECTED",""},
{"FPA-T-PR-13","runnable","RUN","fpa next_state VERIFIED FreshnessPass 1 ;; fpa next_state FRESHNESS_ELIGIBLE IRRAppended 1","state=FRESHNESS_ELIGIBLE && state=IRR_COMMITTED",""},
{"FPA-T-PR-14","runnable","RUN","fpa next_state IRR_COMMITTED WatermarkPersisted 0","state=REJECTED",""},

/* ---------------- SSCAR integrator  (PTS-*) ---------------- */
{"PTS-001","runnable","RUN","sscar next_state S0 Fv01Pass 1","state=S1",""},
{"PTS-002","runnable","RUN","sscar next_state S2 Fv03Pass 1","state=S3",""},
{"PTS-003","runnable","RUN","sscar next_state S7 FamilyVerdictIssued 1 ;; sscar verdict full_closure ;; sscar foc FOC-01","state=S8 && verdict=REPLAY_ADMISSIBLE && family_decision_id",""},
{"PTS-004a","runnable","RUN","sscar next_state S1 Fv02AndFv04Pass 0","state=SX",""},
{"PTS-004b","runnable","RUN","sscar next_state S2 UnlabeledMechanismLevelCarriedClaim 0","state=SX",""},
{"PTS-005","declarative","SKIP","","",CITE_SSCAR},
{"PTS-006","runnable","RUN","sscar next_state S3 FreshnessReplay 0 ;; sscar verdict fv06_fail ;; sscar foc FOC-05","state=SH && verdict=NONCOMPLIANT_HOLD && hold_enter_refs",""},
{"PTS-007","parameterized","RUN","sscar param fv04_reclass","family_flow=blocks_at_S2 && verdict_change=none",""},
{"PTS-008","runnable","RUN","sscar next_state S3 FreshnessReplay 0 ;; sscar next_state S3 CriticalContamination 0","state=SH && state=SX",""},
{"PTS-009","runnable","RUN","sscar next_state S3 CriticalContamination 0 ;; sscar next_state S5 CriticalContamination 0 ;; sscar next_state S0 CriticalContamination 0","state=SX",""},
{"PTS-010","runnable","RUN","sscar next_state S5 AntiRollbackFailure 0","state=SX",""},
{"PTS-011","runnable","RUN","sscar next_state S3 ChainBreak 0 ;; sscar next_state S3 UntrustedAnchorPromoted 0","state=SX",""},
{"PTS-012","runnable","RUN","sscar next_state SH HoldCaseWithNewFamilyClosureBundleAndAnchorUpdate 1","state=SR",""},
{"PTS-013","runnable","RUN","sscar next_state SR ReadmissionBundleChangedCarriedPayload 1","state=S2",""},
{"PTS-014","runnable","RUN","sscar next_state S8 Handoff 1 ;; sscar next_state SX IncidentOnlyOutput 1","state=S8 && state=SX",""},
{"PTS-015","declarative","SKIP","","",CITE_SSCAR},
{"PTS-016","runnable","RUN","sscar evidence all","family_decision_id && boundary_event_id && family_validator_outcomes && report_signature",""},
{"PTS-017a","runnable","RUN","sscar foc FOC-04","tsa_refs && blocked_stage && contaminating_ref_set",""},
{"PTS-017b","runnable","RUN","sscar foc FOC-05","freshness_before && freshness_after && hold_enter_refs",""},
{"PTS-017d","runnable","RUN","sscar foc FOC-05","hold_exit_refs && anchor_update_ref=strictly_increasing",""},
{"PTS-018","runnable","RUN","sscar foc FOC-04 ;; sscar foc FOC-05","incident_id && hold_case_id",""},
{"PTS-019","declarative","SKIP","","",CITE_SSCAR},
{"PTS-020","declarative","SKIP","","",CITE_SSCAR},
{"PTS-021","runnable","RUN","sscar vocab types","FamilyWorkflowState!=FamilyNormativeVerdict && type_disjoint=1",""},
{"PTS-022","runnable","RUN","sscar next_state S3 FreshnessReplay 0 ;; sscar verdict fv06_fail ;; sscar next_state S3 CriticalContamination 0 ;; sscar verdict fv09_fail","state=SH && verdict=NONCOMPLIANT_HOLD && state=SX && verdict=CONTAMINATION_FAIL_CLOSED",""},
{"PTS-023","parameterized","RUN","sscar param sr_reentry","carried_payload->S2 && policy_snapshot_id->S5 && third_point=forbidden",""},
{"PTS-024","runnable","RUN","sscar derive","state=S5 && dual_source",""},
{"PTS-025","runnable","RUN","sscar next_state S4 AntiRollbackFailure 0 ;; sscar verdict fv07_integrity ;; sscar evidence all","state=SX && verdict=CONTAMINATION_FAIL_CLOSED && rehydration_closure_ref && family_validator_outcomes",""},
{"PTS-026","runnable","RUN","sscar next_state S1 Fv02AndFv04Pass 0","state=SX",""},
{"PTS-027","declarative","SKIP","","",CITE_SSCAR},

/* ---------------- Annex-C Family Connector Tests (CT-01..14) ---------------- */
{"CT-01","connector","RUN","sscar ct CT-01","components=5 && FV-01=pass",""},
{"CT-02","connector","RUN","sscar ct CT-02","verdict=CONTAMINATION_FAIL_CLOSED && blocked_stage=provenance_classification && contaminating_ref_set=populated",""},
{"CT-03","connector","RUN","sscar ct CT-03","FV-02=untrusted_until_verification && advance_past_S2=no",""},
{"CT-04","connector","RUN","sscar ct CT-04","verdict=NONCOMPLIANT_HOLD && hold_enter_refs=populated",""},
{"CT-05","connector","RUN","sscar ct CT-05","FV-05=fail && verdict=REPLAY_INCOMPLETE",""},
{"CT-06","connector","RUN","sscar ct CT-06","verdict=CONTAMINATION_FAIL_CLOSED && anti_rollback=fail",""},
{"CT-07","connector","RUN","sscar ct CT-07","verdict=REPLAY_INCOMPLETE && lineage_complete=no",""},
{"CT-08","connector","RUN","sscar ct CT-08","verdict=REPLAY_ADMISSIBLE && report_signature=present",""},
{"CT-09","connector","RUN","sscar ct CT-09","verdict=CONTAMINATION_FAIL_CLOSED && contaminating_ref_set=populated",""},
{"CT-10","connector","RUN","sscar ct CT-10","state=SR && anchor_update_ref=strict_increase",""},
{"CT-11","connector","RUN","sscar ct CT-11","wellformed=REPLAY_ADMISSIBLE_CONSTRAINED && misclassified=INCIDENT_ONLY",""},
{"CT-12","connector","RUN","sscar ct CT-12","empty_outcomes=emission_blocked && partial_outcomes_verdict=INCIDENT_ONLY",""},
{"CT-13","connector","RUN","sscar ct CT-13","reclassification=explicit_or_fail_closed && flow=blocks_at_S2",""},
{"CT-14","connector","RUN","sscar ct CT-14","carried=S2 && rehydration=S5 && third_point=forbidden",""},

{0,0,0,0,0,0}
};

/* ----- helpers ---------------------------------------------------------- */
static char g_baseline[2048];

/* run one baseline invocation; capture stdout into out (cap bytes); return exit code */
static int run_one(const char *args, char *out, size_t cap, int *ran)
{
    char cmd[4096];
    snprintf(cmd, sizeof cmd, "\"%s\" %s", g_baseline, args);
    out[0] = '\0'; *ran = 0;
    FILE *p = POPEN(cmd, "r");
    if (!p) return -2;
    *ran = 1;
    size_t n = 0; int c;
    while ((c = fgetc(p)) != EOF && n + 1 < cap) out[n++] = (char)c;
    out[n] = '\0';
    int rc = PCLOSE(p);
    return rc;
}

static int all_substrings_present(const char *hay, const char *expect_list)
{
    char buf[2048]; strncpy(buf, expect_list, sizeof buf - 1); buf[sizeof buf - 1] = '\0';
    char *save = NULL;
    for (char *tok = buf; ; tok = NULL) {
        char *piece = NULL;
        /* manual split on " && " */
        if (tok) save = tok;
        if (!save || !*save) break;
        char *amp = strstr(save, " && ");
        if (amp) { *amp = '\0'; piece = save; save = amp + 4; }
        else { piece = save; save = NULL; }
        /* trim */
        while (*piece == ' ') ++piece;
        if (*piece && !strstr(hay, piece)) return 0;
        if (!save) break;
    }
    return 1;
}

/* JSON string escape into dst */
static void json_escape(const char *s, char *dst, size_t cap)
{
    size_t j = 0;
    for (size_t i = 0; s[i] && j + 2 < cap; ++i) {
        unsigned char ch = (unsigned char)s[i];
        if (ch == '"' || ch == '\\') { dst[j++] = '\\'; dst[j++] = (char)ch; }
        else if (ch == '\n') { dst[j++] = '\\'; dst[j++] = 'n'; }
        else if (ch == '\r') { /* skip */ }
        else if (ch < 0x20) { dst[j++] = ' '; }
        else dst[j++] = (char)ch;
    }
    dst[j] = '\0';
}

int main(int argc, char **argv)
{
    char owndir[2048] = "";
#ifdef _WIN32
    char self[2048];
    DWORD k = GetModuleFileNameA(NULL, self, sizeof self);
    if (k > 0 && k < sizeof self) {
        strncpy(owndir, self, sizeof owndir - 1);
        char *slash = strrchr(owndir, '\\');
        if (!slash) slash = strrchr(owndir, '/');
        if (slash) *slash = '\0';
    }
#endif
    if (owndir[0] == '\0' && argv[0]) {
        strncpy(owndir, argv[0], sizeof owndir - 1);
        char *slash = strrchr(owndir, PATHSEP);
        if (slash) *slash = '\0'; else owndir[0] = '\0';
    }

    /* baseline: argv[1] override else <owndir>/baseline.exe */
    if (argc > 1 && argv[1][0]) strncpy(g_baseline, argv[1], sizeof g_baseline - 1);
    else if (owndir[0]) snprintf(g_baseline, sizeof g_baseline, "%s%cbaseline.exe", owndir, PATHSEP);
    else strncpy(g_baseline, "baseline.exe", sizeof g_baseline - 1);

    const char *outdir = (argc > 2 && argv[2][0]) ? argv[2] : ".";

    /* FAIL-CLOSED preflight: the baseline must start and answer the sentinel. */
    {
        char probe[4096]; int ran = 0;
        run_one("sscar next_state S0 Fv01Pass 1", probe, sizeof probe, &ran);
        if (!ran || !strstr(probe, "state=S1")) {
            fprintf(stderr,
                "run_pts: FAIL-CLOSED — baseline not startable or wrong sentinel at: %s\n"
                "         (probe output: %.200s)\n"
                "         No pt_results.json written.\n", g_baseline, probe);
            return 3;
        }
    }

    char path_json[4096], path_log[4096];
    snprintf(path_json, sizeof path_json, "%s%cpt_results.json", outdir, PATHSEP);
    snprintf(path_log,  sizeof path_log,  "%s%cpt_run_log.txt",  outdir, PATHSEP);
    FILE *fj = fopen(path_json, "w");
    FILE *fl = fopen(path_log, "a");  /* append-only log */
    if (!fj || !fl) { fprintf(stderr, "run_pts: cannot open output files in %s\n", outdir); return 4; }

    char ts[64];
    { time_t t = time(NULL); struct tm *g = gmtime(&t);
      strftime(ts, sizeof ts, "%Y-%m-%dT%H:%M:%SZ", g); }

    int total = 0, pass = 0, fail = 0, skip = 0, err = 0;
    /* first pass: counts + log + collect rows */
    fprintf(fj, "{\n  \"agent_id\": \"FAM-SSCAR-FI-001\",\n  \"lang\": \"c\",\n");
    fprintf(fj, "  \"test_run_timestamp_utc\": \"%s\",\n", ts);
    fprintf(fj, "  \"execution_mode\": \"live\",\n  \"protocol\": \"buyer-conformance\",\n");
    /* results array written after we know totals -> buffer rows in a temp file approach:
       simpler: write results first into a string table is large; instead emit totals
       with a placeholder is not valid JSON. So: two passes over RECS (table is static). */

    /* pass 1: compute + log + build results text */
    static char results_buf[600000];
    size_t rb = 0;
    char out[8192], esc[16384];

    fprintf(fl, "==== NNT-FAM-SSCAR-FI-001 c acceptance run %s ====\n", ts);
    for (const rec_t *r = RECS; r->id; ++r) {
        total++;
        const char *status;
        char notes[2048] = "";
        if (strcmp(r->disp, "SKIP") == 0) {
            status = "SKIP"; skip++;
            snprintf(notes, sizeof notes, "cited SKIP: %s", r->cite);
            fprintf(fl, "PT-ID: %s\nCOMMAND: (no invocation -- SKIP: %s)\nEXIT_CODE: -1\nSTDOUT_TAIL: (not invoked; see pt_results.json notes)\n\n",
                    r->id, r->cite);
        } else {
            /* split args on " ;; " into up to 6 invocations; concatenate stdout */
            char argsbuf[4096]; strncpy(argsbuf, r->args, sizeof argsbuf - 1); argsbuf[sizeof argsbuf-1]='\0';
            char combined[16384]; combined[0] = '\0';
            char logblock[20000]; int lb = 0;
            lb += snprintf(logblock + lb, sizeof logblock - lb, "PT-ID: %s\n", r->id);
            int any_ran = 0, worst_rc = 0, err_invoke = 0;
            char *save = argsbuf;
            while (save && *save) {
                char *sep = strstr(save, " ;; ");
                char one[4096];
                if (sep) { size_t len = (size_t)(sep - save); if (len >= sizeof one) len = sizeof one - 1;
                           memcpy(one, save, len); one[len] = '\0'; save = sep + 4; }
                else { strncpy(one, save, sizeof one - 1); one[sizeof one-1]='\0'; save = NULL; }
                while (*one == ' ') memmove(one, one+1, strlen(one));
                int ran = 0;
                int rc = run_one(one, out, sizeof out, &ran);
                if (!ran) err_invoke = 1;
                else any_ran = 1;
                if (rc != 0) worst_rc = rc;
                size_t cl = strlen(combined);
                snprintf(combined + cl, sizeof combined - cl, "%s", out);
                /* tail = last 4096 bytes of this invocation's stdout */
                const char *tail = out; size_t ol = strlen(out);
                if (ol > 4096) tail = out + (ol - 4096);
                lb += snprintf(logblock + lb, sizeof logblock - lb,
                               "COMMAND: \"%s\" %s\nEXIT_CODE: %d\nSTDOUT_TAIL: %s\n",
                               g_baseline, one, rc, tail);
                if (lb > (int)sizeof logblock - 2000) break;
            }
            fprintf(fl, "%s\n", logblock);
            if (err_invoke && !any_ran) {
                status = "ERROR"; err++;
                snprintf(notes, sizeof notes, "baseline invocation failed (popen) for args: %s", r->args);
            } else if (all_substrings_present(combined, r->expect)) {
                status = "PASS"; pass++;
                snprintf(notes, sizeof notes, "oracle matched; exit=%d", worst_rc);
            } else {
                status = "FAIL"; fail++;
                char trimmed[300]; strncpy(trimmed, combined, sizeof trimmed - 1); trimmed[sizeof trimmed-1]='\0';
                snprintf(notes, sizeof notes, "oracle [%s] not matched; got: %s", r->expect, trimmed);
            }
        }
        json_escape(notes, esc, sizeof esc);
        rb += snprintf(results_buf + rb, sizeof results_buf - rb,
                       "    {\"id\": \"%s\", \"category\": \"%s\", \"status\": \"%s\", \"notes\": \"%s\"}%s\n",
                       r->id, r->cat, status, esc, (r + 1)->id ? "," : "");
        if (rb > sizeof results_buf - 2000) break;
    }

    fprintf(fj, "  \"totals\": {\"total\": %d, \"pass\": %d, \"fail\": %d, \"skip\": %d, \"error\": %d},\n",
            total, pass, fail, skip, err);
    fprintf(fj, "  \"results\": [\n%s  ]\n}\n", results_buf);
    fclose(fj); fclose(fl);

    printf("run_pts: total=%d pass=%d fail=%d skip=%d error=%d\n", total, pass, fail, skip, err);
    printf("run_pts: wrote %s and %s\n", path_json, path_log);
    return 0;
}
