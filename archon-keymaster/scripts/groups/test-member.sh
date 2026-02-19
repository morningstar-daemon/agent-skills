#!/bin/bash
# Test if a DID is a member of a group
# Usage: ./test-member.sh <group-did-or-alias> [member-did-or-alias]
# If member is omitted, tests current identity

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <group> [member]"
    echo ""
    echo "If member is omitted, tests current identity."
    echo ""
    echo "Examples:"
    echo "  $0 research-team"
    echo "  $0 research-team alice"
    echo "  $0 did:cid:group... did:cid:member..."
    exit 1
fi

GROUP="$1"
MEMBER="${2:-}"

# Source environment
if [ -f ~/.archon.env ]; then
    source ~/.archon.env
fi
export ARCHON_WALLET_PATH="${ARCHON_WALLET_PATH:-$HOME/clawd/wallet.json}"

if [ -z "$MEMBER" ]; then
    echo "Testing if current identity is in group: $GROUP"
else
    echo "Testing membership..."
    echo "  Group:  $GROUP"
    echo "  Member: $MEMBER"
fi
echo ""

npx @didcid/keymaster test-group "$GROUP" $MEMBER
