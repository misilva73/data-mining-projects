
# Import data from product clustering
import_product_data <- function(ncluster){
  train_file <- paste("./Results/product_clustered_data",
                      as.character(ncluster),
                      "_TRAIN.csv", sep="")
  temp_train <- read.csv(train_file) %>% 
    transmute(ID=CustID,
              Household=newPremHousehold,
              Health=newPremHealth,
              Life=newPremLife,
              Motor=newPremMotor,
              Work=newPremWork,
              product_cluster=as.factor(X_SEGMENT_),
              product_distance=Distance,
              role="train")
  score_file <- paste("./Results/product_clustered_data",
                      as.character(ncluster),
                      "_SCORE.csv", sep="")
  temp_score <- read.csv(score_file) %>% 
    transmute(ID=CustID,
              Household=newPremHousehold,
              Health=newPremHealth,
              Life=newPremLife,
              Motor=newPremMotor,
              Work=newPremWork,
              product_cluster=as.factor(X_SEGMENT_),
              product_distance=Distance,
              role="outliers")
  temp <- rbind(temp_train, temp_score) %>% 
    arrange(ID)
  return(temp)
}


# Import data from value clustering
import_value_data <- function(ncluster){
  train_file <- paste("./Results/value_clustered_data",
                      as.character(ncluster),
                      "_TRAIN.csv", sep="")
  temp_train <- read.csv(train_file) %>% 
    transmute(ID=CustID,
              CMV=CustMonVal,
              Claims=ClaimsRate,
              Children=as.factor(IMP_Children),
              Education=as.factor(IMP_EducDeg),
              Area=as.factor(IMP_GeoLivArea),
              Salary=IMP_MonthSal,
              Age=age,
              Fidelity=policy_time,
              Reversals=as.factor(reversals),
              value_cluster=as.factor(X_SEGMENT_),
              value_distance=Distance,
              role="train")
  score_file <- paste("./Results/value_clustered_data",
                      as.character(ncluster),
                      "_SCORE.csv", sep="")
  temp_score <- read.csv(score_file) %>% 
    transmute(ID=CustID,
              CMV=CustMonVal,
              Claims=ClaimsRate,
              Children=as.factor(IMP_Children),
              Education=as.factor(IMP_EducDeg),
              Area=as.factor(IMP_GeoLivArea),
              Salary=IMP_MonthSal,
              Age=age,
              Fidelity=policy_time,
              Reversals=as.factor(reversals),
              value_cluster=as.factor(X_SEGMENT_),
              value_distance=Distance,
              role="outliers")
  temp <- rbind(temp_train, temp_score) %>% 
    arrange(ID)
  return(temp)
}


# Import centroids from product clustering
import_product_centroids <- function(ncluster){
  temp_file <- paste("./Results/product_centroids",
                      as.character(ncluster),
                      ".csv", sep="")
  temp <- read.csv(temp_file) %>% 
    transmute(product_cluster=as.factor(X_SEGMENT_),
              freq=X_FREQ_,
              mean_distance=X_RMSSTD_,
              radius=X_RADIUS_,
              nearest_cluster=X_NEAR_,
              Household=newPremHousehold,
              Health=newPremHealth,
              Life=newPremLife,
              Motor=newPremMotor,
              Work=newPremWork)
  return(temp)
}


# Import centroids from value clustering
import_value_centroids <- function(ncluster){
  temp_file <- paste("./Results/value_centroids",
                     as.character(ncluster),
                     ".csv", sep="")
  temp <- read.csv(temp_file) %>% 
    transmute(value_cluster=as.factor(X_SEGMENT_),
              freq=X_FREQ_,
              mean_distance=X_RMSSTD_,
              radius=X_RADIUS_,
              nearest_cluster=X_NEAR_,
              CMV=CustMonVal,
              Salary=IMP_MonthSal,
              Fidelity=policy_time)
  return(temp)
}