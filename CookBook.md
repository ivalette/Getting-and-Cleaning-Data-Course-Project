#CookBook
In this document, we will describe the variables, the datasets, transformations or work that was performed to clean up the data from the link provided in README.md with the R script "run_analysis.R".

##General description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

##Dataset Description
This section contains a list of both temporary and non-temporary datasets used in this assignment

- "feature" is the datasets that contents all the variable names for the data contained in "X_test" and "X_train". It is composed of 561 different variable names.
- "featureLt" is the datasets produced by the R script "run_analysis" and that contains only the mean or standard deviation variables contained in "X_test" and "X_train". It has 66 variable names.
- "X_test" is the test dataset and has 2947 rows and 561 variables (described in Variable Description)
- "X_train" is the training dataset and has 7352 rows and 561 variables (described in Variable Description)
- "mergeData" is created by the "run_analysis.R" script. It is composed of two datasets: "X_test" and "X_train". It has 10299 rows and 561 variables.
- "mean_std" is composed of the combined datasets "X_test" and "X_train". It has 10299 rows and only 66 variables (contains only the mean or standard deviation as described in Variable Reduction section). It is produced by the "run_analysis.R" script.
- "y_test" is the test dataset for the activity codes. It contains only one column and 2947 rows. This column is renamed by the "run_analysis.R" script to "activity".
- "y_train" is the training dataset for the activity labels. It contains only one column and 7352 rows. This column is renamed by the "run_analysis.R" script to "activity".
- "mergeDataActivity" is created by the "run_analysis.R" script. It is composed of two datasets: "y_test" and "y_train". It has 10299 rows and 1 variables renamed to "activity". The activity variable is originally a numeric code (with a value from 1 to 6) that the "run_analysis.R" script will transform to a character vector as described in the file "activity_labels".
- "activity_labels" is a file with the coding values and labels for the "activity" variable contains in "y-test" and "y_train".
- mean_std_labels is created by the "run_analysis.R" script. it is composed of 10299 rows and 67 mean, standard deviations and activity variables.
- "subject_test" is the test dataset with the subject ID. It is composed of 2947 rows and 1 variable labeled "subjectID" by the "run_analysis.R" script.
- "subject_train" is the training dataset with the subject ID. It is composed of 7352 rows and 1 variable labeled "subjectID" by the "run_analysis.R" script.
- "subject" is obtained after merging the test and training datasets for "subjectID". It is composed of 10299 rows and 1 variable labeled "subjectID".
- "mean_std_Final" is a dataset obtained after merging the following datasets: "subject", "mean_std_labels". It has 68 variables and 10299 rows.

- "tidy" is the final dataset with 180 rows and 69 variables. We export this dataset as a flat file called "tidy_data". This file is the end result of this assignment


##Variable Descriptions from Step 1 - Merges the training and the test sets to create one data set
The first step of the "run_analysis.R" script will merge together the test and training datasets "X_test" and "X_train". These files are composed of the following information:

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


##Variable Reduction from Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement
The run_analysis script only extracts the mean and standard deviation contained in the original "X_test" and "X_train" datasets. The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation

See the README.md file for references on the grep() expression.

The original list of variables is then reduced to the following 66 variables and their location:
1           tBodyAcc-mean()-X
2           tBodyAcc-mean()-Y
3           tBodyAcc-mean()-Z
4            tBodyAcc-std()-X
5            tBodyAcc-std()-Y
6            tBodyAcc-std()-Z
41        tGravityAcc-mean()-X
42        tGravityAcc-mean()-Y
43        tGravityAcc-mean()-Z
44         tGravityAcc-std()-X
45         tGravityAcc-std()-Y
46         tGravityAcc-std()-Z
81         tBodyAccJerk-mean()-X
82       tBodyAccJerk-mean()-Y
83       tBodyAccJerk-mean()-Z
84        tBodyAccJerk-std()-X
85        tBodyAccJerk-std()-Y
86        tBodyAccJerk-std()-Z
121          tBodyGyro-mean()-X
122          tBodyGyro-mean()-Y
123          tBodyGyro-mean()-Z
124           tBodyGyro-std()-X
125           tBodyGyro-std()-Y
126           tBodyGyro-std()-Z
161      tBodyGyroJerk-mean()-X
162      tBodyGyroJerk-mean()-Y
163      tBodyGyroJerk-mean()-Z
164       tBodyGyroJerk-std()-X
165       tBodyGyroJerk-std()-Y
166       tBodyGyroJerk-std()-Z
201          tBodyAccMag-mean()
202           tBodyAccMag-std()
214       tGravityAccMag-mean()
215        tGravityAccMag-std()
227      tBodyAccJerkMag-mean()
228       tBodyAccJerkMag-std()
240         tBodyGyroMag-mean()
241          tBodyGyroMag-std()
253     tBodyGyroJerkMag-mean()
254      tBodyGyroJerkMag-std()
266           fBodyAcc-mean()-X
267           fBodyAcc-mean()-Y
268           fBodyAcc-mean()-Z
269            fBodyAcc-std()-X
270            fBodyAcc-std()-Y
271            fBodyAcc-std()-Z
345       fBodyAccJerk-mean()-X
346       fBodyAccJerk-mean()-Y
347       fBodyAccJerk-mean()-Z
348        fBodyAccJerk-std()-X
349        fBodyAccJerk-std()-Y
350        fBodyAccJerk-std()-Z
424          fBodyGyro-mean()-X
425          fBodyGyro-mean()-Y
426          fBodyGyro-mean()-Z
427      fBodyGyro-std()-X
428           fBodyGyro-std()-Y
429           fBodyGyro-std()-Z
503          fBodyAccMag-mean()
504           fBodyAccMag-std()
516  fBodyBodyAccJerkMag-mean()
517   fBodyBodyAccJerkMag-std()
529     fBodyBodyGyroMag-mean()
530      fBodyBodyGyroMag-std()
542 fBodyBodyGyroJerkMag-mean()
543  fBodyBodyGyroJerkMag-std()

##Further Transformation for Step 3 and Step 4 - Uses descriptive activity names to appropriately labels the dataset 
See the paragraph on Dataset Description to understand the transformations performed by the "run_analysis.R" script to convert the numeric activity values to descriptive character values on the following datasets: "y_test", "Y_train" and "mergeDataActivity".

##Final Transformation Step 5 - Creates an tidy dataset with the average of each variable for each activity and each subject
Here we aggregate our dataset per activity and per subjectID. The end result is a flat file ("tidy_data.txt") containing the end result of this assignment.See the README.md file for references on the aggregate() function.





