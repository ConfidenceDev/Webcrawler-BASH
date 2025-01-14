#!/bin/bash

# BASH scripting 101 class

# Replace posts with comments, users etc.
CRAWL_URL="https://jsonplaceholder.typicode.com/posts/2"
SAVE_TO="content.csv"

# Fetching JSON content and saving to a temporary file
curl -s "$CRAWL_URL" -o content.json

# Display the fetched JSON content (for debugging)
# cat content.json

# Extracting JSON data and writing to a CSV file
echo "Id,Title,Body" > "$SAVE_TO"

# Processing the json data with jq plugin
# jq -r '.[] | [.id, .title, .body] | @csv <-close single quote content.json >> $SAVE_TO

# Processing the JSON data (without jq)
grep -E '"id":|"title":|"body":' content.json | \
sed -E 's/^[[:space:]]*"id": ([0-9]+),?/\1/' | \
sed -E 's/^[[:space:]]*"title": "(.*)",?/\1/' | \
sed -E 's/^[[:space:]]*"body": "(.*)"/\1/' | \
awk 'ORS=(NR%3?",":"\n")' >> "$SAVE_TO"

# Remove the temporary JSON file
rm -f content.json

# Display the saved CSV content
# cat $SAVE_T"
echo "Data saved to $SAVE_TO"

