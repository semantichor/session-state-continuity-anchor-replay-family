# Session State Continuity & Anchor Replay Family (FAM-SSCAR)

A family specification package, distributed free of charge. It defines the normative boundary and decision logic of the SSCAR family: its component agents, its family integrator, and the composed family-level verdict that none of the components produces alone.

Family page: https://semantichor.com/families/sscar/

## License and acceptance

The package is governed by the SSCAR family License, included as `SSCAR_Family_Pack/SSCAR_Family_License.md`. In its words:

> Where you obtained the package otherwise than at the point of distribution, you accept this license by accepting it at semantichor.com, in the same two confirmations, before any use of the package.

> A copy of the package held without acceptance confers nothing.

Acceptance page: https://semantichor.com/families/sscar/license/

The supplementary derivations carry their own rights statement, in the "Rights and use" section of `SSCAR_Family_Supplement/README.md`.

## Contents

| Folder | Content | Archived record |
|---|---|---|
| `SSCAR_Family_Pack/` | The package, 210 files, as distributed | https://doi.org/10.5281/zenodo.23895082 |
| `SSCAR_Family_Supplement/` | The supplementary derivations, 28 files | https://doi.org/10.5281/zenodo.23896482 |

Both folders are byte-identical to the archived ZIP files. Release v1.1.0 of this repository carries the same two ZIP files.

## Integrity

| Item | SHA-256 |
|---|---|
| `SSCAR_Family_Pack.zip` | `df876868946c5166f7279b3b0226d2bd01b8d4a3b2651075cea70692ebf51994` |
| manifest_ref (SHA-256 of `SSCAR_Family_Manifest.sha256`, bound in the License) | `33ae0304298fe8891231455741dc512404cef9406e0f1c2ed5499945a3b497f5` |
| integrator manifest_ref (SHA-256 of `UNIT/FAM-SSCAR-FI-001/SSCAR_Manifest.sha256`) | `be319c25a82ffe4407fa8a91a51f283f1f50e524bfdb8af9845cd220b8903784` |
| `SSCAR_Family_Supplement.zip` | `92a6011fb627f0af4f39292dc0a9f63f72e6f41676dae8beb66121e490a621fc` |
| Supplement Manifest (`SSCAR_Family_Supplement_Manifest.json`) | `bfa5075282164beb690ee5a09169b7af5255fe1c6e31764cd4b950ea70897f75` |

## Checking a clone

```text
cd SSCAR_Family_Pack
sha256sum -c SSCAR_Family_Manifest.sha256
cd ../SSCAR_Family_Supplement
python verify_anchor.py ../SSCAR_Family_Pack/SSCAR_Family_Manifest.sha256
```

The second check prints the supplement Manifest's SHA-256, which equals the value above. The package's own runbook, `SSCAR_Family_Pack/verify.md`, governs the verification of the package.

The `.gitattributes` file at the repository root (`* -text`) keeps every file byte-identical on checkout, on every operating system. The supplement verifier inventories its folder recursively, so a file added inside that folder makes the check fail.
