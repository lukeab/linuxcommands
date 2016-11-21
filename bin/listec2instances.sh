#!/bin/bash

ENV=$1
if [[ $ENV == "" ]]; then
	echo "Please provide and environment name as the first parameter"
	echo
	exit 1
fi
AWSENVPREFIX=${AWSENVPREFIX:=""} #set this to your vpc environment prefix eg <company>-<Department>-<project>-
#eg  export AWSENVPREFIX="acme-sales-widgets-"


#ENVPREFIX and ENV will be used to make up a string matching what's in your ~/.aws/config  so make sure you include any sepreating characters.
#Otherwise leave it blank so you can hit any env if you have plenty of non-prefixable environments you connect to.
#

TMPFILE_LOC=/tmp/ec2instances_"${AWSENVPREFIX}${ENV}".json
TMPFILE_TTL=60

if [ ! -f "${TMPFILE_LOC}" ] || [ "$(find "${TMPFILE_LOC}" -mmin +"${TMPFILE_TTL}")" ] ; then
  aws --profile "${AWSENVPREFIX}""${ENV}" ec2 describe-instances --output json --query "Reservations[*].Instances[*]" > "${TMPFILE_LOC}"
fi


cat ${TMPFILE_LOC} | jq  --raw-output '.[]|.[]|(if .Tags then (.Tags[]|select(.Key == "Name").Value) else empty end)+" " +(.NetworkInterfaces[0]|.PrivateIpAddress) + " " + (.NetworkInterfaces[1]|.PrivateIpAddress)  + " " +.InstanceId+" " +.Placement.AvailabilityZone+" " +.PublicIpAddress' |sort -s|column -t | grep -E --color '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'
