# dynamodb

I have a requirement where we have to uploaded the dynamo db backed up data into one of the existing table. (Restoring data to new table is very simple and straight forward we can do it using console directly)
1. Back up json data from S3 should be created into batch write format. So created this PY script which does the same thing
2. We can process max of 25 records per batch and upto 400 KB. So to loop through each array object and call aws batch-write i wrote another shell script which is fairly simple to use
