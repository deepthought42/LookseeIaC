# LookseeIaC

# Deployment

Deploying the web crawler involves setting up multiple serverless services that are connected via GCP PubSub. To successfully deploy it, you need to do a few things:

1. Set up the GCP project
2. Set up the secrets
3. Set up the PubSub topics
4. Set up the Cloud Run services

## Secrets

### Neo4j Password

The Neo4j password is stored in the `secrets` module. It is used to authenticate the Neo4j database.

```bash
export TF_VAR_environment="<YOUR_ENVIRONMENT(dev|stage|prod|etc.)>"
export TF_VAR_project_id="<YOUR_PROJECT_ID>"
export TF_VAR_region="<REGION>"

export TF_VAR_neo4j_password="<NEO4J_PASSWORD>"
export TF_VAR_neo4j_username="<NEO4J_USERNAME>"
export TF_VAR_neo4j_bolt_uri="<NEO4J_BOLT_URI>"
export TF_VAR_neo4j_db_name="<NEO4J_DB_NAME>"
export TF_VAR_auth0_client_secret="<AUTH0_CLIENT_SECRET>"
export TF_VAR_auth0_client_id="<AUTH0_CLIENT_ID>"

export TF_VAR_pusher_key="<PUSHER_KEY>"
export TF_VAR_pusher_app_id="<PUSHER_APP_ID>"
export TF_VAR_pusher_cluster="<PUSHER_CLUSTER>"

export TF_VAR_smtp_password="<SMTP_PASSWORD>"
export TF_VAR_smtp_username="<SMTP_USERNAME>"

export GOOGLE_APPLICATION_CREDENTIALS="<GOOGLE_APPLICATION_CREDENTIALS_PATH>"
terraform apply
```