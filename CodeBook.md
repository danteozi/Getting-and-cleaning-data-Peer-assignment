## Introduction
run_analysis.R does 5 steps operations as required by the assignment.
1. Data from both training and test sets will be loaded
2. Features and activity files, which contains variable names and also activity descriptive names will be loaded
3. Data from feature will be used to rename variable names in both train and test sets
4. Train and test sets will be merged into one big set
5. Data from activity will be used to give activity more descriptive names. As a result activity name one will be appropriately label as followed:
- 1 - WALKING
- 2 - WALKING_UPSTAIRS
- 3 - WALKING DOWNSTAIRS
- 4 - SITTING
- 5 - STANDING
- 6 - LAYING
6. Name of each variables will be transformed into more descriptive version as followed
- "Acc" will be substituted by "Accelerometer"
- "Gyro" will become "Gyroscope"
- "Mag" will become "Magnitude"
- Any variable beginning with "t" will have the "t" transformed into "Time"
- Any variable beginning with "f" will have the "f" transformed into "Frequency"
- Any variable with "tBody" will be changed into "TimeBody"
7. Finally, we generate a new dataset with all the average measures for each subject and activity type. It is called "tidy_Data.txt". The
	data sets have 180 rows

## Variables in file tidy_Data.txt
- subjectID: the unique number identifier for each participant of the study. It has value from 1 to 30 to denote each of 30 participants
- activity_name: the descriptive names of each activity
- The rest of other variables are various measurements with descriptive names
