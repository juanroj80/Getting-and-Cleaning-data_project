url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- paste0(getwd(), "/", "datafile.zip")
download.file(url = url, destfile = destfile, method = curl)
unzip("datafile.zip", list=TRUE)

library(dplyr)
#reading files from dataset
activ_labels <- read.table("activity_labels.txt", header=FALSE)
feat <- read.table("features.txt", header=FALSE)
#reading files from test
sub_test <- read.table("./test/subject_test.txt", header=FALSE)
feat_test <- read.table("./test/X_test.txt", header=FALSE)
res_test <- read.table("./test/y_test.txt", header=FALSE)
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt", header=FALSE)
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt", header=FALSE)
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt", header=FALSE)
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt", header=FALSE)
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt", header=FALSE)
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt", header=FALSE)
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt", header=FALSE)
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt", header=FALSE)
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt", header=FALSE)
#reading files from train
sub_train <- read.table("./train/subject_train.txt", header=FALSE)
feat_train <- read.table("./train/X_train.txt", header=FALSE)
res_train <- read.table("./train/y_train.txt", header=FALSE)
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt", header=FALSE)
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt", header=FALSE)
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt", header=FALSE)
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt", header=FALSE)
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt", header=FALSE)
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt", header=FALSE)
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt", header=FALSE)
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt", header=FALSE)
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt", header=FALSE)
#descriptive activities
names(res_train) <- "activity"
names(res_test) <- "activity"
res_test <- mutate(res_test, activity = as.character(factor(activity, levels=1:6, labels = activ_labels$V2)))
res_train <- mutate(res_train, activity = as.character(factor(activity, levels=1:6, labels = activ_labels$V2)))
#label columns
names(feat_train) <- feat$V2
names(feat_test) <- feat$V2
names(sub_train) <- "subject"
names(sub_test) <- "subject"
complete_train <- cbind(sub_train, res_train, feat_train)
complete_test <- cbind(sub_test, res_test, feat_test)
#complete data set
complete_dataset <- rbind(complete_train, complete_test)
#mean and standard deviation
mean_and_standarddeviation <- complete_dataset%>%select(matches("mean|std"))
#giving accurate names for variables
names(complete_dataset) <- gsub("tBodyAcc", "Body acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tGravityAcc", "Gravity acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tBodyAccJerk", "Body jerk acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tBodyGyro", "Body gyroscopic acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tBodyGyroJerk", "Body gyroscopic jerk acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tBodyAccMag", "Body magnitud acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tGravityAccMag", "Gravity magnitud acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tBodyAccJerkMag", "Body magnitud jerk acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tBodyGyroMag", "Body magnitud gyroscopic acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("tBodyGyroJerkMag", "Body magnitud gyroscopic jerk acceleration over time", names(complete_dataset))
names(complete_dataset) <- gsub("fBodyAcc", "Body acceleration Fast Fourier Transform", names(complete_dataset))
names(complete_dataset) <- gsub("fBodyAccJerk", "Body jerk acceleration Fast Fourier Transform", names(complete_dataset))
names(complete_dataset) <- gsub("fBodyGyro", "Body gyroscopic acceleration Fast Fourier Transform", names(complete_dataset))
names(complete_dataset) <- gsub("fBodyAccMag", "Body magnitud acceleration Fast Fourier Transform", names(complete_dataset))
names(complete_dataset) <- gsub("fBodyAccJerkMag", "Body magnitud jerk acceleration Fast Fourier Transform", names(complete_dataset))
names(complete_dataset) <- gsub("fBodyGyroMag", "Body magnitud gyroscopic acceleration Fast Fourier Transform", names(complete_dataset))
names(complete_dataset) <- gsub("fBodyGyroJerkMag", "Body magnitud gyroscopic jerk acceleration Fast Fourier Transform", names(complete_dataset))
