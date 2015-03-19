Getting and Cleaning Data Course Project
========================================
Preparing data for the future analysis
--------------------------------------

In this repo stored R-script which prepares data collected from the accelerometers from the Samsung Galaxy S smartphone for the future analysis. Script constructs the data which consist average values of the measurements on the mean and standard deviation for each accelerometer and gyroscope measurement.
So, what is this scrip do:

  * Downloads the data to the temporary file
  * Reads certain files from this data
  * Deletes temporary file, so you don't need to clean up after the script
  * From read data it extracts only the measurements on the mean and standard deviation for each measurement
  * As original data was splitted into train and test set script merges train and test set
  * Original data is consist from different file. Script merges data into one data frame
  * Script gives proper variable names (about variables you can read in codebook)
  * Activity variable was codded as 1, 2, etc. Scrip decodes this activity labels (WALKING, WALKING_UPSTAIRS, etc.)
  * It computes average of the measurements on the mean and standard deviation by subject id and activity type
  * It saves the file contains average values as features_average.txt