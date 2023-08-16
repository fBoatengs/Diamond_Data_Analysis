# INSTALLING AND LOADING REQUIRED PACKAGES AND LIBRARIES. 
install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")
install.packages("here")

library("here")
library("tidyverse")
library("skimr")
library("janitor")


#LOADING DATASET
data(diamonds)
diamond_df <- diamonds
head(diamond_df)


#CHECKING THE DATA STRUCTURE AND ITS SUMMARY STATISTICS
str(diamond_df)                    
skim_without_charts(diamond_df)
skim_without_charts(diamond_df[c("price", "cut", "carat")])
glimpse(diamond_df)

# DATA EXPLORATION AND PREPROCESSING
rename_with(diamond_df, toupper)
clean_names(diamond_df)
# any(is.na(diamond_df))
missing_values <- sapply(diamond_df, function(x) sum(is.na(x)))
print(missing_values)

# Check for outliers using box plots
ggplot(diamond_df, aes(x = cut, y = price))+  
  geom_boxplot()

ggplot(diamond_df, aes(x = cut, y = carat))+  
  geom_boxplot()


# EXPLORING CUT, CARAT, AND PRICE:
diamond_df %>%
  group_by(cut) %>%
  summarise(n=n(), 
            mean= mean(price), 
            median=median(price), 
            Q1= quantile(price,0.25),
            Q3= quantile(price,0.75))

# Visualize price distributions using histograms
ggplot(diamond_df, aes(x = price)) + geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Diamond Prices", x = "Price", y = "Frequency")

# Visualize the relationship between cut and price using faceted histograms
ggplot(diamond_df, aes(x = price)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  facet_wrap(~ cut, scales = "free") +
  labs(title = "Distribution of Diamond Prices by Cut",
       x = "Price", y = "Frequency")


diamond_df %>%
  group_by(cut) %>%
  summarise(n=n(), 
            mean= mean(carat), 
            median=median(carat), 
            Q1= quantile(carat,0.25),
            Q3= quantile(carat,0.75))

# Visualize carat distributions using histograms
ggplot(diamond_df, aes(x = carat)) + geom_histogram(bins = 30, fill = "orange", color = "black") +
  labs(title = "Distribution of Carat Values", x = "Carat", y = "Frequency")

# Visualize the relationship between cut and carat using faceted histograms
ggplot(diamond_df, aes(x = carat)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  facet_wrap(~ cut, ncol = 2, scales = "free") +
  labs(title = "Distribution of Carat Values by Cut",
       x = "Carat", y = "Frequency")


diamond_df %>%
  ggplot(aes(x=cut,y=carat, color=cut)) +
  geom_boxplot()

diamond_df %>%
  ggplot(aes(x=cut,y=price, color=cut)) +
  geom_boxplot()

diamond_df %>%
  ggplot(aes(price,carat, col= cut))+
  geom_point()



# REGRESSION ANALYSIS

# Create a linear regression model
model <- lm(price ~ carat + cut, data = diamond_df)
summary(model)

# Visualize the regression results
# Create a scatter plot of carat vs. price
ggplot(diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Regression Analysis: Price vs. Carat",
       x = "Carat", y = "Price", color = "Cut")

# Predict new values using the model
new_data <- data.frame(carat = c(5.0, 5.0 ,5.0), cut = c("Ideal", "Premium", "Fair"))
predicted_prices <- predict(model, newdata = new_data)
print(predicted_prices)


# EVALUATING THE MODELS PERFORMANCE.

# Predict the response variable
predictions <- predict(model)
residuals <- diamonds$price - predictions

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mean(residuals^2))
cat("RMSE:", rmse, "\n")

# Calculate R-squared (Coefficient of Determination)
rsquared <- summary(model)$r.squared
cat("R-squared:", rsquared, "\n")

# Visualize the residuals
ggplot() +
  geom_histogram(aes(x = residuals), bins = 30, fill = "blue", color = "black") +
  labs(title = "Residuals Histogram",
       x = "Residuals", y = "Frequency")
