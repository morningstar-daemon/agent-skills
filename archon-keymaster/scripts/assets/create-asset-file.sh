#!/bin/bash
# Create a new asset from a file (base64 encoded)
# Usage: create-asset-file.sh <file-path> [content-type]
# Example: create-asset-file.sh document.pdf application/pdf

if [ $# -lt 1 ]; then
    echo "Usage: $0 <file-path> [content-type]"
    echo "Example: $0 document.pdf application/pdf"
    exit 1
fi

FILE_PATH="$1"
CONTENT_TYPE="${2:-application/octet-stream}"

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

curl -s -X POST "${KEYMASTER_URL}/api/v1/assets" \
    -H "Content-Type: application/json" \
    -d @"$TEMP_JSON" | jq -r '.did'
