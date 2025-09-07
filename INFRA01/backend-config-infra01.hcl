# ✅ Update the values to be used to backend configuration.
# ⚠️ This is pre-requisite to execute the code.
# ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.

resource_group_name  = "ankur02backendrg"                        # Example: "rg-backend"
storage_account_name = "ankur02storage01a1"                      # Example: "rgbackendtorageaccount"
container_name       = "ankur02storage01a1container"             # Example: "rgbackendstoragecontainer"
key                  = "AzureCode05-Infra.terraform.tfstate"     # Example: "infra01.terraform.tfstate"