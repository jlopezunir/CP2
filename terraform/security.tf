# Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "mySecGroup" {
    name                = "sshtraffic"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

        security_rule {
        name                       = "NodePort MySQL"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "30036"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation1" {
    network_interface_id      = azurerm_network_interface.vm1_NIC.id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id

}
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation2" {
    network_interface_id      = azurerm_network_interface.vm2_NIC.id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id
}
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation3" {
    network_interface_id      = azurerm_network_interface.vm3_NIC.id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id
}
