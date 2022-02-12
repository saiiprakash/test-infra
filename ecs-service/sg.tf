module "ecs_sg" {
  source = "terraform-aws-modules/security-group/aws"
  name        = "ECS-SG"
  description = "ECS-SG"
  vpc_id      = "vpc-0099b31e0ede4abd1"

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp","http-80-tcp"]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
  
  
  /*ingress_with_source_security_group_id = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      source_security_group_id  = "sg-0502b3551591cd816" 
    },
    {
      from_port   = 8081
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      source_security_group_id  = "sg-0502b3551591cd816" 
    },
  ]*/
  ingress_with_cidr_blocks = [
    {
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      description = "app port"
      cidr_blocks = "0.0.0.0/0"
    }
    
  ]
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