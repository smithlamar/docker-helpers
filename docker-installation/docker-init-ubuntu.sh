#!/bin/bash
set -e
set -u

# First time setup of docker on ubuntu for development (tested on Windows 10 Hyper-V Ubuntu VM)
# Commands sourced from: https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04

# Update software package repositories
sudo apt-get update -q -y

# Uninstall potentially existing versions of docker
sudo apt-get remove docker docker-engine docker.io -q -y

# Install tools needed for to get official docker repositories
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y -q
# Add Docker’s GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –

# Install the Docker Repository
# The command “$(lsb_release –cs)” scans and returns the codename of your Ubuntu installation – in this case, Bionic
# stable– is the type of Docker release.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
# Update the new repositories
sudo apt-get update -q -y

# Install Latest Version of Docker
sudo apt-get install docker-ce -q -y

docker --version

# Start Docker and set it up to run at system startup
sudo systemctl start docker
sudo systemctl enable dock