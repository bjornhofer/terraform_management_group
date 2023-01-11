data "azurerm_management_group" "parent_mgmt_group" {
  display_name = var.mgmt_group_parent
}

resource "azurerm_management_group" "mgmt_group" {
  count                      = var.dbg_simulate ? 0 : 1
  parent_management_group_id = data.azurerm_management_group.parent_mgmt_group.id
  display_name               = var.management_group_name
  subscription_ids           = var.management_group_subscriptions
}

data "azurerm_management_group" "mgmt_group" {
  count        = var.dbg_simulate ? 1 : 0
  display_name = var.management_group_name
}