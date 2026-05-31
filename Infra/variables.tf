variable "environment" {
  type      = string
}
variable "location" {
  type      = string
}

variable "resource_group_name" {
  type      = string
}

variable "servicebus_namespace_name" {
  type      = string
}

variable "function_app_name" {
  type      = string
}

variable "storage_account_name" {
  type      = string
}

variable "keyvault_name" {
  type      = string
}

variable "apim_name" {
  type      = string 
}

variable "servicebus_connection_string" {
  type      = string
  sensitive = true
}