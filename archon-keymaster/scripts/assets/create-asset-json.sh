#!/bin/bash
# Create a new asset from a JSON file
# Usage: create-asset-json.sh <json-file>
# Example: create-asset-json.sh document.json

if [ $# -lt 1 ]; then
    echo "Usage: $0 <json-file>"
    echo "Example: $0 document.json"
    exit 1
fi

JSON_FILE="$1"

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: File '$JSON_FILE' not found"
    exit 1
fi

npx @didcid/keymaster create-asset-json "$JSON_FILE"
