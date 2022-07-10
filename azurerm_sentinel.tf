#----------------------------------------------------------------------------------------
# azurerm_sentinel_data_connector_azure_active_directory
#----------------------------------------------------------------------------------------
resource "azurerm_sentinel_data_connector_azure_active_directory" "main" {
  name                       = "${local.workspaces_prefix}-data-conector-aad"
  log_analytics_workspace_id = azurerm_log_analytics_solution.security-insights.workspace_resource_id
}
