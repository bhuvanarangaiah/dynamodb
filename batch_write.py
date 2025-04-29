import json

# Load your records from a file
with open('./yy4c2wcarm72rkngng7fxky47y.json', 'r') as file:
    records = [json.loads(line) for line in file]

# Create batches
batch_size = 25
batches = [records[i:i + batch_size] for i in range(0, len(records), batch_size)]

# Create the final output for batch-write-item
batch_items = []
for batch in batches:
    batch_dict = {
        "dtci-global-qa-applenewsservice-content": []
    }
    for record in batch:
        batch_dict["dtci-global-qa-applenewsservice-content"].append({
            "PutRequest": {
                "Item": record["Item"]
            }
        })
    batch_items.append(batch_dict)

# Write to a new file
with open('batches-qa.json', 'w') as outfile:
    json.dump(batch_items, outfile)