#!/bin/bash
# Update an asset from a JSON file
# Usage: update-asset-json.sh <asset-did> <json-file>
# Example: update-asset-json.sh did:cid:bagaaiera... updated.json

if [ $# -lt 2 ]; then
    echo "Usage: $0 <asset-did> <json-file>"
    echo "Example: $0 did:cid:bagaaiera... updated.json"
    exit 1
fi

ASSET_DID="$1"
JSON_FILE="$2"

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: File '$JSON_FILE' not found"
    exit 1
fi

npx @didcid/keymaster update-asset-json "$ASSET_DID" "$JSON_FILE"
