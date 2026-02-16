#!/bin/bash
# Get an asset by DID
# Usage: get-asset.sh <asset-did>
# Example: get-asset.sh did:cid:bagaaiera...

if [ $# -lt 1 ]; then
    echo "Usage: $0 <asset-did>"
    echo "Example: $0 did:cid:bagaaiera..."
    exit 1
fi

ASSET_DID="$1"

npx @didcid/keymaster get-asset "$ASSET_DID"
