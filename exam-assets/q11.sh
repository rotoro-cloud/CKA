#!/bin/bash

cd /tmp/.script/exam-assets

# Define the commands to deploy the helm chart
helm install messenger-front-01 --namespace=default ./current-version

# Moving the new version app directory 
mv /tmp/.script/exam-assets/nightly-build /root/

# Removing the script 
rm -rf /tmp/.script
