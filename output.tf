output "management_group" {
  //value = var.dbg_simulate ? data.azurerm_management_group.mgmt_group : azurerm_management_group.mgmt_group
  value = data.azurerm_management_group.mgmt_group
}
