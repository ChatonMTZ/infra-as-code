Param($environment)

terraform destroy -var-file=".\Environments\$environment.tfvars" -force