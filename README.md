# getdata-011-courseproject
Gettting and cleaning data course project

The code is organized to solve the following problems:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output is a tidy dataset produced by step 5.

## Prerequisite
Make sure you have `plyr`, `dplyr` and `tidyr` packages installed.

```
install.packages("plyr")
install.packages("dplyr")
install.packages("tidyr")
```

## How to run the code
1. Make sure to set the working directory to contain the UCI_HAR_Dataset 
2. Clone the source code in the working directory
3. Run the following command to execute the code:

  ```
  source("getdata-011-courseproject/run_analysis.R")
  ```
4. Run `View(tidyDataset)` to view the dataset

*Note: The dataset is large so it may take a while to run the code*