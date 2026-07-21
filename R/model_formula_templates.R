# Formula-level templates for the B7 result-locked analysis.
#
# This file contains no individual-participant data, local paths, or credentials.
# Researchers must obtain source data directly from each original provider and
# implement compatible variables under their approved data-use agreements.

required_packages <- c("survival", "splines", "metafor", "cmprsk")

check_required_packages <- function() {
  missing <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing)) stop("Install required R packages: ", paste(missing, collapse = ", "))
  invisible(TRUE)
}

b7_common_covariates <- c(
  "baseline_age", "baseline_sex", "educ_level",
  "marital_cat", "income_q", "smoke_cat", "drink_bin", "bmi"
)

b7_cox_formula <- function(time = "follow_up_years", event = "event", exposure = "exposure_sd") {
  as.formula(paste(
    "survival::Surv(", time, ", ", event, ") ~ ", exposure,
    " + baseline_age + baseline_sex + educ_level +",
    " I(marital_cat == 'married') + income_q + factor(smoke_cat) +",
    " drink_bin + splines::ns(bmi, df = 3)"
  ))
}

fit_b7_cohort_cox <- function(data, time = "follow_up_years", event = "event", exposure = "exposure_sd") {
  check_required_packages()
  survival::coxph(b7_cox_formula(time, event, exposure), data = data, ties = "efron")
}

fit_b7_reml_meta <- function(per_cohort_log_hr) {
  check_required_packages()
  metafor::rma(yi = log_hr, sei = se_log_hr, data = per_cohort_log_hr, method = "REML")
}

fit_b7_fine_gray <- function(data, covariate_matrix) {
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

message("B7 result-locked formula templates loaded.")
