#!/bin/bash
# List all groups owned by current identity
# Usage: ./list-groups.sh

set -e

# Source environment
if [ -f ~/.archon.env ]; then
    source ~/.archon.env
fi
export ARCHON_WALLET_PATH="${ARCHON_WALLET_PATH:-$HOME/clawd/wallet.json}"

echo "Groups owned by current identity:"
echo ""

npx @didcid/keymaster list-groups
