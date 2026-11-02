# Session State Continuity & Anchor Replay Family Pack — Verification Runbook (`verify.md`)

> Drop this file next to the **unzipped** SEMANTICHOR Session State Continuity & Anchor Replay Family Pack and run it inside an
> agentic environment with a shell and a filesystem (Cowork, Codex, or any comparable agentic shell).
> It must **execute**, not be read. If you cannot run commands, stop: every result below is `NOT RUN`.

---

## What this runbook is
You received a **family pack**: FAM-SSCAR, the Session State Continuity & Anchor Replay Family — a fail-closed family of six agents whose verdict is emergent, not summed. The family
whitepaper says what the family promises: which components it is made of, what it guarantees, that
its capability emerges only from the composition, and that the package is complete and ready to
build. This runbook has you establish, **on the package you hold and on your own machine**, that you
received what was promised. It does so at three levels:

- **Integrity and identity.** You hold exactly the package that was published: every unit intact,
  and every component unit the very package of that agent.
- **The specification.** What makes each promise possible is defined in the normative documents you
  received, and the figures those documents declare about themselves reproduce.
- **The evidence.** What the package ships as evidence runs on your machine and shows the
  composition behaving as declared.

Each check has the same shape: **find what the package declares, observe what your machine
produces, record whether they match.**

**The object of this runbook is the family integrator, in composition.** The family is five
component agents and one integrator that composes them, with three connector annexes. Each component
agent is carried unchanged, the same files byte for byte as that agent's own package, and that
package is verified by its own `verify.md`. Here a component unit is checked for integrity and
identity, and is exercised through the composed suites; it is not read or verified for itself. The
integrator has no package of its own in which it could be verified on its own: it has no component
to wire. It is verified here.

**How the documents divide.** The whitepaper is a commercial document: it says what is promised. The
README is a reading guide: it says where to look and in what order. Neither is normative. The
normative documents are the integrator's Specification, its Semantic Index, Coverage Matrix,
Ambiguity Register and Conformance Tests, and the three connector annexes. A promise is shown where
the normative documents deliver it and where the shipped evidence exercises it.

## What this runbook does not do
- **It does not evaluate your implementation or your deployment.** The specification is
  execution-neutral: it defines *what*, never *how*. What you build, and the substrate you build it
  on, are yours. Where that line falls is stated by the package itself (Ground Rule 9).
- **It does not judge the family against the inter-session continuity / family replay admissibility domain.** Whether the model is right
  for your problem is a human judgment.
- **It does not search for defects.** Before this package reached you, it was constructed, sanitised,
  converted with a byte-level re-verification, derived repeatedly by the evidence it ships, and
  composed and minted. This runbook does not repeat that work. It has you confirm that what you hold
  is what was published, that what it declares reproduces, and that its evidence reproduces.
- **It does not build or derive anything.** No step asks you to write an implementation, rebuild a
  shipped binary or re-derive the evidence. Every step reproduces something that was shipped.
- **It does not verify a component agent for itself.** That is the work of the component's own
  package and its own `verify.md`.

## Ground rules
1. **Do not trust this file.** It ships with the product. Re-run every command and trust the **raw
   output**, not anything written here. If this file and the output disagree, the output wins — and
   you report the discrepancy.
2. **Execute, never assert.** Run the check, paste the **raw output**, state what it shows. Did not
   run it → `NOT RUN`, never a match.
3. **Compare against the package's own declarations, never against this file.** This runbook carries
   **no numbers**. Every expected value is read from a shipped document, and you record where you read
   it. The whitepaper is not a source of values.
4. **Each status has one meaning.**
   - `MATCH` — the value the package declares reproduces, on the criterion of the document that
     defines it.
   - `MISMATCH` — it does not reproduce, and a document of the package (Ground Rule 8) would have to
     change for the declared value to hold.
   - `INCONCLUSIVE` — the check could not be completed: a verifier failed, a toolchain is missing, or
     your security software blocked a step. Name the cause. It is not used for a level of detail the
     package does not declare.
   - `NOT RUN` — the check was not run.
   A check you could not complete is never a mismatch, and an unconfirmed result is never a match.
