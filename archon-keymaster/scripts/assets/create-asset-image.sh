#!/bin/bash
# Create a new asset from an image file
# Usage: create-asset-image.sh <image-path>
# Example: create-asset-image.sh avatar.png

if [ $# -lt 1 ]; then
    echo "Usage: $0 <image-path>"
    echo "Example: $0 avatar.png"
    exit 1
fi

IMAGE_PATH="$1"

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

# Create JSON payload (Keymaster stores just the base64 data)
TEMP_B64=$(mktemp)
TEMP_JSON=$(mktemp)
trap "rm -f $TEMP_B64 $TEMP_JSON" EXIT

base64 -w 0 "$IMAGE_PATH" > "$TEMP_B64"

# Simple format: just wrap base64 string in quotes
echo -n '"' > "$TEMP_JSON"
cat "$TEMP_B64" >> "$TEMP_JSON"
echo '"' >> "$TEMP_JSON"

KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

curl -s -X POST "${KEYMASTER_URL}/api/v1/assets" \
    -H "Content-Type: application/json" \
    -d @"$TEMP_JSON" | jq -r '.did'
