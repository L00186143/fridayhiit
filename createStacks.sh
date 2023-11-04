#!/bin/bash

# Replace with your S3 bucket name
s3_bucket="fridayhiit"

# Replace with your desired stack name
stack_name="FridayHIIT"
key_name="friday-hiit"

# Deploy the CloudFormation templates from S3 bucket
aws s3 cp s3://$s3_bucket/vpc.yml ./vpc.yaml
aws s3 cp s3://$s3_bucket/instances.yml ./instances.yml


aws cloudformation create-stack --stack-name "$stack_name" --template-body file://vpc.yml
aws cloudformation wait stack-create-complete --stack-name "$stack_name"


aws cloudformation update-stack --stack-name "$stack_name" --template-body file://instances.yml --parameters ParameterKey=KeyName,ParameterValue="$key_name"
aws cloudformation wait stack-update-complete --stack-name "$stack_name"

#echo "CloudFormation stack deployment complete"
echo "CloudFormation stack update complete"