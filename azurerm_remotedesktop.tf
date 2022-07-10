# Generate randon name for the Windows VM
resource "random_string" "random-win-vm" {
  length  = 8
  special = false
  lower   = true
  upper   = false
  # number  = true
}

resource "azurerm_virtual_network" "rds" {
  name                = "${local.vnet_prefix}-rds"
  address_space       = ["10.0.0.0/16"]
  location            = var.region
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "rds" {
  name                 = "${local.snet_prefix}-internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.rds.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Get a Static Public IP for the Windows VM
resource "azurerm_public_ip" "windows-vm-ip" {
  name                = "win-${random_string.random-win-vm.result}-vm-ip"
  location            = var.region
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  depends_on = ["azurerm_public_ip.windows-vm-ip"]

  name                = "${local.nic_prefix}-main"
  location            = var.region
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.rds.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows-vm-ip.id
  }
}

resource "azurerm_windows_virtual_machine" "main" {
  name                  = "${local.vm_prefix}-vm"
  location              = var.region
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = "Standard_B2s"

  computer_name  = "win-${random_string.random-win-vm.result}-vm"
  admin_username = var.windows_admin_username
  admin_password = var.windows_admin_password

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  #delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  #delete_data_disks_on_termination = true

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows_2016_sku
    version   = "latest"
  }

  os_disk {
    name                 = "win-${random_string.random-win-vm.result}-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  enable_automatic_updates = true
  provision_vm_agent       = true

  tags = {
    environment = "staging"
  }
}
