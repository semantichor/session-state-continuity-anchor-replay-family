Annex B — Concept Identity Register

Session State Continuity \& Anchor Replay Family Integrator

Buyer-facing canonical-token reference

# Document Information

| Field | Value |
| --- | --- |
| Document class | Annex — buyer-facing canonical-token reference |
| Audience | Implementers integrating the family package |
| Language | English |
| Status | Execution-neutral; standalone; binds to the family integrator public specification |
| Integrator | Session State Continuity \& Anchor Replay Family Integrator (FAM-SSCAR-FI-001), package version 1.1.0 |
| Family components covered | Audit Replay Agent (ARA); Boundary Defense Agent (BDA); Freshness Portability Agent (FPA); Truth Arbitration Agent (TAA); Verified Rehydration Agent (VRA) |
| Version date | 12 May 2026 |

# 1. Purpose and Use

This document is the canonical-token register for the Session State Continuity \& Anchor Replay Family Integrator. For each token shared across more than one component, the register declares the producing authority, the equivalence rule under which the token is considered the same value across components, the consumers, the coherence constraint that prevents uncontrolled synonymy or semantic collapse, and the evidence binding through which the token can be reconstructed offline.

This annex prevents the situation in which two components use the same term with different meanings, or two different names for the same operational object. It does not introduce new concepts; it does not supplement the canonical semantic index of the integrator; it records only the cross-component identity required for correct wiring between components and the family integrator.

# 2. Canonical Token Register

Each row identifies a token shared between two or more components. The producing authority is the component or composition that owns the token; the equivalence rule states the condition under which two instances are operationally identical; the consumers are the validators, contracts, or tests that consume the token; the coherence constraint is the verifiable rule that the token must satisfy across consumers; the evidence binding identifies the public evidence field through which the token surfaces in the boundary event evidence report.

