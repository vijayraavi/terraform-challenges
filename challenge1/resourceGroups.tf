resource "azurerm_resource_group" "rg" {
    name = "${var.rg}"
    location = "${var.region}"

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}