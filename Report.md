---
title: 'Exploring the Interplay of Price, Cut, and Carat in Diamonds: A Data Analysis.'
output: pdf_document
fontsize: 11.5pt
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


```{r, echo=FALSE,message=FALSE}
library("here")
library("tidyverse")
library("skimr")
library("janitor")
```

## 1. Abstract
In the world of diamonds, various attributes contribute to a gemstone's overall value and desirability. Among these attributes, the cut, carat, and price are pivotal factors influencing consumer preferences and market dynamics. This project aims to delve into the intricate relationship between the cut quality, carat weight, and price of diamonds using a comprehensive data analysis approach. By exploring patterns and correlations within these attributes, we seek to uncover insights that shed light on the factors driving diamond pricing and provide valuable information for jewelers, buyers, and enthusiasts to understand how different aspects come together to define a diamond's worth.


## 2. Introduction
Diamonds, renowned for their exquisite beauty and enduring allure, have captivated individuals for centuries. Their timeless elegance, coupled with their value as precious gemstones, makes the study of their attributes and market trends a captivating endeavor. In this data analysis project, we delve into the multifaceted world of diamonds by exploring the intricate relationship between their price, cut, and carat weight.

Understanding how these attributes interplay is not only of interest to gemologists and jewelry enthusiasts but also holds practical implications for traders, retailers, and consumers. Cut, referring to the craftsmanship and shape of a diamond, plays a pivotal role in its brilliance and overall visual appeal. Carat, a measure of a diamond's weight, is closely linked to its rarity and value. Price, the ultimate manifestation of a diamond's worth, is influenced by complex factors.

By meticulously dissecting the data, we aim to uncover patterns, correlations, and insights that illuminate the connections between these attributes. This analysis is not merely an exercise in data exploration; it is an exploration of the essence that gives diamonds their allure and monetary value.

Through this project, we seek to provide a nuanced perspective on the intricate world of diamonds, bridging the realms of science and art. By unraveling the relationships between price, cut, and carat, we hope to contribute to a deeper appreciation of the craftsmanship and allure that diamonds epitomize.

## 3. Dataset Description

### 3.1 Overview
The diamond dataset used in this project is a comprehensive collection of diamond attributes and their corresponding prices. This dataset is commonly utilized in the field of data analysis to understand the factors that influence the price of diamonds. Diamonds are valued not only for their intrinsic beauty but also for their rarity and the "Four Cs" criteria: cut, carat, color, and clarity. In this analysis, we will focus on exploring the relationship between the attributes of cut, carat, and price.

### 3.3 Attributes of Interest
The primary attributes of interest for this analysis are:

* **Cut:** This attribute refers to the quality of the diamond's cut, which affects its brilliance and overall appearance. The cut is categorized into levels such as "Ideal," "Premium," "Good," "Fair," and "Very Good."

* **Carat:** Carat is a unit of weight used to measure the size of diamonds. It's one of the most important factors influencing a diamond's price, as larger diamonds tend to be more valuable.

* **Price:** Price is the target variable in our analysis. It represents the monetary value assigned to each diamond based on its various attributes, including cut, carat, color, and clarity.

### 3.4 Dataset Structure
The dataset consists of several columns, each containing information about different attributes of the diamonds. Some of the key columns include:

* **Cut:** Categorical variable representing the quality of the diamond's cut.

* **Carat:** Numeric variable representing the weight of the diamond in carats.

* **Price:** Numeric variable representing the price of the diamond in a specific currency.

* **Other Columns:** The dataset also include additional columns such as color, clarity, depth,and its dimensions.


## 4. Data Analysis:

### 4.1 Descriptive Statistic
To begin, the summary statistics provide a brief overview of the key characteristics of the data set. These statistics are calculated to help understand the central tendency, variability, and distribution of the data.

```{r, echo=FALSE}
data(diamonds)
diamond_df <- diamonds
```

```{r, echo=FALSE}
#Summary Statistics of key variables
summary(diamond_df[c("price", "cut","carat")])
```

Based on the summary statistics provided above, we can make the following observations about the diamond dataset:

* Price ranges from \$326 to \$18823, with a median price of \$2401 and a mean price of approximately \$3933.

* Cut categories include Fair, Good, Very Good, Premium, and Ideal, with varying counts for each category.

* Carat weight ranges from 0.2 to 5.01, with a median of 0.7 and an average of around 0.7979 carats.

### 4.2 Exploring Price and Cut Relationships
The visualization below depicts the correlation between diamond cut and price through faceted histograms that highlight their respective skewness. As observed in the ensuing visualization, the price distribution for each diamond cut skews to the right, implying an abundance of diamonds within specific price ranges. This suggests that there are comparatively fewer diamonds with exceptionally high prices across all cut categories.

