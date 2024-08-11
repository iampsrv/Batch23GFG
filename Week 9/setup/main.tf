provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ami_id" {
  default = "ami-053b0d53c279acc90"
  type    = string
}