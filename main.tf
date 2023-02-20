// Gather data
data "azurerm_management_group" "root" {
  name = keys(var.mg_structure)[0]
}

data "azurerm_management_group" "all" {
    for_each = toset(data.azurerm_management_group.root.all_management_group_ids)
    name = split("/", each.key)[4]
}

// transform data
locals {
    mg_display_names = [for mg_detail in data.azurerm_management_group.all : mg_detail.display_name]
    mg_parents = {for mg_detail in data.azurerm_management_group.all : mg_detail.display_name => split("/",mg_detail.parent_management_group_id)[4]}
    mg_ids = {for mg_detail in data.azurerm_management_group.all : mg_detail.display_name => split("/",mg_detail.id)[4]}

    layer1_name = keys(var.mg_structure[keys(var.mg_structure)[0]])[0]
    layer2_name = element(var.mg_structure[keys(var.mg_structure)[0]][keys(var.mg_structure[keys(var.mg_structure)[0]])[0]], 0)

    layer1_id = local.layer1_exists ? local.mg_ids[local.layer1_name] : null
    layer2_id = local.layer2_exists ? local.mg_ids[local.layer2_name] : null

}

// Check existence
locals {
    layer1_exists = contains(local.mg_display_names, local.layer1_name)
    layer2_exists = contains(local.mg_display_names, local.layer2_name)
}

output "layer1_exists" {
  value = local.layer1_exists
}

output "layer2_exists" {
  value = local.layer2_exists
}

// Check parents
locals {
  layer1_parent_consitent = local.layer1_exists ? keys(var.mg_structure)[0] == local.mg_parents[local.layer1_name] ? true : false : false
  layer2_parent_consitent = local.layer2_exists ? local.layer1_id == local.mg_parents[local.layer2_name] ? true : false : false
}

output "layer1_parent_consitent" {
    value = local.layer1_parent_consitent
}

output "layer2_parent_consitent" {
  value = local.layer2_parent_consitent
}

/*
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
*/
