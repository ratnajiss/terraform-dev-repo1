terraform {
  backend "azurerm"{
    resource_group_name = "storage-tfstate-rg"
    storage_account_name = "tfstateeastus009"
    container_name = "terraformdev1"
    key = "terraform.terraformdev1"
    access_key = "TAc+6gqJganiEHGf/4KcFcyDBc5k2+t3f/bYSWSO8q8FkJNTeF22YL1Xhz7NfEh4bkoArZ2l1EWv+ASt0dL8Zg=="
  }
}


provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    tenant_id = var.tenant_id
    client_secret = var.client_secret
  
}
locals {
  setup_name = "practice-hyd1"
}

resource "azurerm_resource_group" "webapprg1" {
  name = "webapprg989"
  location = "East US"
  tags = {
    "name" = "${local.setup_name}-rsg"
  }
  
}
resource "azurerm_app_service_plan" "appplan11" {
  name = "appplandev1"
  location = azurerm_resource_group.webapprg1.location
  resource_group_name = azurerm_resource_group.webapprg1.name
  sku {
    tier = "standard"
    size = "S1"
  }
  tags = {
    "name" = "${local.setup_name}-appplan"
  }
  depends_on = [
    azurerm_resource_group.webapprg1
  ]
  
}

resource "azurerm_app_service" "webapp1" {
  name = "webappdev6441"
  location = azurerm_resource_group.webapprg1.location
  resource_group_name = azurerm_resource_group.webapprg1.name
  app_service_plan_id = azurerm_app_service_plan.appplan11.id
  tags = {
    "name" = "${local.setup_name}-webapp"
  }
  depends_on = [
    azurerm_app_service_plan.appplan11
  ]
  
}