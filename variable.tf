// Provider
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

variable "mg_structure" {
  type = map
  description = <<EOF
    A map how the tree of management groups should look like. 
    
    Root Manamgenet Group has to be an ID!
    
    Example: "123412aa-aaaa-11111-1234567890aa" = 
        {"parent_management_group_name" = ["child_management_group_name"]
    }
  EOF
}

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
  default     = false
  description = <<EOF
    DEBUG: simulate creation 
    default: false
    Explanation: true = simulate creation, false = do not simulate creation"
}
