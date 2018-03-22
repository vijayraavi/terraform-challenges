resource "azurerm_virtual_network" "vnet" {
    name                = "myTerraformVnet"
    address_space       = [ "10.76.0.0/16" ]
    location            = "${var.region}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    tags                = "${var.tags}
    }
}

resource "azurerm_subnet" "aks" {
    name                 = "aksSubnet"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    address_prefix       = "10.76.2.0/24"
}
