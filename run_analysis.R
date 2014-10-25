## You should create one R script called run_analysis.R that does the following.
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Create a directory for the "Project" folder (See "README.md" for instructions)
## setwd("/Users/isa/Documents/Courses/Johns Hopkins/Getting & Cleaning Data/Project")
## getwd()



# You should create one R script called "run_analysis.R" that does the following:
run_analysis <- function(){
        
        # Download the file. Note: You need to unzip the file separetly if you do not have a Mac.    
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, "UCI-HAR-dataset", method="curl")
        
        
        ## 1. Merges the training and the test sets to create one data set.
        # Load the "features" table
        features <- read.table("./UCI HAR Dataset/features.txt")
        
        # Load "X_test" and "X_train" datasets and append the column names located in the second column of
        # the "features" table
        X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
        X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
        
        # Merge the training and test datasets together by appending the rows from "X_train" to "X_test".
        mergeData <- rbind(X_test, X_train)
        
        # Control that the number of rows are correct!
        # str(X_test)
        # str(X_train)
        # str(mergeData)
        
        
        
        ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
        ## See references for help with this expression
        # Extract the colum names from "features" that measure the mean or the std of each measurement.
        featureLt <- features[grep("std|mean\\(", features[,2]),]
        
        # Create a new dataset from mergeData that only contains the 66 measurements of the mean and the std.
        mean_std <- mergeData[,featureLt[,1]]
        
        # Control that the new dataset "mean_std" only contains the mean and std and no other variables!
        # nrow(featureLt)
        # str(mean_std)

        
        
        
        # 3. Uses descriptive activity names to name the activities in the data set.
        # Load "y_test" and "y_train" datasets and append a new column name called "activity".
        y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
        y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
        
        # Merge the training and test datasets together by appending the rows from y_test to y_train.
        mergeDataActivity <- rbind(y_test, y_train)
        # Control that the numbers of rows is correct!
        # str(mergeDataActivity)
         
        
        
        
        # 4. Appropriately labels the data set with descriptive variable names. 
        # replace the activity code of each row in "mergeDataActivity" by the activity name from 
        # "activity_labels".
        labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        for (i in 1:nrow(labels)) {
                code <- as.numeric(labels[i, 1])
                activityLabels <- as.character(labels[i, 2])
                mergeDataActivity[mergeDataActivity$activity == code, ] <- activityLabels
        }
        # Control that the conversion from code to activityLabels is done correctly
        # head(mergeDataActivity, n=88)
        
        # Append a new colum with activity labels to already existing dataset "mergeDataActivity".
        mean_std_labels <- cbind(mergeDataActivity, mean_std)
        
        #Control that the datasets have the right number of colums and rows:
        # str(mean_std_labels)
        
        
        
        
        # 5. Creates a second, independent tidy data set with the average of each variable 
        #    for each activity and each subject.
        # Load the subject training and test datasets and rename the column name to "subjectID".
        subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subjectID'))
        subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subjectID'))
        
        # Merge the training and test datasets by appending the rows from subject_train to subject_test.
        subject <- rbind(subject_test, subject_train)
        
        # Append a new colum with subjectID to already existing dataset "mean_std_labels".
        mean_std_Final <- cbind(subject, mean_std_labels)
        
        # Control that the datasets have the right numbers of rows and columns
        # str(subject_test)
        # str(subject_train)
        # str(subject)
        # str(mean_std_Final)
        
        
        # Calculate the average of each variable for each activity and each subject
        ## See references for help with the aggregate function
        tidy <- aggregate(mean_std_Final[,-2], by = list(activity = mean_std_Final[,2], subject = mean_std_Final[,1]), mean)
        
        # Create an independent dataset with the tidy data 
        write.csv(tidy, file='tidy_data.txt', row.names=FALSE)
}
