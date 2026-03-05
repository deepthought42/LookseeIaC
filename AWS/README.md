# AWS Terraform deployment

This directory contains an AWS-first Terraform deployment that mirrors the GCP architecture:

- Cloud Run services -> ECS Fargate services (`modules/ecs_service`)
- Pub/Sub topics -> Amazon Kinesis streams (`modules/kinesis`)
- Secret Manager -> AWS Secrets Manager (`modules/secrets`)
- Compute Engine Neo4j VM -> EC2 Neo4j instance (`modules/neo4j-db`)
- VPC networking -> AWS VPC, subnets, NAT, and security groups (`modules/vpc`)

## Usage

```bash
cd AWS
terraform init
terraform plan \
  -var='neo4j_ami_id=ami-xxxxxxxx' \
  -var='neo4j_password=change-me' \
  -var='smtp_username=user' \
  -var='smtp_password=pass' \
  -var='pusher_key=key' \
  -var='pusher_app_id=id' \
  -var='pusher_cluster=cluster' \
  -var='pusher_secret=secret' \
  -var='auth0_client_id=id' \
  -var='auth0_client_secret=secret' \
  -var='auth0_domain=domain' \
  -var='auth0_audience=audience'
```

> Note: update container images and IAM policies based on each microservice's final runtime requirements.
