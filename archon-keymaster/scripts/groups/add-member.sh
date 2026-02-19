#!/bin/bash
# Add a member to an Archon group
# Usage: ./add-member.sh <group-did-or-alias> <member-did-or-alias>

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <group> <member>"
    echo ""
    echo "Examples:"
    echo "  $0 research-team did:cid:bagaaiera..."
    echo "  $0 did:cid:group... alice"
    exit 1
fi

GROUP="$1"
MEMBER="$2"

# Source environment
if [ -f ~/.archon.env ]; then
    source ~/.archon.env
fi
export ARCHON_WALLET_PATH="${ARCHON_WALLET_PATH:-$HOME/clawd/wallet.json}"

echo "Adding member to group..."
echo "  Group:  $GROUP"
echo "  Member: $MEMBER"

npx @didcid/keymaster add-group-member "$GROUP" "$MEMBER"

echo ""
echo "✓ Member added to group"
