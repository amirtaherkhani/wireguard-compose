#!/bin/bash

# This script is used to check and configure network settings for the WireGuard container (wg-easy).
# It does the following:
# 1. Verifies IP forwarding and source address validation settings inside the container.
# 2. Configures IP forwarding and source address validation mark on the host if needed.

# Step 1: Execute commands inside the WireGuard container (wg-easy)

echo "Checking IP forwarding and source valid mark settings inside the container..."

docker exec -it wg-easy /bin/bash -c "
  # Check if IP forwarding is enabled in the container
  echo 'Checking IP forwarding in the container:'
  sysctl net.ipv4.ip_forward

  # Check if source address validation mark is enabled in the container
  echo 'Checking source address validation mark in the container:'
  sysctl net.ipv4.conf.all.src_valid_mark
"

# Step 2: Configure IP forwarding and source valid mark settings on the host
echo "Enabling IP forwarding and source address validation mark on the host if not already configured..."

# Enable IP forwarding on the host
sudo sysctl -w net.ipv4.ip_forward=1
echo "IP forwarding has been enabled on the host."

# Enable source address validation mark on the host
sudo sysctl -w net.ipv4.conf.all.src_valid_mark=1
echo "Source address validation mark has been enabled on the host."

# Step 3: Verify the changes on the host
echo "Verifying the changes on the host..."

# Verify IP forwarding setting on the host
echo "IP forwarding setting on the host:"
sysctl net.ipv4.ip_forward

# Verify source address validation mark on the host
echo "Source address validation mark on the host:"
sysctl net.ipv4.conf.all.src_valid_mark
