library(lawstat)
library(dplyr)
library(multcomp)
library(emmeans)
library(ggplot2)

gastro <- read.csv("gastrointestinal_disease_dataset.csv")

# Data structure overview
str(gastro)
head(gastro)
summary(gastro)
colnames(gastro)

# Check for missing values
# No missing value
colSums(is.na(gastro)) 

# Select relevant variables for analysis: BMI (outcome) and Diet_Type (predictor)
BMI_Diet <- gastro[, c("BMI", "Diet_Type")]

# Convert Diet_Type to factor for categorical analysis
BMI_Diet$Diet_Type <- as.factor(BMI_Diet$Diet_Type)
levels(BMI_Diet$Diet_Type)

colSums(is.na(BMI_Diet)) 
summary(BMI_Diet)

# Sample size distribution across diet groups
table(BMI_Diet$Diet_Type)

# Comprehensive descriptive statistics by diet group
BMI_Diet %>%
  group_by(Diet_Type) %>%
  summarise(
    n = n(),
    Mean = round(mean(BMI), 2),
    SD = round(sd(BMI), 2),
    Median = round(median(BMI), 2),
    Min = min(BMI),
    Max = max(BMI),
    Percentage = round(n / nrow(BMI_Diet) * 100, 1)
  )

# Normality assessment using Q-Q plot
fitlm <- lm(BMI_Diet$BMI ~ BMI_Diet$Diet_Type, data = BMI_Diet)
lm.res <- resid(fitlm)

qqnorm(lm.res)
qqline(lm.res)

# Cook's distance
plot(fitlm, which = 4)


# Check homogeneity of variances (ANOVA assumption)
# Test Statistic = 0.57147, p-value = 0.6337

levene.test(y=BMI_Diet$BMI, group=BMI_Diet$Diet_Type)

# H0: μ_omnivore = μ_pescatarian = μ_vegan = μ_vegetarian
# H1: At least one group mean differs from the others
anova_result <- aov(BMI ~ Diet_Type, data = BMI_Diet)
anova_summary <- summary(anova_result)
print(anova_summary)

# Post-hoc pairwise comparisons (unadjusted)
# Confidence intervals for all pairwise differences
emm_DT <- emmeans(fitlm, specs = ~ Diet_Type)
all_pairs <- pairs(emm_DT, adjust = "none")
all_pairs
confint(all_pairs)            

# Boxplot: BMI distribution across diet groups
ggplot(BMI_Diet, aes(x = Diet_Type, y = BMI, fill = Diet_Type)) +
  geom_boxplot(alpha = 0.7) +
  labs(title = "BMI Distribution by Diet Type",
       x = "Diet Type", y = "BMI") +
  theme_minimal()

# Residual vs fitted plots
plot(resid(fitlm) ~ fitted(fitlm))

# Build a linear model with all variables
full_model <- lm(BMI ~ ., data = gastro)
summary(full_model)  


gastro_clean <- gastro[, !(colnames(gastro) %in% c("Body_Weight", "Obesity_Status"))]
print(colnames(gastro_clean))

# The linear model without "Body_Weight", "Obesity_Status"
full_model1 <- lm(BMI ~ ., data = gastro_clean)
summary(full_model1)


gastro_1 <- gastro[, c("BMI", "Age", "Ethnicity", "Stress_Level")]
print(gastro_1)

# The linear model including "BMI", "Age", "Ethnicity", "Stress_Level" 
full_model2 <- lm(BMI ~ ., data = gastro_1)
summary(full_model2)

