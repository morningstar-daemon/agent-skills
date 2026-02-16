#!/bin/bash
# Update an asset with new file data
# Usage: update-asset-file.sh <asset-did> <file-path>
# Example: update-asset-file.sh did:cid:bagaaiera... document.pdf

if [ $# -lt 2 ]; then
    echo "Usage: $0 <asset-did> <file-path>"
    echo "Example: $0 did:cid:bagaaiera... document.pdf"
    exit 1
fi

ASSET_DID="$1"
FILE_PATH="$2"

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' not found"
    exit 1
fi

npx @didcid/keymaster update-asset-file "$ASSET_DID" "$FILE_PATH"
