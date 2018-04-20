#provider
variable "provider_subscription_id" {}
variable "provider_client_id" {}
variable "provider_client_secret" {}
variable "provider_tenant_id" {}

variable "location" {
  default = "North Europe"
}

variable "environment" {}
variable "projet_name" {}

#App service configuration
variable "app_service_tiers" {}
variable "app_service_size" {}
variable "app_service_capacity" {}

#database Configuration
variable "database_objective_name" {}
variable "database_edition" {}
variable "database_admin_password" {}
