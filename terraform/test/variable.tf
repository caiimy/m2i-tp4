# Account Environment
variable "env" {
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

variable "project_name_id" {
    type = string
}

variable "credentials_file" { }