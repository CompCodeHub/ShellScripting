#!/bin/bash

####################
# Author: Suyash
# Date: 01/06/2024
# 
# This script outputs node health
# 
# Version: v1
########################

set -x # Debug mode
set -e # Exit when error
set -o pipefail # Exit for pipefailures

df -h

free -g

nproc

ps -ef | grep amazon | awk -F" " '{print $2}'
