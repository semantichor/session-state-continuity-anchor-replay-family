Annex A — Producer-Consumer Manifest

Session State Continuity \& Anchor Replay Family Integrator

Buyer-facing implementation reference

# Document Information

| Field | Value |
| --- | --- |
| Document class | Annex — buyer-facing implementation reference |
| Audience | Implementers integrating the family package |
| Language | English |
| Status | Execution-neutral; standalone; binds to the family integrator public specification |
| Integrator | Session State Continuity \& Anchor Replay Family Integrator (FAM-SSCAR-FI-001), package version 1.1.0 |
| Family components covered | Audit Replay Agent (ARA); Boundary Defense Agent (BDA); Freshness Portability Agent (FPA); Truth Arbitration Agent (TAA); Verified Rehydration Agent (VRA) |
| Version date | 12 May 2026 |

# 1. Purpose and Use

This document maps each family-level validator of the Session State Continuity \& Anchor Replay Family Integrator to the component that produces the data it consumes, the canonical field consumed, the pass condition, the failure mode that applies when the condition is not met, and the implementation obligations that follow.

The manifest is execution-neutral. It does not prescribe a stack, a deployment topology, or a cryptographic suite. It describes the wiring that must hold for the family integrator to compose a valid replay-admissibility verdict over its five components.

This annex is non-additive and non-modificative with respect to the family integrator specification: the producer-consumer relationships described here are read from the public specification of each component and from the family validator catalogue of the integrator. The annex explicates the wiring; it does not redefine it.

# 2. Validator-to-Producer Matrix

Each row of the matrix below corresponds to one family-level validator (FV-01..FV-12) of the family integrator. For each validator, the row identifies the component that produces the consumed field or output, the canonical field name, the pass condition, the failure mode, and the family decision object that the validator supports.