5. **Structural only.** These checks confirm that the package reproduces what it declares. They
   cannot confirm that what it declares is correct for the inter-session continuity / family replay admissibility domain.
6. **The package co-states its figures. Read every place, not the first place.** A quantity is
   normally stated by an **anchor** that defines it and by derivatives that restate it. Find every
   place the normative documents and the READMEs state it, and record each one. Where an anchor and a
   derivative differ, record both, name the anchor, and read what the package states about how its
   derivatives relate to it.
7. **Name the axis before you compare.** Two figures are comparable only if they count the same
   thing. Write down what each one counts, in the same row. Where the package declares the rule that
   relates two figures, that rule is the criterion. Where it declares none, record both figures with
   their axes and stop. Two of this package's own declarations differing is not a result this runbook
   produces, and a difference no row of this runbook asks for is not recorded.
8. **A finding is about a document of the package.** Before you compare a value, name the document
   of the package the finding would be about, and before you write `MISMATCH`, state that you read it
   end to end. That document is a file of this runbook's canonical set (Ground Rule 10) or a
   family-level file at the root of the package. A file of the NNT companion is never such a document:
   the companion is evidence, and it cannot establish a defect in the package. A discrepancy you cannot
   anchor to a document of the package is a reading you have not finished, not a defect you have
   found.
9. **Latitude is not a gap.** The specification determines the logic and deliberately leaves the
   deployment substrate, and the adapters between the components' own fields and the family tokens,
   to the implementer. Where the specification declares a parameter but declares no outcome for some
   combination of it, the surface is declared and the outcome is left open: that is latitude, and you
   record it as latitude. The companion states the expected convergence frame; find it and record
   where you read it.
10. **The canonical set is one document. Read it whole before you record anything.** In this runbook
    the canonical set is the integrator's, as the integrator README lists it: the Specification, the
    Semantic Index in all three editions (human, YAML, JSON), the Coverage Matrix, the Ambiguity
    Register, the Conformance Tests and the three connector annexes, read together with the family
    README and the integrator README. The component units are not part of it. Read it all before you
    record a single result, and list the set in your report. Record, file by file, the depth you read
    it at: as text, read through; or as structured data, read entry by entry with every field as
    text. Counting a structured edition's entries and comparing editions is the vocabulary check, not
    reading. Rows that rest on a file you did not read are `NOT RUN`. Where the map names a section of
    a component unit, read that section there, whole, for the field or token the row concerns.
    Before you write `MISMATCH` or `INCONCLUSIVE`, read the set again with the finding in hand and ask
    what in this package already accounts for what you saw. If the package accounts for it, the row is
    `MATCH` and that document is its anchor. State in your report that you made this confrontation and
    what the package said.
11. **The whitepaper says what is shown; it is not compared with anything.** It is not a source of
    values (Ground Rule 3), and it is not a list of things to look for. Do not compare it with the
    README or with the normative documents: a difference of number or wording between them is not a
    result of this runbook and is not recorded. A promise enters this runbook only through the
    addresses the map gives and through the runs.
12. **Presence, not absence.** Every question in this runbook asks where something promised or
    declared is found in the package, or what a run returns. None asks what is missing. Every value
    you record as read from a document carries that document's own words, verbatim, with the file and
    the line it stands on.
13. **The vehicle is measured only through what the shipped evidence asserts.** The shipped baselines
    are study artefacts of the composition, not reference implementations, and not the object of this
    runbook. What you reproduce from them is what the shipped runners assert: the result of each
    record, in each paradigm. Do not drive a baseline outside its runner — no state-by-state
    enumeration, no direct call of an internal function, no input the composition does not produce. A
    field of a baseline that no runner asserts is not the object of any row.

## Rows
The rows of your report are the checks of the Procedure and the rows of the map below, and nothing
else. Every row of the map is a row of your report. A row whose anchor you have not re-read takes the
status Ground Rule 2 gives a check you did not run, in its table.

## Inputs
- The unzipped **Session State Continuity & Anchor Replay Family Pack**: the six units under `UNIT/` (five component agents and the
  integrator, which carries the three connector annexes), the family-level files at its root, and the
  NNT companion (`NNT_Family_Companion/`: baselines, runners, observation record).
