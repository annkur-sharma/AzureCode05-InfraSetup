# ✅ Update the values to be used to backend configuration.
# ⚠️ This is pre-requisite to execute the code.
# ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.

resource_group_name  = <<ENTER backend - Resource Group>>           # Example: "rg-backend"
storage_account_name = <<ENTER backend - Storage Account>>          # Example: "rgbackendtorageaccount"
container_name       = <<ENTER backend - Storage Container Name>>   # Example: "rgbackendstoragecontainer"
key                  = <<ENTER backend - State File Name>>          # Example: "infra01.terraform.tfstate"