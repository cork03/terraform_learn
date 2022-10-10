terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}

resource "aws_instance" "hello-world" {
  ami           = "ami-078296f82eb463377"
  instance_type = "t2.nano"
  tags = {
    "Name" = "hello world"
  }
}

variable "project" {
  type = string
}

variable "enviroment" {
  type = string
}
