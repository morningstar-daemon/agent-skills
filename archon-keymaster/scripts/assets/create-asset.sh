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
KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

curl -s -X POST "${KEYMASTER_URL}/api/v1/assets" \
    -H "Content-Type: application/json" \
    -d "$JSON_DATA" | jq -r '.did'
