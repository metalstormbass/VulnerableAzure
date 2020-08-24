#Provision AKS cluster in Azure

resource "azurerm_kubernetes_cluster" "vuln_k8_cluster" {
  name                = "${var.victim_company}-kubecluster"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  dns_prefix          = "${var.victim_company}-k8"

  default_node_pool {
    name       = "default"
    node_count = var.nodecount
    vm_size    = "Standard_D2_v2"
  }

 service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"     # Options are calico or azure - only if network plugin is set to azure
    dns_service_ip     = "172.16.0.10" # Required when network plugin is set to azure, must be in the range of service_cidr and above 1
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "172.16.0.0/16" # Must not overlap any address from the VNEt
  }

  lifecycle {
    ignore_changes = [
      windows_profile,
    ]
 }
}



#Authenticate to Terraform Kubernetes Module

#Provider for K8, used after built
provider "kubernetes" {
    host                   = azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.cluster_ca_certificate)
    load_config_file = false
}


#Perform Configuration on K8 cluster itself



resource "kubernetes_namespace" "vulnk8" {
  metadata {
    name                   = "vulnk8"
  }
}


resource "kubernetes_deployment" "vuln-k8-deployment" {
  metadata {
    name                   = "vulnk8"
    namespace              = kubernetes_namespace.vulnk8.metadata.0.name
    labels                 = {
      app                  = "vulnk8"
    }
  }

  spec {
    replicas               = 2

    selector {
      match_labels         = {
        app                = "vulnk8"
      }
    }

    template {
      metadata {
        labels             = {
          app              = "vulnk8"
        }
      }

      spec {
        container {
          image            = "yonatanph/logicdemo:latest"
          name             = "user-app"
          port {
            container_port = "80"
          }
          security_context {
            capabilities {
              add          = ["SYS_ADMIN"]
            }
          }
        }
      }
    }
  }

}


resource "kubernetes_service" "vuln-k8-service" {
  metadata {
    name                   = "vulnk8"
    namespace              = kubernetes_namespace.vulnk8.metadata.0.name
  }
  spec {
    selector               = {
      app                  = "vulnk8"
    }
    port {
      port                 = 80
    }

    type                   = "LoadBalancer"
  }
}
