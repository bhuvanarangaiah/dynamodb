import json

# Read the raw export
with open('exported_data_qa.json') as f:
    data = json.load(f)

# Transform to batch-write format
output = {
    "election-notifications": [
        {
            "PutRequest": {
                "Item": item
            }
        }
        for item in data['Items']
    ]
}

# Save the formatted file
with open('import_ready.json', 'w') as f:
    json.dump(output, f, indent=2)

print("Transformation complete! Use import_ready.json for import")
