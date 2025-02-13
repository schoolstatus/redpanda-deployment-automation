## we assume a default vpc. if you have one you want to use you will need to provide a vpc and subnet ID

module "redpanda-cluster" {
  source                   = "redpanda-data/redpanda-cluster/aws"
  version                  = "~> 0.1"
  public_key_path          = var.public_key_path
  nodes                    = var.nodes
  deployment_prefix        = var.deployment_prefix
  enable_monitoring        = var.enable_monitoring
  tiered_storage_enabled   = var.tiered_storage_enabled
  allow_force_destroy      = var.allow_force_destroy
  vpc_id                   = var.vpc_id
  distro                   = var.distro
  hosts_file               = var.hosts_file
  tags                     = var.tags
  aws_region               = var.aws_region
  associate_public_ip_addr = var.associate_public_ip_addr
  subnet_id                = var.subnet_id
  availability_zone        = var.availability_zone
}

variable "availability_zone" {
  default = ["us-west-2a"]
  type    = list(string)
}

variable "associate_public_ip_addr" {
  default = true
  type    = bool
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "nodes" {
  type    = number
  default = 3
}

variable "deployment_prefix" {
  type    = string
  default = "test-rp-cluster"
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

variable "tiered_storage_enabled" {
  type    = bool
  default = false
}

variable "allow_force_destroy" {
  type    = bool
  default = false
}
variable "vpc_id" {
  description = "only set when you are planning to provide your own network rather than using the default one"
  type        = string
  default     = ""
}

variable "distro" {
  type    = string
  default = "ubuntu-focal"
}

variable "hosts_file" {
  type    = string
  default = "hosts.ini"
}

variable "tags" {
  type    = map(string)
  default = {}
}

terraform {
  required_version = ">=0.12"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

variable "subnet_id" {
  default = ""
  type    = string
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

provider "aws" {
  region = var.aws_region
}
