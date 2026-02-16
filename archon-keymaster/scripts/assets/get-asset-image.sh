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
KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

# Get asset
ASSET=$(curl -s "${KEYMASTER_URL}/api/v1/assets/${ASSET_DID}")

# Try to extract as structured object first, fall back to simple string
if echo "$ASSET" | jq -e '.asset | type == "object"' >/dev/null 2>&1; then
    # Structured object with metadata
    FILENAME=$(echo "$ASSET" | jq -r '.asset.filename // "downloaded-image.png"')
    BASE64_DATA=$(echo "$ASSET" | jq -r '.asset.data')
else
    # Simple base64 string
    FILENAME="downloaded-image.png"
    BASE64_DATA=$(echo "$ASSET" | jq -r '.asset')
fi

# Use provided output path or default to filename
if [ -z "$OUTPUT_PATH" ]; then
    OUTPUT_PATH="$FILENAME"
fi

# Decode and save
if [ "$BASE64_DATA" != "null" ] && [ -n "$BASE64_DATA" ]; then
    echo "$BASE64_DATA" | base64 -d > "$OUTPUT_PATH"
    echo "Image saved to: $OUTPUT_PATH"
else
    echo "Error: No image data found in asset"
    exit 1
fi
