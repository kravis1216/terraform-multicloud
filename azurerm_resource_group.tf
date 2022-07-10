resource "azurerm_resource_group" "main" {
  name     = "${local.rg_prefix}-main"
  location = var.region
}

resource "azurerm_resource_group" "rdsgateway" {
  name     = "${local.rg_prefix}-rdsgateway"
  location = var.region
}

resource "azurerm_resource_group" "siem" {
  name     = "${local.rg_prefix}-siem"
  location = var.region
}
