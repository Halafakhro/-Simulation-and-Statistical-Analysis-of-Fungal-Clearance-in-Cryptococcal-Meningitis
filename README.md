# Cryptococcal Meningitis Induction Therapy Simulation

This project simulates a clinical dataset in **R** to evaluate the **efficacy of three antifungal induction regimens**—7-day, 14-day, and 21-day treatments—in patients with cryptococcal meningitis. The goal is to analyze fungal clearance trends over time and determine the optimal duration of induction therapy using statistical methods and visualization.

## 📊 Objective

To compare the **mean fungal burden** across three treatment arms and identify which regimen achieves the greatest fungal clearance both at the end of induction and at a 10-week follow-up.

## 🧪 Methodology

- **Simulated data generation**:
  - Baseline fungal burden: ~10⁵ CFU/mL across all groups.
  - Admission (Day -1): ~10⁴.⁸ CFU/mL.
  - Induction completion:
    - 7-day: ~10⁴.⁶  
    - 14-day: ~10⁴.⁴  
    - 21-day: ~10⁴.²  
  - Follow-up (10 weeks post-induction):
    - 7-day: ~10⁴.⁰  
    - 14-day: ~10³.⁸  
    - 21-day: ~10³.⁶  

- **Statistical analysis**:
  - **ANOVA** to compare mean fungal burdens across treatment arms.
  - **Tukey HSD post-hoc** test to identify significant pairwise differences.
  
- **Visualization**:
  - Boxplots of fungal burden by treatment group at both induction completion and follow-up.

## ✅ Results Summary

- **ANOVA showed significant differences** in fungal clearance at both time points:
  - Induction Completion: *F = 1270, p < 2e-16*
  - Follow-up (10 weeks): *F = 157, p < 2e-16*

- **Tukey HSD results confirmed**:
  - 21-day regimen consistently achieved **superior fungal clearance** compared to 7-day and 14-day.
  - 14-day regimen outperformed 7-day in both phases.

## 🧮 Sample Size Estimation

Used the `pwr.t.test()` function from the `pwr` package in R to estimate appropriate sample sizes based on effect size, significance level, and statistical power.


## 📌 Notes

- The follow-up period reflects **10 weeks post-induction**, not including the duration of treatment.
- This is a **simulation study** and is not based on real patient data.


