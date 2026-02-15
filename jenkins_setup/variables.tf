# variables.tf

variable "environment" {
  description   = "Environment name (dev, staging, prod)"
  type          = string
  default       = "dev"
}

variable "pvc_storage_size" {
  description = "Storage size for Jenkins PVC"
  type        = string
  default     = "10Gi"
}

variable "pv_storage_size" {
  description = "Storage size for Persistent Volume"
  type        = string
  default     = "30Gi"
}

variable "host" {
  type        = string
}

variable "client_certificate" {
  type        = string
}

variable "client_key" {
  type        = string
}

variable "cluster_ca_certificate" {
  type        = string
}

variable "mounted_logical_volume" {
  type        = string
}

variable "docker_registry" {
  type        = string
  default     = "https://index.docker.io/v1/"
}

variable "dockerhub_username" {
  type        = string
  sensitive   = true
  description = "Docker Hub username or organization name"
}

variable "dockerhub_password" {
  description = "Docker Hub personal access token"
  type        = string
  sensitive   = true
}

variable "git_username" {
  type        = string
  sensitive   = true
  description = "Git username for repository access"
  default     = ""
}

variable "git_password" {
  type        = string
  sensitive   = true
  description = "Git password/token for repository access"
  default     = ""
}

# New variable for additional JCasC configuration
variable "additional_casc_config" {
  type        = string
  description = "Additional JCasC configuration in YAML format"
  default     = ""
}