#!/bin/bash

# Update system packages
sudo apt-get update -y
sleep 5

# Install Nginx
sudo apt-get install -y nginx
sleep 5

sudo systemctl enable nginx
sleep 5

sudo systemctl start nginx
sleep 5

# Install dependencies for Terraform
sudo apt-get install -y git
sleep 5

# Update system packages
sudo apt-get update -y
sleep 5

# Create and Git clone application
mkdir application
cd application
git clone https://github.com/annkur-sharma/AppCode01-DevSecOps-Facts.git

# Remove files from html folder
sudo rm -r /var/www/html/*

# Copy files to your web server root (example for Nginx /var/www/html):
sudo cp -r AppCode01-DevSecOps-Facts/* /var/www/html/

# Generate a unique GUID for this VM (optional but recommended):
uuidgen | sudo tee /var/www/html/guid.txt