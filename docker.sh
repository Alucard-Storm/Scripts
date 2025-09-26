#!/bin/bash
# This script automates the installation of Docker Engine, Docker CLI, containerd, Docker Buildx, Docker Compose plugin,
# and Docker Desktop on a Debian-based Linux system. It adds Docker's official GPG key, sets up the Docker repository,
# updates package sources, installs required packages, and downloads/installs Docker Desktop.
# It also optionally adds the current user to the 'docker' group for non-root Docker usage.

set -e

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo."
  exit 1
fi

# Add Docker's official GPG key:
apt-get update
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb
apt install -y ./docker-desktop-amd64.deb
rm docker-desktop-amd64.deb

# Optionally add current user to docker group
if [ -n "$SUDO_USER" ]; then
  usermod -aG docker "$SUDO_USER"
  echo "User $SUDO_USER added to docker group. You may need to log out and back in."
fi