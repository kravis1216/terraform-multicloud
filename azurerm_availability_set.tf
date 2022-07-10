#----------------------------------------------------------------------------------------# Availability Sets#----------------------------------------------------------------------------------------resource "azurerm_availability_set" "rdsgateway-as" {  name                = "${local.as_prefix}-rdsgateway-as"  location            = var.region  resource_group_name = azurerm_resource_group.main.name  managed             = true}#----------------------------------------------------------------------------------------
# Availability Sets
#----------------------------------------------------------------------------------------
resource "azurerm_availability_set" "rdsgateway-as" {
  name                = "${local.as_prefix}-rdsgateway-as"
  location            = var.region
  resource_group_name = azurerm_resource_group.main.name
  managed             = true
}
