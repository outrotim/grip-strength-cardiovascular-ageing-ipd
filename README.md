# Endpoint-specific grip-strength signal in cardiovascular ageing

This repository contains the minimal public code and aggregate inputs for the manuscript:

> Endpoint Specificity Reveals a Grip-Strength Signal in Cardiovascular Ageing Across Six Harmonised Cohorts: Stage-Specific and Biomarker-Triangulated Evidence

The repository is intentionally small. It does not contain individual-participant data, restricted cohort files, model objects, imputed datasets, or any intermediate person-level derivatives.

## Repository contents

| Path | Purpose |
|---|---|
| `R/model_formula_templates.R` | Formula-level templates for the main Cox, Fine-Gray, random-effects meta-analysis, mediation, E-value, and clinical-translation analyses. |
| `R/redraw_main_figures.R` | Recreates publication-style summary panels from the aggregate CSV files in `data/`. |
| `data/aggregate_figure_inputs.csv` | Aggregate estimates used to redraw endpoint-gradient, stage-specific, biomarker, triangulation, and clinical-translation panels. |
| `data/model_parameter_manifest.csv` | Non-identifying model and analysis parameter manifest. |
| `environment.yml` | Minimal R/Python environment description. |
| `LICENSE` | MIT license for code and CC-BY 4.0 notice for aggregate parameter/input files. |

## Data availability

Individual-participant data are not redistributed here. The primary analyses used Gateway-to-Global-Aging harmonised releases from CHARLS, ELSA, HRS, KLoSA, MHAS, and SHARE, plus NHANES 2011-2014 linked to the NCHS 2019 public-use mortality file. Access to the ageing-cohort individual-participant data remains governed by the original cohort data-use agreements and must be obtained directly from the relevant data providers. Although NHANES and its public-use mortality file are available from their primary source, this repository does not redistribute source rows, analytic derivatives, or linked person-level records from those resources.

This repository shares only:

- formula-level analysis templates;
- non-identifying analysis parameters;
- aggregate hazard ratios, odds ratios, confidence intervals, event counts, heterogeneity statistics, and clinical-translation summaries already reported in the manuscript or supplement.

It does not share:

- raw or harmonised participant-level data;
- person-wave data;
- imputed datasets;
- End-of-Life cause-of-death files;
- RDS model objects;
- notebook outputs;
- local data paths or credentials.

## Basic use

Create the environment:

```bash
conda env create -f environment.yml
conda activate grip-cv-ageing-open
```

Run the aggregate figure redraw script:

```bash
Rscript R/redraw_main_figures.R
```

The script writes PNG and PDF outputs to `outputs/`. These figures are intended for transparency and verification of the public aggregate inputs; they are not a substitute for access to the restricted individual-participant data.

## Important caveats

- The scripts here cannot recreate the full individual-participant-data pipeline because those data cannot be redistributed by a secondary-analysis group.
- The aggregate inputs are suitable for checking reported estimate directions, endpoint gradients, and figure logic.
- The 25 kg grip reference is a practical risk-stratification reference from the observed spline analysis, not a diagnostic or intervention threshold.
- Clinical-translation summaries such as PAF, decision-curve windows, and trial sample-size scenarios are observational and should be interpreted as hypothesis-generating.
- Genetic-instrumental analyses support coronary disease and myocardial infarction only; they do not establish trial-level causality for all cardiovascular endpoints.

## Licenses

Code in `R/` is released under the MIT License.

Aggregate input tables in `data/` are released under the Creative Commons Attribution 4.0 International License (CC-BY 4.0). See `LICENSE` for details.

## Citation

Please cite the associated manuscript:

Zhang W, Xia Y, et al. Endpoint Specificity Reveals a Grip-Strength Signal in Cardiovascular Ageing Across Six Harmonised Cohorts: Stage-Specific and Biomarker-Triangulated Evidence. Manuscript submitted. Replace this placeholder with the journal citation and DOI after publication.