| Canonical token | Producing authority | Local variants / aliases | Consumers | Equivalence rule | Coherence constraint | Evidence binding |
| --- | --- | --- | --- | --- | --- | --- |
| accepted\_head\_digest | Freshness Portability Agent | Verified Rehydration Agent: verified\_head\_selection / accepted head | FV-05; FV-07; replay admission token; identity test | byte-identical | same snapshot scope; same integrity-receipt linkage | accepted\_head\_digest / linked\_irr\_digest field of the family evidence contract |
| linked\_irr\_digest | Freshness Portability Agent | — | FV-05; replay admission token; identity test | byte-identical | must be the latest valid integrity receipt record at evaluation time | accepted\_head\_digest / linked\_irr\_digest field |
| tsa\_label | Truth Arbitration Agent | Boundary Defense Agent: tsa\_label as boundary statement-record annotation | FV-03; FV-04; FV-09; boundary event evidence report; provenance tests | semantic-label-bound | Label assigned at admission. No unlabeled mechanism-level claim is admitted. | tsa\_refs / provenance\_refs field |
| source\_class | Truth Arbitration Agent | Boundary Defense Agent: source\_class as admissibility class | FV-03; FV-04; FV-09; provenance tests | policy-bound | The admitted source-class set is declared in policy\_snapshot\_id. No admission outside the declared set. | tsa\_refs / provenance\_refs field |
| policy\_snapshot\_id | Truth Arbitration Agent + Freshness Portability Agent | Verified Rehydration Agent: policy prerequisite witness | FV-03; FV-06; FV-07; FV-12; readmission test | scope-bound | Stable across one family event. Identical id is required for hold-to-readmission comparison. | family continuity intake required field |
| anchor\_document\_ref | Boundary Defense Agent | Verified Rehydration Agent: anchor\_document\_ref as cross-referent at rehydration | FV-02; FV-07; boundary event evidence report; identity test; rehydration test | byte-identical (digest) and scope-bound (reference) | Remains untrusted until verification closes. No promotion without FV-02 pass. | anchor\_document\_digest / anchor\_document\_ref field |
| anchor\_update\_ref | Freshness Portability Agent | — | FV-06; FV-12; family hold record; family readmission review; readmission test | strict-increase (monotonic) | Strictly greater than the prior anchor\_update\_ref for the same continuity scope. Readmission on identical artifacts is forbidden. | freshness\_before / freshness\_after / anchor\_update\_ref field |
| freshness\_before / freshness\_after | Freshness Portability Agent | — | FV-06; freshness test | strict-increase | freshness\_after must be strictly greater than freshness\_before for advancement. | freshness\_before / freshness\_after / anchor\_update\_ref field |
| rehydration\_closure\_ref | Verified Rehydration Agent | — | FV-07; replay admission token; rehydration test | byte-identical (reference) | Produced only when read-only startup, snapshot stability, anti-rollback, chain or signature checks, and policy prerequisites all pass. | rehydration\_closure\_ref field |
| snapshot\_id | Verified Rehydration Agent | — | FV-07; rehydration test | scope-bound (per restore event) | Stable across the rehydration window. Cannot be downgraded to an older snapshot. | rehydration evidence record |
| irr\_digest | Verified Rehydration Agent + Freshness Portability Agent | Freshness Portability Agent: linked\_irr\_digest as companion field | FV-05; FV-07; identity and rehydration tests | byte-identical | The integrity-receipt digest at the verified rehydration component equals linked\_irr\_digest at the freshness component for the same accepted head. | accepted\_head\_digest / linked\_irr\_digest field |
| replay\_refs, checkpoint\_refs, rollback\_refs | Audit Replay Agent | — | FV-08; boundary event evidence report; round-trip test | byte-identical references and lineage-complete chain | Chain unbroken. Checkpoint and rollback lineages cover all replay states; no missing intermediate step. | replay\_refs / checkpoint\_refs / rollback\_refs field |
| validator\_bundle\_id | Verified Rehydration Agent + Family Integrator | Family Integrator: family\_validator\_outcomes (composition) | FV-07; FV-11; family verdict; composition test | aliased (the local validator bundle is a component of the family-level bundle) | The local bundle is a component of the family-level bundle; the family-level bundle is the union with cross-component witnesses. | family\_validator\_outcomes field |
| statement\_id | Truth Arbitration Agent | Boundary Defense Agent: statement-record statement\_id as admission annotation | FV-03; FV-04; carried\_statement\_refs in the boundary event evidence report; provenance test | byte-identical | Stable identifier across statement lifetime. Cannot be reassigned after admission. | carried\_statement\_refs field |
| family\_decision\_id | Family Integrator (composition only) | — | Family verdict; replay admission token; contamination incident notice; family hold record; composition test | byte-identical (UUID-class) | Unique per family event. Never reused across continuity boundary events. | family\_decision\_id field |
| boundary\_event\_id | Family Integrator (composition only) | — | Boundary event evidence report; composition test | byte-identical | Unique per boundary event. Binds the family verdict to a single reconstructible continuity case. | boundary\_event\_id field |
| contaminating\_ref\_set + blocked\_stage | Family Integrator (composing local contamination signals) | Boundary Defense Agent: contamination\_flags; Truth Arbitration Agent: provenance-inadmissible flag; Verified Rehydration Agent: anti-rollback-failure flag | FV-09; contamination incident notice; contamination test | aliased (union of local contamination signals) | Non-empty contaminating\_ref\_set and non-empty blocked\_stage are mandatory before entering the contamination-fail-closed state. | contamination\_flags / contaminating\_ref\_set field |
| hold\_enter\_refs / hold\_exit\_refs | Family Integrator (composition); Freshness Portability Agent contributes anchor\_update\_ref | — | FV-12; family hold record; family readmission review; readmission test | scope-bound (per hold case) | hold\_enter\_refs is non-empty for hold entry. hold\_exit\_refs is non-empty and anchor\_update\_ref is strict-increase for the hold-to-readmission-review transition. | hold\_enter\_refs / hold\_exit\_refs field |
| disclosure\_class\_entries | Truth Arbitration Agent + Audit Replay Agent + Family Integrator | — | FV-10; boundary event evidence report; disclosure-class test | semantic-label-bound (class) and scope-bound (entries) | Every carried openness or defect is classified distinctly. The classes true defect, bounded execution-neutral openness, and bounded handoff obligation do not collapse into each other. | disclosure\_class\_entries field |
| report\_signature / export\_manifest\_ref | Family Integrator (composition only) | — | FV-11; boundary event evidence report; composition test | byte-identical | Produced only at the report-ready state. Mandatory before any family verdict emission. | report\_signature / export\_manifest\_ref field |
| session\_id / prior\_session\_ref | Family Integrator (input contract field; sourced upstream) | — | Family continuity intake; family replay request; family verdict; identity test | byte-identical (identifiers) | session\_id is stable across one continuity event. prior\_session\_ref points to a validated predecessor. | session\_id / prior\_session\_ref field |

