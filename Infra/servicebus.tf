resource "azurerm_servicebus_namespace" "sb" {
  name                = var.servicebus_namespace_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku = "Basic"
}

resource "azurerm_servicebus_queue" "workqueue" {
  name         = "workqueue"
  namespace_id = azurerm_servicebus_namespace.sb.id

  max_delivery_count = 10
}