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
  
  # Find the feature column indices where the data is a mean.  
  meanColumnIndices <- grep(pattern="mean()", x=featureLabels[,2], fixed=TRUE, value=FALSE)
  
  # Find the feature column indices where the data is a standard deviation
  sdColumnIndices <- grep(pattern="std", x=featureLabels[,2])

  # Merge mean and sd column indices and sort.
  selected <- c(meanColumnIndices, sdColumnIndices)
  selected <- sort(selected)
  
  ############################################
  
  # Create descriptive names for the types of measurement features
  existingFeatures <- c("tBodyAcc", "tGravityAcc", "tBodyAccJerk",
                       "tBodyGyro", "tBodyGyroJerk", "tBodyAccMag", "tGravityAccMag",
                       "tBodyAccJerkMag", "tBodyGyroMag", "tBodyGyroJerkMag", "fBodyAcc",
                       "fBodyAccJerk", "fBodyGyro", "fBodyAccMag", "fBodyAccJerkMag",
                       "fBodyGyroMag", "fBodyGyroJerkMag", "-mean()", "-std()",
                       "-X", "-Y", "-Z")
  
  descriptiveFeatures <- c("Body Acceleration (time)", 
                          "Gravity Acceleration (time)",
                          "Body Acceleration Jerk (time)",
                          "Body Gyroscope Magnitude (time)", 
                          "Body Gyroscope Jerk (time)", 
                          "Body Acceleration Magnitude (time)",
                          "Gravity Acceleration Magnitude (time)",
                          "Body Acceleration Jerk Magnitude (time)",
                          "Body Gyroscope Magnitude (time)",
                          "Body Gyroscope Jerk Magnitude (time)",
                          "Body Acceleration (frequency)",
                          "Body Jerk acceleration (frequency)", 
                          "Body Gyroscope (frequency)", 
                          "Body Acceleration Magnitude (frequency)", 
                          "Body Acceleration Jerk Magnitude (frequency)",
                          "Body Gyroscope Magnitude (frequency)", 
                          "Body Gyroscope Jerk Magnitude (frequency",
                          " Average", " Standard Deviation", " of X-coordinate",
                          " of Y-coordinate", " of Z-coordinate")
  
  # Modify the feature labels to use descriptive text. This will modify
  # more than just the mean and sd column names, but that's ok since we're
  # throwing those other columns away. Very, very small performance impact.
  for(i in 1:length(existingFeatures)) {
    featureLabels$V2 <- gsub(existingFeatures[i], descriptiveFeatures[i], featureLabels$V2, fixed=TRUE)  
  }
    
  ############################################
  
  # Read activity labels
  activityLabels <- read.table("activity_labels.txt")

  ############################################
  
  # Read training data
  print("2. Reading training data...")
  subjectPerSampleTrain <- read.table("train/subject_train.txt", row.names=NULL)
  activityPerSampleTrain <- read.table("train/y_train.txt", row.names=NULL)

  samplesTrain <- read.table(colClasses="numeric", "train/x_train.txt", row.names=NULL)
  stopifnot(nrow(subjectPerSampleTrain) == nrow(activityPerSampleTrain == nrow(samplesTrain)))
    
  # Verification before assigning feature labels to columns
  stopifnot(ncol(samplesTrain) == nrow(featureLabels))
 
  print("     Assigning Feature Labels as column names")
  colnames(samplesTrain) <- featureLabels[, 2]

  # Extract mean and standard deviation column data only.
  # Want to do this before bringing in Subject and Activity data
  # because the column indices coming from the featureLabels data 
  # correspond to the raw training data.
  print("Extracting mean and standard deviation data")
  
  # Create a smaller data set that has:
  #   Subject, Activity, mean and sd columns
  samplesTrain <- samplesTrain[, selected]
  
  # Bring subject and activity data into training data
  # after extracting just the mean/stddev data.
  samplesTrain <- cbind(activityPerSampleTrain, samplesTrain)
  samplesTrain <- cbind(subjectPerSampleTrain, samplesTrain)
  colnames(samplesTrain)[1] <- "Subject"
  colnames(samplesTrain)[2] <- "Activity"
  
  ############################################

  # Read test data
  print("3. Reading test data...")
  subjectPerSampleTest <- read.table("test/subject_test.txt", row.names=NULL)
  activityPerSampleTest <- read.table("test/y_test.txt", row.names=NULL)
  samplesTest <- read.table(colClasses="numeric", "test/x_test.txt", row.names=NULL)

  
  # Verification before assigning feature labels to columns
  stopifnot(nrow(subjectPerSampleTest) == nrow(activityPerSampleTest == nrow(samplesTest)))

  print("     Assigning Feature Labels as column names")
  colnames(samplesTest) <- featureLabels[, 2]

  # Create a smaller data set that has:
  #   Subject, Activity, mean and sd columns
  samplesTest <- samplesTest[, selected]
  
  # Bring subject and activity data into test data
  # after extracting just the mean/stddev data.
  samplesTest <- cbind(activityPerSampleTest, samplesTest)
  samplesTest <- cbind(subjectPerSampleTest, samplesTest)
  colnames(samplesTest)[1] <- "Subject"
  colnames(samplesTest)[2] <- "Activity"

  
  ############################################
  
  # Merge training and test data sets
  print("4. Merging training and test data sets...")
  samplesMerged <- rbind(samplesTrain, samplesTest)

  # Replace Activity identifiers with descriptive names.
  print("5. Use descriptive activity names")
  samplesMerged$Activity <- lapply(samplesMerged$Activity,
      function(n) { 
        switch(n, activityLabels[1,2], activityLabels[2,2], 
                activityLabels[3,2], activityLabels[4,2],
                activityLabels[5,2]) 
      })
  
  ############################################
  
  # Create a tidy data set that contains the average of each variable
  # for each activity and subject.
  
  
}