# 3. Equivalence Rules

The operational definitions of the equivalence rules used above.

| Equivalence rule | Operational definition |
| --- | --- |
| byte-identical | Token values are byte-for-byte equal across all consumers. Used for digests, references of UUID class, and signature fields. Any encoding difference is a coherence defect. |
| scope-bound | The token is identical within a defined scope (one family event, one rehydration window, one continuity scope). Across scopes the token may differ; cross-scope identity is forbidden unless explicit aliasing is declared. |
| aliased | The local variant is recognized as the same operational object as the canonical token through an explicit alias declaration. Used for cross-component fields where the local name differs but operational identity holds. |
| policy-bound | Token equivalence is conditioned on identical policy\_snapshot\_id. The same value under different policies is not equivalent for family verdict purposes. |
| semantic-label-bound | Token equivalence holds only if both label and value are preserved. Renaming the label breaks equivalence even if the value is identical. |
| strict-increase (monotonic) | Sequential token instances must be strictly greater under the family-level ordering rule (anchor sequence, integrity receipt chain, hash continuity, anti-rollback). Host timestamps are not admitted as the ordering authority. Non-monotonic values trigger the noncompliant-hold state. |
| lineage-complete (chain) | The token set forms an unbroken chain from the initial state to the final state. A missing intermediate reference triggers replay-incomplete. |

# 4. Consumer Impact Map

The link between each canonical token and its consumers across the validator-to-producer matrix and the connector test suite.

| Canonical token | Family validator consumers | Output / input contract consumers | Connector test consumers |
| --- | --- | --- | --- |
| accepted\_head\_digest | FV-05; FV-07 | replay admission token; family replay request | identity test; rehydration test |
| linked\_irr\_digest | FV-05 | replay admission token; family evidence contract | identity test |
| tsa\_label | FV-03; FV-04; FV-09 | boundary event evidence report; family evidence contract | provenance tests |
| source\_class | FV-03; FV-04 | family evidence contract | provenance tests |
| policy\_snapshot\_id | FV-03; FV-06; FV-07; FV-12 | family continuity intake | readmission test |
| anchor\_document\_ref | FV-02; FV-07 | boundary event evidence report; family continuity intake | boundary test; rehydration test |
| anchor\_update\_ref | FV-06; FV-12 | family hold record; family readmission review | readmission test |
| rehydration\_closure\_ref | FV-07 | replay admission token; family replay request | rehydration test |
| replay\_refs, checkpoint\_refs, rollback\_refs | FV-08 | boundary event evidence report | round-trip test |
| family\_decision\_id | (emitted by family integrator composition) | family verdict; replay admission token; contamination incident notice; family hold record | composition test |
| contaminating\_ref\_set | FV-09 | contamination incident notice | contamination test |
| hold\_exit\_refs | FV-12 | family hold record; family readmission review | readmission test |
| disclosure\_class\_entries | FV-10 | boundary event evidence report | disclosure-class test |
| session\_id / prior\_session\_ref | FV-01 indirectly (intake) | family continuity intake; family replay request; family verdict | identity test |

