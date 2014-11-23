1. I used "read.table" to read data and "rbind" to combine test with training together. 
2. I read features.txt and used subset to choose only names.
3. Then I used "gsub" to make descriptive variable names.
4. When I was done, I used "colnames" to attach these variable names on my data.
5. Selected only the measurements on the mean and standard deviation to form a new data, which is ms ("m"ean + "s"td).
6. Read y_test.txt and y_train.txt, combine them using "rbind", then "cbind" to ms.
7. Read subject_test.txt and subject_train.txt, combine them using "rbind", then "cbind" to ms.
8. Using subset to name the activities in the data set.
9. Using "order" to sort the data.
10. At last, using "melt" & "dcast" from reshape2 package to form a new data containing mean of each variable based on each subject and activity.
11. Using "write.table" to record the dataset.