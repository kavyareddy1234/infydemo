# Define Terraform provider
terraform {
  required_version = ">= 0.12"
}
# Configure the Azure provider
provider "azurerm" { 
  environment = "public"
  version = ">= 2.0.0"
  features {} 
  subscription_id = 1fc3b03c-4b80-482d-8cfd-2214fc605b65
  client_id = cc8ed034-3815-4aad-99c7-c0aa4cd1aeb4
  tenant_id = 640a7a44-7eac-489a-b73e-220eac0b7cf3
  client_secret = B3f-qBQp4c.7QLAH5i625E8W2zC4._PCK0
}
# Create a resource group for network
resource "azurerm_resource_group" "network-rg" {
  name = "${var.app_name}-${var.environment}-rg"
  location = var.location
  tags = {
    application = var.app_name
    environment = var.environment
  }
}
# Create the network VNET
resource "azurerm_virtual_network" "network-vnet" {
  name = "${var.app_name}-${var.environment}-vnet"
  address_space = [var.network-vnet-cidr]
  resource_group_name = azurerm_resource_group.network-rg.name
  location = azurerm_resource_group.network-rg.location
  tags = {
    application = var.app_name
    environment = var.environment
  }
}
# Create a subnet for Network
resource "azurerm_subnet" "network-subnet" {
  name = "${var.app_name}-${var.environment}-subnet"
  address_prefix = var.network-subnet-cidr
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  resource_group_name = azurerm_resource_group.network-rg.name
}