# 5. Coherence Constraints

The global coherence constraints that prevent uncontrolled synonymy, downgrade, semantic collapse, and verdict drift. Each constraint is verifiable through the connector test suite (Annex C).

| ID | Constraint | Description |
| --- | --- | --- |
| CC-01 | Anchor / integrity-receipt identity preservation | accepted\_head\_digest produced by the freshness component and the verified-head-selection produced by the verified rehydration component must refer to the same operational object for the same family event. linked\_irr\_digest at the freshness component is byte-identical to irr\_digest at the verified rehydration component. Aliasing is declared explicitly; implicit synonymy is a coherence defect. |
| CC-02 | Statement labeling closure | No carried claim consumed by FV-03 can be promoted to mechanism level without tsa\_label, source\_class, and policy\_snapshot\_id. Renaming the label without preserving the value is a coherence defect and triggers either FV-04 reclassification or FV-09 contamination block. |
| CC-03 | Snapshot stability | snapshot\_id at the verified rehydration component remains identical across the rehydration window declared by policy\_snapshot\_id. The snapshot cannot be downgraded to an older value. The anti-rollback policy operates byte-level over the snapshot\_id chain. |
| CC-04 | Strict-increase order rule | Family replay order is determined by the anchor sequence, the integrity-receipt chain, hash continuity, and anti-rollback. Host timestamps are not admitted as the ordering authority. anchor\_update\_ref is strict-increase across hold-to-readmission transitions. |
| CC-05 | Policy scope binding | policy\_snapshot\_id binds all tokens consumed in the same family event. Token values valid under one policy cannot be reused under another policy unless explicit policy compatibility is declared. There is a bounded openness on policy choice at FV-03; the implementer chooses the admitted source-class set per policy. |
| CC-06 | Cross-component authority discipline | The family integrator cannot override local authority. The authority for accepted\_head\_digest remains with the freshness component; the authority for rehydration\_closure\_ref remains with the verified rehydration component; the authority for tsa\_label remains with the truth arbitration component; the authority for the checkpoint chain remains with the audit replay component; the authority for the boundary contract remains with the boundary defense component. The family integrator composes; it never rewrites. |
| CC-07 | Disclosure class distinctness | The classes true defect, bounded execution-neutral openness, and bounded handoff obligation remain distinct in disclosure\_class\_entries. Collapsing any pair triggers FV-10 and incident-only emission. |
| CC-08 | Anti-rollback chain integrity | The integrity-receipt chain at the verified rehydration component and the linked-integrity-receipt chain at the freshness component must be unbroken and identical for the same continuity scope. A chain break is an anti-rollback failure and triggers contamination-fail-closed. |
| CC-09 | Readmission monotonicity | anchor\_update\_ref at the hold-to-readmission-review transition is strictly greater than anchor\_update\_ref at the entry to the hold state for the same continuity scope. Readmission on identical artifacts is forbidden. |
| CC-10 | Validator outcome closure | family\_validator\_outcomes must be populated before any family verdict emission. Empty or partial outcomes trigger incident-only emission at FV-11. |

# 6. Reuse Note

| Field | Value |
| --- | --- |
| Status | Active; companion to the family integrator public specification |
| Objective | Provide a canonical reference for the cross-component identity of operational tokens that participate in the family verdict composition |
| Reusable elements | Canonical token register; equivalence rules; consumer impact map; coherence constraints |
| Reuse conditions | Reuse is permitted only with explicit preservation of token canonical names, equivalence rules, and coherence constraints. |
| Open items for implementation | Concrete cryptographic suite for digest fields; concrete storage backend for the integrity-receipt chain; policy-snapshot governance details. |
| Boundary with the public specification | This annex does not modify the family integrator public specification, does not add canonical tokens to the index, and does not extend the verdict vocabulary. |

*Annex B — Concept Identity Register — Session State Continuity \& Anchor Replay Family Integrator*
