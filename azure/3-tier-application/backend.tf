# These resources are to be created before running "terraform init" 
terraform { 
  backend "azurerm" { 
    resource_group_name       = "dev" 
    storage_account_name      = "dev1tatiana" 
    container_name            = "devcontainer" 
    access_key                = "UIj5ogBZ98tt0xSS0xEFTT7Kljhh3qQDkvEOSz/YpAuZElrJK4Agww+MDLQrd+dhHWR570ZCK5Oz1hGVC5Xy6A==" 
    key                       = "dev_terraform.tfstate" 
  } 
} 