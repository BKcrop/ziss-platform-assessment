resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.environment}"

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

  sku                 = "PerGB2018"
}

resource "azurerm_application_insights" "appi" {

  name                = "appi-${var.environment}"

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

  workspace_id        = azurerm_log_analytics_workspace.law.id

  application_type    = "web"
}