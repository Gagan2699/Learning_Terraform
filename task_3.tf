provider "azurerm" {
    version = 1.38
    }

resource "azurerm_app_service_plan" "svcplan" {
  name                = "#######"    #  Unique Service Plan Name
  location            = "eastus"
  resource_group_name = "#######"    # Resource Group Name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "#######"    #  Unique App Service Plan Name
  location            = "eastus"
  resource_group_name = "#######"    # Resource Group Name
  app_service_plan_id = azurerm_app_service_plan.svcplan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}