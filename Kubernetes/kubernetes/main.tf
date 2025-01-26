terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "web_page" {
  metadata {
    name = "web-page-new"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "web-page-new"
      }
    }

    template {
      metadata {
        labels = {
          app = "web-page-new"
        }
      }

      spec {
        container {
          image = "didamendes/conversao-temperatura:v1"
          name  = "web-page-new"
        }
      }
    }
  }
}

resource "kubernetes_service" "web_page_service" {
  metadata {
    name = "web-page-new"
  }

  spec {
    selector = {
      app = kubernetes_deployment.web_page.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 8080
      target_port = 80
    }
    type = "NodePort"
  }
}