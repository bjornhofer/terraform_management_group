provider "azurerm" {
  features {}
  alias = "management_group"
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
} 



locals {
  create__management_group = var.dbg_simulate ? false : var.management_group_create ? true : false
  create__management_group_above_1 = var.management_group_above_1_name != null ? var.dbg_simulate ? false : var.management_group_above_1_create ? true : false : false
  create__management_group_above_2 = var.management_group_above_2_name != null ? var.dbg_simulate ? false : var.management_group_above_2_create ? true : false : false
}

## Management Group
data "azurerm_management_group" "mgmt_group_parent" {
  display_name = var.mgmt_group_parent
  provider = azurerm.management_group
}
resource "azurerm_management_group" "mgmt_group" {
  count                      = local.create__management_group ? 1 : 0
  parent_management_group_id = data.azurerm_management_group.mgmt_group_parent.id
  display_name               = var.management_group_name
  subscription_ids           = var.management_group_subscriptions
  provider = azurerm.management_group
}

data "azurerm_management_group" "mgmt_group" {
  count        = local.create__management_group ? 0 : 1
  display_name = var.management_group_name
  provider = azurerm.management_group
}

## Management Group - One above
data "azurerm_management_group" "parent_above_1" {
  count = var.management_group_above_1_name != null ? 1 : 0
  display_name = var.mgmt_group_parent
  provider = azurerm.management_group
}
resource "azurerm_management_group" "above_1" {
  count                      = local.create__management_group_above_1 ? 1 : 0
  parent_management_group_id = data.azurerm_management_group.mgmt_group_parent_above_1.id
  display_name               = var.management_group_above_1_name
  subscription_ids           = var.management_group_above_1_subscriptions
  provider = azurerm.management_group
}

data "azurerm_management_group" "above_1" {
  count        = var.management_group_above_1_name != null ? local.create__management_group_above_1 ? 0 : 1 : 0
  display_name = var.management_group_above_1_name
  provider = azurerm.management_group
}

## Management Group - Two above
data "azurerm_management_group" "parent_above_2" {
  count = var.management_group_above_2_name != null ? 1 :0
  display_name = var.management_group_above_2_parent
  provider = azurerm.management_group
}
resource "azurerm_management_group" "above_2" {
  count                      = local.create__management_group_above_2 ? 1 : 0
  parent_management_group_id = data.azurerm_management_group.mgmt_group_parent_above_2.id
  display_name               = var.management_group_above_2_name
  subscription_ids           = var.management_group_above_2_subscriptions
  provider = azurerm.management_group
}

data "azurerm_management_group" "above_2" {
  count        = var.management_group_above_2_name != null ? local.create__management_group_above_2 ? 0 : 1 : 0
  display_name = var.management_group_above_2_name
  provider = azurerm.management_group
}