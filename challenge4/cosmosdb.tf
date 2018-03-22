resource "azurerm_resource_group" "cosmosdb" {
    name        = "${var.rg["cosmosdb"]}"
    location    = "${var.region}"
    tags        = "${var.tags}"
}

resource "random_id" "cosmosdb" {
    keepers = {
      azi_id = 1
    }

    byte_length = 8
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
    name                = "cosmosdb-${random_id.cosmosdb.hex}"
    location            = "${azurerm_resource_group.cosmosdb.location}"
    resource_group_name = "${azurerm_resource_group.cosmosdb.name}"
    tags                = "${var.tags}"
    offer_type          = "Standard"
    kind                = "MongoDB"
  
    consistency_policy {
        consistency_level = "Session"
    }

    failover_policy {
        location = "${var.failover[0]}"
        priority = 0
    }

    failover_policy {
        location = "${var.failover[1]}"
        priority = 1
    }
}
