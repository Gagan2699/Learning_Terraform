provider "azurerm" {
    version = 1.38
    }
 #  OPTIONAL TO CREATE RESOURCE GROUP HERE
 # resource "azurerm_resource_group" "resourcegroup01" {
 # name     = var.resource_group_name
 # location = var.location
 #  }

resource "azurerm_virtual_network" "azvnet" {
  name                = "#####"                     # Unique Network Name
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = "#####"                     # Resource Group Name
}

resource "azurerm_subnet" "subnet" {
  name                 = "#####"                     # Unique Subnet Name
  address_prefix       = "10.0.1.0/24"
  resource_group_name  = "#####"                     # Resource Group Name
  virtual_network_name = "#####"                     # Virtual Network Name
}

resource "azurerm_public_ip" "static" {
  name                = "${var.resource_group_name}-vm-pip"
  location            = "eastus"
  resource_group_name = "#####"                     # Resource Group Name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.resource_group_name}-vm-nic"
  location            = "eastus"
  resource_group_name = "#####"                     # Resource Group Name
  ip_configuration {
    name                          = "primary"
    subnet_id                     = "#####".id                     # Subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "#####".id                     # Static.id
  }
}

resource "azurerm_windows_virtual_machine" "simple-vm" {
  name                = "#####"                                    # Unique Name
  resource_group_name = "#####"                                    # Resource Group Name
  location            = "eastus"
  size                = "Standard_B4ms"
  admin_username      = var.admin_username                         
  admin_password      = var.admin_password

  network_interface_ids = [
    "#####",                                                         # Nic.id
  ]
  os_disk {
    name                 = join("_", [var.vm_name, "OsDisk"])
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-10"
    sku       = "20h1-pro"
    version   = "19041.685.2012032305"
  }
}
