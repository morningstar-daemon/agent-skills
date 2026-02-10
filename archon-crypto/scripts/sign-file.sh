#!/bin/bash
# Sign a JSON file with your DID
# Usage: ./sign-file.sh <file> [output-file]

set -e

if [ $# -lt 1 ]; then
    echo "Usage: $0 <file> [output-file]"
    echo ""
    echo "Examples:"
    echo "  $0 manifest.json                    # Outputs to manifest.signed.json"
    echo "  $0 contract.json signed.json        # Outputs to signed.json"
    echo ""
    echo "Note: File must be valid JSON."
    exit 1
fi

FILE="$1"
OUTPUT="${2:-${FILE%.json}.signed.json}"

# Check file exists
if [ ! -f "$FILE" ]; then
    echo "ERROR: File not found: $FILE"
    exit 1
fi

# Check it's JSON
if ! jq empty "$FILE" 2>/dev/null; then
    echo "ERROR: File is not valid JSON"
    exit 1
fi

# Load environment
if [ -f ~/.archon.env ]; then
    source ~/.archon.env
else
    echo "ERROR: ~/.archon.env not found"
    exit 1
fi

echo "Signing: $FILE"
echo "Output: $OUTPUT"
echo ""

# Sign file (outputs to stdout, we redirect)
cd ~/clawd
if npx @didcid/keymaster sign-file "$FILE" > "$OUTPUT" 2>&1; then
    echo "✓ File signed"
    echo ""
    echo "Signed file: $OUTPUT"
    echo ""
    echo "Others can verify with:"
    echo "  ./verify-file.sh $OUTPUT"
else
    echo "✗ Signing failed"
    rm -f "$OUTPUT"
    exit 1
fi
