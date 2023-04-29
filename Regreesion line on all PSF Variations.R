########################################################### RUN ALL FROM HERE#################################################################
#for looping#

#CHANGE ACCORDINGLY
setwd("C:\\Users\\Acer\\Desktop\\DBA\\Project")
data <-read.csv("Raw Data\\ModelDB grp by.csv")

data <-na.omit(data)

# split training and testing data
test_data <- data[data$Test_Train=="Test",]
train_data <- data[data$Test_Train=="Train",]

condonames<-as.list(unique(train_data$Project.Name))

#variable combination#

Permutation_PSF =list('Vol','Age_Q',	'Covid',	'MRT',	'Schools',	'PPI',	
                      'Vol + Age_Q',	'Vol + Covid',	'Vol + MRT',	'Vol+Schools',	'Vol + PPI',	'Age_Q + Covid',	'Age_Q + MRT',	'Age_Q + Schools',	'Age_Q + PPI',	'Covid + MRT',	'Covid + Schools',	'Covid + PPI',	 'MRT + Schools',	'MRT + PPI',	'Schools + PPI',
                      'Vol + Age_Q + Covid','Vol + Age_Q + MRT',	'Vol + Age_Q + Schools',	'Vol + Age_Q + PPI',	'Vol + Covid + MRT',	'Vol + Covid + Schools',	'Vol + Covid + PPI',	'Vol + MRT + Schools',	'Vol + MRT + PPI',	'Vol + Schools + PPI',	'Age_Q + Covid + MRT',	'Age_Q + Covid + Schools',	'Age_Q + Covid + PPI',	'Age_Q + MRT + Schools',	'Age_Q + MRT + PPI',	'Age_Q + Schools + PPI',	'Covid + MRT + Schools',	'Covid + MRT + PPI',	'Covid + Schools + PPI',	'MRT + Schools + PPI',
                      'Vol + Age_Q + Covid + MRT', 	'Vol + Age_Q + Covid + Schools', 	'Vol + Age_Q + Covid + PPI',	'Vol + Age_Q  + MRT + Schools', 	'Vol + Age_Q + MRT + PPI',	'Vol + Age_Q + Schools + PPI',	'Vol + Covid + MRT + Schools',	'Vol +  Covid + MRT + PPI',	'Vol + Covid + Schools + PPI',	'Vol + MRT +Schools + PPI',	'Age_Q + Covid + MRT + Schools',	'Age_Q + Covid + MRT + PPI',	'Age_Q + Covid + Schools + PPI',	'Age_Q + MRT + Schools + PPI',	'Covid + MRT + Schools + PPI',	
                      'Vol + Age_Q + Covid + MRT + Schools', 	'Vol + Age_Q + Covid + MRT + PPI',	'Vol + Age_Q + Covid + Schools + PPI',	'Vol + Age_Q + MRT + Schools + PPI',	'Vol + Covid + MRT + Schools + PPI',	'Age_Q + Covid + MRT + Schools + PPI',
                      'Vol + Age_Q + Covid + MRT + Schools + PPI')


Permutation_DPSF=list('Vol','Age_Q',	'Covid',	'MRT',	'Schools',	'DPPI',	
                      'Vol + Age_Q',	'Vol + Covid',	'Vol + MRT',	'Vol+Schools',	'Vol + DPPI',	'Age_Q + Covid',	'Age_Q + MRT',	'Age_Q + Schools',	'Age_Q + DPPI',	'Covid + MRT',	'Covid + Schools',	'Covid + DPPI',	 'MRT + Schools',	'MRT + DPPI',	'Schools + DPPI',
                      'Vol + Age_Q + Covid','Vol + Age_Q + MRT',	'Vol + Age_Q + Schools',	'Vol + Age_Q + DPPI',	'Vol + Covid + MRT',	'Vol + Covid + Schools',	'Vol + Covid + DPPI',	'Vol + MRT + Schools',	'Vol + MRT + DPPI',	'Vol + Schools + DPPI',	'Age_Q + Covid + MRT',	'Age_Q + Covid + Schools',	'Age_Q + Covid + DPPI',	'Age_Q + MRT + Schools',	'Age_Q + MRT + DPPI',	'Age_Q + Schools + DPPI',	'Covid + MRT + Schools',	'Covid + MRT + DPPI',	'Covid + Schools + DPPI',	'MRT + Schools + DPPI',
                      'Vol + Age_Q + Covid + MRT', 	'Vol + Age_Q + Covid + Schools', 	'Vol + Age_Q + Covid + DPPI',	'Vol + Age_Q  + MRT + Schools', 	'Vol + Age_Q + MRT + DPPI',	'Vol + Age_Q + Schools + DPPI',	'Vol + Covid + MRT + Schools',	'Vol +  Covid + MRT + DPPI',	'Vol + Covid + Schools + DPPI',	'Vol + MRT +Schools + DPPI',	'Age_Q + Covid + MRT + Schools',	'Age_Q + Covid + MRT + DPPI',	'Age_Q + Covid + Schools + DPPI',	'Age_Q + MRT + Schools + DPPI',	'Covid + MRT + Schools + DPPI',	
                      'Vol + Age_Q + Covid + MRT + Schools', 	'Vol + Age_Q + Covid + MRT + DPPI',	'Vol + Age_Q + Covid + Schools + DPPI',	'Vol + Age_Q + MRT + Schools + DPPI',	'Vol + Covid + MRT + Schools + DPPI',	'Age_Q + Covid + MRT + Schools + DPPI',
                      'Vol + Age_Q + Covid + MRT + Schools + DPPI')



