#!/bin/bash

top_level=$(git rev-parse --show-toplevel)
cd ${top_level}

array=(${top_level}/lambdas/*/)

# loop over all directories, re-building the lambda functions
for i in ${array[@]}
do
    # navigate to correct lambda-containing directory, build a new binary, and zip it
    cd ${i}
    GOARCH=amd64 GOOS=linux go build -o bootstrap main.go
    zip -jrm main.zip bootstrap
    cd ${top_level}
done

echo
read -p "Press ENTER to perform a 'terraform apply' and update your lambda functions." -n 1 -r
echo
# run a terraform apply to update the lambda function updated
terraform apply
