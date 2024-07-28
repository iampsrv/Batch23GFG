provider "aws" {
  region = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

terraform {
  cloud {
    organization = "gfgbatchninteen"

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

# module "myec2modulepub" {
#   source  = "iampsrv/myec2module/pranjal"
#   version = "1.0.0"
#   instance_type_mod="t2.micro"
#   ami_id_mod="ami-053b0d53c279acc90"
#   name="myec2publishmod"
#   name_sg = "mysgmod"
#   # insert the 4 required variables here
# }

module "myec2modulenewpub" {
  source  = "iampsrv/batch19tfmod/pranjal"
  version = "1.0.0"
  instance_type_mod="t3.micro"
  ami_id_mod="ami-053b0d53c279acc90"
  name="myec2newpublishmod"
  name_sg = "mynewsgmod"
  # insert the 4 required variables here
}
