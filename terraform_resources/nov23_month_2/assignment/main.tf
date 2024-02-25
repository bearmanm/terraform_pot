# AWS INSTANCE RESOURCE 
module "ec2" {
  source            = "../../modules/ec2"
  environment = local.environment
}
