#!/bin/bash

ENV=$1
if [[ $ENV == "" ]]; then
	echo "Please provide and environment name as the first parameter"
	echo
	exit 1
fi
AWSENVPREFIX=${AWSENVPREFIX:=""} #set this to your vpc environment prefix eg <company>-<Department>-<project>-
#eg  export AWSENVPREFIX="acme-sales-widgets-"
echo "AWSENVPREFIX = $AWSENVPREFIX"

#ENVPREFIX and ENV will be used to make up a string matching what's in your ~/.aws/config  so make sure you include any sepreating characters.
#Otherwise leave it blank so you can hit any env if you have plenty of non-prefixable environments you connect to.
#

aws --profile ${AWSENVPREFIX}${ENV} ec2 describe-instances --output json --query "Reservations[*].Instances[*]" | jq  --raw-output '.[]|.[]|(if .Tags then (.Tags[]|select(.Key == "Service").Value) else empty end)+" " +.PrivateIpAddress+" " +.InstanceId+" " +.Placement.AvailabilityZone' |sort -s|column -t | grep -E --color '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'
