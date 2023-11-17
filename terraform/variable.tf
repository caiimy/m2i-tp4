# Account Environment
variable "env" {
    type = string
}

# Kubernetes cluster prod name
variable "cluster_name" {
    type = string
}

variable "gcp_user" {
    type = string
    default = "admin"
}

variable "region" {
    type = string
}

variable "zone" {
    type = string
}

variable "project_name" {
    type = string
}