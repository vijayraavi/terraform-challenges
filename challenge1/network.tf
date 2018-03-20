resource "azurerm_virtual_network" "vnet" {
    name                = "myTerraformVnet"
    address_space       = [ "10.76.0.0/16" ]
    location            = "${var.region}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}

resource "azurerm_subnet" "vm" {
    name                 = "vmSubnet"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    address_prefix       = "10.76.1.0/24"
}

resource "azurerm_public_ip" "vm" {
    name                         = "${var.vmname}-pip"
    location                     = "${var.region}"
    resource_group_name          = "${azurerm_resource_group.rg.name}"
    public_ip_address_allocation = "dynamic"

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}

resource "azurerm_network_security_group" "linux" {
    name                = "linuxNSG"
    location            = "${var.region}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    ;
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}