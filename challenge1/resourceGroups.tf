resource "azurerm_resource_group" "vm" {
    name = "${var.resourceGroup}"
    location = "${var.region}"

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}