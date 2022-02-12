resource "aws_lb" "factlb" {
  name               = "factorial"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.lb_sg.security_group_id]
  subnets            = ["subnet-01924ff38472dd079","subnet-057d1e5cd23afdff4"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "factorialtg" {
  name        = "factorial-tg"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-0099b31e0ede4abd1"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.factlb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.factorialtg.arn
  }
}

module "lb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "ECS-LB-SG"
  description = "ECS-LB-SG"
  vpc_id      = "vpc-0099b31e0ede4abd1"

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp","http-80-tcp"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
}