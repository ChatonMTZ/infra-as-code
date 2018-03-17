Param($environment)

terraform plan ".\infra-as-code\DeployInfrastructure" -var-file=".\Environments\$environment.tfvars"