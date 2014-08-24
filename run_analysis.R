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

  # Read feature labels
  print("1. Reading Feature Labels...")
  featureLabels <- read.table("features.txt", row.names=NULL)
  
  # Read activity labels
  activityLabels <- read.table("activity_labels.txt")
  
  # Read training data
  print("2. Reading training data...")
  subjectPerSampleTrain <- read.table("train/subject_train.txt", row.names=NULL)
  activityPerSampleTrain <- read.table("train/y_train.txt", row.names=NULL)
  print(length(activityPerSampleTrain))
  print(class(activityPerSampleTrain))
  print(names(activityPerSampleTrain))
  samplesTrain <- read.table(colClasses="numeric", "train/x_train.txt", row.names=NULL)
  stopifnot(nrow(subjectPerSampleTrain) == nrow(activityPerSampleTrain == nrow(samplesTrain)))
  
  # Replace activity number per sample with descriptive label for the activity
  #activityPerSampleTrain$V1 <-  activityLabels[activityPerSampleTrain,2]
  
  print("head of activity in train is now:")
  print(head(activityPerSampleTrain))
  #activityPerSampleTrain <- lapply(activityPerSampleTrain,
  #                                 function(n) {
  #                                   as.character(activityLabels[n, 2])   
  #                                })
  
  # Verification before assigning feature labels to columns
  stopifnot(ncol(samplesTrain) == nrow(featureLabels))
  print("     Assigning Feature Labels as column names")
  colnames(samplesTrain) <- featureLabels[, 2]
  
  # Bring subject and activity data into training data
  samplesTrain <- cbind(activityPerSampleTrain, samplesTrain)
  samplesTrain <- cbind(subjectPerSampleTrain, samplesTrain)
  colnames(samplesTrain)[1] <- "Subject"
  colnames(samplesTrain)[2] <- "Activity"
  
  # Read test data
  print("3. Reading test data...")
  subjectPerSampleTest <- read.table("test/subject_test.txt", row.names=NULL)
  activityPerSampleTest <- read.table("test/y_test.txt", row.names=NULL)
  samplesTest <- read.table(colClasses="numeric", "test/x_test.txt", row.names=NULL)

  # Replace activity number per sample with descriptive label for the activity
  
  #  activityPerSampleTest <- sapply(activityPerSampleTest,
 #                                  function(n) {
#                                     as.character(activityLabels[n, 2])   
#                                   })
  
  # Verification before assigning feature labels to columns
  stopifnot(nrow(subjectPerSampleTest) == nrow(activityPerSampleTest == nrow(samplesTest)))
  print("     Assigning Feature Labels as column names")
  colnames(samplesTest) <- featureLabels[, 2]
  
  # Bring subject and activity data into test data
  samplesTest <- cbind(activityPerSampleTest, samplesTest)
  samplesTest <- cbind(subjectPerSampleTest, samplesTest)
  colnames(samplesTest)[1] <- "Subject"
  colnames(samplesTest)[2] <- "Activity"

# Merge training and test data sets
  print("4. Merging training and test data sets...")
#  samplesMerged <- rbind(samplesTrain, samplesTest)
  
  # Find the column indices where the data is a mean.  
  meanColumnIndices <- grep(pattern="mean()", x=featureLabels[,2], fixed=TRUE, value=FALSE)

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