### variables.tf ###
# ------------------
# list
variable "aws_region" {
    type = string
    description = "AWS Region to use for resources"
    default = "us-east-1" # You can provide one "us-east-1" default value or a list [,]  
}
# to refer to value stored in the key value pair default = var.regions[0] 
# ------------------
# map 
variable "aws_instance_size" { 
  type        = map(string)
  description = "instance resource size"
  default     = {
    small     = "t2.micro"
    medium    = "t2.small"
    large     = "t2.large"
  }
}
# to refer to value stored in the key value pair default (there are two ways)
# var.aws_instance_sizes["small"] or var.aws_instance_sizes.small
# -------------------
# resource_tags
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

variable "aws_vpc_cidr_block" {
    type = number
    description = "AWS vpc CIDR block address to use for resource"
}

variable "aws_dns_hostname" {
    type = bool
    description = "AWS vpc dns hostname to use for resource"
    default = true
}

### locals.tf ###
# ------------------
locals {
  resource_tags = {
	company = var.company
	project = "${var.company}-${var.project}"
	billing_code = var.billing_code
  }
}
 
resource "aws_vpc" "app" {
  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_hostnames = var.aws_dns_hostname
  tags = local.resource_tags
}
# for this exapmle: use locals to store values which are referenced in the aws resource "aws_vpc" below e.g. tags = local.resource_tags
resource "aws_instance" "ec2" {
  instance_type          = var.aws_instance_sizes["small"]
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  tags = merge(
    { Name = "${var.company}-${var.project}-${var.billing_code}-node1-ec2" },
  local.resource_tags)
}
# in this example you can merge the tags to create a name label for the resource

### outputs.tf ###
# ------------------  
