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

npx @didcid/keymaster update-asset-image "$ASSET_DID" "$IMAGE_PATH"
