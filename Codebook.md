## Codebook for Getting and Cleaning Data course project

### Data Source
Data was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data must be unzipped and the folder in which the data is located must be set as the working directory

### Dataset information
Taken from here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### Steps followed
Created one R script called run_analysis.R that does the following. 
1.  Merged the training and the test sets to create one data set..
2.  Extracted only the measurements on the mean and standard deviation for each measurement. Selected any feature containing the string "mean" or "std"..
3.  Used descriptive activity names to name the activities in the data set. This info was found in activity_labels.txt..
4.  Appropriately labeled the data set with descriptive variable names (see "variable names".. 
5.  From the data set in step 4, created a second, independent tidy data set 
with the average of each variable for each activity and each subject using dplyr package. Called "tidy_data_step5.txt"..

### Variable names:
* activity: activity name e.g. WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING 
* subject: which subject performed the activity, numbered 1-30
* features measured are contained in the rest of the columns. Labelling as follows: measurement unit: time or freq
location of measurement: e.g. body
measurement method: accelerometer or gyroscope
summary statistic: mean or standard deviation (std)
direction of movement: X, Y or Z
