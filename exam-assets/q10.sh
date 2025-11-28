#!/bin/bash

cd /tmp/.ques10/exam-assets/

# Define the commands to be executed
command1="helm install filtration-east-app --namespace=filtration-east ./filter-app"
command2="helm install secrets-global-app --namespace=secrets-global ./secrets-app"
command3="helm install view-global-app --namespace=view-global ./view-app"
command4="helm install catalog-eu-only --namespace=catalog-eu-only ./catalog-app"

sleep 2

# Loop until all commands have executed successfully
while true; do
  # Execute the commands
   $command1 && $command2 && $command3 && $command4
  
  # Check if any command failed
  if [ $? -ne 0 ]; then
    # If a command failed, print an error message and try once again and then exit the loop
    echo "One or more commands failed. Retrying..."
    $command1 && $command2 && $command3 && $command4
    break
  
  else
    # If all commands succeeded, exit the loop
    break
  fi
done

echo "All commands executed successfully."

rm -rf /tmp/.ques10
