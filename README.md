# Integrated Geroscience Framework for Cardiovascular Ageing

Analysis code for the manuscript:

> **Integrated Geroscience Framework for Cardiovascular Ageing: Endpoint Specificity, Timing, and Differential Biomarker Profiles of Grip Strength, Social Engagement, and Multimorbidity Across Six Cohorts**
>
> Submitted to *The Lancet Healthy Longevity* (2026).

---

## What this repository contains

R and Python scripts that reproduce the analyses reported in the manuscript and its supplementary materials. This is a code-only deposit; no individual-participant data are included.

The analytical pipeline covers:

- Harmonisation of six Gateway-to-Global-Aging cohorts (CHARLS, ELSA, HRS, KLoSA, MHAS, SHARE)
- Dual-primary-endpoint pooled Cox regression (non-fatal CV and cause-specific fatal CV)
- NHANES 2011–2014 with NCHS 2019 linked-mortality external validation
- Two-sample Mendelian randomization (`TwoSampleMR` / IEU OpenGWAS)
- Joint longitudinal–survival modelling (`JMbayes2`)
- Multi-state and competing-risk analyses (Fine-Gray)
- Biomarker mediation (regression-based + `CMAverse` counterfactual)
- REML random-effects meta-analysis with τ²-based prediction intervals and HKSJ small-sample adjustment
- Clinical-translation analyses: Harrell's C, decision-curve, PAF, grip-strength threshold, hypothetical RCT sample size
- Causal DAG (`ggdag` / `dagitty`)

## Data sources

| Source | Access |
|--------|--------|
| CHARLS, ELSA, HRS, KLoSA, MHAS, SHARE harmonised files | [Gateway to Global Aging](https://g2aging.org) |
| Gateway End-of-Life sub-files (HRS, MHAS, SHARE) | Gateway End-of-Life module application |
| NHANES 2011–2014 examination data | [CDC NCHS](https://www.cdc.gov/nchs/nhanes/) |
| NCHS 2019 Public-Use Linked Mortality File | [CDC NCHS](https://www.cdc.gov/nchs/data-linkage/mortality-public.htm) |
| Grip-strength GWAS instruments | UK Biobank via IEU OpenGWAS (`ukb-b-10215`) |
| CVD outcome GWAS | `ieu-a-7` (CHD), `ieu-a-798` (MI), `ebi-a-GCST005838` (stroke), `ebi-a-GCST006414` (AF) |

This repository **does not redistribute any of the underlying data**.

## Repository status

This is the minimal public deposit accompanying the submitted manuscript. The full set of 46 numbered analytical scripts is being prepared for public release; the index below describes the complete pipeline. The complete script set will be pushed to this repository before manuscript acceptance, and a release tag with a frozen commit hash will be attached for citation.

See `scripts/INDEX.md` for the full list of analytical scripts (00–46) with their role in the pipeline.

## Citation

If you use code or derived variables from this repository, please cite the forthcoming manuscript. A versioned release will be tagged at the time of journal publication.

## Licence

Code is released under the **MIT License** (see `LICENSE`). Outputs derived from third-party cohort data remain subject to the original cohorts' data-use agreements.

## Contact

Open an issue for code-related questions. Scientific questions should be addressed to the corresponding author listed on the published manuscript.
