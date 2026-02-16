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

KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

curl -s -X POST "${KEYMASTER_URL}/api/v1/assets" \
    -H "Content-Type: application/json" \
    -d @"$JSON_FILE" | jq -r '.did'
