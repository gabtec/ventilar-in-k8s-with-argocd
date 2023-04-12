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
