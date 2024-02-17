# AWS INSTANCE RESOURCE 
module "ec2" {
  source            = "../../modules/ec2"
}

# AWS s3 STORAGE RESOURCE
module "s3" {
  source = "../../modules/s3"
  bucket_name = var.bucket_name
}
