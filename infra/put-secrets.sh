#!/bin/bash

# Script to put secrets from .dev.vars to Cloudflare Workers using wrangler
# Based on the static list from .dev.vars.example

set -e

# Check if .dev.vars file exists
if [ ! -f ".dev.vars" ]; then
    echo "Error: .dev.vars file not found"
    exit 1
fi

# Source the .dev.vars file to load variables
source .dev.vars

# Static list of variables from .dev.vars.example
VARIABLES=(
    "ACCESS_CLIENT_ID"
    "ACCESS_CLIENT_SECRET"
    "ACCESS_TOKEN_URL"
    "ACCESS_AUTHORIZATION_URL"
    "ACCESS_JWKS_URL"
    "COOKIE_ENCRYPTION_KEY"
)

echo "Putting secrets to Cloudflare Workers..."

# Loop through each variable and put it as a secret
for var in "${VARIABLES[@]}"; do
    if [ -n "${!var}" ]; then
        echo "Putting secret: $var"
        echo "${!var}" | npx wrangler secret put "$var"
    else
        echo "Warning: $var is not set in .dev.vars, skipping..."
    fi
done

echo "Done putting secrets!"