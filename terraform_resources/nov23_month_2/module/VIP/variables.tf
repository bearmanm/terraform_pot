#######################
## Environment
#######################

variable "aws_region" { # var.aws_region
  type        = string
  description = "aws_region used for this deployment"
  default     = "eu-west-2"
}

variable "AccountNumber" {
  description = "AWS account number"
  type        = string
  default     = "269632189206"
}

# This block defines a validation rule for the "environment" variable. 
# It checks whether the value provided for the variable (var.environment) is contained within the specified list ["dev", "nprd", "prod"]. 
# If the condition is not met, it will display the error message specified.
variable "environment" { # var.environment
  type        = string
  description = "environment this deployment is in"
  validation {
    condition     = contains(["dev", "nprd", "prod"], var.environment)
    error_message = "Valid values for var: environment are (dev, nprd, prod)."
  }
}

########################
## Tagging 
########################
variable "territory" { # var.territory
  type        = string
  description = "territory used for this resource"
  default     = "uk"
}

variable "billing_team" { # var.billing_team
  type        = string
  description = "billing_team identified for use of resources"
  default     = "cti"
}

variable "department" { # var.department
  type        = string
  description = "department identified for use of resources"
  default     = "cbp"
}

variable "project" { # var.project
  type        = string
  description = "project identified for use of resources"
  default     = "video-ipath"
}

variable "sub_department" { # var.sub_department
  type        = string
  description = "sub department identified for use of resources"
  default     = "ctb"
}

variable "cost_centre" { # var.cost_centre
  type        = string
  description = "cost centre identified for use of resources"
  default     = "2000920244"
}

variable "workflow" { # var.workflow
  type        = string
  description = "workflow identified for use of resources"
  default     = "grpctb"
}

variable "resource_tags" { # var.resource_tags
  description = "List of common tags for all resources"
  type        = map(any)
  default     = {}
}

variable "additional_tags" { # var.additional_tags
  description = "List of additional tags for MCR ec2"
  type        = map(any)
  default     = {}
}

######################
## Resources
######################

variable "mgmt_instance_type" { # var.mgmt_instance_type
  type        = string
  description = "EC2 manamgement_cluster for Videoipath"
  default     = "t3a.medium" # nevion recommendation
}

variable "node1_instance_type" { # var.node1_instance_type
  type        = string
  description = "EC2 node1_cluster for Videoipath"
  default     = "r5a.2xlarge" # nevion recommendation
}

variable "node2_instance_type" { # var.node2_instance_type
  type        = string
  description = "EC2 node2_cluster for Videoipath"
  default     = "r5a.2xlarge" # nevion recommendation
}

variable "node3_instance_type" { # var.node3_instance_type
  type        = string
  description = "EC2 node3_cluster for Videoipath"
  default     = "r5a.2xlarge" # nevion recommendation
}

###################
## ami 
###################

# variable "ami" {             # var.ami
#   type = string
#   description = "Rocky Linux9 (64-bit(x86))(HVM), SSD Volume Type for videoipath"
#   default = "ami-0dc67239a7014b5d7"  # rocky 9 ami_id number
# }

variable "ami" { # var.ami
  type        = string
  description = "Red Hat Enterprise Linux 9 (64-bit(x86))(HVM), SSD Volume Type for videoipath"
  default     = "ami-077fcd53ac5622b57" # Red Hat Enterprise Linux 9 ami_id number # FREE TIER
}

####################
## key pair
####################

variable "ec2_key" { # var.ec2_key
  description = "The ec2_key name to use for instances"
  type        = string
  default     = "AWS_EC2_VIPH_KP_MB" # key_pair created in ec2/key_pair
}

####################
## s3 
####################
variable "bucket_name" { #var.bucket_name
  description = "this is our s3 for our software"
  type        = string
  default     = "prod-grpctb-resources-269632189206-s3" # check this is the correct bucket
}

variable "bucket_name_auditlogs-s3" { #var.bucket_name_auditlogs-s3
  description = "this is our s3 for our software"
  type        = string
  default     = "prd-grpctb-euw2-auditlogs-s3" # check this is the correct bucket
}

#################
## Networks 
#################
variable "aws_az1_subnet" { # var.aws_az1_subnet
  type        = string
  description = "prd-grpctb-az1-private-subnet-01 cidr range to use for resource"
  default     = "10.194.33.0/26"
}

variable "aws_az2_subnet" { # var.aws_az2_subnet
  type        = string
  description = "prd-grpctb-az2-private-subnet-01 cidr range to use for resource"
  default     = "10.194.33.64/26"
}

variable "aws_az3_subnet" { # var.aws_az3_subnet
  type        = string
  description = "prd-grpctb-az3-private-subnet-01 cidr range to use for resource"
  default     = "10.194.33.128/26"
}

variable "vpc_cidr_block" { #var.vpc_cidr_block
  description = " this is the cidr_block for prd-grpctb-euw2-vpc-01"
  type        = string
  default     = "10.194.32.0/23"
}

variable "vpc_id" { # var.vpc_id # Specifies the ID of the VPC to which the subnet belongs.
  description = "this is the vpc_id for prod-grpctb-euw2-vpc-01 (london region)"
  type        = string
  default     = "vpc-075f7e9a3ec7c0de3"
}

variable "az1_subnet_id" {
  description = "prod-grpctb-az1-private-subnet-01 subnet_id"
  type        = string
  default     = "subnet-01cfbf0766aa6ac62"
}

variable "az2_subnet_id" {
  description = "prod-grpctb-az2-private-subnet-01 subnet_id"
  type        = string
  default     = "subnet-0fa29a1f5f24b8115"
}

variable "az3_subnet_id" {
  description = "prod-grpctb-az3-private-subnet-01 subnet_id"
  type        = string
  default     = "subnet-0c7c5ef17a2d13fe9"
}

##################
## EBS Volumes
##################

variable "ebs_volume_type" { # var.ebs_volume_type # Specifies the 
  description = "volume type for instance"
  type        = string
  default     = "gp3"
}

variable "ebs_node_volume_size" { # var.ebs_node_volume_size # Specifies the disk size
  description = "volume type for instance"
  type        = string
  default     = "256"
}

variable "ebs_mgmt_volume_size" { # var.ebs_mgmt_volume_size # Specifies the 
  description = "volume type for instance"
  type        = string
  default     = "20"
}

variable "ebs_iops" { # var.ebs_iops # Specifies the 
  description = "iops value for instance"
  type        = string
  default     = "3000"
}

variable "ebs_throughput" { # var.ebs_throughput # Specifies the 
  description = "throughput value for instance"
  type        = string
  default     = "125"
}

##################
## role
##################
variable "assume_role" { # var.assume_role 
  description = "throughput value for instance"
  type        = string
  default     = " "
}