resource "azurerm_resource_group" "aci" {
    name        = "${var.rg["aci"]}"
    location    = "${var.region}"
    tags        = "${var.tags}"
}

locals {
    name        = "${azurerm_cosmosdb_account.cosmosdb.name}"
    key         = "${azurerm_cosmosdb_account.cosmosdb.primary_master_key}"
    endpoint    = "${local.name}.documents.azure.com:10255/"
}

resource "azurerm_container_group" "aci-iexcompanies" {
    name                = "iexcompanies"
    location            = "${azurerm_resource_group.aci.location}"
    resource_group_name = "${azurerm_resource_group.aci.name}"
    tags                = "${var.tags}"
    ip_address_type     = "public"
    os_type             = "linux"
    container {
        name = "iexcompanies"
        image = "inklin/iexcompanies"
        cpu ="0.5"
        memory =  "1.5"
        port = "80"

        environment_variables {
            "COSMOSDB"="mongodb://${local.name}:${local.key}@${local.endpoint}?ssl=true&replicaSet=globaldb"
    }
  }
}