| Row | Validator ID | Producer component | Produced field / output | Consumed pass condition | Failure mode | Family decision object | Implementation obligation |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | FV-01 Required Control Coverage | Family Integrator (composition gate over the component set) | Component set declaration: five family components admitted (ARA, BDA, FPA, TAA, VRA), each accompanied by its public specification. | All required continuity-control domains are present, coherent, and admitted for family use. | Block integrator issuance — the family integrator does not advance past intake. | Family pack admission (intake → source coverage admitted). | Implementers must validate the family component set is closed and complete before any downstream evaluation. |
| 2 | FV-02 Boundary Input Contract | Boundary Defense Agent | Boundary contract enforcement over anchor document reference and carried payload; tool-state quarantine; statement-record gating with tsa\_label and source\_class. | The anchor document and the carried payload satisfy the family continuity intake contract and remain untrusted until verification closes. | CONTAMINATION\_FAIL\_CLOSED — boundary revalidation; integrator blocks until closure. | Carried claim set admissibility; anchor document boundary admissibility; contamination case. | Implementers must wire the boundary defense component as the sole authority for anchor document and carried payload admission. |
| 3 | FV-03 Carried Claim Provenance Admissibility | Truth Arbitration Agent | statement\_id, tsa\_label, source\_class, and policy-compatible provenance fields for each carried claim. | Carried claims have statement identity, tsa\_label, source\_class, and policy-compatible provenance. | CONTAMINATION\_FAIL\_CLOSED or REPLAY\_INCOMPLETE, depending on the labeling defect class. | Carried claim set admissibility; session replay admissibility. | Implementers must declare policy\_snapshot\_id explicitly. The policy-compatibility check has bounded openness in policy snapshot scope; the implementer chooses the admitted source\_class set per policy. |
| 4 | FV-04 Boundary Role Consistency | Boundary Defense Agent + Truth Arbitration Agent | boundary\_validated\_role; explanatory-only vs mechanism-level reclassification flag; crash-proximity-warning risk band; authority-model assignment. | Explanatory-only payload is not consumed as mechanism-level material without explicit reclassification. | FAIL\_CLOSED, or a local-reclassification step; the family flow blocks until closure. | Carried claim set admissibility; contamination case. | Bounded handoff obligation: implementers may extend the reclassification policy without breaking the semantic core. Reclassification must be explicit, never implicit. |
| 5 | FV-05 Accepted Head / IRR Linkage | Freshness Portability Agent | accepted\_head\_digest; linked\_irr\_digest; integrity-receipt-record anchoring chain. | accepted\_head\_digest is linked to the latest valid integrity receipt record. | REPLAY\_INCOMPLETE — verdict-emission-layer signal. | Accepted anchor state; verified rehydration closure. | Implementers must emit REPLAY\_INCOMPLETE explicitly at the verdict-emission layer when linkage is broken. A workflow projection that returns the state object cannot directly signal a verdict-layer token; non-advancement is the projection-correct signal. |
| 6 | FV-06 Freshness / Anchor Strict Increase | Freshness Portability Agent | freshness\_before, freshness\_after, anchor\_update\_ref; strict-increase watermark. | The anchor is strictly increasing and compatible with the local continuity watermark. | NONCOMPLIANT\_HOLD — enter the hold state; readmission requires anchor\_update\_ref. | Accepted anchor state. | Implementers must emit NONCOMPLIANT\_HOLD explicitly at the verdict-emission layer when the freshness/anchor cluster signals stagnation, regression, or watermark divergence. |
| 7 | FV-07 Verified Rehydration Closure | Verified Rehydration Agent | rehydration\_closure\_ref; read-only startup flag; snapshot stability witness; anti-rollback chain; policy\_snapshot\_id. | Read-only startup, snapshot stability, anti-rollback, chain or signature checks, and policy prerequisites all pass. | CONTAMINATION\_FAIL\_CLOSED or NONCOMPLIANT\_HOLD, depending on the prerequisite class. | Verified rehydration closure; session replay admissibility. | Implementers must emit CONTAMINATION\_FAIL\_CLOSED at the verdict-emission layer when anti-rollback fails or the chain breaks. Anti-rollback failure is not a recoverable hold. |
| 8 | FV-08 Replay Reconstruction Sufficiency | Audit Replay Agent | checkpoint\_refs; rollback\_refs; replay\_refs; report sufficiency. | Checkpoint reconstruction, rollback reconstruction, and report sufficiency support family replay. | REPLAY\_INCOMPLETE — verdict-emission-layer signal; projection signals via non-advancement. | Replay continuity bundle; session replay admissibility. | Implementers must emit REPLAY\_INCOMPLETE at the verdict-emission layer when the lineage is incomplete. Host timestamps must not substitute for replay/checkpoint/rollback references. |
| 9 | FV-09 Contamination Absence | All five family components (cross-component evaluation) | contamination\_flags; contaminating\_ref\_set; blocked\_stage. The boundary defense component and the truth arbitration component are the primary contamination sources; the verified rehydration, freshness portability, and audit replay components are the secondary contamination signals. | No unauthorized artifact and no inadmissible carried claim influences the verdict. | CONTAMINATION\_FAIL\_CLOSED — enter the contamination-fail-closed state; no replay admission token is emitted. | Contamination case; session replay admissibility. | Implementers must emit a contamination incident notice with non-empty contaminating\_ref\_set and a non-empty blocked\_stage before entering the contamination-fail-closed state. |
| 10 | FV-10 Disclosure Class Preservation | Truth Arbitration Agent + Audit Replay Agent | disclosure\_class\_entries; distinct classification of carried openness vs defect. | Every carried openness or defect is classified and preserved distinctly. | INCIDENT\_ONLY — the report is blocked; the replay admission token is withheld. | Continuity disclosure class; session replay admissibility. | Implementers must emit INCIDENT\_ONLY explicitly at the verdict-emission layer when a disclosure-class collapse is detected (true defects, bounded openness, and bounded handoff obligations must not be conflated). |
| 11 | FV-11 Family Evidence Closure | Family Integrator (composition closure across all components) | family\_validator\_outcomes; boundary event evidence report; report\_signature; export\_manifest\_ref. | The family validator bundle and the boundary event evidence report are sufficient for offline reconstruction. | INCIDENT\_ONLY — fail-closed at the evidence layer. | Session replay admissibility (final emission gate before replay admitted). | Implementers must populate family\_validator\_outcomes before any family verdict emission. No verdict exists without a complete validator-outcomes bundle. |
| 12 | FV-12 Family Readmission Closure | Freshness Portability Agent + Family Integrator | hold\_exit\_refs; anchor\_update\_ref; policy stability witness. | hold\_exit\_refs, anchor\_update\_ref, and policy stability are present for readmission. | NONCOMPLIANT\_HOLD — readmission denied; remain in the hold state. | Session replay admissibility (hold → readmission review transition). | Bounded handoff obligation — re-entry envelope: when the carried payload, anchor document reference, policy snapshot, or component set has changed, re-entry targets boundary-screened state; when only rehydration fields have changed, re-entry targets rehydration-closed state. No third re-entry point is admitted. The re-entry target is determined by the altered-field set; operator discretion is not admitted. |

# 3. Bounded Implementation Obligations

The family validator catalogue exposes operationally-neutral surfaces at the verdict-emission layer. The integrator workflow projection signals validator outcomes via state non-advancement; the verdict tokens (REPLAY\_INCOMPLETE, NONCOMPLIANT\_HOLD, CONTAMINATION\_FAIL\_CLOSED, INCIDENT\_ONLY) are emitted at the verdict-emission layer of the implementation. The obligations below are bounded — they extend the implementation surface without modifying the semantic core of the family integrator.

