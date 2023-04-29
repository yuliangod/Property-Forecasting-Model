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

eqns <- {"DPSF_percent~DPPI_percent"}

# outer loop for eqn permutations
df_list <- list()
for (eqn in eqns){                                   #change VAR_PSF to VAR_DPSF and VAR_DPSF_percent for other R^2 values
  # inner loop for condos
  print(eqn)
  for (condo in condonames) {
    condo_test_data = test_data[test_data$Project.Name==condo,]
    condo_train_data = train_data[train_data$Project.Name==condo,]
    
    model <- eqn #eqn of LM 
    result <-lm(model,data=train_data, subset=(Project.Name==condo))
    #print(condo)
    #print(summary(result)$adj.r.squared)
    df_list[[condo]] <- append(df_list[[condo]], summary(result)$adj.r.squared)
    
    # metrics

    df_list[[condo]] <- append(df_list[[condo]], rmse(condo_test_data$DPSF_percent, predict(result,condo_test_data)))
    df_list[[condo]] <- append(df_list[[condo]], rmse(condo_train_data$DPSF_percent, predict(result)))
    
    
  }
  #print(df_list)
  # calculation for district level
  model <- eqn #eqn of LM 
  result <-lm(model,data=train_data)
  df_list[["District 15"]] <- append(df_list[["District 15"]], summary(result)$adj.r.squared)
  
  df_list[["District 15"]] <- append(df_list[["District 15"]], rmse(test_data$DPSF_percent, predict(result,test_data)))
  df_list[["District 15"]] <- append(df_list[["District 15"]], rmse(train_data$DPSF_percent, predict(result)))
}

# convert list to dataframe
df <- as.data.frame(do.call(rbind, df_list))
colnames(df) <- list("Adjusted R^2", "RMSE testing", "RMSE training")      #change to dpsf and dpsf_percent accordingly

write.csv(df, "Results/DPPI Metrics.csv", row.names=TRUE)

