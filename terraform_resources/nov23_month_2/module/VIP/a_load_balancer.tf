## aws_alb (application load balancer)
resource "aws_lb" "video_ipath" {                                                # name of project
  internal           = true                                                      # set to true for creating a private lb, false for public
  load_balancer_type = "application"                                             # application or network lb type 
  security_groups    = [aws_security_group.alb-sg.id]                            # this info is pulled from the alb security-group
  subnets            = [var.az1_subnet_id, var.az2_subnet_id, var.az3_subnet_id] # these are the variable subnet_ids for each az

  enable_deletion_protection = false # set to false will delete lb once done with it

  # access_logs {
  #   bucket  = var.bucket_name_auditlogs-s3 # name of auditlog bucket in prod account
  #   prefix  = "${var.environment}-${var.workflow}-${var.project}-lb-ec2" # creates name maybe?? 
  #   enabled = true # enable access logs - have to be enable for secuirty reasons ask bukky cambell 
  # }

  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-lb-ec2" },
  local.resource_tags)
}

## aws_aib_target_group
resource "aws_lb_target_group" "video_ipath" {
  name     = "${var.environment}-${var.workflow}-${var.project}-alb-tg"
  port     = 443 # Changed from 80 to 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id

  stickiness { # Stickiness allows the load balancer to bind a user's session to a specific target
    # (If this is not configured then after each reloads of the browser user will have to authenticate again) # a requirement in video_ipath maunal
    enabled = true
    type    = "lb_cookie" # The type of sticky sessions. The only current possible values are lb_cookie or app_cookie 
  }

  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-alb-tg" },
  local.resource_tags)
}

## aws_alb_listener
resource "aws_lb_listener" "video_ipath-443" {
  load_balancer_arn = aws_lb.video_ipath.arn # this discovers the lb resource arn
  port              = "443"
  protocol          = "HTTP" # Set/Changed to HTTPS but caused - ValidationError: A certificate must be specified for HTTPS listeners # need to attached ssl policy
  # ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06" this is the recommended aws policy from the console  
  #certificate_arn   = data.aws_acm_certificate.gvg-local-discovery-cert.arn # example
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.video_ipath.arn
  }

  tags = merge(
    { Name = "${var.environment}-${var.workflow}-${var.project}-alb-listen-443" },
  local.resource_tags)
}

## aws_alb_target_group_attachment
resource "aws_lb_target_group_attachment" "node1-ec2" {
  target_group_arn = aws_lb_target_group.video_ipath.arn
  target_id        = aws_instance.node1-ec2.id
  port             = 443 # Change to port 443
}

resource "aws_lb_target_group_attachment" "node2-ec2" {
  target_group_arn = aws_lb_target_group.video_ipath.arn
  target_id        = aws_instance.node2-ec2.id
  port             = 443 # Change to port 443
}

resource "aws_lb_target_group_attachment" "node3-ec2" {
  target_group_arn = aws_lb_target_group.video_ipath.arn
  target_id        = aws_instance.node3-ec2.id
  port             = 443 # Change to port 443 from 80
}


# resource "aws_acm_certificate" "video_ipath-local-discovery-cert" {
#   domain      = "${var.environment}.${var.workflow}.euw2.gva.sky.com" # prod.grpctb.euw2.gva.sky.com
#   types       = ["IMPORTED"]
#   statuses    = ["ISSUED"]
#   most_recent = true
# }