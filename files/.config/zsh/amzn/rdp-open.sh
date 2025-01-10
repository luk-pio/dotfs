#!/bin/bash
set -e
# Usage: ./rdp-open.sh site-services-dev-env-admin  "ais-eu-corp-001-dev" eu-west-1
# Requires installation of xfreerdp and xquartz. 
# On Macos:
# brew install --cask xquartz
# brew install freerdp
#

# ERF1-Edge
# rme-ais-prod-eu-oncorp-1
# prod-eu-trn3-2  /ec2/keypair/manual-prod-eu-trn3-2
# prod-eu-pad2-2
# ais-eu-corp-002-prod
# ais-eu-corp-004-prod

source ./amzn.sh

# Set profile name
profile_name=$1
region=$3
instance_name=$2
local_port=${4:-55001}
remote_port=${5:-3389}

# Get the correct key for trn3 cos it a oonicorn
key_prefix="/ec2/keypair/key-"
if [[ "$instance_name" == "prod-eu-trn3-2" ]]; then
  key_prefix="/ec2/keypair/manual-prod-eu-trn3-2"
fi

instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" "Name=instance-state-name,Values=running" --profile $profile_name --region $region --query 'Reservations[].Instances[].InstanceId' --output text)

if [ -z "$instance_id" ]; then
  echo "Could not get instance id"
  exit 1
fi

echo "Instance ID: $instance_id"

temp_pem_file=$(mktemp)
# Get the latest EC2 key pair parameter name
latest_key=$(aws ssm describe-parameters --query "Parameters[?starts_with(Name, '$key_prefix')].Name" --output text --profile "$profile_name" --region "$region" )
echo "Key: $latest_key"
# Retrieve the parameter value using the latest key
aws ssm get-parameter --name "$latest_key" --with-decryption --profile "$profile_name" --region "$region" --query 'Parameter.Value' --output text > "$temp_pem_file"
aws ec2 get-password-data --instance-id "$instance_id" --priv-launch-key "$temp_pem_file" --profile "$profile_name" --region "$region" > pass.txt
rm "$temp_pem_file"
cat pass.txt | jq -r .PasswordData | pbcopy
echo "Password Copied to clipboard"

## Start the AWS SSM session in the background
aws ssm start-session --target "$instance_id" --document-name AWS-StartPortForwardingSession --parameters "localPortNumber=$local_port,portNumber=$remote_port" --profile "$profile_name" --region "$region" &

# If AWS SSM session was successful, start RDP session
xfreerdp /u:Administrator /p:$(cat pass.txt | jq -r .PasswordData) /v:localhost:$local_port +clipboard /dynamic-resolution /cert:ignore /rfx /gfx:rfx /f /floatbar:sticky:off +fonts /bpp:32 /audio-mode:0 +aero +window-drag /tune:FreeRDP_HiDefRemoteApp:true,FreeRDP_GfxAVC444v2:true,FreeRDP_GfxH264:true

# # Redirect 3389 RDP port to local port 55001
# aws ssm start-session --target "$instance_id" --document-name AWS-StartPortForwardingSession --parameters "localPortNumber=$local_port,portNumber=$remote_port" --profile "$profile_name" --region "$region" &
# sleep 5
# xfreerdp /u:Administrator /p:$(cat pass.txt | jq -r .PasswordData) /v:localhost:$local_port +clipboard /dynamic-resolution /cert:ignore
echo "Connect to RDP using localhost:$local_port:$remote_port"

