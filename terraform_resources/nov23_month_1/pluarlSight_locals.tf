# Mastering locals.tf
#####################

# add these variables to variable.tf

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
# ======
# create locals.tf and add these keys value pairs inside the block

locals {
  common_tags = {
	company = var.company
	project = "${var.company}-${var.project}"
	billing_code = var.billing_code
  }
}
# ======
# add tags = local.common_tags to main.tf 

# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "app" {
  #cidr_block           = var.aws_vpc_cidr_block
  #enable_dns_hostnames = #var.aws_dns_hostname

  tags = local.common_tags
}
###################################################################################
# Explaination: 

locals {} # block is used to define values that can be used elsewhere in your Terraform configuration. 
# These values are evaluated during the Terraform execution plan phase and can be referenced within the configuration.

# common_tags:
# is the name of the local variable being defined. It is set to a map (a collection of key-value pairs).

# common_tags Map: 
# In this map, there are three key-value pairs. Each key is a string, and each value is an expression.

#common_tags = {
  #company = var.company
  #project = "${var.company}-${var.project}"
  #billing_code = var.billing_code
#}


# company: 
# This key is associated with the value 
# var.company. var.company # is likely a variable passed into the module or root configuration block where this 
# local variable is used. It represents the company name.

# project: 
# This key is associated with an interpolated string 
 #"${var.company}-${var.project}". #This means it concatenates the values of 
 # var.company and var.project # with a hyphen in between. This assumes that both 
# var.company and var.project # are defined as variables elsewhere in your configuration. (yes in the variable.tf below)

# billing_code: 
# This key is associated with the value 
# var.billing_code, # which is another variable. This likely represents the billing code.

# So, in summary, this Terraform code defines a local variable 
# common_tags # that is a map containing three key-value pairs:

# company: # Set to the value of the var.company variable.
# project: # Concatenates the values of var.company and var.project with a hyphen in between.
# billing_code: # Set to the value of the var.billing_code variable.

# The purpose of this local variable is likely to consolidate common tags that may be used across different 
# resources in your Terraform configuration. 
# These tags can be applied to resources like EC2 instances, S3 buckets, or other AWS resources 
# to help organize and manage them.