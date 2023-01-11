variable "mgmt_group_parent" {
  type = string
}

variable "management_group_name" {
  type        = string
  description = "Display name of the management group"
}

variable "management_group_subscriptions" {
  type        = list(any)
  description = "List of subscriptions housed in the mangement group"
}

variable "dbg_simulate" {
  type        = bool
  default     = true
  description = "DEBUG: simulate creation | default: false | true = simulate creation, false = do not simulate creation"
}