provider "aws" {
  region = "us-east-1"
}

# terraform {
#   cloud {
#     organization = "gfgbatchninteen"

#     workspaces {
#       name = "ps-wp"
#     }
#   }
# }


# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "gfgbatchninteen"

    workspaces {
      name = "gfgws"
    }
  }
}

resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  tags = {
    Name = "myec2instance"
  }
}

variable "ami" {
  type    = string
  default = "ami-04b70fa74e45c3917"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

module "myec2modulenewpub" {
  source  = "iampsrv/batch19tfmod/pranjal"
  version = "1.0.0"
  instance_type_mod="t3.micro"
  ami_id_mod="ami-053b0d53c279acc90"
  name="myec2newpublishmod1"
  name_sg = "mynewsgmod1"
  # insert the 4 required variables here
}