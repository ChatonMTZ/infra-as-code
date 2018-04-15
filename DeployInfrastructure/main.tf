provider "azurerm" {

  subscription_id = "${var.provider_subscription_id}"
  client_id = "${var.provider_client_id}"
  client_secret = "${var.provider_client_secret}"
  tenant_id = "${var.provider_tenant_id}"
}

terraform {
  backend "azurerm" {}
}

resource "azurerm_resource_group" "AppRg" {
  name     = "app-${var.environment}-rg"
  location = "${var.location}"
}

resource "azurerm_resource_group" "DataRg" {
  name     = "app-${var.environment}-data-rg"
  location = "${var.location}"
}

resource "azurerm_app_service_plan" "AppServicePlan" {
  name                = "app-${var.environment}-sp"
  resource_group_name = "${azurerm_resource_group.AppRg.name}"
  location            = "${var.location}"
  kind                = "Windows"

  sku {
    tier     = "${var.app_service_tiers}"
    size     = "${var.app_service_size}"
    capacity = "${var.app_service_capacity}"
  }
}

resource "azurerm_app_service" "AppService" {
  name                = "app-${var.environment}-as"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.AppRg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.AppServicePlan.id}"

  site_config {
    dotnet_framework_version = "v4.0"
  }
}

resource "azurerm_sql_server" "SqlServer" {
  name                         = "app-${var.environment}-sqlserver"
  resource_group_name          = "${azurerm_resource_group.DataRg.name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "appdbadmin"
  administrator_login_password = "${var.database_admin_password}"
}

resource "azurerm_sql_database" "SqlDatabase" {
  name                             = "app-${var.environment}-db"
  resource_group_name              = "${azurerm_resource_group.DataRg.name}"
  location                         = "${var.location}"
  server_name                      = "${azurerm_sql_server.SqlServer.name}"
  requested_service_objective_name = "${var.database_objective_name}"
  edition                          = "${var.database_edition}"
}
