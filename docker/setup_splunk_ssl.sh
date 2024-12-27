#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define paths for the certificate and key
CERT_PATH="certs/cert.pem"
KEY_PATH="certs/key.pem"
PASSWORD="abcd1234"

echo "Generating self-signed certificate..."
openssl req -x509 -newkey rsa:4096 -passout pass:"$PASSWORD" -keyout "$KEY_PATH" -out "$CERT_PATH" -days 365 -subj "/CN=72bece730a5a/O=SplunkUser"

# Ensure the certificate and key are readable by Docker
chmod 644 "$CERT_PATH" "$KEY_PATH"
cat $CERT_PATH
cat $KEY_PATH

echo "Running Splunk container with SSL enabled..."
docker run -it -d --platform linux/amd64 \
  -p 8000:8000 -p 8191:8191 -p 8089:8089 -p 9997:9997 \
  -e "SPLUNK_HTTP_ENABLESSL=true" \
  -e "SPLUNK_HTTP_ENABLESSL_CERT=$CERT_PATH" \
  -e "SPLUNK_HTTP_ENABLESSL_PRIVKEY=$KEY_PATH" \
  -e "SPLUNK_HTTP_ENABLESSL_PRIVKEY_PASSWORD=$PASSWORD" \
  -e SPLUNK_START_ARGS="--accept-license --answer-yes --no-prompt" \
  -e SPLUNK_PASSWORD="splunkadmin" \
  -v "$(pwd)/certs:/opt/splunk/certs/" \
  --name splunk-server --hostname splunk-server splunk/splunk:latest

echo "Splunk container is running with SSL enabled."