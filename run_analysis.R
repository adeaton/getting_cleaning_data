# Here are the data for the project: 
   
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Instructions:
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

## Steps

# Set working directory to location of dataset
setwd("~//GettingData/Project/UCI HAR Dataset")

# Read data into R
train<-read.table("train/X_train.txt")
train_lab<-read.table("train/y_train.txt")
train_sub<-read.table("train/subject_train.txt")
train_des<-cbind(train,train_lab,train_sub)

test<-read.table("test/X_test.txt")
test_lab<-read.table("test/y_test.txt")
test_sub<-read.table("test/subject_test.txt")
test_des<-cbind(test,test_lab,test_sub)

# Step 1: merge train and test
merged<-rbind(train_des,test_des)
# save these labels to add in later
activity_numbers<-merged[562]
subjects<-merged[563]

# Step 2: Get feature names, extract those with mean and std deviation
features<-read.table("features.txt")

# do some partial text matching to get features with mean and std deviation
# took any feature that included the term "mean" or "std"
mean <- grep("mean()", features[[2]])
std <- grep("std()", features[[2]])
# combine conditions
meanStd<-sort(c(mean,std))

# Get only features with mean or std info from "merged" dataset, now called "merged_filter"
merged_filter<-merged[,meanStd]
# Name columns of merged dataset with feature names
colnames(merged_filter)<-features[meanStd,][[2]]

# Step 3: Name activities in dataset

# get names of activities that correspond to activity labels
activity_labels<-read.table("activity_labels.txt")
activity_labels<-activity_labels[2]

# convert activity labels (numeric) in merged_filter dataset
for(i in 1:6){
activity_numbers[activity_numbers==i] <- as.character(activity_labels[i,])
}
colnames(activity_numbers)<-"activity"
colnames(subjects)<-"subject"
merged_filter_info<-cbind(merged_filter,activity_numbers,subjects)

# Step 4: Label columns in merged_filter_info
old_names<-names(merged_filter_info)
a<-gsub("tBody","timebody",old_names)
b<-gsub("fBody","freqbody",a)
c<-gsub("tGravity","timegravity",b)
d<-gsub("fGravity","freqgravity",c)
e<-gsub("\\()","",d)
f<-gsub("-","",e)
g<-gsub("Acc","accelerometer",f)
h<-gsub("Gyro","gyroscope",g)
i<-gsub("Mag","magnitude",h)
j<-gsub("Jerk","jerk",i,fixed=T)
k<-gsub("Body","body",j,fixed=T)
l<-gsub("Freq","freq",k,fixed=T)

# assign new names to dataset
names(merged_filter_info)<-l

# Step 5: Get mean for each subject and activity

library(dplyr)
# group by activity and subject, then find mean of each column
tidy_data<-merged_filter_info %>% group_by(activity,subject) %>% summarise_each(funs(mean))
dim(tidy_data)
# check dimensions of tidy_data

# save to file
write.table(tidy_data,"tidy_data_step5.txt",row.names=F,col.names=T,sep="\t")

