#!/bin/bash
# Get an asset and format as JSON
# Usage: get-asset-json.sh <asset-did>
# Example: get-asset-json.sh did:cid:bagaaiera...

if [ $# -lt 1 ]; then
    echo "Usage: $0 <asset-did>"
    echo "Example: $0 did:cid:bagaaiera..."
    exit 1
fi

ASSET_DID="$1"

npx @didcid/keymaster get-asset-json "$ASSET_DID"
