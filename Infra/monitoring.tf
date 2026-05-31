resource "azurerm_monitor_metric_alert" "function_failures" {

  name                = "function-failures"

  resource_group_name =
    azurerm_resource_group.rg.name

  scopes = [
    azurerm_windows_function_app.func.id
  ]

  criteria {
    metric_namespace =
      "Microsoft.Web/sites"

    metric_name = "Requests"

    aggregation = "Count"

    operator = "GreaterThan"

    threshold = 5
  }
}