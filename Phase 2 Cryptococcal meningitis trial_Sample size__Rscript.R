install.packages("pwr")
library(pwr)
library(ggplot2)

#Sample Size Calculations
#Case 1: Large Effect Size (d = 1), alpha = 0.05, Power = 80%
sample_size <- pwr.t.test(d = 1, sig.level = 0.05, power = 0.8, type = "two.sample")
print(sample_size)
#Adjust Standard Deviation


#Adjust standard deviation 
#Case 2: Moderate Effect Size (d = 0.5), alpha = 0.05, Power = 80%
sample_size_sd_high <- pwr.t.test(d = 0.5, sig.level = 0.05, power = 0.8, type = "two.sample")
print(sample_size_sd_high)

# Reassess Power and Alpha
#Case 3: Moderate Effect Size (d = 0.5), alpha = 0.05, Higher Power (90%)
sample_size_high_power <- pwr.t.test(d = 0.5, sig.level = 0.05, power = 0.9, type = "two.sample")
print(sample_size_high_power)



# Simulating Fungal Clearance Data for 3 Treatment Arms, 7-days, 14-days, 21-days

# Set seed for reproducibility
set.seed(123)

# Number of participants per group (moderate size at 80% power, accounting for 10% dropout rate)
n_per_group <- 70  

# Create groups for treatment arms (7-day, 14-day, 21-day induction therapy)
group <- factor(rep(c("7_days", "14_days", "21_days"), each = n_per_group))

# Generate fungal clearance data for different time points based on realistic EFA levels
# Baseline: Screening fungal burden (similar across groups)
fungal_clearance_screening <- c(rnorm(n_per_group, mean = 10^5, sd = 5000), 
                                rnorm(n_per_group, mean = 10^5, sd = 5000), 
                                rnorm(n_per_group, mean = 10^5, sd = 5000))

# Admission (Day -1): Slight reduction in fungal burden (similar across groups)
fungal_clearance_admission <- c(rnorm(n_per_group, mean = 10^4.8, sd = 4000),
                                rnorm(n_per_group, mean = 10^4.8, sd = 4000),
                                rnorm(n_per_group, mean = 10^4.8, sd = 4000))

# Induction Completion: Fungal burden decreases by treatment duration
fungal_clearance_induction <- c(rnorm(n_per_group, mean = 10^4.6, sd = 3000),  # 7-day
                                rnorm(n_per_group, mean = 10^4.4, sd = 3000),  # 14-day
                                rnorm(n_per_group, mean = 10^4.2, sd = 3000))  # 21-day

# Follow-Up (10 weeks): Continued decline in fungal burden
fungal_clearance_followup <- c(rnorm(n_per_group, mean = 10^4.0, sd = 2000),  # 7-day
                               rnorm(n_per_group, mean = 10^3.8, sd = 2000),  # 14-day
                               rnorm(n_per_group, mean = 10^3.6, sd = 2000))  # 21-day

# Combine data into a single dataframe
data <- data.frame(group, fungal_clearance_screening, fungal_clearance_admission, 
                   fungal_clearance_induction, fungal_clearance_followup)

# View first rows of the dataset
head(data)

# Conduct ANOVA for Each Time Point

# ANOVA for induction completion data
anova_induction <- aov(fungal_clearance_induction ~ group, data = data)
summary(anova_induction)

# ANOVA for follow-up data
anova_followup <- aov(fungal_clearance_followup ~ group, data = data)
summary(anova_followup)

# Tukey HSD for Induction Completion
TukeyHSD(anova_induction)

# Tukey HSD for Follow-Up
TukeyHSD(anova_followup)

# Visualization for Induction Completion results
library(ggplot2)
ggplot(data, aes(x = group, y = fungal_clearance_induction, fill = group)) +
  geom_boxplot() +
  labs(title = "Fungal Clearance at Induction Completion",
       x = "Treatment Arm",
       y = "Fungal Burden (CFU/mL)") +
  theme_minimal()

# Visualization for Follow-Up results
ggplot(data, aes(x = group, y = fungal_clearance_followup, fill = group)) +
  geom_boxplot() +
  labs(title = "Fungal Clearance at Follow-Up (10 Weeks)",
       x = "Treatment Arm",
       y = "Fungal Burden (CFU/10mL)") +
  theme_minimal()
