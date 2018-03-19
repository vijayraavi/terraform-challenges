resource "azurerm_resource_group" "vm" {
        name = "${var.resourceGroup}"
        location = "${var.region}"
}
