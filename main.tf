terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
    region = "ap-northeast-1"
#    zone = "ap-northeast-1c"
}

data "aws_subnet" "subnet1" {
  availability_zone = "ap-northeast-1c"
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.subnet1.id
#  count = var.instance_count
}

variable "ami_id" {
    default = "ami-0f36dcfcc94112ea1"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "instance_count" {
    default = 1
}

output "print_ip" {
    value = aws_instance.web.public_ip
}
