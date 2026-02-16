#!/bin/bash
# Get an image asset and save it to disk
# Usage: get-asset-image.sh <asset-did> [output-path]
# Example: get-asset-image.sh did:cid:bagaaiera... ./avatar.png

if [ $# -lt 1 ]; then
    echo "Usage: $0 <asset-did> [output-path]"
    echo "Example: $0 did:cid:bagaaiera... ./image.png"
    exit 1
fi

ASSET_DID="$1"
OUTPUT_PATH="$2"

if [ -n "$OUTPUT_PATH" ]; then
    npx @didcid/keymaster get-asset-image "$ASSET_DID" "$OUTPUT_PATH"
else
    npx @didcid/keymaster get-asset-image "$ASSET_DID"
fi
