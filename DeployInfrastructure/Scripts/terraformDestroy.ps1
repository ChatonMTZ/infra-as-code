Param($environment)

terraform destroy ".\infra-as-code\DeployInfrastructure" -var-file=".\Environments\$environment.tfvars" -force