## Filename: run_analysis.R
##
##  Original: 8/10/2014 Bob Uva
##
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##
##  Data set locations relative to project: ../UCI HAR Dataset/test and ../UCI HAR Dataset/train
##

run_analysis <- function(x) {
  
  # Set working directory
  setwd("C:/DSCoursera/GettingAndCleaningData/Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
  
  # Read training data
  print("Reading training data...")
  subjectPerSample <- read.table("train/subject_train.txt")
  activityPerSample <- read.table("train/y_train.txt")
  samples <- read.table(colClasses="numeric", "train/x_train.txt")
  stopifnot(nrow(subjectPerSample) == nrow(activityPerSample == nrow(samples)))
  
  # Read feature labels
  print("Reading Feature Labels...")
  featureLabels <- read.table("features.txt")
  stopifnot(ncol(samples) == nrow(featureLabels))
  print("Now to assign featureLabels as training samples column names")
  colnames(samples) <- featureLabels[,2]
  
  # Read test data
  print("Reading test data...")
  subjectPerSampleTest <- read.table("test/subject_test.txt")
  activityPerSampleTest <- read.table("test/y_test.txt")
  samplesTest <- read.table(colClasses="numeric", "test/x_test.txt")
  stopifnot(nrow(subjectPerSampleTest) == nrow(activityPerSampleTest == nrow(samplesTest)))
  print("Now to assign featureLabels as test samples column names")
  colnames(samplesTest) <- featureLabels[,2]
  
  # Merge training and test data sets
  samplesMerged <- rbind(samples, samplesTest)
}
