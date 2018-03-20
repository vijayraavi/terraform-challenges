variable "rg" {
    type = "map"

    default = {
        cosmosdb = "challenge3-cosmosdb"
        aci = "challenge3-aci"
    }
}

variable "region" {
    type = "string"
    default = "West Europe"
}

variable "failover" {
    default = [ "East US", "Central India" ]
}

variable "tags" {
    type = "map"

    default = {
        environment = "test"
        description = "Technical Depth"
    }
}
