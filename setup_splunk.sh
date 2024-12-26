#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

docker run -it -d --platform linux/amd64 \
  -p 8000:8000 -p 8191:8191 -p 8089:8089 -p 9997:9997 \
  -e SPLUNK_START_ARGS="--accept-license --answer-yes --no-prompt" \
  -e SPLUNK_PASSWORD="splunkadmin" \
  --name splunk-server --hostname splunk-server splunk/splunk:latest
