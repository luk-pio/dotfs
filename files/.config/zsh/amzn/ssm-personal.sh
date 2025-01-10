#!/usr/bin/env zsh
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SSM Personal 🔴
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 💾
# @raycast.packageName ssm-personal
#
# Documentation:
# @raycast.description Opens a tunnel on port 4111 to the production environment database
# @raycast.author lukasz_piotrak
# @raycast.authorURL https://raycast.com/lukasz_piotrak

ada credentials update --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --once --account=590183662907 --profile=personal && export AWS_PROFILE=personal
aws ssm start-session --target i-0c8b269e4882d6347 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":["rdsstack-personal-rdsclusterwriterinstance831f8440-ld8plcv9kwx9.c1akkukegpza.eu-west-1.rds.amazonaws.com"],"portNumber":["3306"],"localPortNumber":["3309"]}' --region eu-west-1 --profile personal &
