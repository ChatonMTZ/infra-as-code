variable "location" {
  default = "North Europe"
}

variable "environment" {}

#App service configuration
variable "app_service_tiers" {}
variable "app_service_size" {}
variable "app_service_capacity" {}

#database Configuration
variable "database_objective_name" {}
variable "database_edition" {}
variable "database_admin_password" {}