- **Compiled-paradigm binaries, and your security software.** The companion ships **prebuilt,
  unsigned** executables. A mainstream antivirus or endpoint tool may flag, block or quarantine them as
  unrecognised. **That is a property of unsigned binaries, not a finding about this package.** This
  runbook does **not** ask you to change your security settings. If your security software blocks a
  check, that check is `INCONCLUSIVE` or `NOT RUN` under Ground Rule 4, and you report it as such,
  naming the tool and the file it acted on.
- **Your transfer, and line endings.** A manifest binds bytes. If a tool rewrote line endings on your
  copy, text files will hash differently, which reads exactly like tamper. Normalise line endings on
  your copy and verify again: if the set then matches, you measured your own transfer, and you record
  it as an observation naming the tool, never as a mismatch.
## What this pack declares, and where each criterion is stated

This section is a map of **this** pack: the addresses of the declarations the checks read. It is an
address list and nothing more. Paths are relative to the pack root; the integrator's files are under
`UNIT/FAM-SSCAR-FI-001/`; line numbers refer to the files as shipped.

### Rows of checks 1, 2 and 4

| Quantity | Declared in | Where its criterion is stated |
|---|---|---|
| Which configuration you hold | Family README, "What you received" — both tables and the paragraphs that follow them; `SSCAR_Family_Manifest.sha256` header | the README states how each unit is carried, and which family-level files take the place of material a unit's own README names but the unit does not carry here |
| Package integrity, family level | `SSCAR_Family_Manifest.sha256`, header and entries; `SSCAR_Family_License.md`, "Identifier and integrity reference" | the family Manifest header states the levels of the chain, what its entries cover and what it excludes |
| Package integrity, unit level, and identity of each component | each unit's own Manifest, `UNIT/<agent_id>/…_Manifest.sha256`; each component unit's License, "Identifier and integrity reference"; the family Manifest header, the `core agent_manifest_ref` lines; the direct `UNIT/` entries of the family Manifest | the unit Manifests carry no header; the family Manifest header states which unit files they leave uncovered and that it hashes those files directly; a component unit's License binds that unit's Manifest by `manifest_ref`, the reference of the agent's own package |
| Which License governs what | Family README, "What you received", the paragraph on licenses; `SSCAR_Family_License.md`, "Subject"; each component unit's License, "Subject" | the family README states which license governs the composed family and which governs a component used on its own |
| The canonical set of this runbook | integrator README (`SSCAR_README.md`), "What you received", L22–34 | the integrator README lists the files of the integrator's set, the connector annexes among them |
| Canonical terms, integrator | `SSCAR_Semantic_Index.md` (D1), "Document metadata" and the index scope statement; D2 YAML and JSON, `metadata`; `SSCAR_Coverage_Matrix.md` (D3), "Category Summary" and "Checkpoint"; family README and integrator README, "Versioning" | D1 states its own derivation scope and its categories; D3 states its category totals; the READMEs restate the figures |
| Index editions, integrator — how D1 and D2 correspond | integrator README, "What you received", the row of the structured edition; D1, "Document metadata", the index scope statement and the editorial rule; D2 YAML and JSON, `metadata`; D3, "Checkpoint" | the README states how the structured edition relates to D1; what corresponds between editions is the same IDs, labels, categories, statuses and source sections |
| Ambiguity entries, integrator | `SSCAR_Ambiguity_Register.md` (D4); family README and integrator README, "Versioning" | D4's table is its own count |
| Family verdicts and workflow states | `SSCAR_Specification.md` §4.1 (L142 onward); §9 Workflow and State Transitions; `SSCAR_Conformance_Tests.md` §8 Minimal Run Note, `Input types required` | §4.1 lists the verdicts; §9 lists the states with their entry and exit triggers |
| Conformance records, integrator — what a record is | `SSCAR_Conformance_Tests.md` §5, the opening statement (L27), the header line under the title (L25), and the `Kind` and `Execution surface` columns; §7 Public Oracles; §8 Minimal Run Note, `PASS condition` (L212) and `Bounded external obligations not locally runnable` (L213); family README and integrator README, "How to verify your implementation conforms" | §5's opening statement names the records it counts, the records it places in §7 and the verdict-layer subsets it counts as records of their own; the header line states what the §5 tests are run against, and each row's `Execution surface` states how that row is exercised; §8 (b) states how the declarative records placed in §7 are passed: through the declarative oracles of §7, as a class |
| Connector tests | `SSCAR_Family_Connector_Tests.md` (Annex C), "Document Information", §2 Test Catalogue and §4 Coverage Map; family README and integrator README, "Versioning" | Annex C states its test count and that its tests verify wiring and do not replace the integrator's suite (L26, L262) |
| Wiring — what each component produces for the family validators | `SSCAR_Producer_Consumer_Manifest.md` (Annex A) §2, §4 and §5; `SSCAR_Concept_Identity_Register.md` (Annex B) §2, §3 and §4; Specification §3, the sentence on exact field names (L80), and §11 Evidence Contract (L503) | Annex A states which component produces what each family validator consumes, and under which public field; Annex B states, per token, the producing authority, the local name a component gives it and the rule by which the component's value is equivalent to it; §3 states what of a field may be adapted to a deployment format and what is fixed |
| What remains yours to build | family README, "What your team must produce" and "How the family is deployed by your team"; Specification §14, §16 and §17; Annex A §3; Annexes A, B and C, §6 Reuse Note, "Open items for implementation"; `SSCAR_Conformance_Tests.md` §8, L213 | the README names the artefacts, among them the adapters between each component's fields and the family tokens; §17 separates the execution layer from the stable semantic core; each annex lists its open items |
| What the shipped baselines are | `NNT_Family_Companion/baselines/python/baseline.py`, L1–15; `NNT_Family_Companion/NNT_README.md`; `NNT_Family_Companion/Convergence_Exhibit.md` | the baseline's header states that it implements all six agents in composition, the integrator consuming the components' public fields; the companion states that the baselines are study artefacts |