```{r, echo=FALSE, fig.dim = c(8, 4)}
# Visualize the relationship between cut and price using faceted histograms
ggplot(diamond_df, aes(x = price)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  facet_wrap(~ cut, scales = "free") +
  labs(title = "Distribution of Diamond Prices by Cut",
       x = "Price", y = "Frequency")
```

Examining the box plot below, a clear trend emerges: diamonds with premium cuts command higher prices, while those with ideal cuts are associated with lower prices. This simple yet insightful observation underscores the influence of cut quality on diamond pricing.
```{r, echo=FALSE, out.width="80%"}
diamond_df %>%
  ggplot(aes(x=cut,y=price, color=cut)) +
  geom_boxplot()+
  labs(title = "Boxplot of Cut and Price")
```


### 4.3 Exploring Carat and Cut Relationships
The visualization below depicts the correlation between diamond cut and carat through faceted histograms that highlight their respective skewness. As observed in the ensuing visualization, the carat distribution for each diamond cut slightly skews to the right, implying an abundance of diamonds within specific carat  ranges. This suggests that there are comparatively fewer diamonds with exceptionally high carat across all cut categories.

```{r, echo=FALSE, fig.dim = c(8, 4)}
# Visualize the relationship between cut and carat using faceted histograms
ggplot(diamond_df, aes(x = carat)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  facet_wrap(~ cut, ncol = 2, scales = "free") +
  labs(title = "Distribution of Carat Values by Cut",
       x = "Carat", y = "Frequency")
```


Also, the boxplot below, displays various diamond cuts—Fair, Good, Very Good, Premium, and Ideal—plotted against carat weight, including outlier data points. We can also see that carat and cut hold a negative correlation. Diamonds with Good, Very Good, and Ideal cuts generally have a carat weight of less than 1, as indicated by a median value of <1. While a few Fair and Premium cut diamonds slightly exceed 1 carat in weight, their medians remain at <=1 carat. The Premium cut exhibits the most expansive range between the 1st and 3rd quartiles. Larger diamonds are predominantly associated with the Fair cut.

```{r, echo=FALSE, out.width="80%"}
diamond_df %>%
  ggplot(aes(x=cut,y=carat, color=cut)) +
  geom_boxplot()+
  labs(title = "Boxplot of Cut and Carat")
```


The scatter plot reveals a robust positive correlation between carat and price, with a predominant concentration of diamonds with low carat values along the x-axis. It is evident that diamonds with lower carat weights tend to have correspondingly lower prices. As carat size escalates, there is a noticeable upward trend in diamond prices.
```{r, echo=FALSE, out.width="80%"}
diamond_df %>%
  ggplot(aes(price,carat, col= cut))+
  geom_point()+
  labs(title = "Carat vs Price and Cut")
```


## 5. Regression Analysis
In the realm of data analysis, accurate regression models are vital for predictive modeling. We employ the lm function, a key tool in statistical programming, to build a robust regression model for our project. This model, crafted from carefully selected features (price, cut, carat), predicts diamond prices effectively.

Regression models unveil relationships between variables through mathematical representations. The lm function helps us intricately understand how chosen features (price, cut, carat) influence diamond prices. This predictive tool becomes invaluable, offering insight into future diamond prices by considering these amalgamated features. Below is the summary of the model built for this project. 

```{r, echo=FALSE}
# Create a linear regression model
model <- lm(price ~ carat + cut, data = diamond_df)
summary(model)
```

### Model Summary:

* The model's residual standard error is 1511, which represents the average magnitude of the differences between observed and predicted values.

* The multiple R-squared value of 0.8565 indicates that around 85.65% of the variability in diamond prices is explained by the model's predictors (carat and cut).

* The adjusted R-squared, which takes into account the number of predictors, remains the same as the multiple R-squared, indicating that the added predictors (cut levels) contribute meaningfully to explaining price variability.

* The F-statistic is 6.437e+04, and its associated p-value is practically zero (< 2.2e-16), suggesting that the overall model is highly significant.

### Coefficients:

The intercept of -2701.38 represents the estimated baseline price for diamonds with zero carat weight and cut quality, though this is impractical for diamonds. The carat coefficient of 7871.08 suggests that each additional carat increases the predicted diamond price by $7871.08, assuming cut quality remains constant. The coefficients for different cut levels (L, Q, C, ^4) reveal their impact on price compared to the reference level, "Ideal." For example, an "L" cut elevates price by 1239.80, while "Q" and "C" cuts decrease price. The '^4' level indicates a nonlinear relationship between this cut and price.

### Residuals:

The residuals, which represent the differences between the actual and predicted prices, have a distribution with a minimum of -17540.7 and a maximum of 12721.4. The majority of residuals are within the range of -791.6 to 522.1, indicating that the model generally captures the price trends well.


