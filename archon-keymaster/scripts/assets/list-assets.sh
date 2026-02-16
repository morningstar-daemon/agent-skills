#!/bin/bash
# List all assets in the registry

KEYMASTER_URL="${KEYMASTER_URL:-http://localhost:4226}"

curl -s "${KEYMASTER_URL}/api/v1/assets" | jq -r '.assets[]'
