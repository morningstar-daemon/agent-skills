#!/bin/bash
# Create a new asset from JSON data
# Usage: create-asset.sh <json-data>
# Example: create-asset.sh '{"type":"document","title":"My Doc","content":"..."}'

if [ $# -lt 1 ]; then
    echo "Usage: $0 <json-data>"
    echo "Example: $0 '{\"type\":\"document\",\"title\":\"My Doc\"}'"
    exit 1
fi

JSON_DATA="$1"

npx @didcid/keymaster create-asset "$JSON_DATA"