| Validator surface | Obligation class | Implementation obligation | Buyer guidance |
| --- | --- | --- | --- |
| Freshness / anchor cluster (FV-06) | Verdict emission | Implement NONCOMPLIANT\_HOLD emission for anchor strict-increase failure, watermark divergence, anchor stagnation, and anchor monotonicity edge cases. | Project the workflow state; emit the verdict at the verdict-emission layer; record FOC-05 family hold record with hold\_enter\_refs populated. |
| Accepted head / IRR linkage (FV-05) | Verdict emission | Implement REPLAY\_INCOMPLETE emission when accepted\_head\_digest is not linked to the latest valid integrity receipt record. | Projection layer cannot directly emit verdict-layer tokens; non-advancement past the anchor-locked state is the projection-correct signal. |
| Disclosure class preservation (FV-10) | Verdict emission | Implement INCIDENT\_ONLY emission when disclosure-class collapse is detected at the report-ready state. | Distinct classes (true defect, bounded openness, bounded handoff) must not be conflated in disclosure\_class\_entries. |
| Verified rehydration / evidence closure (FV-07, FV-11) | Verdict emission | Implement CONTAMINATION\_FAIL\_CLOSED at the verified-rehydration layer; implement INCIDENT\_ONLY at the evidence-closure layer. | Family validator outcomes must be populated before any verdict emission (observability rule). |
| Replay reconstruction (FV-08) | Verdict emission | Implement REPLAY\_INCOMPLETE at the verdict-emission layer when the replay/checkpoint/rollback lineage is incomplete. | Projection signals via non-advancement past the replay-reconstructed state. |
| Boundary role consistency (FV-04) | Handoff | Reclassification of an explanatory-only payload to mechanism-level material must be explicit and policy-bound. Implicit reclassification is forbidden. | Implementers may extend the reclassification policy. The extension preserves the semantic core. |
| Family readmission closure (FV-12) | Handoff | Re-entry from the readmission-review state targets the boundary-screened state when boundary fields are altered, or the rehydration-closed state when rehydration fields are altered. No third re-entry point is admitted. | The re-entry target is determined by the altered-field set; operator discretion is not admitted. |

# 4. Component Public Field Map

The public fields that the family validators consume from each component. Each field is named according to the component public specification.

| Component | Public fields consumed by family validators |
| --- | --- |
| Audit Replay Agent (ARA) | checkpoint\_refs; rollback\_refs; replay\_refs; report\_id; report\_signature; disclosure\_class\_entries (partial). |
| Boundary Defense Agent (BDA) | anchor\_document\_ref; carried\_payload; tsa\_label; source\_class; crash-proximity-warning state; accepted\_anchor; evidence\_ok; verification counter; tool\_state\_activation. |
| Freshness Portability Agent (FPA) | accepted\_head\_digest; linked\_irr\_digest; freshness\_before; freshness\_after; anchor\_update\_ref; readmission state flag. |
| Truth Arbitration Agent (TAA) | statement\_id; tsa\_label; source\_class; policy\_snapshot\_id; boundary\_validated\_role; residual\_risk\_statement; escalation\_request\_ref. |
| Verified Rehydration Agent (VRA) | restoration\_request; import\_admissibility; verified\_head\_selection (accepted head); validator\_bundle\_id; snapshot\_id; irr\_digest; failure\_code; readmission\_request; state set (startup\_readonly through readmission\_pending). |

# 5. Failure Propagation

Failure of a component in the fields consumed by the family validators propagates to the family verdict in the following manner. The propagation rules are derived from the family gate logic of the integrator and are stated here without relaxation.

- If FV-02, FV-03, FV-07, or FV-09 fails in a blocking manner, the family verdict is CONTAMINATION\_FAIL\_CLOSED. No replay admission token is emitted.
- If FV-05 or FV-06 fails without contamination, the family verdict is NONCOMPLIANT\_HOLD or REPLAY\_INCOMPLETE, depending on remediability.
- If only the replay closure is missing, the minimum family verdict is REPLAY\_INCOMPLETE. If both the replay closure and the evidence closure are missing, the family verdict becomes INCIDENT\_ONLY.
- REPLAY\_ADMISSIBLE\_CONSTRAINED is admissible only when all blocking validators have passed and the remaining restrictions are explicitly classified as bounded execution-neutral openness or bounded handoff obligation.
- Every material family-level transition emits an observable artifact; silent state advancement is forbidden.
- Family validator outcomes must be populated before any family verdict emission.

# 6. Reuse Note

| Field | Value |
| --- | --- |
| Status | Active; companion to the family integrator public specification |
| Objective | Provide a ready-to-implement reference for the producer-consumer wiring of the family integrator |
| Reusable elements | Validator-to-producer matrix; bounded implementation obligations; component public field map; failure propagation summary |
| Reuse conditions | Reuse is permitted only with explicit preservation of validator semantics, decision-object identity, and failure semantics. |
| Open items for implementation | Cryptographic suite selection; storage backend; operator workflow; verdict-emission-layer implementation; reclassification policy details; re-entry orchestration. |
| Boundary with the public specification | This annex does not modify the family integrator public specification, does not add semantics to the verdict vocabulary, and does not extend the canonical index. |

*Annex A — Producer-Consumer Manifest — Session State Continuity \& Anchor Replay Family Integrator*
