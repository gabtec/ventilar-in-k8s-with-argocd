# Ventilar App deployed in K8S with ArgoCD

This is a learning project.
**It may have costs, associated with cloud kubernetes clusters**

## Automations

It's intended that this is fully automated:

1. **On** commits to infra/ main branch --> will deploy a k8s in a cloud provider using terraform

2. **On** commits to frontend/ main branch --> will deploy the app in the k8s cluster. This will be accomplished in steps:
   **2.1.** Github actions will run tests and on success will build a container image (with a unique tag)
   **2.2.** ArgoCD, running in k8s cluster, will detect the new image, pull it and deploy the new version of the app

3. **On** commits to backend/ main branch --> will behave like in step 2

## Requirements

The credentials to terraform connect to the cloud provider, must be set in **github secrets**. Also the container registry credentials, to upload new images.

### 1. Setup Terraform backend

To have a central location to store this project tfstate file, we need to setup a terraform backend {} block.
With this we will be able to deploy terraform scripts in CD pipelines (state is pulled to the runner, tf executes, updates the state in remote location, and then the runner is destroyed).

Since we are using Azure Cloud, the backend will also be in azure.
Check my other repo "/projects/tf-azure-storage-for-terraform-backend/terraform"

```sh
# Update the main.tf file with the backend block
terraform {
  # terraform version
  required_version = ">= 1.4.0"

  backend "azurerm" {
   # the resource group name, where the storage exists
   resource_group_name  = "tfstate-rg"
   # the storage account name, where the storage container exists
   storage_account_name = "tfstatefoobar"
   # the storage container name, where the file will be saved
   container_name       = "tfstate"
   # the desired name for the tfstate file (e.g "prod.terraform.tfstate")
   key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {...}
  }
}
```

### 2. Create an Azure Service Principal for Github to use with terraform

```sh
# get my account sub id
$ az account list

# create SP
$ az ad sp create-for-rbac --name "github-tf-2023-04-13-11-00-00" --role="Contributor" --scopes="/subscriptions/20000000-0000-0000-0000-000000000000"

# from the output, create your github project repo, secrets
## AZ_AD_CLIENT_ID = appId
## AZ_AD_CLIENT_SECRET = password
## AZ_AD_TENANT_ID = tenant
## AZ_SUBSCRIPTION_ID = your_subs_id

# next --> create a github action...
```

---

### 3. Connect to the created AKS Cluster

```sh
# this will merge the kubeconfig file with our local ~/.kube/config
$ az aks get-credentials --resource-group gabtec-rg --name gabtec-aks

# test it
$ kubectl get nodes
```

### 4. Hard delete

```sh
# deleting the Azure resource group will delete the cluster
$ az group delete --name gabtec-rg --yes --no-wait

# (SOS) Also delete the resource group that has the TF backend storage
```

# END

**Don't forget to delete all cloud resources created, to avoid unexpected $costs**

---