#Permutation_DPSF_percent=list('Vol','Age_Q',	'Covid',	'MRT',	'Schools',	'DPPI_percent',	
#                              'Vol + Age_Q',	'Vol + Covid',	'Vol + MRT',	'Vol+Schools',	'Vol + DPPI_percent',	'Age_Q + Covid',	'Age_Q + MRT',	'Age_Q + Schools',	'Age_Q + DPPI_percent',	'Covid + MRT',	'Covid + Schools',	'Covid + DPPI_percent',	 'MRT + Schools',	'MRT + DPPI_percent',	'Schools + DPPI_percent',
#                              'Vol + Age_Q + Covid','Vol + Age_Q + MRT',	'Vol + Age_Q + Schools',	'Vol + Age_Q + DPPI_percent',	'Vol + Covid + MRT',	'Vol + Covid + Schools',	'Vol + Covid + DPPI_percent',	'Vol + MRT + Schools',	'Vol + MRT + DPPI_percent',	'Vol + Schools + DPPI_percent',	'Age_Q + Covid + MRT',	'Age_Q + Covid + Schools',	'Age_Q + Covid + DPPI_percent',	'Age_Q + MRT + Schools',	'Age_Q + MRT + DPPI_percent',	'Age_Q + Schools + DPPI_percent',	'Covid + MRT + Schools',	'Covid + MRT + DPPI_percent',	'Covid + Schools + DPPI_percent',	'MRT + Schools + DPPI_percent',
#                              'Vol + Age_Q + Covid + MRT', 	'Vol + Age_Q + Covid + Schools', 	'Vol + Age_Q + Covid + DPPI_percent',	'Vol + Age_Q  + MRT + Schools', 	'Vol + Age_Q + MRT + DPPI_percent',	'Vol + Age_Q + Schools + DPPI_percent',	'Vol + Covid + MRT + Schools',	'Vol +  Covid + MRT + DPPI_percent',	'Vol + Covid + Schools + DPPI_percent',	'Vol + MRT +Schools + DPPI_percent',	'Age_Q + Covid + MRT + Schools',	'Age_Q + Covid + MRT + DPPI_percent',	'Age_Q + Covid + Schools + DPPI_percent',	'Age_Q + MRT + Schools + DPPI_percent',	'Covid + MRT + Schools + DPPI_percent',	
#                              'Vol + Age_Q + Covid + MRT + Schools', 	'Vol + Age_Q + Covid + MRT + DPPI_percent',	'Vol + Age_Q + Covid + Schools + DPPI_percent',	'Vol + Age_Q + MRT + Schools + DPPI_percent',	'Vol + Covid + MRT + Schools + DPPI_percent',	'Age_Q + Covid + MRT + Schools + DPPI_percent',
#                              'Vol + Age_Q + Covid + MRT + Schools + DPPI_percent')

Permutation_DPSF_percent=list('DPPI_percent',	
                              'Vol + DPPI_percent',	'Age_Q + DPPI_percent',	'Covid + DPPI_percent','MRT + DPPI_percent',	'Schools + DPPI_percent',
                              'Vol + Age_Q + DPPI_percent','Vol + Covid + DPPI_percent','Vol + MRT + DPPI_percent',	'Vol + Schools + DPPI_percent',	'Age_Q + Covid + DPPI_percent',	'Age_Q + MRT + DPPI_percent',	'Age_Q + Schools + DPPI_percent','Covid + MRT + DPPI_percent',	'Covid + Schools + DPPI_percent',	'MRT + Schools + DPPI_percent',
                              'Vol + Age_Q + Covid + DPPI_percent',	'Vol + Age_Q + MRT + DPPI_percent',	'Vol + Age_Q + Schools + DPPI_percent',	'Vol +  Covid + MRT + DPPI_percent',	'Vol + Covid + Schools + DPPI_percent',	'Vol + MRT +Schools + DPPI_percent','Age_Q + Covid + MRT + DPPI_percent',	'Age_Q + Covid + Schools + DPPI_percent',	'Age_Q + MRT + Schools + DPPI_percent',	'Covid + MRT + Schools + DPPI_percent',	
                              'Vol + Age_Q + Covid + MRT + DPPI_percent',	'Vol + Age_Q + Covid + Schools + DPPI_percent',	'Vol + Age_Q + MRT + Schools + DPPI_percent',	'Vol + Covid + MRT + Schools + DPPI_percent',	'Age_Q + Covid + MRT + Schools + DPPI_percent',
                              'Vol + Age_Q + Covid + MRT + Schools + DPPI_percent')


