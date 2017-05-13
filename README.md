## Tidy Data from Smartphone Movement Experiment

The original dataset was transformed by the following steps;

1) Import data. The data was imported with read.table from working directory.

2) Rename variables. The variables of features.txt were renamed to be human-readable. For example "tBodyAcc-mean()-X" was transformed to "time of BodyAccMean in the X-Direction"

3) Merge tables. 
	1) The features table was merged with the x_test table to give x_test table non-numeric headers
	2) The y_test table was merged with the activity_labels table to match activity indices to their names.
	3) The subject_test table was merged with the activity_name and x_test tables to produce a final test table.
	4) The features table was merged with the x_train table to give x_train table non-numeric headers
	5) The y_train table was merged with the activity_labels table to match activity indices to their names.
	6) The subject_train table was merged with the activity_name and x_train tables to produce a final train table.
	7) The test and train tables were merged to produce a total dataset.

4) Reduce data. The unnecessary columns without mean or standard deviation were dropped.

5) Summarise data. The data was grouped by activity and subject and then summarise_each was apply to produce mean for each activity-subject pair. 180 rows in all.

6) Write data. Data was written to a text file.

