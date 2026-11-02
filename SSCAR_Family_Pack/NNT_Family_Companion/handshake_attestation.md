# NNT — Handshake attestation for FAM-SSCAR-FI-001

> Companion-bounded record of the live-handshake check (live-handshake gate). This file is evidence that the run was executed against live toolchains, not via static-trace fallback. Every claim below is bounded to this single NNT run on this version of the agent pack.

## Run-level configuration

- `reconstruction_permissions.mode`: `broad`
- `binary_provenance.mode`: `trusted-path`

### Declared residual contamination axis

- **Session permission breadth**: the test run was started in a `broad-permission` mode. The reconstruction execution surface was wider than the minimum required for the 6 declared toolchain paths. This is the documented residual axis for the default NNT mode. Readers re-running this NNT in `reconstruction_permissions.mode: allowlist` would zero this axis.

Other residual axes (reconstruction prompt-author, model, training data) are shared across all 5 paradigm reconstructions and declared in the NNT methodology.

## Per-paradigm handshake records

### python

- Toolchain ACK: PASS
  - Sentinel captured: `hello, NNT-python`
  - First line of `toolchain_ack.txt`: `hello, NNT-python`
- Comprehension ACK: PASS
  - Sentences (period-terminated): 4
  - Citations resolved (2):
    - `SSCAR_README.md:92` (text; matched keywords: annex, boundary, component, conforming, executable)
    - `SSCAR_Whitepaper.html:1090` (text; matched keywords: fail, family, rather, shape, state)

### rust

- Toolchain ACK: PASS
  - Sentinel captured: `hello, NNT-rust`
  - First line of `toolchain_ack.txt`: `hello, NNT-rust`
- Comprehension ACK: PASS
  - Sentences (period-terminated): 4
  - Citations resolved (2):
    - `SSCAR_README.md:92` (text; matched keywords: annex, decision, fail-closed, family, integrator)
    - `SSCAR_Specification.md:167` (text; matched keywords: evidence, family, readmission, verdict)

### prolog

- Toolchain ACK: PASS
  - Sentinel captured: `hello, NNT-prolog`
  - First line of `toolchain_ack.txt`: `hello, NNT-prolog`
- Comprehension ACK: PASS
  - Sentences (period-terminated): 4
  - Citations resolved (2):
    - `SSCAR_README.md:92` (text; matched keywords: annex, component, conforming, executable, fail-closed)
    - `SSCAR_Conformance_Tests.md:208` (text; matched keywords: expose, familynormativeverdict, familyworkflowstate, fev-, foc-)

### c

- Toolchain ACK: PASS
  - Sentinel captured: `hello, NNT-c`
  - First line of `toolchain_ack.txt`: `hello, NNT-c`
- Comprehension ACK: PASS
  - Sentences (period-terminated): 4
  - Citations resolved (2):
    - `SSCAR_README.md:92` (text; matched keywords: annex, conforming, decision, executable, fail-closed)
    - `SSCAR_Coverage_Matrix.md:107` (text; matched keywords: closure, family, rehydration, replay, validator)

### bash

- Toolchain ACK: PASS
  - Sentinel captured: `hello, NNT-bash`
  - First line of `toolchain_ack.txt`: `hello, NNT-bash`
- Comprehension ACK: PASS
  - Sentences (period-terminated): 5
  - Citations resolved (2):
    - `SSCAR_README.md:105` (text; matched keywords: against, conformance, directly, drives, gate)
    - `SSCAR_Semantic_Index.yaml:1117` (text; matched keywords: closure, composes, cross-domain, decision, family)

