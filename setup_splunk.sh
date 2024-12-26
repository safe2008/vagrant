#!/bin/bash

# Set file paths for the certificate and key
CERT_PATH="/home/cert.pem"
KEY_PATH="/home/key.pem"
PASSWORD="abcd1234"

# Create self-signed certificate and key using openssl
echo "Generating self-signed certificate..."
openssl req -x509 -newkey rsa:4096 -passout pass:$PASSWORD -keyout $KEY_PATH -out $CERT_PATH -days 365 -subj /CN=localhost

# Check if openssl command was successful
if [[ $? -ne 0 ]]; then
  echo "Failed to generate certificate. Exiting..."
  exit 1
fi

# Run Splunk container with SSL enabled
echo "Running Splunk container with SSL enabled..."

docker run -it -d --platform linux/amd64 \
  -p 8000:8000 -p 8191:8191 -p 8089:8089 -p 9997:9997 \
  -e "SPLUNK_HTTP_ENABLESSL=true" \
  -e "SPLUNK_HTTP_ENABLESSL_CERT=$CERT_PATH" \
  -e "SPLUNK_HTTP_ENABLESSL_PRIVKEY=$KEY_PATH" \
  -e "SPLUNK_HTTP_ENABLESSL_PRIVKEY_PASSWORD=$PASSWORD" \
  -e SPLUNK_START_ARGS="--accept-license --answer-yes --no-prompt" \
  -e SPLUNK_PASSWORD="splunkadmin" \
  --name splunk-server splunk/splunk:latest

# Check if docker command was successful
if [[ $? -ne 0 ]]; then
  echo "Failed to start Splunk container. Exiting..."
  exit 1
fi

echo "Splunk container is running with SSL enabled."
