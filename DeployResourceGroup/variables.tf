variable "location" {
  default = "North Europe"
}

variable "environment" {}

#App service configuration
variable "appServiceTier" {}

variable "appServiceSize" {}
variable "appServiceCapacity" {}

#database Configuration
variable "databaseObjectiveName" {}

variable "databaseObjectiveId" {}
