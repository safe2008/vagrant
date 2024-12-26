#!/bin/bash

# Add the current user to the Docker group
echo "Adding the current user to the Docker group..."
sudo usermod -aG docker $USER

# Refresh group membership for the current session
echo "Refreshing group membership..."
newgrp docker

# Verify Docker access
echo "Checking Docker access..."
docker ps

# Display the groups for the current user
echo "Displaying groups for the current user..."
groups $USER

# Verify Docker access again
echo "Verifying Docker access again..."
docker ps

# Run the Splunk container setup (replace with your Docker run command)
CERT_PATH="$HOME/cert.pem"
KEY_PATH="$HOME/key.pem"
PASSWORD="abcd1234"

echo "Generating self-signed certificate..."
openssl req -x509 -newkey rsa:4096 -passout pass:$PASSWORD -keyout $KEY_PATH -out $CERT_PATH -days 365 -subj "/CN=efb201210918/O=SplunkUser"

if [[ $? -ne 0 ]]; then
  echo "Failed to generate certificate. Exiting..."
  exit 1
fi

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

if [[ $? -ne 0 ]]; then
  echo "Failed to start Splunk container. Exiting..."
  exit 1
fi

echo "Splunk container is running with SSL enabled."
