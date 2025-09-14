# ✅ Update the values to be used to backend configuration.
# ⚠️ This is pre-requisite to execute the code.
# ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.

resource_group_name  = "rg-backend"                          # Example: "rg-backend"
storage_account_name = "rgbackendtorageaccount"              # Example: "rgbackendtorageaccount"
container_name       = "rgbackendstoragecontainer"           # Example: "rgbackendstoragecontainer"
key                  = "infra01-Infra.terraform.tfstate"     # Example: "infra01.terraform.tfstate"