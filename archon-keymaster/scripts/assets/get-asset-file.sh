#!/bin/bash
# Get a file asset and save it to disk
# Usage: get-asset-file.sh <asset-did> [output-path]
# Example: get-asset-file.sh did:cid:bagaaiera... ./downloaded.pdf

if [ $# -lt 1 ]; then
    echo "Usage: $0 <asset-did> [output-path]"
    echo "Example: $0 did:cid:bagaaiera... ./document.pdf"
    exit 1
fi

ASSET_DID="$1"
OUTPUT_PATH="$2"

if [ -n "$OUTPUT_PATH" ]; then
    npx @didcid/keymaster get-asset-file "$ASSET_DID" "$OUTPUT_PATH"
else
    npx @didcid/keymaster get-asset-file "$ASSET_DID"
fi
