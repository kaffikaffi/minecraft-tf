resource "azurerm_resource_group" "minecraft" {
  name     = "minecraft-server"
  location = "UK South"
}

resource "azurerm_storage_account" "minecraft" {
  name                     = "mymcstorage"
  resource_group_name      = azurerm_resource_group.minecraft.name
  location                 = azurerm_resource_group.minecraft.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_share" "mcdata" {
  name = "mcvolume"
  storage_account_name = azurerm_storage_account.minecraft.name
  quota = 30 //How big the storage is
}

resource "azurerm_container_group" "minecraft" {
  name                = "minecraft"
  location            = azurerm_resource_group.minecraft.location
  resource_group_name = azurerm_resource_group.minecraft.name
  ip_address_type     = "public"
  dns_name_label      = "minecraft-server"
  os_type             = "Linux"
  restart_policy = "OnFailure" // "Always" Used in itzg documentation

  container {
    name   = "minecraft-server-tf-az"
    image = "itzg/minecraft-server"
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
      MAX_PLAYERS="10"
      TYPE="PAPER"
      ALLOW_NETHER="true"
      GENERATE_STRUCTURES="true"
      DIFFICULTY="hard"
      OPS="DrMais" //Admins on the server
      ICON="https://dreyerdigital.com/profile-pic.d8d9cd59.jpeg" //Image beside server in MC
      MOTD="Minecraft hostet i Azure <3"
      VIEW_DISTANCE="10"
      MEMORY="14G"
    }
  }
}
output "fqdn" {
  value = azurerm_container_group.minecraft.fqdn
}
