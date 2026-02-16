#!/bin/bash
# Create a new asset from a file
# Usage: create-asset-file.sh <file-path>
# Example: create-asset-file.sh document.pdf

if [ $# -lt 1 ]; then
    echo "Usage: $0 <file-path>"
    echo "Example: $0 document.pdf"
    exit 1
fi

FILE_PATH="$1"

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' not found"
    exit 1
fi

npx @didcid/keymaster create-asset-file "$FILE_PATH"
