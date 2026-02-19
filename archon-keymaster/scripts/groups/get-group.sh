#!/bin/bash
# Get details of an Archon group
# Usage: ./get-group.sh <group-did-or-alias>

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <group-did-or-alias>"
    echo ""
    echo "Examples:"
    echo "  $0 research-team"
    echo "  $0 did:cid:bagaaiera..."
    exit 1
fi

GROUP="$1"

# Source environment
if [ -f ~/.archon.env ]; then
    source ~/.archon.env
fi
export ARCHON_WALLET_PATH="${ARCHON_WALLET_PATH:-$HOME/clawd/wallet.json}"

echo "Group details for: $GROUP"
echo ""

npx @didcid/keymaster get-group "$GROUP"
