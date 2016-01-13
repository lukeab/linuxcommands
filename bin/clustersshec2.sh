#!/bin/bash
#
# This script lets us use our listec2instances.sh script to get the ip's for 
# servers in the VPC and concurrently ssh to them all. 
# 
#

AWSSSHUSER=${AWSSSHUSER:-"ec2-user"}

AWSENVNAME=$1
INSTANCEROLE=$2

CLUSTERSSH="cssh"
case $OSTYPE in darwin*) CLUSTERSSH="csshx" ;; esac

if [[ $AWSENVNAME == "" ]]; then
  echo "Please provide and environment name, one of sit,stage,prod"
  exit 1;
fi
if [[ $INSTANCEROLE == "" ]];then
  set -x
  $CLUSTERSSH -l $AWSSSHUSER $(listec2instances.sh $AWSENVNAME |awk '{if (NR!=1) {print $2}}'|tr '\n' ' ')
else
  set -x
  $CLUSTERSSH -l $AWSSSHUSER $(listec2instances.sh $AWSENVNAME |grep $INSTANCEROLE |awk '{print $2}'|tr '\n' ' ')
fi

