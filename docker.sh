#!/bin/bash
# This script automates the installation of Docker Engine, Docker CLI, containerd, Docker Buildx, Docker Compose plugin,
# and Docker Desktop on a Debian-based Linux system. It adds Docker's official GPG key, sets up the Docker repository,
# updates package sources, installs required packages, and downloads/installs Docker Desktop.
# It also optionally adds the current user to the 'docker' group for non-root Docker usage.

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Install Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb
sudo apt install ./docker-desktop-amd64.deb -y
rm docker-desktop-amd64.deb

# Optionally add current user to docker group
if [ -n "$SUDO_USER" ]; then
  sudo usermod -aG docker $USER
  echo "User $USER added to docker group. You may need to log out and back in."
fi
