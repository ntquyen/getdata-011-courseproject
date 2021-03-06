## The code assumes that UCI_HAR_Dataset is in the working directory
# setwd("/path/to/UCI_HAR_Dataset")

### Load dependent libraries
library(plyr)
library(dplyr)
library(tidyr)

#---------------- 1. Merges the training and the test sets to create one data set.

# Load data in test and train folders
x_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
y_train <- read.table("UCI_HAR_Dataset/train/Y_train.txt")
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")

x_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("UCI_HAR_Dataset/test/Y_test.txt")
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")

# Merge test and train data
dataset <- rbind(x_train, x_test)

#---------------- 2. Extracts only the measurements on the mean and ----------------
#------------------------ standard deviation for each measurement. ----------------

# Load feature names
features <- read.table("UCI_HAR_Dataset/features.txt")
features <- as.character(features[, 2])

# Indices of extracted columns
extracted.measures <- grep("mean|std", features);

# Extract
dataset <- dataset[, extracted.measures]


#---------------- 4. Appropriately labels the data set with ---------------
#------------------------ descriptive variable names. ---------------

# Names of extracted columns
extracted.features <- features[extracted.measures]
## Replace and remove special characters
extracted.features <- gsub("-", "_", extracted.features)
extracted.features <- gsub("\\(\\)", "", extracted.features)

# Assign column names
names(dataset) <- extracted.features


#---------------- 3. Uses descriptive activity names to name the ---------------
#--------------------------- activities in the data set ----------------

# add activity column
activities <- rbind(y_train, y_test)
names(activities) <- "activity_id"
dataset <- cbind(dataset, activities)

# Load activity labels
activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt")
names(activity_labels) <- c("activity_id", "activity_name")

# merge using join, because "merge()" doesn't keep the order of y_test1
dataset <- join(dataset, activity_labels, by = "activity_id")


#---------------- 5. Creates a second, independent tidy data set with the average of ----------------
#--------------------------- each variable for each activity and each subject. ----------------

# add subject column
subjects <- rbind(subject_train, subject_test)
names(subjects) <- "subject"
dataset <- cbind(dataset, subjects)

dataset <- tbl_df(dataset)

# Build tidy dataset 
tidyDataset <- dataset %>%
  gather(measure, value, -subject, -activity_name, -activity_id) %>%
  group_by(measure, activity_name, subject) %>% 
  summarize(avg_value = mean(value)) %>%
  print