variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "ami_id" {
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "nv-lap"
}