#!/bin/bash

#Jira url example: https://radbee-jira.radbeedev.com

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <parameters-file> <url> <username> <password>"
    exit 1
fi

PARAMS_FILE=$1
URL="$2/rest/api/latest/search"
USERNAME=$3
PASSWORD=$4

# Check if the parameters file exists
if [ ! -f "$PARAMS_FILE" ]; then
    echo "The file $PARAMS_FILE does not exist!"
    exit 2
fi

# Counter initialization
COUNTER=0

# Infinite loop for continuous requests
while true; do
    # Increment the counter
    COUNTER=$((COUNTER + 1))
    echo ""
    echo "Request Number: $COUNTER"

    # Fetch the parameter for this iteration using modulo
    JQL=$(sed -n "$((COUNTER % $(wc -l < "$PARAMS_FILE") + 1))p" "$PARAMS_FILE")
    echo "JQL: $JQL"
    ESCAPED_JQL=$(echo "$JQL" | sed 's/"/\\"/g')

    JSON_BODY='{"jql": "'"${ESCAPED_JQL}"'", "expand": ["schema", "names", "renderedFields"], "fields": ["*all"], "startAt": 0, "maxResults": 100}'
    
    
    # Get the current time in seconds before executing the curl command
    START_TIME=$(date +%s)

    # POST request with basic authentication and JSON body
    RESPONSE=$(curl -s -w "\n%{http_code}" -X POST -u "$USERNAME:$PASSWORD" \
             -H "Content-Type: application/json" \
             -d "$JSON_BODY" "$URL")

    # Get the current time in seconds after the curl command
    END_TIME=$(date +%s)
    # Calculate the time difference
    TIME_DIFF=$(($END_TIME - $START_TIME))

    # Extract body and status code from response
    BODY=$(echo "$RESPONSE" | sed '$d')
    STATUS_CODE=$(echo "$RESPONSE" | tail -n1)

    # Print request number, status code, and first 20 characters of the body
    echo "Status Code: $STATUS_CODE"
    echo "Execution Time: ${TIME_DIFF}s"
    echo "Body (first 100 chars): ${BODY:0:100}"

    # Adding a sleep of 1 second between requests. Adjust as needed.
    sleep 1
done