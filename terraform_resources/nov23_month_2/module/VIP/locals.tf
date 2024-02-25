# resource_tags
# when var.aws_region is set to "eu-west-2," the resulting value of reg will be "ew2" 
# because it takes the first character "e," the fourth character "w," and the last character "2."
locals {
  reg = "${lower(substr(var.aws_region, 0, 1))}${lower(substr(var.aws_region, 3, 1))}${substr(var.aws_region, -1, 1)}" # eu-west-2 > ew2


  # this local variable region_short is creating a shortened and lowercase representation of the var.aws_region. 
  # The three substrings ${substr(var.region, 0, 2)} ${substr(var.region, 3, 1)} ${substr(var.region, -1, 1)} are concatenated together to 
  # form the value of the region_short local variable.

  region_short = lower("${substr(var.aws_region, 0, 2)}${substr(var.aws_region, 3, 1)}${substr(var.aws_region, -1, 1)}") # eu-west-2 > euw2

  ami = "ami-077fcd53ac5622b57"

  resource_tags = {
    territory      = var.territory,
    billing_team   = var.billing_team,
    department     = var.department,
    sub_department = var.sub_department,
    environment    = var.environment,
    cost_centre    = var.cost_centre,
    workflow       = var.workflow,
    project        = var.project,
  }
  # sg = { # create list # maps 
  #   "0.0.0.0/0",
  #   "0.0.0.0/0", 
  # }
}