##Introduction
This is the description about the variables, the data, and any transformations or work for the project.

##Source
A full description of the data set can be found here : [The UCI Machine Learning Repositor](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Performance

The project script 'run_analysis.R' is formed into 5 steps by project definition.

5 steps that the courses provided are below :
- 1. Merges the training and the test sets to create one data set. 
- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Beggining, All data files were downloaded after setting working derectory and readed as name of
- 'features_info.txt' : Shows information about the variables used on the feature vector.
- features            : 'features.txt': List of all features.
- activity            : 'activity_labels.txt': Links the class labels with their activity name.
- xTrain              : 'train/X_train.txt': Training set.
- yTrain              : 'train/y_train.txt': Training labels.
- xTest               : 'test/X_test.txt': Test set.
- yTest               : 'test/y_test.txt': Test labels.
and similar datasets are combined as one data set

(Tesk1), Merging Training dataset (yTrain, justjectTrain, xTrain) and Test dataset (yTest, subjectTest, xTest) using cbind. and bind Test data and Training data set into one data set as nmae of 'combine'
#
(Task2), For subsetting columns which has mean and std value, I used 'grep' function to extract colunms which has "-mean()" and "-std()" in variable name. and saved 'combine'
#
(Task3), Merge data subset with 'activity' data frame to include descriptive activity names in data set
#
(Task4), By using 'rename' function, appropriate name were given to the dataset. Specifically, 'actId' and 'subId' change to 'Activity' and 'Subject'
#
(Task5), Omit last tow columns which have type of activity to calculate average of each variables first, and save output dataset as name of 'Mean_data' by using 'ddply' function. and export the dataset by function 'write.table' having name of 'Mean_data.txt'
