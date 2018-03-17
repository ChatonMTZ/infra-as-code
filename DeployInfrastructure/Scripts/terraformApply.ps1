Param($environment)

terraform apply -var-file=".\Environments\$environment.tfvars" -auto-approve