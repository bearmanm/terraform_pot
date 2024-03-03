variable "aws_access_key" {
  type = string
  description = "AWS access key"
  sensitive = true
}

variable "aws_secret_key" {
    type = string
    description = "AWS Secret key"
    sensitive = true
}

variable "aws_region" {
    type = string
    description = "AWS Region to use for resources"
    default = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"] # You can provide one "us-east-1" default value or a list [,]  
}

variable "aws_vpc_cidr_block" {
    type = number
    description = "AWS vpc CIDR block address to use for resource"
    default = "10.0.0.0/16"
}

variable "aws_dns_hostname" {
    type = bool
    description = "AWS vpc dns hostname to use for resource"
    default = true
}

variable "aws_subnet_cidr_block" {
    type = string
    description = "AWS public subnet1 cidr range to use for resource"
    default = "10.0.0.0/24"
}

variable "aws_subnet_map_public_ip" {
    type = bool
    description = "AWS public subnet1 map public ip on launch"
    default = true
}

variable "instance_type" {
    type = string
    description = "Type for EC2 Instance"
    default = "t3.micro"
}

variable "company" {
    type = string
    description = "this is the company name for resource tagging"
    default = "Globomantics"
}

variable "project" {
    type = string
    description = "this is the project name for resource tagging"
}

variable "billing_code" {
    type = string
    description = "this is the billing code for resource tagging"
}