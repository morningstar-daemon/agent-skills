#!/bin/bash
# Transfer an asset to another DID
# Usage: transfer-asset.sh <asset-did> <recipient-did>
# Example: transfer-asset.sh did:cid:bagaaiera... did:cid:bagaaierat...

if [ $# -lt 2 ]; then
    echo "Usage: $0 <asset-did> <recipient-did>"
    echo "Example: $0 did:cid:bagaaiera... did:cid:bagaaierat..."
    exit 1
fi

ASSET_DID="$1"
RECIPIENT_DID="$2"
KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

curl -s -X POST "${KEYMASTER_URL}/api/v1/assets/${ASSET_DID}/transfer" \
    -H "Content-Type: application/json" \
    -d "{\"to\":\"${RECIPIENT_DID}\"}"
