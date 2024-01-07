#!/bin/bash

############################
# Author: Suyash Talekar
# Date: 6th Jan, 2024
# 
# Version: v1
# 
# This script will report AWS resource usage
################################

set -x # Debug mode
set -o pipefail

# List s3 buckets
echo "List of s3 buckets" > resources.txt
aws s3 ls >> resources.txt
echo " " >> resources.txt

# List EC2 instances
echo "List of ec2 instances" >> resources.txt
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> resources.txt
echo " " >> resources.txt

# List lambda funcions
echo "List of lambda functions" >> resources.txt
aws lambda list-functions | jq '.Functions[].FunctionName' >> resources.txt
echo " " >> resources.txt

# AWS IAM
echo "List of IAM users" >> resources.txt
aws iam list-users | jq '.Users[].UserName' >> resources.txt
echo " "

