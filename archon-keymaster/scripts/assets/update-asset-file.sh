#!/bin/bash
# Update an asset with new file data
# Usage: update-asset-file.sh <asset-did> <file-path> [content-type]
# Example: update-asset-file.sh did:cid:bagaaiera... document.pdf application/pdf

if [ $# -lt 2 ]; then
    echo "Usage: $0 <asset-did> <file-path> [content-type]"
    echo "Example: $0 did:cid:bagaaiera... document.pdf application/pdf"
    exit 1
fi

ASSET_DID="$1"
FILE_PATH="$2"
CONTENT_TYPE="${3:-application/octet-stream}"

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' not found"
    exit 1
fi

# Get base64 encoded content
FILENAME=$(basename "$FILE_PATH")

# Create JSON payload with file metadata (use temp file for large data)
TEMP_JSON=$(mktemp)
trap "rm -f $TEMP_JSON" EXIT

# Build JSON with base64 data inline
{
    echo "{"
    echo "  \"type\": \"file\","
    echo "  \"filename\": \"$FILENAME\","
    echo "  \"contentType\": \"$CONTENT_TYPE\","
    echo -n "  \"data\": \""
    base64 -w 0 "$FILE_PATH"
    echo "\""
    echo "}"
} > "$TEMP_JSON"

KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

curl -s -X PUT "${KEYMASTER_URL}/api/v1/assets/${ASSET_DID}" \
    -H "Content-Type: application/json" \
    -d @"$TEMP_JSON"
