Param($environment)

terraform apply ".\infra-as-code\DeployInfrastructure" -var-file=".\Environments\$environment.tfvars" -auto-approve