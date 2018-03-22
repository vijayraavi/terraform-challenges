variable "rg" {
    type = "map"
    default = {
        cosmosdb = "challenge4-cosmosdb"
        aks = "challenge4-aks"
    }
}

variable "region" {
    default = "West Europe"
}

variable "failover" {
    # Two regions expected in the list
    default = [ "West Europe", "East US" ]
}

variable "tags" {
    type = "map"
    default = {
        environment = "test"
        description = "Technical Depth"
    }
}
