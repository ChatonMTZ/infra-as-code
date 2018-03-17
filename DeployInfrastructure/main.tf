provider "azurerm" {
  subscription_id = "{{subscriptionId}}"
  client_id       = "{{clientId}}"
  client_secret   = "{{clientSecret}}"
  tenant_id       = "{{tenantId}}"
}

terraform {
  backend "azurerm" {
    storage_account_name = "{{backendStorageAccountName}}"
    container_name       = "{{backendContainerName}}"
    key                  = "{{backendKey}}"
    access_key           = "{{backendAccessKey}}"
  }
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
    tier     = "${var.appServiceTier}"
    size     = "${var.appServiceSize}"
    capacity = "${var.appServiceCapacity}"
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
  administrator_login_password = "{{dbAdminAccount}}"
}

resource "azurerm_sql_database" "SqlDatabase" {
  name                             = "app-${var.environment}-db"
  resource_group_name              = "${azurerm_resource_group.DataRg.name}"
  location                         = "${var.location}"
  server_name                      = "${azurerm_sql_server.SqlServer.name}"
  requested_service_objective_name = "${var.databaseObjectiveName}"
  edition                          = "${var.databaseEdition}"
}