In summary, the model suggests that carat weight and cut quality are strong predictors of diamond prices. The coefficients provide insights into the magnitude and direction of these relationships, considering the different cut levels as well. The model appears to fit the data quite well, as indicated by the R-squared values and the significant F-statistic.

### 5.1 Evaluating Models Performance
The multiple R-squared is 0.8565, showing 85.65% variance in diamond prices explained by carat and cut. Adjusted R-squared matches, highlighting cut's meaningful contribution. The F-statistic is 6.437e+04, with p-value < 2.2e-16, emphasizing model significance. Residuals range from -17540.7 to 12721.4, mostly within -791.6 to 522.1, capturing price trends. Residuals' histogram suggests a normal distribution. Overall, the model fits well, supported by these findings.

```{r, echo=FALSE, out.width="80%"}
# Predict the response variable
predictions <- predict(model)
residuals <- diamonds$price - predictions
# Visualize the residuals
ggplot() +
  geom_histogram(aes(x = residuals), bins = 30, fill = "blue", color = "black") +
  labs(title = "Residuals Histogram",
       x = "Residuals", y = "Frequency")
```


### 5.2 Generating Predictions from the Model
Subsequently, we move forward to conduct predictions using the generated model. Our objective is to estimate the prices for diamonds with ideal, premium, and fair cuts, each weighing 5.0 carats. The prediction outcomes are presented below.

```{r, echo=FALSE}
new_data <- data.frame(carat = c(5.0, 5.0 ,5.0), cut = c("Ideal", "Premium", "Fair"))
predicted_prices <- predict(model, newdata = new_data)
print(predicted_prices)
```

Analyzing the predictions further, we observe that an Ideal cut diamond weighing 5.0 carats is estimated to cost \$37,280.86. Comparatively, a Premium cut diamond of the same weight is projected to be priced at \$36,919.20. In contrast, a Fair cut diamond with a 5.0-carat weight is anticipated to have a lower price of \$35,479.94.

These predictions reflect the model's understanding of how different cut qualities influence the prices of diamonds of equal weight. The price variations suggest that cut quality significantly impacts diamond valuation, with an Ideal cut commanding the highest price, followed by Premium and Fair cuts. This insight is consistent with industry norms, where cut quality is pivotal in determining a diamond's market value.

## 6. Conclusion
This project conducted comprehensive data analysis to explore the intricate relationship between the attributes of diamond cut quality, carat weight, and price. The study aimed to uncover patterns, correlations, and insights that shed light on the factors influencing diamond pricing. A meticulous examination of the dataset, various visualizations, and statistical analyses revealed valuable findings about how these attributes interplay and contribute to a diamond's overall worth.

## 6.1 Findings

### Diamond Cut and Price.
The examination underscored a distinct correlation between the cut of a diamond and its corresponding price. Diamonds possessing superior cuts, such as those classified as Premium, exhibited a strong association with elevated prices. Following these were Fair-cut diamonds, largely due to the tendency for many Fair-cut diamonds to possess higher carat weights, which inherently leads to higher pricing. Conversely, diamonds with Ideal cuts displayed comparatively lower prices, primarily attributed to the prevalence of lower carat weights among most Ideal-cut diamonds.
The visualization of price distribution for each diamond cut revealed a right-skewed pattern, indicating that there are fewer diamonds with exceptionally high prices in all cut categories.

### Diamond Carat and Cut.
The relationship between diamond carat weight and cut was explored. It was observed that the carat distribution for each diamond cut slightly skews to the right, suggesting an abundance of diamonds within specific carat ranges for each cut category.
The box plot analysis indicated a negative correlation between carat weight and cut quality. Diamonds with higher-quality cuts, such as Very Good and Ideal, generally had lower carat weights, while Fair cuts exhibited larger diamonds.

### Carat and Price Relationship.
A robust positive correlation was identified between carat weight and price. Generally, diamonds with higher carat weights had correspondingly higher prices, while diamonds with lower carat weights were associated with lower prices.

### Regression Model.
A regression analysis was conducted to quantitatively assess the relationships between carat weight, cut quality, and diamond price.
The regression model revealed that carat weight and cut quality were strong predictors of diamond prices. The coefficients for different cut levels provided insights into their impact on price compared to the reference level, "Ideal."
The model's multiple R-squared value of 0.8565 indicated that around 85.65% of the variability in diamond prices could be explained by the predictors (carat and cut).
The model's residual analysis showed that it captured the price trends well, with residuals distributed around a normal distribution.

### Predictions.
Using the generated model, predictions were made for diamond prices based on cut quality and carat weight. The predictions aligned with industry norms, where diamonds with higher-quality cuts were projected to have higher prices for the same carat weight.

In conclusion, this data analysis project successfully uncovered valuable insights into the interplay of diamond attributes, providing a deeper understanding of the factors driving diamond pricing. The findings contribute to both the scientific understanding and the practical implications for jewelers, buyers, and enthusiasts in the diamond market.
