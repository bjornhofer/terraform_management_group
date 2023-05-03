variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

## Management Group
variable "mgmt_group_parent" {
  type = string
  default = "Tenant Root Group"
}

variable "management_group_name" {
  type        = string
  description = "Display name of the management group"
}

variable "management_group_create" {
  type = bool
  description = "Create the management group"
  default = false
}

variable "management_group_subscriptions" {
  type        = list(any)
  description = "List of subscriptions housed in the mangement group"
}

## Management Group - one layer above
variable "management_group_above_1_name" {
  type = string
  description = "Display name of the management group one layer above"
  default = null
}

variable "management_group_above_1_create" {
  type = bool
  description = "Create the management group one layer above"
  default = false
}

variable "management_group_above_1_subscriptions" {
  type        = list(any)
  description = "List of subscriptions housed in the mangement group one layer above"
  default = null
}

variable "management_group_above_1_parent" {
  type = bool
  description = "Parent management group of the management group one layer above"
  default = false
}

## Management Group - two layer above
variable "management_group_above_2_name" {
  type = string
  description = "Display name of the management group two layer above"
  default = null
}

variable "management_group_above_2_create" {
  type = bool
  description = "Create the management group two layer above"
  default = false
}

variable "management_group_above_2_subscriptions" {
  type        = list(any)
  description = "List of subscriptions housed in the mangement group two layer above"
  default = null
}

variable "management_group_above_2_parent" {
  type = bool
  description = "Parent management group of the management group two layer above"
  default = false
}

variable "dbg_simulate" {
  type        = bool
  default     = true
  description = "DEBUG: simulate creation | default: false | true = simulate creation, false = do not simulate creation"
}
