#!/bin/bash

AWS_LB_VERSION="2.2.0"
AWS_LB_ROLE_ARN="arn:aws:iam::381354187112:role/AmazonEKSLoadBalancerControllerRole"

curl -o iam_policy_v1_to_v2_additional.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v${AWS_LB_VERSION}/docs/install/iam_policy_v1_to_v2_additional.json

LBC_POLICY_ARN=$(aws iam create-policy --policy-name AWSLoadBalancerControllerAdditionalIAMPolicy --policy-document file://iam_policy_v1_to_v2_additional.json | jq .Policy.PolicyName)

aws iam attach-role-policy \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --policy-arn ${LBC_POLICY_ARN}
