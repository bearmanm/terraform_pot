# local values are values computed inside of the configuration. 

# You can't submit values directly to them, unlike input variables.  

# the syntax for locals starts with the key word locals,  

locals { 
# the rest of the information goes inside of the block 
# inside the block are key value pairs, and value could be any terraform supported data type. 
# string, list, object, the sky is the limite...  
}

# for example
locals {
	key = value
}

# here is an example of a locals block
# here is an example of a locals block
# the first key value pair defines a local with the name instance_prefix and the value "globo"
# the next key is common tags, and it's value is a map defining some common tags. 
# you can refer to other values inside of your configuration for the values on local, for instance the project key is 
# assigned value in the variable project. 
# you can specify the locals block multiple times in your configuration if you want to, 
# but the name of each key must be unique within the configuration since that is how you reference a locals value. 

locals {
	instance_prefix = "globo"
	common_tags = {
        company = "Globomantics"
	    #project = var.project
	    #billing_code = var.billing_code
	}
}

# to refer to a value stored in a local, the syntax starts with the local key word. note that local is singluar not plural. 
# followed by dot and the name_label.

# local.<name_label>

# to get the value in the instance_prefix the syntax would be

# local.instance_prefix

# if we have a collection data type in our local, the same syntax from the variable example applies.

# local.common_tags.company 

# we could get the value stored insdie company by writing local.common_tags.company. 
# if we'd rather get the entire map, we'd only need to write

# local.common_tags 

