#!/bin/sh
set -e

echo "Starting Nginx with API_BASE_URL: $API_BASE_URL"

# Replace environment variables in Nginx configuration
if [ -z "$API_BASE_URL" ]; then
  echo "Error: API_BASE_URL is not set"
  exit 1
fi

# Replace placeholder in the Nginx configuration template
envsubst '${API_BASE_URL}' < /etc/nginx/nginx.template.conf > /etc/nginx/nginx.conf

# Inject environment variable into env-config.js
echo "window.API_BASE_URL='$API_BASE_URL';" > /usr/share/nginx/html/env-config.js

# Check the generated Nginx config for syntax errors
nginx -t

# Start Nginx in the foreground
nginx -g 'daemon off;'
