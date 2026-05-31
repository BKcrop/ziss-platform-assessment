resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "Platform Assessment"
  publisher_email     = "test@test.com"
  sku_name = "Consumption_0"
}

resource "azurerm_api_management_api" "function_api" {
  name                = "work-api"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision = "1"
  display_name = "Work API"
  path = "work"
  protocols = ["https"]
}


resource "azurerm_api_management_api" "function_api" {
name = "work-api"
resource_group_name = azurerm_resource_group.rg.name
api_management_name = azurerm_api_management.apim.name
revision = "1"
display_name = "Work API"
path = "work"
protocols = ["https"]
}


resource "azurerm_api_management_api_operation" "health_live" {
operation_id = "health-live"
api_name = azurerm_api_management_api.function_api.name
api_management_name = azurerm_api_management.apim.name
resource_group_name = azurerm_resource_group.rg.name
display_name = "Health Live"
method = "GET"
url_template = "/health/live"
response {
status_code = 200
}
}

resource "azurerm_api_management_api_operation" "health_ready" {
operation_id = "health-ready"
api_name = azurerm_api_management_api.function_api.name
api_management_name = azurerm_api_management.apim.name
resource_group_name = azurerm_resource_group.rg.name
display_name = "Health Ready"
method = "GET"
url_template = "/health/ready"
response {
status_code = 200
}
}

resource "azurerm_api_management_api_operation" "get_work" {
operation_id = "get-work"
api_name = azurerm_api_management_api.function_api.name
api_management_name = azurerm_api_management.apim.name
resource_group_name = azurerm_resource_group.rg.name
display_name = "Get Work"
method = "GET"
url_template = "/work"
response {
status_code = 200
}
}

resource "azurerm_api_management_api_operation" "post_work" {
operation_id = "post-work"
api_name = azurerm_api_management_api.function_api.name
api_management_name = azurerm_api_management.apim.name
resource_group_name = azurerm_resource_group.rg.name
display_name = "Post Work"
method = "POST"
url_template = "/work"
response {
status_code = 202
}
}