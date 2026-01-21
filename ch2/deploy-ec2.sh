#!/bin/bash
# AWS cli practice

set -e

export AWS_DEFAULT_REGION="ap-southeast-4"

# $ aws ec2 create-security-group   --group-name "new-security-group"   --description "New security group for example"
# {
#     "GroupId": "sg-12345",
#     "SecurityGroupArn": "arn:aws:ec2:ap-southeast-4:12345:security-group/sg-12345"
# }

security_group_id=$(aws ec2 create-security-group \
  --group-name "new-security-group" \
  --description "New security group for example" \
  --output text \
  --query GroupId)

# $ aws ec2 authorize-security-group-ingress   --group-id "sg-12345"   --protocol tcp   --port 22   --cidr "0.0.0.0/0"
# {
#     "Return": true,
#     "SecurityGroupRules": [
#         {
#             "SecurityGroupRuleId": "sgr-12345",
#             "GroupId": "sg-12345",
#             "GroupOwnerId": "12345",
#             "IsEgress": false,
#             "IpProtocol": "tcp",
#             "FromPort": 22,
#             "ToPort": 22,
#             "CidrIpv4": "0.0.0.0/0",
#             "SecurityGroupRuleArn": "arn:aws:ec2:ap-southeast-4:12345:security-group-rule/sgr-12345"
#         }
#     ]
# }

aws ec2 authorize-security-group-ingress \
  --group-id "$security_group_id" \
  --protocol tcp \
  --port 22 \
  --cidr "0.0.0.0/0" > /dev/null

# Example of finding available images through CLI command
# aws ec2 describe-images \
# --owners amazon \
# --filters 'Name=architecture, Values=x86_64' \
# --filters 'Name=image-type, Values=machine' \
# --filters 'Name=description, Values=Amazon Linux' \
# --filters 'Name=free-tier-eligible, Values=true' \
# --filters 'Name=image-id, Values=ami-02320f059b1afdc2f'

image_id="ami-02320f059b1afdc2f"

# Example CLI Usage
# $ aws ec2 run-instances \
# --image-id "ami-02320f059b1afdc2f" \
# --instance-type "t3.micro" \
# --subnet-id "subnet-12345" \
# --security-group-ids sg-12345 \
# --key-name "mykey"
# {
#     "ReservationId": "r-12345",
#     "OwnerId": "12345",
#     "Groups": [],
#     "Instances": [
#         {
# ...

instance_id=$(aws ec2 run-instances \
  --image-id "$image_id" \
  --instance-type "t3.micro" \
  --security-group-ids "$security_group_id" \
  --output text \
  --query Instances[0].InstanceId
)

# CLI Example
# $ aws ec2 describe-instances --instance-ids i-12345
# {
#     "Reservations": [
#         {
# ...

public_ip=$(
  aws ec2 describe-instances \
  --instance-ids "$instance_id" \
  --output text \
  --query 'Reservations[*].Instances[*].PublicIpAddress'
)

echo "Instance ID = $instance_id"
echo "Security Group ID = $security_group_id"
echo "Public IP = $public_ip"
