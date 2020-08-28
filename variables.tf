provider "azurerm"{
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id  = var.tenant_id
    version = "=2.5.0"
    features {}
}

variable "subscription_id"{
    description = "Enter subscription ID for provisioning resources in Azure"
}
variable "client_id"{
    description = "Enter Client ID for Application created in Azure AD"
}
variable "client_secret"{
    description = "Enter Client Secret for Application created in Azure AD"
}
variable "tenant_id"{
    description = "Enter Tenant ID / Direcory ID of our Azure AD "
}