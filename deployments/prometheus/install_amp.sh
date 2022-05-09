#!/bin/bash

AWS_REGION="us-east-1"
NS="monitoring"
ROLE_ARN="arn:aws:iam::381354187112:role/AmazonEKSManagedPrometheusRole"
WORKSPACE_ID="ws-578e5218-eb77-4b99-8b87-682d49328b22"

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus-for-amp prometheus-community/prometheus \
     -n ${NS} \
     -f ./amp_ingest_override_values.yaml \
     --set serviceAccounts.server.annotations."eks\.amazonaws\.com/role-arn"="${ROLE_ARN}" \
     --set server.remoteWrite[0].url="https://aps-workspaces.${AWS_REGION}.amazonaws.com/workspaces/${WORKSPACE_ID}/api/v1/remote_write" \
     --set server.remoteWrite[0].sigv4.region=${AWS_REGION}
