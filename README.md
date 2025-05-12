# LookseeIaC

> *Infrastructure that lets Look‑see run circles around inaccessible websites.*

---

## Table of Contents

1. [What’s in the Box](#whats-in-the-box)
2. [Architecture](#architecture)
3. [Prerequisites](#prerequisites)
4. [Required Google Cloud APIs](#required-google-cloud-apis)
5. [Getting Started](#getting-started)
6. [Configuration](#configuration)
7. [Project Structure](#project-structure)
8. [Local Dev & CI/CD](#local-dev--cicd)
9. [Security & Secrets](#security--secrets)
10. [Cleaning Up](#cleaning-up)
11. [Contributing](#contributing)
12. [License](#license)

---

## What’s in the Box

This repo is a **Terraform mono‑module** that spins up every Google Cloud resource Look‑see needs to crawl a site, run automated accessibility audits, and stash the results in a Neo4j graph database. In less time than it takes to microwave leftover pizza you’ll get:

* A private **Neo4j Aura** instance (or the URI of an existing one)
* A fleet of **Cloud Run services** (crawler, auditor, notifier, and a tiny API gateway)
* **Pub/Sub topics** that glue the micro‑services together
* **Secret Manager** entries for DB creds, SMTP, and Pusher keys
* **Service accounts** with minimum‑viable IAM roles
* **Cloud Build** pipelines that build and deploy container images on every tag push

*If you’re curious how the pieces dance together, jump to the 60‑second tour below.*

---

## Architecture


Everything is 100 % serverless so you only pay while the containers are awake.

---

## Prerequisites

* **Google Cloud account** with billing enabled.
* **Terraform 1.6+** – any newer release is fine.
* **Google Cloud SDK** (`gcloud`) authenticated against your project.
* **Docker** – Cloud Build can build for you, but local Docker makes debugging faster.
* **Node 18+** – only needed if you hack on the micro‑services before pushing.
* **A Neo4j Aura instance** (free tier works) or credentials to an existing cluster.

> *Need a refresher on CI/CD? Peek at my AWS blog post “Anatomy of a CI/CD Pipeline” for extra context.*

---

## Required Google Cloud APIs

Enable these once per project (replace `${PROJECT_ID}`):

```bash
gcloud services enable \
  run.googleapis.com \
  cloudbuild.googleapis.com \
  pubsub.googleapis.com \
  secretmanager.googleapis.com \
  compute.googleapis.com \
  --project=${PROJECT_ID}
```

---

## Getting Started

```bash
# 1. Clone and enter the repo
$ git clone https://github.com/deepthought42/LookseeIaC.git
$ cd LookseeIaC

# 2. Export the bare‑minimum variables
$ export TF_VAR_project_id="my‑gcp‑proj"
$ export TF_VAR_region="us‑central1"
$ export TF_VAR_environment="dev"

# 3. Export your secrets (see next section)
$ export TF_VAR_neo4j_username=neo4j
$ export TF_VAR_neo4j_password="super‑secret"
$ export TF_VAR_neo4j_bolt_uri="bolt+s://xxxxx.databases.neo4j.io"
$ export TF_VAR_neo4j_db_name="neo4j"
$ export TF_VAR_smtp_username="postmaster@example.com"
$ export TF_VAR_smtp_password="s3ndM3Mail$"
$ export TF_VAR_pusher_key="app-key"
$ export TF_VAR_pusher_app_id="app-id"
$ export TF_VAR_pusher_cluster="us3"

# 4. Initialise and deploy
$ terraform init
$ terraform plan -out=tf.plan
$ terraform apply tf.plan
```

The first run takes about 5‑7 minutes while Cloud Build cooks the container images.

When `terraform apply` finishes it prints the public HTTPS URL of the API gateway and crawler service. Hit `/healthz` on either endpoint to confirm they’re alive.

---

## Configuration

All tunables live in **`variables.tf`**. You can override them via `terraform.tfvars` or environment variables:

| Variable                            | Description                      | Default       |
| ----------------------------------- | -------------------------------- | ------------- |
| `project_id`                        | GCP project to deploy into       | –             |
| `region`                            | Primary region for all resources | `us‑central1` |
| `environment`                       | Tag applied to every resource    | `dev`         |
| `neo4j_bolt_uri`                    | BOLT URI to your Aura instance   | –             |
| `neo4j_username` / `neo4j_password` | DB creds                         | –             |
| `smtp_username` / `smtp_password`   | SMTP creds for outbound email    | –             |
| `pusher_*`                          | Realtime updates                 | –             |

> **Heads‑up.** Changing `environment` triggers *new* resources rather than updating in place. Handy for blue‑green swaps, but noisy if you do it by accident.

---

## Local Dev & CI/CD

* **Local smoke test:** each service has a `make dev` that builds and runs the container with mock env vars.
* **CI/CD:** pushing a tag like `v1.2.3` triggers Cloud Build.

  * Builds the Docker image
  * Pushes to Artifact Registry
  * Re‑deploys the Cloud Run service

The pipeline YAML lives beside each service so you can tweak build flags without touching Terraform.

For a deeper dive into semantic versioning in pipelines check my **“Ship It Like SemVer”** AWS blog post.

---

## Security & Secrets

* Secrets are **never** baked into Terraform state. Everything sensitive sits in Secret Manager and is only referenced by resource ID.
* Every Cloud Run service owns a dedicated **service account** with the smallest IAM role needed (mostly Pub/Sub publisher or subscriber).
* `create-indexes-and-constraints.cql` is executed once at deploy time via a Cloud Build step so the DB schema is consistent across environments.

---

## Cleaning Up

```bash
terraform destroy
```

Terraform tears down every resource, including the Artifact Registry images. Neo4j Aura lives outside GCP, so kill that instance from the Neo4j console if you spun up a temporary cluster.

---

## Contributing

Pull requests are welcome. Open an issue for big changes so we can chat about the design first. All code is formatted with **`terraform fmt`** and validated by **`tflint`** on push.

---

## License

Apache‑2.0. See [LICENSE.md](LICENSE.md) for the boring details.
