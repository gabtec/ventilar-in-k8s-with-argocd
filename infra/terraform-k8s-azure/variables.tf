# --------------------------------
# Login Variables Definitions
# --------------------------------
variable "appId" {
  description = "AKS Cluster service principal"
  type        = string
  sensitive   = true
  default     = ""
}

variable "password" {
  description = "AKS Cluster password"
  type        = string
  sensitive   = true
  default     = ""
}

# --------------------------------
# Infra Variables Definitions
# --------------------------------
variable "CLOUD_REGION" {
  description = "The region/location of the cloud provider resources"
  type        = string
  default     = "westeurope"
}

variable "PROJ_OWNER" {
  description = "A name to prefix resources"
  type        = string
  default     = "gabtec"
}

variable "PROJ_NAME" {
  description = "The name of the project"
  type        = string
  default     = "project-alpha"
}

variable "PROJ_ENV_TAG" {
  description = "A tag for the resources"
  type        = string
  default     = "demo"
}