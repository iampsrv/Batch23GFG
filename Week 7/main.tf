provider "aws" {
  region = "us-east-1"
}


terraform {
  cloud {
    organization = "gfgbatch12"

    workspaces {
      name = "ps-wp"
    }
  }
}

variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}


# module "myec2module" {
#   source = "./myec2module"
#   instance_type_mod="t2.micro"
#   ami_id_mod="ami-053b0d53c279acc90"
#   name="myec2mod"
#   name_sg = "mysgmod"
# }

# module "myec2module" {
#   source  = "iampsrv/myec2module/pranjal"
#   version = "1.0.0"
#   instance_type_mod="t2.micro"
#   ami_id_mod="ami-053b0d53c279acc90"
#   name="myec2publishmod"
#   name_sg = "mysgmod"
#   # insert the 4 required variables here
# }

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.0.2"
#     }
#   }

#   required_version = ">= 1.1.0"
# }

