# Code book
This documentation explains how I solved the problems:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Download the working data here: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Data description: [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Problem 1: Merges the training and the test sets to create one data set.

In problem 1, I loaded the data using `read.table()` and merged the `train/X_train.txt` and `test/X_test.txt` using `rbind()`, assign the a variable name called `dataset`

## Problem 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

1. In problem 2, I loaded the feature file. Then I extracted only the second column which contains the feature names I need. At the same time, I coerced it into character using `as.character()` since it was in `factor` type.

2. Using `grep()`, I first extracted the indices of mean and standart deviation features. Then using these indices, I extracted from the `dataset` the corresponding column.

3. List of fetched and modified features:
  * tBodyAcc_mean_XYZ
  * tBodyAcc_std_XYZ
  * tGravityAcc_mean_XYZ
  * tGravityAcc_std_XYZ
  * tBodyAccJerk_mean_XYZ
  * tBodyAccJerk_std_XYZ
  * tBodyGyro_mean_XYZ
  * tBodyGyro_std_XYZ
  * tBodyGyroJerk_mean_XYZ
  * tBodyGyroJerk_std_XYZ
  * tBodyAccMag_mean
  * tBodyAccMag_std
  * tGravityAccMag_mean
  * tGravityAccMag_std
  * tBodyAccJerkMag_mean
  * tBodyAccJerkMag_std
  * tBodyGyroMag_mean             
  * tBodyGyroMag_std
  * tBodyGyroJerkMag_mean
  * tBodyGyroJerkMag_std
  * fBodyAcc_mean_XYZ
  * fBodyAcc_std_XYZ
  * fBodyAcc_meanFreq_XYZ
  * fBodyAccJerk_mean_XYZ
  * fBodyAccJerk_std_XYZ
  * fBodyAccJerk_meanFreq_XYZ
  * fBodyGyro_mean_XYZ
  * fBodyGyro_std_XYZ
  * fBodyGyro_meanFreq_XYZ
  * fBodyAccMag_mean
  * fBodyAccMag_std
  * fBodyAccMag_meanFreq
  * fBodyBodyAccJerkMag_mean
  * fBodyBodyAccJerkMag_std
  * fBodyBodyAccJerkMag_meanFreq
  * fBodyBodyGyroMag_mean
  * fBodyBodyGyroMag_std
  * fBodyBodyGyroMag_meanFreq
  * fBodyBodyGyroJerkMag_mean
  * fBodyBodyGyroJerkMag_std
  * fBodyBodyGyroJerkMag_meanFreq

## Problem 4: Appropriately labels the data set with descriptive variable names. 

For the sake of simplicity, I decided to solve problem 4 ahead of problem 3.
1. Base on indices of needed features (mean and standart deviation), I fetched the exact features name
2. Using `gsub()`, I remove the special characters like `-`, `(` and `)` off these names
3. Assign these name to the dataset

## Problem 3: Uses descriptive activity names to name the activities in the data set

The activity is stored in `Y_train` and `Y_test` files, but they contain only the activity ids. The activity labels are actually store in `activity_labels.txt`. Our job is merging the label into the `dataset`.

1. Load and merge data `Y_train` and `Y_test` together using `rbind()` and assign the name `activity_id`
2. Merge the data above into `dataset` using `cbind()`
3. Load the `activity_labels.txt` file. It contains 2 column: id and label. So assign the column names `activity_id` and `activity_name`.
4. Use `join()` to assign the labels into `dataset`

## Problem 5: Create tidy data set

I used `dplyr` library to solve this problem. My tidy dataset will be in the following format:

```
 measure activity_name subject avg_value
tBodyAcc_mean_X LAYING 1 0.2215982
tBodyAcc_mean_X LAYING 2 0.2813734
tBodyAcc_mean_X LAYING 3 0.2755169
tBodyAcc_mean_X LAYING 4 0.2635592
...

```

1. Use `gather()` to gather variables like `tBodyAcc_mean_X`
2. Use `group_by()` to group the need variables: `measure`, `activity_name` and `subject`
3. Use `summarize()` to calculate the mean of each variables and stored it in `avg_value`
