#!/bin/bash
set -e
set -u

GROUP_USER=$1 # The user to add to the docker group that can run docker commands without sudo.

# First time setup of docker on ubuntu for development (tested on Windows 10 Hyper-V Ubuntu VM)
# Commands mostly based on: https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04
# and https://docs.docker.com/install/linux/linux-postinstall/

# Update software package repositories
sudo apt-get update -q -y

# Uninstall potentially existing versions of docker
sudo apt-get remove docker docker-engine docker.io -q -y

# Install tools needed for to get official docker repositories
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y -q
# Add Docker’s GPG Key
TEMP_GPG_KEY_FILE='docker_gpg_key.txt'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg > "$TEMP_GPG_KEY_FILE"
sudo apt-key add $TEMP_GPG_KEY_FILE

# Install the Docker Repository
# The command “$(lsb_release –cs)” scans and returns the codename of your Ubuntu installation – in this case, Bionic
# stable– is the type of Docker release.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"

# Update the new repository
sudo apt-get update -q -y

# Install Latest Version of Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io -q -y

# Version sanity check
docker --version

# Start Docker and set it up to run at system startup
sudo systemctl start docker
sudo systemctl enable docker

#  Manage Docker as non root user: https://docs.docker.com/install/linux/linux-postinstall/
sudo groupadd docker
sudo usermod -aG docker "$GROUP_USER"
# Force the new group to take effect, else log out of your session and log back in.
newgrp docker

docker run hello-world

# install docker compose with bash completion by copying it from github and making it executable
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.25.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose