# Code book
This documentation explains how I solved the problems:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Problem 1: Merges the training and the test sets to create one data set.

In problem 1, I loaded the data using `read.table()` and merged the `train/X_train.txt` and `test/X_test.txt` using `rbind()`, assign the a variable name called `dataset`

## Problem 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

1. In problem 2, I loaded the feature file. Then I extracted only the second column which contains the feature names I need. At the same time, I coerced it into character using `as.character()` since it was in `factor` type.

2. Using `grep()`, I first extracted the indices of mean and standart deviation features. Then using these indices, I extracted from the `dataset` the corresponding column.

3. List of features:



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
