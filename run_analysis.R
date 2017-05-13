# 1) Import data
# 2) Rename variables with descriptive labels
# 3) Merge tables
# 4) Removed undesired data
# 5) Summarise data
# 6) Write data

library(dplyr)
rm(list = ls())

#1

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

#2

colnames(activity_labels) <- c("activity_index","activity_name")

features$new_name <- gsub("^t", "time of ", features$V2)
features$new_name <- gsub("^f", "frequency of ", features$new_name)
features$new_name <- gsub("-mean\\(\\)","Mean ",features$new_name)
features$new_name <- gsub("-std\\(\\)","StdDev ",features$new_name)
features$new_name <- gsub("-X","in the X-Direction",features$new_name)
features$new_name <- gsub("-Y","in the Y-Direction",features$new_name)
features$new_name <- gsub("-Z","in the Z-Direction",features$new_name)

#3

colnames(x_test) <- features$new_name
colnames(subject_test) <- "subject"
colnames(y_test) <- "activity"
named_y_test <- inner_join(x = y_test, y = activity_labels, by = c("activity" = "activity_index"))
test_data <- cbind(subject_test,activity = named_y_test$activity_name,x_test)

colnames(x_train) <- features$new_name
colnames(subject_train) <- "subject"
colnames(y_train) <- "activity"
named_y_train <- inner_join(x = y_train, y = activity_labels, by = c("activity" = "activity_index"))
train_data <- cbind(subject_train,activity = named_y_train$activity_name,x_train)

all_data <- rbind(test_data,train_data)

#4

reduced_data <- all_data[,grepl("subject|activity|Mean|StdDev", colnames(all_data))]

#5

averaged_data <- reduced_data %>%
                  group_by(activity, subject) %>%
                  summarise_each(funs(mean))

#6

write.table(averaged_data, file = "./tidy_data.txt",row.name = FALSE)


