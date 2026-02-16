#!/bin/bash
# Update an existing asset
# Usage: update-asset.sh <asset-did> <json-data>
# Example: update-asset.sh did:cid:bagaaiera... '{"type":"document","updated":true}'

if [ $# -lt 2 ]; then
    echo "Usage: $0 <asset-did> <json-data>"
    echo "Example: $0 did:cid:bagaaiera... '{\"type\":\"document\",\"updated\":true}'"
    exit 1
fi

ASSET_DID="$1"
JSON_DATA="$2"

npx @didcid/keymaster update-asset "$ASSET_DID" "$JSON_DATA"
