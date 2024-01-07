#!/bin/bash


###########################################################################
# Author: Suyash Talekar						  #
# Date: 7th Jan, 2024							  #	
# 									  #
# Version: v2								  #
#									  #
# This script will list all users having access to your github repository #
#									  #	
# Usage: 1) Export your github "username" and "token"			  #
#	 2) Run with two cmd args: GitHubUserName RepoName		  #
###########################################################################


# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Errors out if wrong number of cmd args received
function error_out {
	expected_cmd_args=2
	if [ "$#" -ne "$expected_cmd_args" ];
	then
		echo "Please provide cmd args 1)GithHub Username 2)Your repo name"
    exit 1
	fi
}


# Main script
error_out "$@"
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
