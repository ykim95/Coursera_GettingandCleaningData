@@ -0,0 +1,109 @@
#------------------------------------------------------------------------------------------------#
# Coursera Getting and Cleaning Data Project
# YounJoo Kim
# 
#'features_info.txt': Shows information about the variables used on the feature vector.
#'features.txt': List of all features.
#'activity_labels.txt': Links the class labels with their activity name.
#'train/X_train.txt': Training set.
#'train/y_train.txt': Training labels.
#'test/X_test.txt': Test set.
#'test/y_test.txt': Test labels.

#set working directory
setwd("C:/Users/Maggie Kim/Documents/GitHub/Coursera/getcleanData/week3/data/UCI HAR Dataset")

#Read data from files
features       <- read.table('./features.txt', header = F) 
activity       <- read.table('./activity_labels.txt', header = F)          
subjectTrain   <- read.table('./train/subject_train.txt' ,header = F)
xTrain         <- read.table('./train/x_train.txt', header = F)
yTrain         <- read.table('./train/y_train.txt', header = F)
subjectTest    <- read.table('./test/subject_test.txt', header=F)
xTest          <- read.table('./test/x_test.txt', header = F)
yTest          <- read.table('./test/y_test.txt', header = F)

#check data sets
head(features, 3)
head(activity, 3)
head(subjectTrain, 3)
View(xTrain)
View(yTrain)
head(subjectTest)
View(xTest)
View(yTest)

#Assign column name into Data set
colnames(activity)       <- c('actId','type')
colnames(subjectTrain)   <- c('subId')
colnames(xTrain)         <- features[,2];
colnames(yTrain)         <- c('actId')
colnames(subjectTest)    <- c('subId')
colnames(xTest)          <- features[,2];
colnames(yTest)          <- c('actId')

#######################################################################
#TASK1. Merges the training and the test sets to create one data set.##
#######################################################################
#merging Train and Test Data
#merging yTrain, subjectTrain, xTrain
TrainDF   <- cbind(yTrain, subjectTrain, xTrain)
#merging yTest, subjectTest, xTest
TestDF    <- cbind(yTest, subjectTest, xTest)

str(TrainDF)
str(TestDF)

#subId == 1 : Train Data, subject ==2 : Test data
#bind Test data and Train data
combine  <- rbind(TrainDF,TestDF)

str(combine)

################################################################################################
#TASK2.Extracts only the measurements on the mean and standard deviation for each measurement. #
################################################################################################

colnames(combine)

## Colnames to extract example
## tGravityAcc-mean()-X
## tGravityAcc-std()-X

# Get number of columns which has "-mean()" and "-std()"
meanFeatures   <- grep("-(mean)\\(\\)", features[, 2])
stdFeatures    <- grep("-(std)\\(\\)", features[,2])

# combine mean and std
MeanStd   <- sort(c(meanFeatures,stdFeatures))

# Extract Mean and Std columns
combine   <- combine[,MeanStd]

################################################################################################
#TASK3.Use descriptive activity names to name the activities in the data set. #
################################################################################################

combine   <- merge(combine,activity, by='actId', all.x = T)

################################################################################################
#TASK4. Appropriately label the data set with descriptive activity names. 
################################################################################################

library(plyr)
combine   <- rename(combine, c("actId" = "Activity", "subId" = "Subject") )

################################################################################################
#TASK5.From the data set in step 4, creates a second, independent tidy data set with the average
#      of each variable for each activity and each subject.  
################################################################################################

#Ommitting last two columns which variable name type.x, type.y
CleanData<-combine[,-c(67,68)]

#Get Average value by Activity and Subject
Mean_Data <- ddply(CleanData, .(Activity, Subject) , colMeans)

#Export the dataset
write.table(Mean_Data, './Mean_data.txt', row.names = TRUE, sep = ',' )
