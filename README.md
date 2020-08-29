# minecraft-tf
This repo is for generating a minecraft-server using Terraform with Azure.  

## Requirements

```
Azure CLI
Terraform
```
[Azure CLI installation](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)  
[Terraform installation](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Installing


Clone the repo

```
git clone git@github.com:kaffikaffi/minecraft-tf.git
cd minecraft-tf
```

Generate variable file

```
touch terraform.tvars
```
Paste the text below in  `terraform.tvars`, and replace the values with your Azure info   To generate this info you need to make a [Service Principal](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html).<b> DO NOT PUSH THIS FILE TO GITHUB! So make sure it is mentioned in your `.gitignore` file </b>


```
subscription_id = "XXX XXX XXX XXX XXX"
client_id = "XXX XXX XXX XXX XXX"
client_secret = "XXX XXX XXX XXX XXX"
tenant_id  = "XXX XXX XXX XXX XXX"
```

End with an example of getting some data out of the system or using it for a little demo

## Deploy and make it live!

Log in to Azure

```
az login
```
If you have made changes to the terraform version or Azurerm version etc. Make sure to run

```
terraform init
```

Now you can check the resources that is going to be made in Azure with the command

```
terraform plan
```
To make terraform setup the plan on your Azure-account, run the command

```
terraform apply
```

## Nice to know
The minecraft server is based on the docker-image [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server). Which always downloads the newest stable version of minecraft-server. Checkout their [documentation](https://github.com/itzg/docker-minecraft-server/blob/master/README.md) on github to understand more of how you can control your server etc.