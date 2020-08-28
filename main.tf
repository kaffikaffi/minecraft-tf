resource "azurerm_resource_group" "minecraft" {
  name     = "minecraft-server"
  location = "northeurope"
}
resource "azurerm_container_group" "minecraft" {
  name                = "minecraft"
  location            = azurerm_resource_group.minecraft.location
  resource_group_name = azurerm_resource_group.minecraft.name
  ip_address_type     = "public"
  dns_name_label      = "minecraft-server"
  os_type             = "Linux"
  restart_policy = "Never" 

  container {
    name   = "first-minecraft-azure"
    image = "itzg/minecraft-server"
    cpu = "1"
    memory = "1"


    # Main minecraft port
    ports {
      port     = 25565
      protocol = "TCP"
    } 
    environment_variables = {
      EULA="TRUE" //!IMPORTANT must have to start
    }
  }
}
output "fqdn" {
  value = azurerm_container_group.minecraft.fqdn
}
