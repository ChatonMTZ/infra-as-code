Param($environment)

terraform plan -var-file=".\Environments\$environment.tfvars"