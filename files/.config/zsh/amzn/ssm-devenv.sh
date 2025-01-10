#!/usr/bin/env zsh
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SSM Devenv 🟡
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 💾
# @raycast.packageName ssm-devenv
#
# Documentation:
# @raycast.description Opens a tunnel on port 3307 to the development environment database
# @raycast.author lukasz_piotrak
# @raycast.authorURL https://raycast.com/lukasz_piotrak

# /Users/lpiotrak/.toolbox/bin/ada credentials update --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --once --account=975049952116 --profile=devenv && export AWS_PROFILE=devenv
source ./amzn.sh 
adasw devenv
aws ssm start-session --target $(aws ec2 describe-instances --region eu-central-1 --filter "Name=tag:Name,Values=BastionHost" --query "Reservations[].Instances[].InstanceId" --output text) --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '{"host":["db.eu-central-1.dev.ais.rme.amazon.dev"],"portNumber":["3306"],"localPortNumber":["3307"]}' --region eu-central-1 --profile devenv &
