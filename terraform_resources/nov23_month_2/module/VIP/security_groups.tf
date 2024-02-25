####################
## SECURITY GROUP ##
####################
resource "aws_security_group" "instance-sg" {
  name        = "${var.environment}-${var.workflow}-${var.project}-ec2_sg"
  description = "Allows inbound traffic from network switches and outbound traffic to web."
  vpc_id = var.vpc_id
  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-ec2-sg" },
  local.resource_tags)

  # ingress rule allowing inbound traffic on port 443 (HTTPS) from any source IP address
  ingress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access from anywhere"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block] 
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    from_port   = 26257
    to_port     = 26257
    description = "Inter-node communication for CockRoachDB SQL"
    protocol    = "tcp"
    self        = true 
  }

  ingress {
    from_port   = 26357
    to_port     = 26357
    description = "Inter-node communication for CockRoachDB RPC (since v22.2.0)"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 9042
    to_port     = 9042
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 8082
    to_port     = 8082
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 7199
    to_port     = 7199
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 7200
    to_port     = 7200
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 7589
    to_port     = 7589
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 2888
    to_port     = 2888
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 3888
    to_port     = 3888
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 2181
    to_port     = 2181
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 8083
    to_port     = 8083
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    description = "Inter-node communication for frontend"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    description = "Inter-node communication for node exporter"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 8181
    to_port     = 8181
    description = "Inter-node communication for cAdvisor"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = 9001
    to_port     = 9001
    description = "Inter-node communication for health check"
    protocol    = "tcp"
    self        = true
  }

  ingress {
    from_port   = -1
    to_port     = -1
    description = "allow all internal icmp traffic"
    protocol    = "icmp"
    self        = true 
  }

  ########################
  ## monitoring-ingress ##
  ######################## 
  ingress {
    from_port   = 80
    to_port     = 80
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.78/32"] 
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.78/32"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.78/32"] 
  }

  ingress {
    from_port   = 8404
    to_port     = 8404
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.78/32"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.79/32"] 
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.79/32"] 
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.79/32"] 
  }

  ingress {
    from_port   = 8404
    to_port     = 8404
    description = "inbound from Ost jumpboxes for monitoring"
    protocol    = "tcp"
    cidr_blocks = ["192.168.42.79/32"] 
  }

  ######################
  ## all-egress-rules ##
  ######################
  egress {
    from_port   = 0
    to_port     = 0
    description = "allowing outgoing between all ports from all destinations"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access to anywhere"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    description = "ssh-ing"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 26257
    to_port     = 26257
    description = "Inter-node communication for CockRoachDB SQL"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 26357
    to_port     = 26357
    description = "Inter-node communication for CockRoachDB RPC (since v22.2.0)"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 9042
    to_port     = 9042
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 8082
    to_port     = 8082
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 3001
    to_port     = 3001
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 9000
    to_port     = 9000
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 7199
    to_port     = 7199
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 7200
    to_port     = 7200
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 7589
    to_port     = 7589
    description = "Inter-node communication for haproxy"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 2888
    to_port     = 2888
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 3888
    to_port     = 3888
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 2181
    to_port     = 2181
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 8083
    to_port     = 8083
    description = "Inter-node communication for zookeeper"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 8000
    to_port     = 8000
    description = "Inter-node communication for frontend"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 9100
    to_port     = 9100
    description = "Inter-node communication for Node exporter"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 8181
    to_port     = 8181
    description = "Inter-node communication for cAdvisor"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 9001
    to_port     = 9001
    description = "Inter-node communication for health check"
    protocol    = "tcp"
    self        = true
  }

  # ICMP internal ec2 testing 
  egress {
    from_port   = -1
    to_port     = -1
    description = "allow all internal icmp traffic"
    protocol    = "icmp"
    self        = true 
  }

  ################
  ## SNP-egress ## 
  ################
  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.252.131.8/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.252.133.17/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.130.104.13/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.130.104.14/32"]
  }

  ##################
  ## Cisco-egress ##
  ##################
  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.192.235/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.192.236/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.217.219/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.217.220/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.153.45/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.153.46/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.153.47/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.254.153.48/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.252.225/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.252.226/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.254.225/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.254.226/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.252.227/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.252.228/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.254.227/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.102.254.228/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.216.32.12/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.216.32.13/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.150.20.88/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.150.20.89/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.216.32.16/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.216.32.17/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.150.20.188/32"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    description = "HTTP access"
    protocol    = "tcp"
    cidr_blocks = ["10.150.20.189/32"]
  }

}

############
## alb sg ## 
############
resource "aws_security_group" "alb-sg" {
  name        = "${var.environment}-${var.workflow}-${var.project}-alb_sg"
  description = "application load balancer"
  vpc_id      = var.vpc_id
  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-alb-sg" },
  local.resource_tags)


  ingress {
    from_port   = 443
    to_port     = 443
    description = "HTTPS access from anywhere" # Changed to HTTPS
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    description = "access traffic from within the vpc"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}