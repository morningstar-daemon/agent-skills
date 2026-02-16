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

npx @didcid/keymaster create-asset-image "$IMAGE_PATH"
