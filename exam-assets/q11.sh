#!/bin/bash

cd /tmp/.script/resources

# Define the commands to deploy the helm chart
helm install messenger-front-01 --namespace=default ./current-version

# Moving the new version app directory 
mv /tmp/.script/resources/nightly-build /root/

# Removing the script 
rm -rf /tmp/.script