Several rows send you to both levels of the pack: the family level at its root and the unit level
under `UNIT/`. Name the level as well as the axis in your row.

### Relations of the declared decision logic (check 3)

| Relation | Places it relates | Where the sentence that states it stands |
|---|---|---|
| The failure effect of each validator, and what the package declares where it is not a §4.1 verdict | Specification §7, the `Fail effect` of FV-01 to FV-12; §4.1 | §7 and §4.1 themselves; for FV-01, Annex A §2, row 1 (L33); for FV-04's local branch, Specification §7, FV-04, L257 |
| The blocking validators are the same in the gate logic, the workflow and the decision table | Specification §10, L497; §9, the SX entry trigger, L483; §8, FD-02 and FD-08 | §10, L497; §9, L483 |
| A positive verdict only when every blocking validator has passed | Specification §4.1, L146; §10, L500 | §4.1, L146; §10, L500 |
| FD-05's gate impact "S5 → S8" and the stepwise workflow from S5 to S8 | Specification §8, FD-05, L362; §9, the S6, S7 and S8 entries (L444–491) | Specification §8, FD-05, the condition set (L360); §7, FV-08, the pass condition (L290); §9, the S6 and S7 entry triggers (L448, L456); Ambiguity Register, AMB-16 (L26), for the label |
| Verdicts with no dedicated workflow state; FV-05's failure effect and the gate logic's "according to remediability" | Specification §7, FV-05, L265; §10, L498; §9 | Ambiguity Register, AMB-17 (L27); Annex A §3, L48 |
| FV-04's failure mode written "FAIL_CLOSED": the Specification defines it; Annexes A and C restate it | Annex A §2, row 4 (L36); Annex C, CT-13 (L44; L195 onward) | Specification §7, FV-04, L255, the anchor; Annex A, L25 and L92; Annex C, L26 and L262 |
| Annex C CT-02, its catalogue line and its Assertion 2: the Specification's discriminator decides which branch of FV-03 applies | Annex C §2 (L33) and §3, CT-02 (L63 onward) | Specification §7, FV-03, L243–246, the anchor; Annex C, L26 and L262 |
| Re-entry from the readmission review: the Specification is the anchor; Annexes A and C restate it | Specification §9, SR exit, L475–477; Annex A §2, row 12 (L44); Annex C, CT-14 (L207 onward) | Specification §9, L475–477, the anchor; Annex A, L25 and L92; Annex C, L26 and L262 |
| A state label and a verdict token are distinct types | Specification §4.1 and §9 | Ambiguity Register, AMB-15 (L25); Conformance Tests §5, PTS-021 (L50) |

