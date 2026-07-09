# Recreate aggregate figure panels from public, non-identifying inputs.
#
# This script reads only CSV files included in this repository. It does not
# access individual-participant data, restricted cohort files, model objects, or
# local absolute paths.

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(readr)
})

cmd_args <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", cmd_args, value = TRUE)
script_dir <- if (length(file_arg) == 1) {
  dirname(normalizePath(sub("^--file=", "", file_arg), mustWork = FALSE))
} else {
  file.path(getwd(), "R")
}

repo_root <- normalizePath(file.path(script_dir, ".."), mustWork = FALSE)
if (!dir.exists(file.path(repo_root, "data"))) {
  repo_root <- normalizePath(getwd(), mustWork = FALSE)
}

input_path <- file.path(repo_root, "data", "aggregate_figure_inputs.csv")
output_dir <- file.path(repo_root, "outputs")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

dat <- readr::read_csv(input_path, show_col_types = FALSE, na = c("NA", ""))

save_panel <- function(plot, stem, width = 7, height = 4.5) {
  ggplot2::ggsave(file.path(output_dir, paste0(stem, ".png")), plot, width = width, height = height, dpi = 300)
  ggplot2::ggsave(file.path(output_dir, paste0(stem, ".pdf")), plot, width = width, height = height)
}

ratio_rows <- dat %>%
  filter(panel %in% c("endpoint_gradient", "stage_specific", "triangulation"),
         estimate_type != "p value") %>%
  mutate(label = factor(label, levels = rev(unique(label))))

endpoint_plot <- dat %>%
  filter(panel == "endpoint_gradient") %>%
  mutate(label = factor(label, levels = label)) %>%
  ggplot(aes(x = label, y = estimate, ymin = lower, ymax = upper)) +
  geom_hline(yintercept = 1, linetype = "dashed", colour = "grey50") +
  geom_pointrange(size = 0.55, colour = "#0f4c4c") +
  geom_text(aes(label = ifelse(is.na(i2), "", paste0("I2=", i2, "%"))),
            nudge_y = -0.07, size = 3, colour = "grey30") +
  scale_y_log10(limits = c(0.25, 1.2), breaks = c(0.3, 0.5, 0.7, 1.0)) +
  labs(x = NULL, y = "Hazard ratio per 1-SD higher grip",
       title = "Endpoint-specificity gradient") +
  theme_minimal(base_size = 11) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

stage_plot <- dat %>%
  filter(panel == "stage_specific") %>%
  mutate(label = factor(label, levels = rev(label))) %>%
  ggplot(aes(x = estimate, y = label, xmin = lower, xmax = upper)) +
  geom_vline(xintercept = 1, linetype = "dashed", colour = "grey50") +
  geom_pointrange(size = 0.55, colour = "#7a4b00") +
  scale_x_log10(limits = c(0.75, 1.25), breaks = c(0.8, 0.9, 1.0, 1.1, 1.2)) +
  labs(x = "Hazard ratio per 1-SD higher grip", y = NULL,
       title = "Stage-specific pattern") +
  theme_minimal(base_size = 11)

biomarker_plot <- dat %>%
  filter(panel == "biomarker_mediation") %>%
  mutate(label = factor(label, levels = rev(unique(label)))) %>%
  ggplot(aes(x = estimate, y = label, colour = domain)) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_point(size = 2) +
  geom_errorbar(aes(xmin = lower, xmax = upper), orientation = "y", width = 0.16, na.rm = TRUE) +
  labs(x = "Proportion mediated (%)", y = NULL,
       title = "Candidate biomarker separation", colour = NULL) +
  theme_minimal(base_size = 11)

clinical_plot <- dat %>%
  filter(panel == "clinical_translation") %>%
  mutate(label = factor(label, levels = rev(label))) %>%
  ggplot(aes(x = estimate, y = label)) +
  geom_col(fill = "#374151", width = 0.65) +
  facet_wrap(~ unit, scales = "free_x") +
  labs(x = NULL, y = NULL, title = "Clinical-translation summary") +
  theme_minimal(base_size = 11)

save_panel(endpoint_plot, "endpoint_gradient")
save_panel(stage_plot, "stage_specific")
save_panel(biomarker_plot, "biomarker_separation")
save_panel(clinical_plot, "clinical_translation", width = 8, height = 5)

message("Wrote aggregate figure panels to: ", output_dir)
