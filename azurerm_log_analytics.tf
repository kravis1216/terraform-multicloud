#----------------------------------------------------------------------------------------
# azurerm_log_analytics_workspace
#----------------------------------------------------------------------------------------
resource "azurerm_log_analytics_workspace" "siem" {
  name                = "${local.workspaces_prefix}-siem"
  location            = var.region
  resource_group_name = azurerm_resource_group.siem.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#----------------------------------------------------------------------------------------
# azurerm_log_analytics_solution
#----------------------------------------------------------------------------------------
resource "azurerm_log_analytics_solution" "security-insights" {
  #solution_name         = "${local.workspaces_prefix}-security-insights"
  solution_name         = "SecurityInsights"
  location              = var.region
  resource_group_name   = azurerm_resource_group.siem.name
  workspace_resource_id = azurerm_log_analytics_workspace.siem.id
  workspace_name        = azurerm_log_analytics_workspace.siem.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}