### The promises (check 7)

The family whitepaper is `UNIT/FAM-SSCAR-FI-001/SSCAR_Whitepaper.html`. Records are named
individually; each is taken from check 5 with the result the companion declares for it.

| Promise (whitepaper) | Where the package defines what delivers it | Records that exercise it |
|---|---|---|
| §04 — the family: five components, the integrator, three connector annexes | Family README, "What you received"; integrator README, L22–34; the family Manifest | — (shown by check 1) |
| §05 G.01 — epistemic structure survives the boundary | Specification §4.2, L153–159; §7, FV-10, L302 | CT-11 |
| §05 G.02 — provenance crosses with the content | Specification §7, FV-03, L237–246 | PTS-017a; CT-02 |
| §05 G.03 — continuity is decided, not assumed | Specification §8; §9; §10; §7, the validator class "Deterministic" (e.g. L223) | PTS-001; PTS-002; PTS-003; PTS-004a; PTS-004b; PTS-006; PTS-007; PTS-008; PTS-009; PTS-010; PTS-011; PTS-012; PTS-013; PTS-014; PTS-021; PTS-022; PTS-023 |
| §05 G.04 — the continuity is auditable offline | Specification §1, rule 11 (L53); §11, L503; §16, AC-05 (L643); §7, FV-11, L310 | PTS-016; CT-07; CT-08; CT-12 |
| §07 — the family capability emerges only from the composition | Specification §1, L23; Ambiguity Register, AMB-01 (L11); family README, "Composition is not optional" | every record of the seven suites, as run in check 5 |
| §08 — complete, ready to build, execution-neutral | Specification §17.1 and §17.3; `NNT_Family_Companion/auto_disclosure_audit.md` | every record of the seven suites, as run in check 5, in each paradigm |

---

## Procedure

### 0 — Reading order
Read the family README first: it states what you received and the order in which to read it. Then
read this runbook's canonical set whole (Ground Rule 10). Each check names an **anchor**, the document
in which the value is defined; the map below gives the addresses.

---

## Part A — integrity and identity

### 1 — Integrity and identity of the units
- **Declared:** the family Manifest lists one SHA-256 entry per covered file and states, in its
  header, the levels of the chain and what it excludes; each unit carries its own Manifest; the family
  License binds the family Manifest's hash as `manifest_ref`; each component unit's License binds that
  unit's Manifest, which is the reference of the agent's own package.
- **Reproduce — verify every artefact,** at both levels:
  - **Linux:** `sha256sum -c <manifest>.sha256`
  - **macOS:** `shasum -a 256 -c <manifest>.sha256`
  - **Windows:** run the Linux command inside **WSL** or **Git Bash**, or verify file by file in
    PowerShell:
    `Get-Content <manifest>.sha256 | ? { $_ -notmatch '^\s*#' -and $_.Trim() } | % { $h,$f = $_ -split '\s+',2; if ((Get-FileHash $f.Trim() -Algorithm SHA256).Hash -ieq $h) { "OK   $f" } else { "FAIL $f" } }`
  Identify the shipped files that no entry covers, at either level.
- **Reproduce — close the chain.** Recompute the family Manifest's hash and compare it to the family
  License's `manifest_ref`. Recompute each unit Manifest's hash and compare it to the reference the
  family Manifest header and the component License bind.
- **Reproduce — tamper-evidence.** Alter one byte of any artefact, re-run the verification, confirm
  that file is reported as failing, then restore it and confirm the full set matches again.
