/****************************************************
        Azure Resource Group Creation
 ***************************************************/
resource "azurerm_resource_group" "az-rg" {
  name     = var.rg_name
  location = var.location
}

/****************************************************
        Azure Network Security Group (NSG)
 ***************************************************/

resource "azurerm_network_security_group" "az-nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.az-rg.location
  resource_group_name = azurerm_resource_group.az-rg.name
}

/***************************************************
       Azure Virtual Network and Subnet 
 **************************************************/

resource "azurerm_virtual_network" "az-vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.az-rg.location
  resource_group_name = azurerm_resource_group.az-rg.name
  address_space       = [var.cidr_range["vpc_cidr"]]


  tags = var.tags
}

/**************************************************
       Azure Subnet
 *************************************************/

resource "azurerm_subnet" "az-subnet" {
  name                 = "servin-subnet-1"
  resource_group_name  = azurerm_resource_group.az-rg.name
  virtual_network_name = azurerm_virtual_network.az-vnet.name
  address_prefixes     = [var.cidr_range["subnet_cidr"]]

}

/*************************************************
        Azure Public Ip
 ************************************************/

resource "azurerm_public_ip" "az-pip" {
  name                    = "servian-pip"
  location                = azurerm_resource_group.az-rg.location
  resource_group_name     = azurerm_resource_group.az-rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = var.tags
}

/*********************************************
       Azure Network Interface
 ********************************************/

resource "azurerm_network_interface" "az-vm-nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.az-rg.location
  resource_group_name = azurerm_resource_group.az-rg.name

  ip_configuration {
    name                          = "ipconfiguration1"
    subnet_id                     = azurerm_subnet.az-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.az-pip.id
}
}

/*********************************************
       Azure Virtual Machine
 ********************************************/
resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.az-rg.location
  resource_group_name   = azurerm_resource_group.az-rg.name
  network_interface_ids = [azurerm_network_interface.az-vm-nic.id]
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
   delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
   delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.vm_image["publisher"]
    offer     = var.vm_image["offer"]
    sku       = var.vm_image["sku"]
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = "admin101"
    admin_password = var.vm_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
   provisioner "remote-exec" {
    script = "servian.sh"
    connection {
      type     = "ssh"
      host     = azurerm_public_ip.az-pip.id
      user     = "admin101"
      password = var.vm_password
    }

  }
  tags = var.tags
}
