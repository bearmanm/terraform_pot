# Variable Syntax
# variables are defined inside of a block

# a varibale block start with the key word followed by a single label "name_label"
variable "name_label" {}
# all the other prperties are defined inside the block and all properties are optional. 

# these are the optional arguments inside the variable block
variable "name_label" {
    type = value # the type argument defines the data type associated with your variable providing error checking. 
    description = "value" # the descritpion argument helps provides some context when the user gets an error.
    default = "value" # the default argument allows you to set a default value for the variable, if no value is submitted, 
                      # terraform will use this default value. 
    sensitive = true # this excepts a boolean value, true or false. If it's set to true, terraform will NOT show you the 
    # value of the variable in it's logs or the terminal output. 
}

# example of actual variables and how to refer to there value inside a configuration. 
variable "billing_tag" {} # this variable show you it's a variable with the name label "billing_tag". 
# since no default value is specified, you'll need to provide one at execution time. 

variable "aws_region" { # our second variable has the name label "aws_region". this time, we have some arguments. 
    type = string # we are going to set the type to string, sine the value will be be one of the aws regions. 
    description = "Region to use for AWS resources" # we have a helpful description here 
    default = "us-east-1" # we are setting the default value of us-east-1, so if no value is specified at execution time, 
                          # terraform will use us-east-1.
    sensitive = false # this is not a sensitive value, so we have set this to false. we don't have to specify this as it's 
    # set to false by default.    
}

# to refer to the value stored in the variable, we simply use the var identifier.name_label "var.<name_label>" 
# for instance to refer to the value stored in our "aws_region" variable, the syntax would be "var.aws_region" 
# and you would get back the string stored in the variable. 

