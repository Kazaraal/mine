# provider.tf

terraform {
  required_providers {

    # Provider to build the Jenkins image
    docker      = {
        source      = "kreuzwerker/docker"
        version     = "3.6.2"
    }

    # Provider for the Kubernetes environment
    kubernetes  = {
        source      = "hashicorp/kubernetes"
        version     = ">= 2.0.0"
    }

    # This provider is the best way of managing Kubernetes resources in Terraform,
    # by allowing you to use the thing Kubernetes loves best - yaml!
    kubectl     = {
        source      = "gavinbunney/kubectl"
        version     = "1.19.0"
    }

    # Supports the use of randomness within Terraform configurations. 
    # This is a logical provider, which means that it works entirely within Terraform logic, 
    # and does not interact with any other services.
    random      = {
      source        = "hashicorp/random"
      version       = "3.8.1"
    }
  }
}

provider "docker" {
  host                    = "unix:///var/run/docker.sock"
}

provider "kubernetes" {
  host                    = var.host
  client_certificate      = base64decode(var.client_certificate)
  client_key              = base64decode(var.client_key)
  cluster_ca_certificate  = base64decode(var.cluster_ca_certificate)
}

provider "kubectl" {
  host                    = var.host
  client_certificate      = base64decode(var.client_certificate)
  client_key              = base64decode(var.client_key)
  cluster_ca_certificate  = base64decode(var.cluster_ca_certificate)
}

provider "random" {
  # Configuration options
}