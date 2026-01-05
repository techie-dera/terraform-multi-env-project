# acmepay-azure-landing-zone

Multi-environment Terraform project for Azure (dev/staging/prod).

## Bootstrap state
cd bootstrap-tfstate
terraform init
terraform apply

## Deploy env
cd ../envs/dev
terraform init
terraform plan
terraform apply
