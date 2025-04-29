#!/bin/bash

# Define the file containing the JSON array
BATCH_FILE="batches.json"

# Check if the file exists
if [[ ! -f "$BATCH_FILE" ]]; then
    echo "Error: $BATCH_FILE not found."
    exit 1
fi

# Read the JSON content from the file
RECORDS=$(<"$BATCH_FILE")

# Debug output: Show the request being sent
echo "Request to DynamoDB:"
echo "$RECORDS"

# Loop through each item in the JSON array
for idx in $(echo "${RECORDS}" | jq -r 'keys[]'); do
    # Extract the current JSON object
    CURRENT_ITEM=$(echo "${RECORDS}" | jq ".[$idx]")

    # Send each item in the array to DynamoDB
    echo "Sending batch to DynamoDB..."
    RESPONSE=$(aws dynamodb batch-write-item --request-items "$CURRENT_ITEM" --no-paginate)

    # Check for unprocessed items
    UNPROCESSED_ITEMS=$(echo "$RESPONSE" | jq '.UnprocessedItems')

    if [ "$UNPROCESSED_ITEMS" != "{}" ]; then
        echo "There are unprocessed items. Continuing to the next batch."
    else
        echo "Batch $((idx + 1)) sent successfully."
    fi

    # Optional: You can add a delay here if you're hitting limits
    # sleep 1
done

echo "All batches processed successfully."