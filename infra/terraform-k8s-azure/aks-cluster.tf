# -----------------------------------
# Creates the Resource Group
# -----------------------------------
resource "azurerm_resource_group" "default" {
  name     = "${var.PROJ_OWNER}-rg"
  location = var.CLOUD_REGION

  tags = {
    environment = var.PROJ_ENV_TAG
    project     = var.PROJ_NAME
  }
}

# ------------------------------------
# Creates AKS Cluster inside the RGroup
# ------------------------------------
resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.PROJ_OWNER}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.PROJ_OWNER}-k8s"
  kubernetes_version = "1.24.10"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "standard_a2_v2" # 2 cpu/ 4 GB
    # vm_size         = "standard_ds2_v2" # 2 cpu/ 7 GB
    # os_disk_size_gb = 30
  }

  # identity {} or service_principal {}, one must be defined
  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = var.PROJ_ENV_TAG
    project     = var.PROJ_NAME
  }
}