# combination DPFS_percent
library(gtools)
variables = list("log(Vol)", "log(Age_Q)", "Schools", "Covid", "MRT", 
                 "DPPI_percent*log(Vol)", "DPPI_percent*log(Age_Q)", "DPPI_percent*Schools", "DPPI_percent*Covid", "DPPI_percent*MRT",
                 "log(Vol)*log(Age_Q)", "log(Vol)*MRT",
                 "log(Age_Q)*MRT"
                 )
Combination_DPSF_percent = list("DPPI_percent", "I(DPPI_percent)^2", "DPPI_percent + I(DPPI_percent)^2")
for (i in 1:length(variables)) {
  comb = combn(variables, i)
  for (n in 1:ncol(comb)){
    eqn <- do.call(paste, c(comb[,n], sep = "+"))
    eqn1 <- paste("DPPI_percent+" ,eqn, sep="")
    print(eqn1)
    Combination_DPSF_percent <- append(Combination_DPSF_percent, eqn1)
    eqn2 <- paste("I(DPPI_percent)^2+" ,eqn, sep="")
    print(eqn2)
    Combination_DPSF_percent <- append(Combination_DPSF_percent, eqn2)
    eqn3 <- paste("DPPI_percent+I(DPPI_percent)^2+" ,eqn, sep="")
    print(eqn3)
    Combination_DPSF_percent <- append(Combination_DPSF_percent, eqn3)
  }
}


#eqn creation#

VAR_PSF <- list()
for (i in 1:63){
eqn_VAR_PSF<-paste("Avg_PSF~","(", Permutation_PSF[i] , ")^2")
VAR_PSF <- append(VAR_PSF,eqn_VAR_PSF)
}

VAR_DPSF <- list()
for (i in 1:63){
  eqn_VAR_DPSF<-paste("DPSF~","(", Permutation_DPSF[i], ")^2")
  VAR_DPSF <- append(VAR_DPSF,eqn_VAR_DPSF)
}

VAR_DPSF_percent <- list()
for (i in 1:length(Combination_DPSF_percent)){
  eqn_VAR_DPSF_percent<-paste("DPSF_percent~", Combination_DPSF_percent[i])
  VAR_DPSF_percent <- append(VAR_DPSF_percent,eqn_VAR_DPSF_percent)
}


# outer loop for eqn permutations
df_list <- list()
for (eqn in VAR_DPSF_percent){                                   #change VAR_PSF to VAR_DPSF and VAR_DPSF_percent for other R^2 values
  # inner loop for condos
  print(eqn)
  for (condo in condonames) {
    model <- eqn #eqn of LM 
    result <-lm(model,data=train_data, subset=(Project.Name==condo))
    #print(condo)
    #print(summary(result)$adj.r.squared)
    df_list[[condo]] <- append(df_list[[condo]], summary(result)$adj.r.squared)
  }
  #print(df_list)
  # calculation for district level
  model <- eqn #eqn of LM 
  result <-lm(model,data=train_data)
  df_list[["District 15"]] <- append(df_list[["District 15"]], summary(result)$adj.r.squared)
}

# convert list to dataframe
df <- as.data.frame(do.call(rbind, df_list))
colnames(df) <- Combination_DPSF_percent       #change to dpsf and dpsf_percent accordingly

write.csv(df, "Results/var_dpsf_percent.csv", row.names=TRUE)

df <- read.csv("Results\\var_dpsf_percent.csv")
##################################### Collect coefficients of best model of each condo ##########################################################
best_model_ls <- as.list(colnames(df)[apply(df,1,which.max)]) # list containing best model for each condo
coeff_df_ls <- list()
adj_r2_ls <- list()
RMSE_ls <- list()
RMSE_train_ls <- list()

