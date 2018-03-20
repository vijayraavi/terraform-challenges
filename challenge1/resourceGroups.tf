resource "azurerm_resource_group" "vm" {
    name = "${var.rg}"
    location = "${var.region}"

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}