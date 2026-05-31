resource "azurerm_role_assignment" "sb_receiver" {

  scope = azurerm_servicebus_namespace.sb.id

  role_definition_name =
    "Azure Service Bus Data Receiver"

  principal_id =
    azurerm_windows_function_app.func.identity[0].principal_id
}