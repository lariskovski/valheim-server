
# Terraform Cloud Template

Instructions to run this project using Terraform Cloud.

## Pre-Reqs

- Create a [Terraform Cloud](https://app.terraform.io) account, organization and project

- Create an workspace with a version control workflow (connect to Github if not already)

- Search and select the desired Github repository

- Confirm the workspace name and configuration

- Go to Variables in the left menu, Workspace Variables, Terraform Variable (*not* Environment Variable) add the `GOOGLE_CREDENTIALS` env containing the SA json with permissions to create the desired infra. Don't forget to flag it as sensitive so it doesn't get logged

- Add `terraform` dir in the workspace settings `Terraform Working Directory` (only needded if TF main file is not on root)

You are now set up with the basics! 🥳

### Github Workflows Configuration

#### Infracost

To use infracost add the secret `INFRACOST_API_KEY` in the repository variables (on Github).

[How to get the Infracost API Key](https://www.infracost.io/docs/#2-get-api-key)

#### TF Lint

TF Lint doesn't need any additional configuration.

## Infrastructure Creation

When everything checks out, push the code to the main branch (or open a PR) then *go to Terraform cloud and approve the apply.* 

## Running Github Workflows Locally

You can install Github Act extention to run tflint and any other workflows locally:

`gh extension install https://github.com/nektos/gh-act`

Run Act to check the TF code:

`gh act -n`

## Sources

[Authenticate to GCP in Terraform Cloud](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference.html#using-terraform-cloud)

[Setup Infracost](https://github.com/infracost/actions?tab=readme-ov-file)

[Terraform Checks in Github Actions](https://medium.com/@nanditasahu031/how-to-use-different-tools-to-do-terraform-checks-in-github-actions-b16e9fa73c42)

[Mount GCS on GCE](https://cloud.google.com/storage/docs/gcsfuse-quickstart-mount-bucket)

## Get startup script logs

`sudo journalctl -u google-startup-scripts.service`

Rerun:

`sudo google_metadata_script_runner --script-type startup`

## GCSFUSE

`--implicit-dirs` 

 https://stackoverflow.com/questions/38311036/folders-not-showing-up-in-bucket-storage