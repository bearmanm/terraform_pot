# terraform main.tf structure

#block_type "label" "name_label" {
    #key = "value"
    #nested_block {
        #key = "value"
    #}
#}

# terraform main.tf structure applied for ec2 instance in aws

#resource "aws_instance" "web_server" {
    #name = "web-server"
    #ebs_volume {
        #size = 40

    #}

#}