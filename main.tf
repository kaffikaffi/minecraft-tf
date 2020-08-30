resource "azurerm_resource_group" "minecraft" {
  name     = "minecraft-server"
  location = "northeurope"
}

resource "azurerm_storage_account" "minecraft" {
  name                     = "ftbstorageborge" //This name should be changed to something relatable
  resource_group_name      = azurerm_resource_group.minecraft.name
  location                 = azurerm_resource_group.minecraft.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}

resource "azurerm_storage_share" "mcdata" {
  name = "mcvolume"
  storage_account_name = azurerm_storage_account.minecraft.name
  quota = 30
}

resource "azurerm_container_group" "minecraft" {
  name                = "minecraft"
  location            = azurerm_resource_group.minecraft.location
  resource_group_name = azurerm_resource_group.minecraft.name
  ip_address_type     = "public"
  dns_name_label      = "minecraft-server"
  os_type             = "Linux"
  restart_policy = "OnFailure" // Always Used in itzg documentation

  container {
    name   = "ftb-azure"
    image = "itzg/minecraft-server:multiarch"
    cpu = "4"
    memory = "16"

    
    ports {
      port     = 25565 //Default mc-port
      protocol = "TCP"
    } 

    volume {
      name = "mc"
      mount_path = "/data" //Structured after the Docker-image
      storage_account_name = azurerm_storage_account.minecraft.name
      storage_account_key = azurerm_storage_account.minecraft.primary_access_key
      share_name = azurerm_storage_share.mcdata.name  
    }

    environment_variables = {
      EULA="TRUE" //!IMPORTANT must have to start
      TYPE="FTBA"
      FTB_MODPACK_ID="11"
      MAX_PLAYERS="5"
      ALLOW_NETHER="true"
      GENERATE_STRUCTURES="true"
      MOTD="Feed The Beast Lite 3 hostet i Azure! <3"
      MEMORY="12G"
    }
  }
}
output "fqdn" {
  value = azurerm_container_group.minecraft.fqdn
}
