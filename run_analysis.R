## Filename: run_analysis.R
##
##  Original: 8/10/2014 Bob Uva
##
##  Prerequisites:
##    Uses the fBasics package. Make sure that package is installed and available.
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

  # Read feature labels
  print("1. Reading Feature Labels...")
  featureLabels <- read.table("features.txt")
  
  # Read training data
  print("2. Reading training data...")
  subjectPerSampleTrain <- read.table("train/subject_train.txt")
  activityPerSampleTrain <- read.table("train/y_train.txt")
  samplesTrain <- read.table(colClasses="numeric", "train/x_train.txt")
  stopifnot(nrow(subjectPerSampleTrain) == nrow(activityPerSampleTrain == nrow(samplesTrain)))
  
  stopifnot(ncol(samplesTrain) == nrow(featureLabels))
  print("     Assigning Feature Labels as column names")
  colnames(samplesTrain) <- featureLabels[,2]
  
  # Read test data
  print("3. Reading test data...")
  subjectPerSampleTest <- read.table("test/subject_test.txt")
  activityPerSampleTest <- read.table("test/y_test.txt")
  samplesTest <- read.table(colClasses="numeric", "test/x_test.txt")
  stopifnot(nrow(subjectPerSampleTest) == nrow(activityPerSampleTest == nrow(samplesTest)))
  print("     Assigning Feature Labels as column names")
  colnames(samplesTest) <- featureLabels[,2]
  
  # Merge training and test data sets
  print("4. Merging training and test data sets...")
  samplesMerged <- rbind(samplesTrain, samplesTest)
  
  # Find the column indices where the word "angle" is used. This should be excluded.
  #angleColumnIndices <- grep(pattern="angle", x=featureLabels[,2])
  
  # Find the column indices where the data is a mean.
  # Note: This does not include 'meanFreq' columns. If that is not correct, 
  # I can change to grepping for 'mean' and for 'angle' and removing the angle
  # columns from the indices list.
  
  meanColumnIndices <- grep(pattern="mean()", x=featureLabels[,2], fixed=TRUE, value=FALSE)
  #remaining <- lapply(meanColumnIndices, function(x) { !(x%in%angleColumnIndices)})
  #remain <- unlist(remaining)
  #means <- meanColumnIndices[remain]
  print(meanColumnIndices)
  print(length(meanColumnIndices))
  # Find the column indices where the data is a standard deviation
  sdColumnIndices <- grep(pattern="std", x=featureLabels[,2])
  
  # Create the data set that contains
  #   1. Descriptive Activity Names 
  #   2. Descriptive Variable Names (for mean and SD columns)
  #
  #dfResults <- data.frame()
  
  # Create a tidy data set that contains
  #   1. the average of each variable for each activity and subject.
}

library