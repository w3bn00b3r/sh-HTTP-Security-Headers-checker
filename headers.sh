#!/bin/bash

# Function to check if a header is present in the response
check_header() {
    header=$(curl -sIL $1 | grep -i $2)
    if [ -z "$header" ]; then
        printf "\e[31m%s\e[0m\n" "$2: MISSING"
    else
        printf "\e[32m%s\e[0m\n" "$header"
    fi
}

# Check if URL is provided as argument
if [ -z "$1" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

# Get response code and print the URL
response_code=$(curl -sIL -w "%{http_code}" $1 -o /dev/null)
echo "URL: $1 (Response code: $response_code)"

# Print the title of the section
echo -e "\nWeb Headers\n"

# Check for each header
check_header $1 "X-Content-Type-Options"
check_header $1 "X-Frame-Options"
check_header $1 "X-XSS-Protection"
check_header $1 "Strict-Transport-Security"
check_header $1 "Content-Security-Policy"
check_header $1 "Referrer-Policy"
check_header $1 "Feature-Policy"
check_header $1 "Cache-Control"
check_header $1 "Permissions-Policy"
check_header $1 "Cross-Origin-Embedder-Policy"
check_header $1 "Cross-Origin-Opener-Policy"
check_header $1 "Cross-Origin-Resource-Policy"
