#!/bin/sh

# Replace placeholders with environment variables
envsubst '\$API_BASE_URL' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf

# Inject API base URL into the JavaScript file
echo "window.API_BASE_URL='$API_BASE_URL';" > /usr/share/nginx/html/env-config.js

# Start Nginx
nginx -g 'daemon off;'
