#!/bin/bash
# Compose a dmail (create without sending)
# Usage: compose.sh <recipient-did> <subject> <body> [cc-did...]
# Then use attach.sh to add files, and send-composed.sh to send

set -e

# Load environment
if [ -f ~/.archon.env ]; then
    source ~/.archon.env
fi
export ARCHON_WALLET_PATH="${ARCHON_WALLET_PATH:-$HOME/clawd/wallet.json}"

if [ $# -lt 3 ]; then
    echo "Usage: $0 <recipient-did> <subject> <body> [cc-did...]"
    echo ""
    echo "Creates a dmail without sending. Use attach.sh to add files,"
    echo "then send-composed.sh to send."
    exit 1
fi

RECIPIENT="$1"
SUBJECT="$2"
BODY="$3"
shift 3

# Build CC array from remaining arguments
CC_JSON="[]"
if [ $# -gt 0 ]; then
    CC_JSON=$(printf '%s\n' "$@" | jq -R . | jq -s .)
fi

# Escape subject and body for JSON
SUBJECT_ESCAPED=$(echo "$SUBJECT" | jq -Rs . | sed 's/^"//;s/"$//')
BODY_ESCAPED=$(echo "$BODY" | jq -Rs .)

# Create temporary JSON file
TMPFILE=$(mktemp /tmp/dmail-XXXXXX.json)
trap "rm -f $TMPFILE" EXIT

cat > "$TMPFILE" << EOF
{
    "to": ["$RECIPIENT"],
    "cc": $CC_JSON,
    "subject": "$SUBJECT_ESCAPED",
    "body": $BODY_ESCAPED,
    "reference": ""
}
EOF

# Create the dmail (but don't send)
DMAIL_DID=$(npx @didcid/keymaster create-dmail "$TMPFILE")

echo "Created draft: $DMAIL_DID"
echo ""
echo "Next steps:"
echo "  Add attachments: ./scripts/attach.sh $DMAIL_DID <file>"
echo "  Send when ready: ./scripts/send-composed.sh $DMAIL_DID"