library(Metrics) # for MAE calculation
# Loop through condo 
for (i in 1:length(condonames)){ 
  condo <- as.character(condonames[i])
  print(condo)
  # Comparing model prediction to actual
  condo_test_data = test_data[test_data$Project.Name==condo,]
  condo_train_data = train_data[train_data$Project.Name==condo,]
  
  eqn <- paste("DPSF_percent~ ", best_model_ls[i])   #change accordingly
  print(eqn)
  model <- eqn #eqn of LM 
  result <-lm(model,data=train_data, subset=(Project.Name==condo))
  print(result$coefficients)
  coeff_df_ls[[condo]] <- result$coefficients
  
  # metrics
  adj_r2_ls[[condo]] <- summary(result)$adj.r.squared

  RMSE_ls[[condo]] <- rmse(condo_test_data$DPSF_percent, predict(result,condo_test_data))
  RMSE_train_ls[[condo]] <- rmse(condo_train_data$DPSF_percent, predict(result))
  #### generating plots ####
  
  # plot predicted values and actual values training 
  jpeg(paste("Results/Plots R/Training/" ,condo,"(training).jpg")) # Opening the graphical device
  
  plot(predict(result), condo_train_data$DPSF_percent,   #change accordingly
       main = paste(condo, "(training)"),
       xlab = "Predicted Values",
       ylab = "Observed Values")
  abline(a = 0, b = 1, lwd=2,
         col = "green")
  
  dev.off() # Closing the graphical device
  
  # plot predicted values and actual values testing
  jpeg(paste("Results/Plots R/Testing/" ,condo,"(testing).jpg")) # Opening the graphical device
  
  plot(predict(result, newdata=condo_test_data), condo_test_data$DPSF_percent,           #change accordingly
       main = paste(condo, "(testing)"),
       xlab = "Predicted Values",
       ylab = "Observed Values")
  abline(a = 0, b = 1, lwd=2,
         col = "green")
  
  dev.off() # Closing the graphical device
  
  ### Checking residuals
  jpeg(paste("Results/Plots R/Residuals/" ,condo,"(residuals).jpg")) # Opening the graphical device
  
  fit <- result$fitted.values
  residuals <- condo_train_data$DPSF_percent-fit
  plot(fitted(result), result$residuals,   #residuals
       main = paste(condo, "(residuals)"),
       xlab = "DPSF_percent",
       ylab = "Residuals")
  abline(0,0)
  lines(lowess(condo_train_data$DPSF_percent, result$residuals, f=0.8), col=c("red"))
  
  dev.off() # Closing the graphical device  
}
  
########### same thing for district level ########### 

eqn <- paste("DPSF_percent~ ", tail(best_model_ls, n=1))   #change accordingly
print(eqn)
model <- eqn #eqn of LM 
result <-lm(model,data=train_data)
print(result$coefficients)
coeff_df_ls[["District 15"]] <- result$coefficients

# metrics
adj_r2_ls[["District 15"]] <- summary(result)$adj.r.squared

RMSE_ls[["District 15"]] <- rmse(test_data$DPSF_percent, predict(result,test_data))
RMSE_train_ls[["District 15"]] <- rmse(train_data$DPSF_percent, predict(result))
# generating plots #

# plot predicted values and actual values training 
jpeg(paste("Results/Plots R/Training/" ,"District 15","(training).jpg")) # Opening the graphical device

plot(predict(result), train_data$DPSF_percent,   #change accordingly
     main = "District 15 (training)",
     xlab = "Predicted Values",
     ylab = "Observed Values")
abline(a = 0, b = 1, lwd=2,
       col = "green")

dev.off() # Closing the graphical device

# plot predicted values and actual values testing
jpeg(paste("Results/Plots R/Testing/" ,"District 15","(testing).jpg")) # Opening the graphical device

plot(predict(result, newdata=test_data), test_data$DPSF_percent,           #change accordingly
     main = paste("District 15", "(testing)"),
     xlab = "Predicted Values",
     ylab = "Observed Values")
abline(a = 0, b = 1, lwd=2,
       col = "green")

dev.off() # Closing the graphical device

# Checking residuals
jpeg(paste("Results/Plots R/Residuals/" ,"District 15","(residuals).jpg")) # Opening the graphical device

fit <- result$fitted.values
residuals <- train_data$DPSF_percent-fit
plot(fitted(result), result$residuals,   #residuals
     main = paste("District 15", "(residuals)"),
     xlab = "DPSF_percent",
     ylab = "Residuals")
abline(0,0)
lines(lowess(train_data$DPSF_percent, result$residuals, f=0.8), col=c("red"))

dev.off() # Closing the graphical device  
########### 

# convert coeffs to dataframe
library(plyr)
coeff_df <- plyr::ldply(coeff_df_ls, rbind)
coeff_df[is.na(coeff_df)] <- 0

write.csv(coeff_df, "Results/coeff.csv", row.names=FALSE)

# convert metrics to dataframe
metrics_df <- as.data.frame(do.call(rbind, adj_r2_ls))
colnames(metrics_df) <- "Adj R2 (training)"
metrics_df["RMSE (testing)"] <- as.data.frame(do.call(rbind, RMSE_ls))
metrics_df["RMSE (training)"] <- as.data.frame(do.call(rbind, RMSE_train_ls))
write.csv(metrics_df, "Results/metrics.csv", row.names=TRUE)

