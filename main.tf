provider "azurerm" {
  features {}
  alias = "management_group"
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
} 

data "azurerm_management_group" "parent_mgmt_group" {
  display_name = var.mgmt_group_parent
  provider = azurerm.management_group
}

resource "azurerm_management_group" "mgmt_group" {
  count                      = var.dbg_simulate ? 0 : 1
  parent_management_group_id = data.azurerm_management_group.parent_mgmt_group.id
  display_name               = var.management_group_name
  subscription_ids           = var.management_group_subscriptions
  provider = azurerm.management_group
}

data "azurerm_management_group" "mgmt_group" {
  count        = var.dbg_simulate ? 1 : 0
  display_name = var.management_group_name
  provider = azurerm.management_group
}
