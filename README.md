# GettingAndCleaningData
Assignment of Coursera "Getting and Cleaning Data", week 4



# working space. 
The script will perform the following steps

1. Read the relevant data
2. Read the labels for the x_* data and the translation of the activities
3. Clean up the labels so they do not contain steering information ()
4. Add the labels to the train and test data. 
5. Unstrip the x_* data with the only necessary columns (mean & std)
6. Gather the subjects, the acitivity and the data together for test and the training
7. Create one data set by putting test and training data together
8. Replace the number of the activity by its expression 
9. Create a data frame with the mean of each variable per subject and activity. The result will be stored in the object "summmary"
