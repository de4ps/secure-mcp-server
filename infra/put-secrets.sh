#!/bin/bash

# Script to put secrets from .env to Cloudflare Workers using wrangler
# Based on the static list from .dev.vars.example

set -e

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "Error: .env file not found"
    exit 1
fi

# Source the .env file to load variables
source .env

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
        echo "Warning: $var is not set in .env, skipping..."
    fi
done

echo "Done putting secrets!"