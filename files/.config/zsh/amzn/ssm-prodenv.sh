#!/usr/bin/env bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SSM Prodenv 🔴
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 💾
# @raycast.packageName ssm-prodenv
#
# Documentation:
# @raycast.description Opens a tunnel on port 4111 to the production environment database
# @raycast.author lukasz_piotrak
# @raycast.authorURL https://raycast.com/lukasz_piotrak

aws ssm start-session --profile=prod-admin --target $(aws ec2 describe-instances --profile=prod-admin --region eu-central-1 --filter "Name=tag:Name,Values=BastionHost" --query "Reservations[].Instances[].InstanceId" --output text) --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":["db.eu-central-1.prod.ais.rme.amazon.dev"],"portNumber":["3306"],"localPortNumber":["4111"]}' --region eu-central-1 &
