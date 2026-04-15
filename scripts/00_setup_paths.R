# =============================================================================
# Study 28: Grip strength, social engagement, multimorbidity -> CV composite
# Script: 00_setup_paths.R — global paths, package loading, constants
# =============================================================================

# ---- 1. Packages ------------------------------------------------------------
required_pkgs <- c(
  "haven", "dplyr", "tidyr", "purrr", "stringr", "forcats",
  "data.table", "readr", "fs", "here",
  "survival", "rms", "mgcv", "splines", "cmprsk", "riskRegression",
  "JMbayes2", "CMAverse", "metafor", "meta",
  "mice", "WeightIt", "ipw", "cobalt",
  "gtsummary", "broom", "broom.mixed",
  "ggplot2", "patchwork", "scales", "viridis"
)
missing_pkgs <- required_pkgs[!sapply(required_pkgs, requireNamespace, quietly = TRUE)]
if (length(missing_pkgs) > 0) {
  message("Missing packages, please install: ", paste(missing_pkgs, collapse = ", "))
}
invisible(lapply(required_pkgs, function(p) {
  suppressMessages(require(p, character.only = TRUE))
}))

# ---- 2. Data root paths (users should edit to local paths) -----------------
EXT_BASE    <- "<LOCAL_PATH>/cohort_data"
NHANES_BASE <- "<LOCAL_PATH>/NHANES"

COHORT_PATHS <- list(
  CHARLS = file.path(EXT_BASE, "CHARLS"),
  ELSA   = file.path(EXT_BASE, "ELSA"),
  HRS    = file.path(EXT_BASE, "HRS"),
  KLoSA  = file.path(EXT_BASE, "KLoSA"),
  LASI   = file.path(EXT_BASE, "LASI"),
  MHAS   = file.path(EXT_BASE, "MHAS"),
  SHARE  = file.path(EXT_BASE, "SHARE")
)

AUX_PATHS <- list(NHANES = NHANES_BASE)

HARMONIZED_HINTS <- list(
  CHARLS = "Harmonized_CHARLS_D",
  ELSA   = "Harmonized ELSA",
  HRS    = "H_HRS_d.dta",
  KLoSA  = "H_KLoSA",
  LASI   = "Harmonized LASI (A.3)",
  MHAS   = "Harmonized MHAS File",
  SHARE  = "Harmonized SHARE"
)

# ---- 3. Project working directory ------------------------------------------
PROJ_ROOT  <- "<LOCAL_PATH>/study28_cardiovascular_aging_ipd"
DATA_DIR   <- file.path(PROJ_ROOT, "data")
SCRIPT_DIR <- file.path(PROJ_ROOT, "scripts")
RESULT_DIR <- file.path(PROJ_ROOT, "results")
FIG_DIR    <- file.path(PROJ_ROOT, "figures")
TAB_DIR    <- file.path(PROJ_ROOT, "tables")
LOG_DIR    <- file.path(PROJ_ROOT, "logs")

for (d in c(DATA_DIR, RESULT_DIR, FIG_DIR, TAB_DIR, LOG_DIR)) {
  dir.create(d, showWarnings = FALSE, recursive = TRUE)
}

# ---- 4. Analytic constants --------------------------------------------------
MIN_AGE_BASELINE <- 50

GRIP_KNOTS   <- c(0.05, 0.275, 0.50, 0.725, 0.95)   # 5 knots
SOCIAL_KNOTS <- c(0.10, 0.50, 0.90)                  # 3 knots
MORB_KNOTS   <- c(0.05, 0.35, 0.65, 0.95)            # 4 knots

RANDOM_SEED  <- 20260414
N_IMPUTE     <- 20
N_BOOTSTRAP  <- 1000

CV_COMPONENTS_PRIMARY   <- c("cv_death", "nonfatal_mi", "stroke", "hf_event")
CV_COMPONENTS_SECONDARY <- c("cv_death", "nonfatal_mi", "stroke")
COMPETING_EVENT         <- "non_cv_death"

COUNTRY_MODERATORS <- c("gdp_per_capita", "uhc_index", "aging_rate",
                        "health_expenditure_pct_gdp", "gini")

# ---- 5. Utility functions ---------------------------------------------------
log_step <- function(msg, script = "") {
  ts <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  cat(sprintf("[%s] [%s] %s\n", ts, script, msg))
  logf <- file.path(LOG_DIR, sprintf("run_%s.log", format(Sys.Date(), "%Y%m%d")))
  cat(sprintf("[%s] [%s] %s\n", ts, script, msg), file = logf, append = TRUE)
}

check_cohort_paths <- function() {
  all_paths <- c(COHORT_PATHS, AUX_PATHS)
  status <- sapply(names(all_paths), function(c) dir.exists(all_paths[[c]]))
  data.frame(
    source = names(status),
    role   = c(rep("primary", length(COHORT_PATHS)),
               rep("auxiliary", length(AUX_PATHS))),
    exists = status,
    path   = unlist(all_paths),
    row.names = NULL
  )
}

log_step("setup_paths initialised", "00_setup_paths.R")
