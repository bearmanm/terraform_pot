# terraform data types
# we can group data types supported by terraform into 3 catogries. 
# the most basic are the primitive data types. 

# these are 'string, number, boolean'. a string is a sequence of unicode charatures. a number can be a integer or a decimal and 
# boolean is either True or False. 
  
# the next catorgry is 'collection' data types, these are List, Set, map. 
# they respresent a grouping of the primitive data types.a List is an ordered group of elements. a set is an unordered 
# group of elements. and a map is a value of key value pairs.   
# In each case, the values stored in any of these 'collection' data types, MUST be of the same data type. 

# the last group is structural data types. these Tuple and Object and are similar to collection data types, except they 
# allow you to mix the data types stored in each grouping, aside from that difference, tuples are functionally equivalent 
# to lists and objects are equivalent to maps. 
# It's useful to be aware of structural data types but chances are your not going to use them for basic configurations. 

# examples of Lists

#List - notice each element of the list is the same data type.  

#[1, 2, 3, 4] # all numbers in this list 

#["us-east-1", "us-east-2", "us-west-1", "us-west-2"]  all strings in this list

#[1, "us-east-2", true] INVALID LIST! this list contains a mixture of data types, 
# which would be invalid for a list but valid for a 'tuple'

# example of map 
#Map - has 3 key value pairs. The keys are going to be strings and values MUST all be the same data type. 
#{
    #small  = "t2.micro"
    #medium = "t2.small"
    #large  = "t2.large"
#}
# in this case, they are all a type string.  

# if you want to use a 'collection' for a variable, how do you construct it? and how do you reference the values inside. 
# use this example - lets say you have variable with a list of AWS regions.    

variable "aws_regions" {
    type = list(string) # The type argument takes the form of the collection type we like to use and what data type will be stored in it.
    # in this case we have list 'collection' type that will be storing string values.  
    description = "Region to use for AWS resources"
    default = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"] # for our default value, we have provided a list of 4 regions, 
    # each as strings. 
}
# Lists are a ordered data type. we can refer to an element by number, starting with zero.
#var.<name_label>[<element_number>]
# if we want the first element in our list, which is "us-east-1" our syntax would be 
#var.aws_regions[0] # a 0 for the first element enclosed in square brackets. 
# we can get the whole list by only specifying the name_label and skipping the square brackets. 

# what if want a map holding AWS instance sizes? the type argument is basically the same! 
# we want to have a map with string as the value held in the map. 

variable "aws_instance_size" {
    type = map(string) 
    description = "Region to use for AWS resources"
    default = {
        small  = "t2.micro"
        medium = "ts.small"
        large  = "t2.large" 
    }
}
# from the default we can define the keys as small, medium or large and associate an ec2 instance size with each key.  
# if we want to refer to the value stored in one of those keys, there are actually two ways of doing so, 
# the first is  
#var.<name_label>.<key_name> 
# the second is 
#var.<name_label>["key_name"]
# we can retreve the value stored in the small key by writing 
#var.aws_instance_sizes.small or var.aws_instance_sizes["small"]

