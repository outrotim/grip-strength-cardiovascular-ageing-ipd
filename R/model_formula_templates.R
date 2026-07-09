# Formula-level templates for the grip-strength cardiovascular ageing IPD analysis.
#
# This file intentionally contains no individual-participant data and no local
# file paths. It documents the estimands and model structure used in the
# manuscript. To run these templates, researchers must obtain the source data
# from the original cohort providers and construct a compatible analysis data
# frame under their own data-use agreements.

required_packages <- c(
  "survival",
  "splines",
  "metafor",
  "cmprsk"
)

check_required_packages <- function() {
  missing <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing) > 0) {
    stop("Install required R packages first: ", paste(missing, collapse = ", "))
  }
  invisible(TRUE)
}

analysis_covariates_model3 <- c(
  "age",
  "sex",
  "education",
  "marital_status",
  "urban_rural",
  "income_quintile",
  "smoking_status",
  "alcohol_use",
  "physical_activity"
)

primary_cox_formula <- function(exposure = "grip_z") {
  as.formula(paste(
    "survival::Surv(follow_up_years, event) ~",
    exposure,
    "+ age + sex + education + marital_status + urban_rural +",
    "income_quintile + smoking_status + alcohol_use +",
    "splines::ns(bmi, df = 3) + physical_activity + strata(cohort)"
  ))
}

restricted_cubic_spline_formula <- function(exposure = "grip_kg") {
  as.formula(paste(
    "survival::Surv(follow_up_years, event) ~",
    "splines::ns(", exposure, ", knots = grip_internal_knots) +",
    "age + sex + education + marital_status + urban_rural +",
    "income_quintile + smoking_status + alcohol_use +",
    "splines::ns(bmi, df = 3) + physical_activity + strata(cohort)"
  ))
}

grip_rcs_knot_probs <- c(0.05, 0.275, 0.50, 0.725, 0.95)
bonferroni_primary_threshold <- 0.0125

fit_one_stage_cox <- function(data, exposure = "grip_z") {
  check_required_packages()
  survival::coxph(primary_cox_formula(exposure), data = data, ties = "efron")
}

fit_two_stage_meta <- function(per_cohort_log_hr) {
  check_required_packages()
  metafor::rma(
    yi = log_hr,
    sei = se_log_hr,
    data = per_cohort_log_hr,
    method = "REML"
  )
}

fit_fine_gray_template <- function(data, covariate_matrix) {
  check_required_packages()
  cmprsk::crr(
    ftime = data$follow_up_years,
    fstatus = data$event_code,
    cov1 = covariate_matrix,
    failcode = 1,
    cencode = 0
  )
}

e_value_rr <- function(rr) {
  rr <- ifelse(rr < 1, 1 / rr, rr)
  rr + sqrt(rr * (rr - 1))
}

population_attributable_fraction <- function(prevalence, relative_risk) {
  prevalence * (relative_risk - 1) / (prevalence * (relative_risk - 1) + 1)
}

delta_c <- function(c_augmented, c_baseline) {
  c_augmented - c_baseline
}

mediation_difference_method_template <- function(total_model, direct_model) {
  beta_total <- stats::coef(total_model)
  beta_direct <- stats::coef(direct_model)
  (beta_total - beta_direct) / beta_total
}

message(
  "Templates loaded. These functions document model structure only; ",
  "they do not include or download restricted cohort data."
)
