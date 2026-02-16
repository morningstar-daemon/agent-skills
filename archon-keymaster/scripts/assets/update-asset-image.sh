#!/bin/bash
# Update an asset with new image data
# Usage: update-asset-image.sh <asset-did> <image-path>
# Example: update-asset-image.sh did:cid:bagaaiera... avatar.png

if [ $# -lt 2 ]; then
    echo "Usage: $0 <asset-did> <image-path>"
    echo "Example: $0 did:cid:bagaaiera... avatar.png"
    exit 1
fi

ASSET_DID="$1"
IMAGE_PATH="$2"

if [ ! -f "$IMAGE_PATH" ]; then
    echo "Error: File '$IMAGE_PATH' not found"
    exit 1
fi

# Detect content type from extension
EXT="${IMAGE_PATH##*.}"
case "${EXT,,}" in
    jpg|jpeg) CONTENT_TYPE="image/jpeg" ;;
    png) CONTENT_TYPE="image/png" ;;
    gif) CONTENT_TYPE="image/gif" ;;
    webp) CONTENT_TYPE="image/webp" ;;
    svg) CONTENT_TYPE="image/svg+xml" ;;
    *) CONTENT_TYPE="image/$(echo ${EXT,,})" ;;
esac

# Get base64 encoded content
FILENAME=$(basename "$IMAGE_PATH")

# Create JSON payload with image metadata (use temp file for large data)
TEMP_JSON=$(mktemp)
trap "rm -f $TEMP_JSON" EXIT

# Build JSON with base64 data inline
{
    echo "{"
    echo "  \"type\": \"image\","
    echo "  \"filename\": \"$FILENAME\","
    echo "  \"contentType\": \"$CONTENT_TYPE\","
    echo -n "  \"data\": \""
    base64 -w 0 "$IMAGE_PATH"
    echo "\""
    echo "}"
} > "$TEMP_JSON"

KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

curl -s -X PUT "${KEYMASTER_URL}/api/v1/assets/${ASSET_DID}" \
    -H "Content-Type: application/json" \
    -d @"$TEMP_JSON"
