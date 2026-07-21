# Redraw B7 primary aggregate figures from public non-identifying inputs.
# This script does not access individual-participant data or local absolute paths.

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(readr)
  library(scales)
})

args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", args, value = TRUE)
script_dir <- if (length(file_arg) == 1) dirname(normalizePath(sub("^--file=", "", file_arg), mustWork = FALSE)) else file.path(getwd(), "R")
repo_root <- normalizePath(file.path(script_dir, ".."), mustWork = FALSE)
if (!dir.exists(file.path(repo_root, "data"))) repo_root <- normalizePath(getwd(), mustWork = FALSE)

input_path <- file.path(repo_root, "data", "aggregate_figure_inputs.csv")
output_dir <- file.path(repo_root, "outputs")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
dat <- read_csv(input_path, show_col_types = FALSE)

save_plot <- function(plot, stem, width = 9.4, height = 4.8) {
  ggsave(file.path(output_dir, paste0(stem, ".png")), plot, width = width, height = height, dpi = 300)
  ggsave(file.path(output_dir, paste0(stem, ".pdf")), plot, width = width, height = height)
}

primary <- dat %>%
  filter(analysis == "primary") %>%
  mutate(
    endpoint_label = factor(endpoint, levels = c("P1 non-fatal cardiovascular events", "P2 cardiovascular death")),
    exposure_label = factor(exposure, levels = c("Grip strength", "Multimorbidity", "Social engagement"))
  )

primary_plot <- ggplot(primary, aes(x = estimate, y = exposure_label, colour = exposure_label)) +
  geom_vline(xintercept = 1, linewidth = 0.4, linetype = "dashed", colour = "grey45") +
  geom_errorbar(aes(xmin = lower, xmax = upper), width = 0.18, linewidth = 0.7, orientation = "y") +
  geom_point(size = 2.7) +
  facet_wrap(~endpoint_label, nrow = 1) +
  scale_x_log10(limits = c(0.45, 1.55), breaks = c(0.5, 0.7, 1, 1.4), labels = number_format(accuracy = 0.1)) +
  scale_colour_manual(values = c("Grip strength" = "#2166AC", "Multimorbidity" = "#B2182B", "Social engagement" = "#4D9221")) +
  labs(
    x = "Hazard ratio per within-cohort 1-SD higher exposure", y = NULL,
    title = "Endpoint-specific associations in common fully adjusted cohort models",
    subtitle = "Random-effects meta-analysis; age, sex, education, marital status, income, smoking, alcohol use, and BMI"
  ) +
  theme_classic(base_size = 10) +
  theme(legend.position = "none", plot.title = element_text(face = "bold"))
save_plot(primary_plot, "Figure1_endpoint_specific_associations")

robustness <- dat %>%
  filter(analysis != "primary", exposure == "Grip strength") %>%
  mutate(
    endpoint_label = factor(endpoint, levels = c("P1 non-fatal cardiovascular events", "P2 cardiovascular death")),
    analysis_label = factor(analysis, levels = rev(unique(analysis)))
  )

robustness_plot <- ggplot(robustness, aes(x = estimate, y = analysis_label)) +
  geom_vline(xintercept = 1, linewidth = 0.4, linetype = "dashed", colour = "grey45") +
  geom_errorbar(aes(xmin = lower, xmax = upper), width = 0.18, linewidth = 0.7, orientation = "y", na.rm = TRUE) +
  geom_point(size = 2.5, colour = "#2166AC") +
  facet_wrap(~endpoint_label, scales = "free_y") +
  scale_x_log10(limits = c(0.45, 1.1), breaks = c(0.5, 0.7, 1.0)) +
  labs(x = "Hazard ratio per within-cohort 1-SD higher grip", y = NULL, title = "Grip-strength robustness analyses") +
  theme_classic(base_size = 10)
save_plot(robustness_plot, "Supplementary_grip_robustness", width = 9.4, height = 5.0)

message("Wrote aggregate figures to: ", output_dir)
