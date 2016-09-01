#!/bin/bash
#
# This script will a list of ORCID works by providing a ORCID number
# email address.
#
export ORCID_API_URL="http://pub.orcid.org"

function requireEnvVar() {
    if [ "$2" = "" ]; then
        echo "Missing $1"
        if [ "$3" != "" ]; then
            echo "$3"
        fi
        exit 1
    fi
}

function requireSoftware() {
    APP=$(which $1)
    if [ "$APP" = "" ]; then
        echo "Missing $1, $2"
        exit 1
    fi
}

requireSoftware "curl" "usually installed with your operating system or OS's package manager"
requireSoftware "jq" "See: https://stedolan.github.io/jq/"
requireEnvVar "ORCID_API_URL" $ORCID_API_URL "Try using one -> https://pub.orcid.org, https://pub.sandbox.orcid.org, https://member.orcid.org"
requireEnvVar "ORCID_CLIENT_ID" $ORCID_CLIENT_ID
requireEnvVar "ORCID_CLIENT_SECRET" $ORCID_CLIENT_SECRET

export ORCID_ACCESS_TOKEN=$(curl -L -H "Accept: application/json" \
    -d "client_id=$ORCID_CLIENT_ID" \
    -d "client_secret=$ORCID_CLIENT_SECRET" \
    -d "scope=/read-public" \
    -d "grant_type=client_credentials" \
    "$ORCID_API_URL/oauth/token" | jq .access_token)
echo 
if [ "$ORCID_ACCESS_TOKEN" != "" ]; then
   echo 
   echo "export ORCID_ACCESS_TOKEN=$ORCID_ACCESS_TOKEN"
   echo 
else
    echo "Login failed $?"
    exit 1
fi

requireEnvVar "ORCID_ACCESS_TOKEN" $ORCID_ACCESS_TOKEN

OUT_FORMAT="application/json"

if [ "$1" != "" ]; then
    export ORCID_NUMBER="$1"
fi
requireEnvVar "ORCID_NUMBER" $ORCID_NUMBER


curl -L -H "Content-Type: $OUT_FORMAT" \
    -H "Authorization: Bearer $ORCID_ACCESS_TOKEN" \
    -X GET "https://pub.orcid.org/v1.2/$ORCID_NUMBER/orcid-works"
