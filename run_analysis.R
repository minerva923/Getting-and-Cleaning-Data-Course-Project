setwd("UCI HAR Dataset")
library(reshape2)

## 1. Merges the training and the test sets to create one data set.
test <- read.table("test/X_test.txt")
training <- read.table("train/X_train.txt")
data <- rbind(test, training)

features <- read.table("features.txt")
features <- features[,2]

## 4. Appropriately labels the data set with descriptive variable names. 
invisible(features <- gsub(pattern = "tB", replacement = "TimeB", features, fixed = TRUE))
invisible(features <- gsub(pattern = "tG", replacement = "TimeG", features, fixed = TRUE))
invisible(features <- gsub(pattern = "fB", replacement = "FrequencyB", features, fixed = TRUE))
invisible(features <- gsub(pattern = "-m", replacement = "M", features, fixed = TRUE))
invisible(features <- gsub(pattern = "-s", replacement = "S", features, fixed = TRUE))
invisible(features <- gsub(pattern = "()-", replacement = "", features, fixed = TRUE))
invisible(features <- gsub(pattern = "()", replacement = "", features, fixed = TRUE))
invisible(features <- gsub(pattern = "Acc", replacement = "Accelerometer", features, fixed = TRUE))
invisible(features <- gsub(pattern = "Gyro", replacement = "Gyroscope", features, fixed = TRUE))
invisible(features <- gsub(pattern = "Mag", replacement = "Magnitude", features, fixed = TRUE))
invisible(features <- gsub(pattern = "BodyBody", replacement = "Body", features, fixed = TRUE))

colnames(data) <- features

## 2. Extracts only the measurements on the mean and standard deviation for 
## each measurement. 
select <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 
            240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517,
            529:530, 542:543)
ms <- data[, select] ## "m"ean + "s"td

## 3. Uses descriptive activity names to name the activities in the data set

testLabels <- read.table("test/y_test.txt", col.names = "Activity")
trainingLabels <- read.table("train/y_train.txt", col.names = "Activity")
Activity <- rbind(testLabels, trainingLabels)
ms <- cbind(Activity, ms)

Subject.a <- read.table("test/subject_test.txt", col.names = "Subject")
Subject.b <- read.table("train/subject_train.txt", col.names = "Subject")
Subject <- rbind(Subject.a, Subject.b)
ms <- cbind(Subject, ms)

ms$Activity[ms$Activity==1] <- "WALKING"
ms$Activity[ms$Activity==2] <- "WALKING_UPSTAIRS"
ms$Activity[ms$Activity==3] <- "WALKING_DOWNSTAIRS"
ms$Activity[ms$Activity==4] <- "SITTING"
ms$Activity[ms$Activity==5] <- "STANDING"
ms$Activity[ms$Activity==6] <- "LAYING"

ms <- ms[order(ms$Subject, ms$Activity),]

## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.

dataset <- melt(ms, id.vars = c("Subject", "Activity"))
final.data.frame <- dcast(dataset, Subject + Activity ~ variable, fun = mean)

write.table(final.data.frame, file = "Dateset.txt", row.name=FALSE)