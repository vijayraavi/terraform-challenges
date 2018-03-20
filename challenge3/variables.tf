variable "rg" {
    type = "map"

    default = {
        cosmosdb = "challenge3-cosmosdb"
        aci = "challenge3-aci"
    }
}

variable "region" {
    default = "West Europe"
}

variable "failover" {
    # Two regions expected in the list
    default = [ "East US", "Central India" ]
}

variable "tags" {
    type = "map"

    default = {
        environment = "test"
        description = "Technical Depth"
    }
}
