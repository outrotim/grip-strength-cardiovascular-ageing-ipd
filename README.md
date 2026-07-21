# Grip Strength and Cardiovascular Ageing Across Six Harmonised Cohorts

This repository contains the minimal public code and aggregate inputs supporting the B7 result-locked manuscript:

> Grip Strength and Cardiovascular Ageing Across Six Harmonised Cohorts: Endpoint-Specific Associations

The repository is intentionally small. It contains no individual-participant data, restricted cohort files, model objects, imputed datasets, intermediate person-level derivatives, local paths, or credentials.

## What this release supports

The release documents a coordinated individual-participant-data analysis of six ageing cohorts. The primary estimand is a cohort-specific, fully adjusted Cox association per within-cohort SD higher exposure, pooled with random-effects REML meta-analysis.

The final common covariate set is age, sex, education, marital status, within-cohort income quintile, smoking, alcohol use, and BMI modelled with a natural spline. Rural residence and physical activity are not in the six-cohort primary model because directly comparable definitions were unavailable across all cohorts.

## Repository contents

| Path | Purpose |
|---|---|
| `R/model_formula_templates.R` | Formula-level templates for the B7 Cox, REML meta-analysis, Fine-Gray, and E-value analyses. |
| `R/redraw_main_figures.R` | Redraws the primary endpoint-specific and grip-robustness figures from aggregate CSV inputs. |
| `data/aggregate_figure_inputs.csv` | Non-identifying B7 aggregate estimates used for figure redraw. |
| `data/model_parameter_manifest.csv` | Non-identifying analysis and data-boundary manifest. |
| `environment.yml` | Minimal R/Python environment description. |
| `LICENSE` | MIT license for code and CC-BY 4.0 notice for aggregate inputs. |

## Data availability

Individual-participant data are not redistributed. The primary analyses used Gateway-to-Global-Aging harmonised releases from CHARLS, ELSA, HRS, KLoSA, MHAS, and SHARE. Access remains governed by the original data-use agreements and must be obtained directly from the relevant data providers. NHANES and its public-use linked mortality file are also not redistributed by this repository.

This repository shares only formula templates, non-identifying analysis parameters, and aggregate estimates reported in the manuscript and supplement. It does not share raw or harmonised participant-level data, person-wave data, imputed data, End-of-Life cause-of-death files, RDS objects, notebook outputs, or credentials.

## Basic use

```bash
conda env create -f environment.yml
conda activate grip-cv-ageing-open
Rscript R/redraw_main_figures.R
```

The script writes PNG and PDF outputs to `outputs/`. These are transparency figures produced only from the included aggregate inputs; they are not a substitute for access to the restricted data.

## Interpretation boundaries

- The reported hazard ratios are observational associations, not intervention effects.
- P1 is self-reported non-fatal cardiovascular disease. P2 is cause-specific cardiovascular death, available in HRS, MHAS, and SHARE through End-of-Life linkage.
- P2 includes an MHAS contribution with 17 cardiovascular deaths; a two-cohort sparse-event sensitivity is provided in the aggregate inputs.
- The B7 covariate-harmonisation correction was post hoc after an internal reproducibility audit. It did not alter exposures, outcomes, follow-up, cohort membership, or participant identifiers.
- The public code cannot reproduce the complete restricted IPD pipeline.

## Licenses

Code in `R/` is released under the MIT License. Aggregate, non-identifying input tables in `data/` are released under CC-BY 4.0.

## Citation

Zhang W, Xia Y, et al. Grip Strength and Cardiovascular Ageing Across Six Harmonised Cohorts: Endpoint-Specific Associations. Manuscript submitted. Replace this placeholder with the journal citation and DOI after publication.