- **Reproduce — final release.** Grep every shipped file for non-final markers (`-draft`, `-rc`, `RC`,
  `TODO`, `PLACEHOLDER`, `WIP`); this sentence matches itself, as expected. State the domain of the
  sweep: which files you read as text, which you scanned as raw bytes, which you skipped. For every
  other hit, record which file carries it and whether that file is a normative document or part of
  the evidence apparatus.
- **Record:** entries matched / total at each level; whether each reference closes; whether the edit
  was detected and the restore returned the set to matching; the uncovered files; every marker found
  outside this file with the document that carries it; the configuration you hold.

---

## Part B — the specification

### 2 — The integrator's figures
- **Declared:** the integrator's Semantic Index (D1) defines the canonical terms and states its own
  derivation rule and per-category counts; its structured editions (D2, YAML and JSON) and Coverage
  Matrix (D3) restate them; the Ambiguity Register (D4) and the Conformance Tests are the anchors for
  their own quantities; the connector annex C states its test count. The READMEs restate these figures:
  they are derivatives (Ground Rule 6).
- **Reproduce — one row per criterion.** Read each criterion before counting: it is what makes a
  figure right, and an item outside it is correctly absent. Count the entries in D1; compare the JSON
  and YAML editions with each other and with D1 and D3 on identifiers, labels, categories, statuses
  and source sections; check the per-category counts against D1's totals; count D4; reproduce the
  Conformance Tests' partition of their records on the criterion the Conformance Tests state; count
  the connector tests. Where the same set is partitioned on two criteria, each is its own row, with
  its axis named (Ground Rule 7).
- **Record:** per criterion, the declared figure, its anchor, what it counts, and the figure you
  observed.

### 3 — The declared decision logic
- **Declared:** the integrator's Specification declares the family verdicts, the validators and the
  effect of each one's failure, the decision table, the workflow and the gate logic; the Ambiguity
  Register declares where a verdict token and a state label share a name; the connector annexes restate
  parts of this logic for the wiring. The map lists each relation this logic states and the address
  of the sentence that states it.
- **Reproduce:** for each relation in the map, read the sentence at its address and record it,
  verbatim, with the places it relates (Ground Rule 6). The integrator is not driven for this check:
  it has no input of its own here, and its behaviour in composition is reproduced in check 5.
- **Record:** per relation, the places, the sentence at the address, and whether it states the
  relation the map names. Where the map names an **anchor**, the anchor's sentence is the declared
  value of the relation. A place that restates the anchor and reads otherwise is recorded with both
  readings, verbatim, and with the sentence by which the package relates that place to its anchor: it
  is a difference between two of the package's own declarations, not a value that fails to reproduce,
  and the row is `MATCH` when the anchor's sentence states the relation (Ground Rules 6, 7 and 10).
  Where the package declares a state label and a verdict token to be distinct types, record them as
  two values.

### 4 — What remains yours to build
- **Declared:** the package states what it does **not** ship: the artefacts your team produces,
  including the adapters between each component's fields and the family tokens; the deployment
  substrate it assumes; and the obligations it delegates. The map gives the addresses.
- **Reproduce:** enumerate what the package declares, from the documents that declare it, and check
  that the statements correspond. Where the conformance suite designates records as bounded-external,
  check that each one names the obligation it rests on.
- **Record:** the declared set, where you read each part, and whether the places correspond.
  Differences of wording between places are recorded with both readings and their axes (Ground
  Rule 7).

---

## Part C — the evidence
**The evidence of the composition.** The integrator has no component to wire on its own, so its only
evidence of working is the composition. The NNT companion carries it: the family derived from the
package alone, in several paradigms, and run on the composed suites. The evidence is informative and
non-normative: it shows that the package's claim was exercised and that the exercise reproduces; it
does not certify the package and cannot establish a defect in it (Ground Rule 8). The companion
discloses that its reconstructions share model, prompt-author and training data: they are
paradigm-isolated, not independently derived. Report that bound as the companion states it.

### 5 — Reproduction of the composed suites
- **Declared:** the companion states, per paradigm and per suite, how many records pass and how many
  are skipped, and names the reason each skip is declarative or bounded-external.
