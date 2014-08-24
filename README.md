GetCleanData
============

Project for Getting and Cleaning Data course.

The run_analysis.R file contains all of the code for the project, and, due to time constraints, I implemented the entire project in the one run_analysis function.

The first part of the function reads in the measurement features and then identifies the columns containing mean or standard deviation results. I used a simple grep
function to retrieve the indices of means and standard deviations, then combined the
two vectors of indices into a single vector called selected.

The next section defines strings that exist in the features list, and my own
descriptive text that should replace the existing text sub-strings. I then iterated
through the existing and replacement lists and used the gsub function to do global
text substitution. This worked well, although there may be a few places where the
resulting string should have had a space in one or another place.

The final preparation step before getting to the raw training and test data was to
read in the activity labels. In all file reading, I used read.table with row.names
set to NULL.

For both the training and the test data sets, I read the subjects per sample and the
activities per sample into their respective data frame, and then read the raw 
measurement data. I used the optional colClasses argument for this measurement data retrievel, which improved the file load performance by maybe four-fold. This was a necessary optimization since it gave me the opportunity to use the full run_analysis function to do quick tests without having to break pieces out for smaller tests. On the other hand, if I had had the time, I would have refactored run_analysis into several script functions for better modularity.

There is also a verification step (where I use stopifnot()) to assure that the number of rows matches between the three data sets (subject per, activity per, and sample measurements).

I then assigned the descriptive feature labels to the data set (training or test), and then reduced the data set to just those features which we care about for the project, namely the mean and standard deviation columns. Note that I assigned the
feature labels to each set, rather than to the merged set later, because I wanted to take advantage of the fact that the indices for the columns would match up with the raw data before having to add Subject and Activity columns at the beginning of each data set. This was purely a individual preference, sinced I wanted Subject and Activity at the beginning of the columns, not the end. There is also no need for premature optimization at this point, unlike the file loading optimization mentioned earlier.

The last part of reading the training and test data sets was adding the Subject and Activity correlation data to the training and test data sets.

The next section is where I merged the training and test data sets using a single rbind call. It took some time to get this to work, which led me back to fixing or improving earlier code, but ultimately it was successful. After merging, I then replaced the activity integer identifiers with descriptive strings based on the activity labels read from file earlier. This last part was working at one time, I think, but I discovered that the Activity column seemed to be something other than a vector and I've since botched up that particular conversion to the activity descriptive string.

I was not able to get a tidy data set to result. I'm submitting what I have since I'm out of time.


