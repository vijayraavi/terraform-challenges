resource "azurerm_network_interface" "vm" {
    name                = "${var.vmname}-nic"
    location            = "${var.region}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.linux.id}"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "${azurerm_subnet.vm.id}"
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          = "${azurerm_public_ip.vm.id}"
    }

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}

resource "azurerm_virtual_machine" "myterraformvm" {
    name                  = "${var.vmname}"
    location              = "${var.region}"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.vm.id}"]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "${var.vmname}-OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "${var.vmname}"
        admin_username = "azureuser"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDN90ltVHrYyg97SWMYwKnX6QeOYUk4qhmNS3/dUDf/VEvoSOpwRsMehRCq+hgPwtLBw/pc664djdsERRd6SmGXuivq1vqLMSH4FQVW1hrizPT8jX4iCddm2KGyguDtmObvUGgi0YqMiRMXiiZ7AX6IMyHWFIO5slM369yMkK1MzLgwCVuu+VzxbrVyWsLon/iUdyqgLDq7pxSL5kCxk1YoySGCkwygOKxGTh77bd/y1/t+5uJmKtAxDMD6M7Azsh+NoMSPTQtxoJNq+exIQKz9D+cnGmIifjoKPe+Lh7mUm2CLcNH2TLM9y9S46ybWyO1urr8oIz6WgcyKzAlcP6IX"
        }
    }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.diagstorage.primary_blob_endpoint}"
    }

    tags = {
        environment = "test"
        description = "Technical Depth"
    }
}