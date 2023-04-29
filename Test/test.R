#CHANGE ACCORDINGLY
setwd("C:\\Users\\Acer\\Desktop\\DBA\\Project")
data <-read.csv("Raw Data\\ModelDB grp by.csv")

data <-na.omit(data)

# split training and testing data
test_data <- data[data$Test_Train=="Test",]
train_data <- data[data$Test_Train=="Train",]

condo <- "LEGENDA AT JOO CHIAT"
eqn <- DPSF_percent ~ DPPI_percent         #+ Vol + DPPI_percent*Vol         #+ I(DPPI_percent^2)

model <- eqn #eqn of LM 
result <-lm(model,data=train_data, subset=(Project.Name==condo))
summary(result)
coeff_df_list <- list()
coeff_df_list[[condo]] <- result$coefficients

# f-stat p-value
pf(summary(result)$fstatistic[1],              # Applying pf() function
   summary(result)$fstatistic[2],
   summary(result)$fstatistic[3],
   lower.tail = FALSE)

# Comparing model prediction to actual
condo_test_data = test_data[test_data$Project.Name==condo,]
condo_train_data = train_data[train_data$Project.Name==condo,]

predict(result, newdata=condo_test_data, interval="confidence")
library(Metrics)

RMSE_test <- rmse(condo_test_data$DPSF_percent, predict(result,condo_test_data))

RMSE_train <- rmse(condo_train_data$DPSF_percent, predict(result))

# plot predicted values and actual values training 
#pdf(paste("Results/Plots R/" ,condo,"(training).pdf")) # Opening the graphical device

plot(predict(result), train_data$DPSF_percent,            #condo_train_data$DPSF_percent,    # change accordingly DPSF
     main = paste(condo, "(training)"),
     xlab = "Predicted Values",
     ylab = "Observed Values")
abline(a = 0, b = 1, lwd=2,
       col = "green")

#dev.off() # Closing the graphical device

# plot predicted values and actual values testing
#pdf(paste("Results/Plots R/" ,condo,"(testing).pdf")) # Opening the graphical device

plot(predict(result, newdata=test_data), test_data$DPSF_percent,                 #newdata=condo_test_data), condo_test_data$DPSF_percent,  # change accordingly to DPSF
     main = paste(condo, "(testing)"),
     xlab = "Predicted Values",
     ylab = "Observed Values")
abline(a = 0, b = 1, lwd=2,
       col = "green")

#dev.off() # Closing the graphical device

# plot against individual variables with confidence intervals (other variables set to mean)
library(jtools)
library(ggplot2)
effect_plot(result, pred = DPPI_percent, interval = TRUE, plot.points=TRUE)

# residual plots
fit <- result$fitted.values
residuals <- condo_train_data$DPSF_percent-fit
plot(fitted(result), result$residuals,   #residuals
     main = paste(condo, "(residuals)"),
     xlab = "DPSF_percent",
     ylab = "Residuals")
abline(0,0)
lines(lowess(condo_train_data$DPSF_percent, result$residuals, f=0.8), col=c("red"))


