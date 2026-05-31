resource "azurerm_service_plan" "plan" {

  name                = "plan-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "Y1"
}


resource "azurerm_windows_function_app" "func" {

  name                = var.function_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_key = azurerm_application_insights.appi.instrumentation_key
  }

  app_settings = {
  FUNCTIONS_WORKER_RUNTIME = "dotnet-isolated"
  WEBSITE_RUN_FROM_PACKAGE = "1"

  WorkQueueName = "workqueue"

  ServiceBusConnection = var.servicebus_connection_string
}
}