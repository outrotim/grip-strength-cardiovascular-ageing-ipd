# Analytical pipeline — script index

The full analytical pipeline comprises 46 numbered R and Python scripts covering harmonisation, pooled Cox, causal triangulation, sensitivity analyses, and figure/table generation. The full set will be pushed to this repository prior to manuscript acceptance; this index describes each script's role so that reviewers can request specific components on demand during peer review.

| # | File | Language | Role |
|---|------|----------|------|
| 00 | `00_setup_paths.R` | R | Paths, packages, constants, logging |
| 01 | `01_cv_outcome_audit.R` | R | Per-cohort CV outcome availability audit |
| 01b | `01b_build_variable_dictionary.py` | Python | Harmonised variable dictionary builder |
| 02 | `02_harmonize_panel.R` | R | Six-cohort panel harmonisation |
| 03 | `03_derive_outcomes.R` | R | P1 non-fatal CV + P2 cause-specific fatal CV derivation |
| 04 | `04_derive_covariates.R` | R | Model 1–4 covariate construction |
| 05 | `05_pilot_hrs_charls.R` | R | HRS–CHARLS pilot validation |
| 06 | `06_rcs_cox_pooled.R` | R | Restricted-cubic-spline pooled Cox |
| 07 | `07_tensor_surface_gam.R` | R | Three-way tensor interaction (`mgcv::gam`) |
| 08 | `08_competing_risk.R` | R | Fine-Gray sub-distribution hazards |
| 09 | `09_mediation_simple.R` | R | Regression-based difference-method mediation |
| 10 | `10_country_meta_regression.R` | R | Country-level meta-regression (`metafor::rma`) |
| 11 | `11_sensitivity.R` | R | Leave-one-cohort-out, 5-y lag, sex/age strata |
| 12 | `12_figures_tables.R` | R | Exploratory figures + Table 1 |
| 13 | `13_mice_imputation.R` | R | MICE multiple imputation (m = 20) |
| 14 | `14_addons_quick.R` | R | E-value, LOO, PAF quick add-ons |
| 15 | `15_cmaverse_mediation.R` | R | Counterfactual mediation via `CMAverse` |
| 16 | `16_cv_cause_probe.R` | R | End-of-Life cause variable audit |
| 17 | `17_nhanes_validation.R` | R | NHANES–NCHS 2019 external validation |
| 18 | `18_mr_grip_cv_STUB.R` | R | Two-sample MR skeleton (superseded by 31) |
| 19 | `19_joint_model_STUB.R` | R | Joint longitudinal–survival skeleton (superseded by 34) |
| 20 | `20_bayesian_brms_STUB.R` | R | Bayesian meta-analysis skeleton (superseded by 35) |
| 21 | `21_multistate_STUB.R` | R | Multi-state skeleton (superseded by 32) |
| 22 | `22_rederive_dual_endpoints.R` | R | Dual-endpoint re-derivation (post-protocol-revision) |
| 23 | `23_pooled_cox_dual.R` | R | Dual-endpoint pooled Cox |
| 24 | `24_dual_supporting.R` | R | Supporting analyses for dual endpoints |
| 25 | `25_dual_figures.R` | R | Dual-endpoint figures |
| 26 | `26_prediction_intervals.R` | R | τ²-based 95% prediction intervals |
| 27 | `27_table1_dual.R` | R | Table 1 baseline characteristics |
| 28 | `28_supp_tables_A2_A3.py` | Python | Supplementary Tables block A |
| 29 | `29_supp_tables_B_block.py` | Python | Supplementary Tables block B |
| 30 | `30_DAG_causal.R` | R | Preliminary causal DAG |
| 31 | `31_MR_grip_CV.R` | R | Two-sample MR: grip → CHD/MI/Stroke/AF |
| 32 | `32_multistate_model.R` | R | Multi-state Cox by baseline multimorbidity |
| 33 | `33_biomarker_mediation.R` | R | CHARLS biomarker mediation (CRP, HbA1c, HDL, TC) |
| 34 | `34_jm_grip_cv.R` | R | Joint longitudinal–survival model (`JMbayes2`) |
| 35 | `35_bayesian_hierarchical.R` | R | HKSJ small-sample adjustment + Bayesian robustness |
| 36 | `36_dca_paf_rct.R` | R | Decision-curve, PAF, grip threshold, RCT sample size |
| 37 | `37_concept_figure.R` | R | Main Figure 2 (three integrated features) |
| 38 | `38_main_figure3_causal.R` | R | Main Figure 3 (causal triangulation) |
| 39 | `39_main_figure1_flow_map.R` | R | Main Figure 1 (study design + STROBE-IPD flow) |
| 40 | `40_main_table2_dual.py` | Python | Main Table 2 assembly |
| 41 | `41_supp_figures.R` | R | Supplementary Figures S3, S4, S5, S8 |
| 42 | `42_number_consistency_audit.py` | Python | Number-consistency audit across manuscript/tables/figures |
| 43 | `43_overstatement_scan.py` | Python | Causal-language overstatement scan |
| 45 | `45_final_proof_pass.py` | Python | Final pre-submission proof pass |
| 46 | `46_supp_fig_S12_DAG.R` | R | Supplementary Figure S6 — causal DAG |
