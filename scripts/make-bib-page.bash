#!/bin/bash

. etc/demo.conf
#export ORCID_API_URL="http://pub.orcid.org"

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

function mkExampleJSON() {
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

    echo "ORCID Access Token"
    echo 
    echo "export ORCID_ACCESS_TOKEN=$ORCID_ACCESS_TOKEN"
    echo

    echo "Got access token, getting works for 0000-0003-0248-0813"
    curl -o example.json \
        -L -H "Content-Type: application/json" \
        -H "Authorization: Bearer $ORCID_ACCESS_TOKEN" \
        -X GET "https://pub.orcid.org/v1.2/0000-0003-0248-0813/orcid-works"

    echo "Displaying response..."
    cat example.json
}

if [ ! -f example.json ]; then
    mkExampleJSON
fi

if [ -f example.json ]; then
    echo "Building our webpage"
    mkpage "title=text:Publications List" \
       "name=text:Donna Wrublewski" \
       "orcid=text:0000-0003-0248-0813" \
       "works=example.json" \
       page-pubs.tmpl > wrublewski-pubs.html
fi
