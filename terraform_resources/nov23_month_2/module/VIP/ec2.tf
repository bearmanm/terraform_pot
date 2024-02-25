# INSTANCE - MGMT NODE
resource "aws_instance" "mgmt-ec2" {
  ami                    = local.ami
  instance_type          = var.mgmt_instance_type
  subnet_id              = var.az1_subnet_id
  key_name               = var.ec2_key
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  root_block_device {
    volume_size = var.ebs_mgmt_volume_size #20
    volume_type = var.ebs_volume_type      #gp3
    tags = merge(
      { Name = "${var.environment}-${var.workflow}-${var.project}-mgmt-vol_az1" },
    local.resource_tags)
  }
  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-mgmt-ec2" },
  local.resource_tags)
}

# INSTANCE - NODE1
resource "aws_instance" "node1-ec2" {
  ami                    = local.ami # this ami is a static value and will not change so locals is better 
  instance_type          = var.node1_instance_type
  subnet_id              = var.az1_subnet_id # can sometimes use a data block because the data will be able to find the az1 subnet, but better not to use as a module
  key_name               = var.ec2_key
  vpc_security_group_ids = [aws_security_group.instance-sg.id] # this direct link from resource secuirty-group within module.
  root_block_device {
    volume_type = var.ebs_volume_type      #gp3
    volume_size = var.ebs_node_volume_size #256
    iops        = var.ebs_iops             #3000  #IOPS are a unit of measure representing input/output operations per second. The operations are measured in KiB
    throughput  = var.ebs_throughput       #125
    tags = merge(
      { Name = "${var.environment}-${var.workflow}-${var.project}-node1-vol_az1" },
    local.resource_tags)
  }
  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-node1-ec2" },
  local.resource_tags)
}

# INSTANCE - NODE2
resource "aws_instance" "node2-ec2" {
  ami                    = local.ami
  instance_type          = var.node2_instance_type
  subnet_id              = var.az2_subnet_id
  key_name               = var.ec2_key
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  root_block_device {
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_node_volume_size
    iops        = var.ebs_iops
    throughput  = var.ebs_throughput
    tags = merge(
      { Name = "${var.environment}-${var.workflow}-${var.project}-node2-vol_az2" },
    local.resource_tags)
  }
  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-node2-ec2" },
  local.resource_tags)
}

# INSTANCE - NODE3
resource "aws_instance" "node3-ec2" {
  ami                    = local.ami
  instance_type          = var.node3_instance_type
  subnet_id              = var.az3_subnet_id
  key_name               = var.ec2_key
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  root_block_device {
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_node_volume_size
    iops        = var.ebs_iops
    throughput  = var.ebs_throughput
    tags = merge(
      { Name = "${var.environment}-${var.workflow}-${var.project}-node3-vol_az3" },
    local.resource_tags)
  }
  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-node3-ec2" },
  local.resource_tags)
}