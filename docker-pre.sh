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