- **Reproduce:** run the shipped runner in each of python, rust, prolog, c, bash, unchanged, from a copy of its
  directory so that no shipped file is overwritten. A runner that cannot resolve its own paths may be
  repointed to your local copy; **disclose the change as a diff** and change nothing else — no oracle,
  no expected value, no assertion. Compare each record's result with the result the companion
  declares for it.
- **Record:** declared profile and observed profile per paradigm and per suite, each with the document
  you read it in; the number of records whose result differs from the declared one; the skip reasons.
  A run's completion marker and the companion's ledger may count over different denominators: name
  which figure you took (Ground Rule 7).

### 6 — Inspection of the observation record
- **Read, do not re-derive:** the mutation observations, the interpretation rules, the coverage trace
  and the auto-disclosure audit. Each states what it claims and what it declines to claim.
- **Record:** what each document declares, verbatim where you quote it, and any bound it places on
  itself. There is no expected value to reproduce.

---

## Part D — the promises

### 7 — What the whitepaper promises, shown on the package
- **Declared:** the map lists each promise of the family whitepaper, the address in the normative
  documents where the package defines what delivers it, and the records of the shipped suites that
  exercise it.
- **Reproduce:** for each promise, (1) read the definition at its address and quote it, with file and
  line; (2) take the result of each named record from check 5. Nothing else is asked: whether a record
  exercises a promise is fixed by the map, not by you, and a promise is never shown by searching for
  what is missing (Ground Rules 11 and 12).
- **Record:** per promise, the definition quoted at its address, and the result of each named record
  against the result the companion declares for it.

---

## Required report format

Before the first table, list the canonical set you identified, say how you read each file, and state
that you read it whole (Ground Rule 10).

**A. Integrity and identity**, **B. The specification**, **C. The evidence**, **D. The promises.** One table per part, one row
per criterion:

| Check | Declared value | Anchor | What it counts | Observed value | Result |
|---|---|---|---|---|---|
| … | … | document + section + line | the criterion this value is read on | … | `MATCH` / `MISMATCH` / `INCONCLUSIVE` / `NOT RUN` |

Every row states the anchor it read the declared value in, and what that value counts. Do not add
commentary to the tables.

Every `MISMATCH` row and every `INCONCLUSIVE` row carries one line beneath its table, and only those
rows do: **the document of the package that would have to change for the declared value to hold** (Ground
Rule 8), the statement that you read that document end to end, and what the confrontation of Ground
Rule 10 found. A row that cannot carry that line is withdrawn before the report is sent.

Part C carries, after its tables, a short **Observations** paragraph. Observations carry **no
verdict**: record what you saw, not what you conclude from it.

**E. Boundary.** State plainly what this run did not cover: your implementation and deployment
substrate; the obligations the package declares external; the component agents for themselves, each
verified by its own package's `verify.md`; the configuration you audited; whether the family is
correct for the inter-session continuity / family replay admissibility domain. State that the fail-closed behaviour of the family is shown on
the package's declarations (check 3) and on the records of the shipped suites that exercise it
(check 5), not by an enumeration of the integrator's states: the integrator has no input of its own
outside the composition.

**F. If this run is one of several.** Use the check identifiers, the map's row names and the four
status words exactly as given, so that two reports can be compared by a diff. If you depart from the
row keys, say so and give the mapping.

End with this line, verbatim:

> *The credibility of this report rests on the raw outputs above, which you can re-run independently —
> not on this prompt. Structural claims are verified by execution; semantic correctness against the
> domain remains a human judgment, deliberately not certified here.*

---

### Note on honesty (for you, the auditor)
The one failure mode that matters is a report claiming **more** than the raw outputs support: a match
where a check did not run, a completed status where a verifier failed, a reproduced profile you did
not actually observe. Report **less** than you proved, never more.

That rule runs in both directions. `MISMATCH` asserts that two things which ought to agree do not, and
`INCONCLUSIVE` asserts that you could not settle it. Both are claims about the package, and both cost
the reader real work to set aside. A conclusion formed before the confrontation and then confirmed by
it has not been tested. Name the document of the package first (Ground Rule 8), then compare.
