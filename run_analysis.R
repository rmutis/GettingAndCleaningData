# Before starting the script make sure that the zip-file was unpacked within your current 
# working space. 

# 1. Read the relevant data

x_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

# 2. Read the labels for the x_* data and the translation of the activities

x_labels <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

# 3. Clean up the labels so they do not contain steering information ()

x_labels$V2 <- gsub("[[:punct:]]", "_", x_labels$V2)

# 4. Add the labels to the train and test data. 

names(x_test) <- x_labels$V2
names(y_test) <- "Activity"
names(sub_test) <- "Subject"
names(x_train) <- x_labels$V2
names(y_train) <- "Activity"
names(sub_train) <- "Subject"

# 5. Unstrip the x_* data with the only necessary columns (mean & std)

vec_std <- grep("[Ss]td", names(x_test))
vec_mean <- grep("[Mm]ean", names(x_test))
vec <- c(vec_mean, vec_std)
x_testclean <- x_test[, vec]
x_trainclean <- x_train[, vec]

# 6. Gather the subjects, the acitivity and the data together for test and the training

test <- cbind(sub_test, y_test, x_testclean)
train <- cbind(sub_train, y_train, x_trainclean)

# 7. Create one data set by putting test and training data together

data <- rbind(test, train)

# 8. Replace the number of the activity by its expression 

data$Activity[data$Activity == 1] = "WALKING"
data$Activity[data$Activity == 2] = "WALKING_UPSTAIRS"
data$Activity[data$Activity == 3] = "WALKING_DOWNSTAIRS"
data$Activity[data$Activity == 4] = "SITTING"
data$Activity[data$Activity == 5] = "STANDING"
data$Activity[data$Activity == 6] = "LAYING"

# 9. Create a data frame with the mean of each variable per subject and activity
# The result will be stored in the object "summmary"

summary <- summarize_each(data_grouped, mean)
summary <- summary[, 3:90]