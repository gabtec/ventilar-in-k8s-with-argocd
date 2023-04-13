provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.default.kube_config.0.host
  # username               = azurerm_kubernetes_cluster.default.kube_config.0.username
  # password               = azurerm_kubernetes_cluster.default.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubectl"
    args        = ["create", "namespace", "argocd"]
  }

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubectl"
    args        = ["apply", "-n", "argocd", "-f", "https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"]
  }

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubectl"
    args        = ["patch", "service", "argocd-server", "-n", "argocd", "-p", "'{\"spec\": {\"type\": \"LoadBalancer\"}}'"]
  }

}