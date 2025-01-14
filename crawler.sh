#!/bin/bash

# BASH scripting 101 class

# Replace posts with comments, users etc 
CRAWL_URL="https://jsonplaceholder.typicode.com/posts"
SAVE_TO="content.csv"

# Fetching html content and saving to temp json file - from jq plugin
curl -s "$URL" > content.json

# Extracting json data from content.json and write to csv file - with @csv from jq plugin
echo "Id, Title, Body" > "$SAVE_TO" 
jq -r '.[] | [.id, .title, .body] | @csv' content.json >> "$SAVE_TO"

# Remove temp json file
rm content.json

echo "Data saved to $SAVE_TO" 
