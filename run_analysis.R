# LOAD DATA FROM LOCAL FILES

trainfile <- "UCI-HAR-Dataset/train/X_train.txt"
subjecttrain <-"UCI-HAR-Dataset/train/subject_train.txt"
testfile <- "UCI-HAR-Dataset/test/X_test.txt"
subjecttest <-"UCI-HAR-Dataset/test/subject_test.txt"
activitytrain <- "UCI-HAR-Dataset/train/y_train.txt"
activitytest <- "UCI-HAR-Dataset/test/y_test.txt"
trainset <- read.table(trainfile)
testset <- read.table(testfile)
trainsubjects <- read.table(subjecttrain)
testsubjects <- read.table(subjecttest)
activitytrain <- read.table(activitytrain)
activitytest <- read.table(activitytest)

# GET HEADINGS

headingfile <- "UCI-HAR-Dataset/features.txt" # get activity headers
headings <- read.table(headingfile)
headers <- headings[,2]
headers <- gsub("\\(|\\)", "", headers) # strip brackets

# CHANGE HEADER NAMES

names(trainset) <- headers
names(testset) <- headers
trainset <- cbind(trainsubjects,activitytrain,trainset)
testset <- cbind(testsubjects,activitytest,testset)

# MERGE DATASETS

merged <- rbind(trainset,testset)
names(merged)[1]<- "Subject" # add subject header
names(merged)[2]<- "Activity" # add activity header

# CHANGE SUBJECT AND ACTIVITY TO FACTORS WITH RENAMING OF LEVELS

merged[,1]<- as.factor(merged[,1])
merged[,2] <- factor(merged[,2], levels=c(1,2,3,4,5,6), labels=c("Walking","Walking_up","Walking_down","Sitting","Standing","Laying"))

# SELECT COLUMNS WITH MEANS AND STANDARD DEVIATIONS

subject <- subset(merged, select = grepl("Subject", names(merged)))
activity <- subset(merged, select = grepl("Activity", names(merged)))
mean <- subset(merged, select = grepl("mean", names(merged)))
mean1 <-subset(mean, select = grepl("meanFreq", names(mean))) # get meanFreq columns
std <-subset(merged, select = grepl("std", names(merged)))
mean2 <- mean[,!(names(mean) %in% names(mean1))] # remove meanFreq columns
meanstd <- cbind(subject,activity,mean2,std)

# CALCULATE COLUMN MEANS BY SUBJECT AND ACTIVITY

# Splits dataset by Subject and Activity, then calculates column means
result <- lapply(split(meanstd[,3:68],list(meanstd[,1],meanstd[,2])),colMeans)
final <- as.data.frame(result) # tidy result to data frame
