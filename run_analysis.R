# 1.Setting up space and download required file ----
# set up a working directory
setwd("B:/Data Science Specialization John Hopskin/Getting and cleaning data/Peer assignment")

#Create folder to hold the download file
if(!file.exists("./data")) {dir.create("./data")}
setwd("./data")

#download file and unzip to the folder
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "gear_data.zip", method="libcurl")
if(!file.exists("FUCI HAR Dataset")) {unzip("gear_data.zip")}

# 2. Merging train and test data set ----
#Reading data from the test set
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

#Reading data from the train set
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")

#Reading features labels
features <- read.table("./UCI HAR Dataset/features.txt")

#Reading activities labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Rename columns name for train and test datasets
colnames(train_set) <- features[,2]
colnames(train_subject) <- c("subjectID")
colnames(train_labels) <- c("activity")

colnames(test_set) <- features[,2]
colnames(test_subject) <- c("subjectID")
colnames(test_labels) <- c("activity")

#Merge data with subject id and label activity for each of train and test set
train <- cbind(train_subject,train_labels,train_set)
test <- cbind(test_subject, test_labels, test_set)

#Merge train and test data into one final dataset
all_data <- rbind(train,test)

# 3. Extracts only the measurements on the mean and standard deviation for each measurement ----
featureSelect <- grep("*[Mm]ean*|*std*|subjectID|activity", colnames(all_data))
all_data_extract <- all_data[,featureSelect]

# 4. Uses descriptive activity names to name the activities in the data set
require(dplyr)
colnames(activities) <- c("activity","activity_name")
all_data_extract <- merge(all_data_extract, activities, by = "activity", all.x = TRUE)
all_data_extract <- select(all_data_extract, -activity)

# 5. Appropriately labels the data set with descriptive variable names
names(all_data_extract)<-gsub("Acc", "Accelerometer", names(all_data_extract))
names(all_data_extract)<-gsub("Gyro", "Gyroscope", names(all_data_extract))
names(all_data_extract)<-gsub("Mag", "Magnitude", names(all_data_extract))
names(all_data_extract)<-gsub("^t", "Time", names(all_data_extract))
names(all_data_extract)<-gsub("^f", "Frequency", names(all_data_extract))
names(all_data_extract)<-gsub("tBody", "TimeBody", names(all_data_extract))

# 6. creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

tidyData <- aggregate(. ~subjectID + activity_name, all_data_extract, mean)

write.table(tidyData, "tidy_Data.txt", row.names = FALSE, quote = FALSE)

