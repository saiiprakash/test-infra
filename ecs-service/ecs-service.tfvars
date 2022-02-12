name = "factorial"
cluster = "arn:aws:ecs:ap-south-1:364485175950:cluster/dev-cluster"
subnets = ["subnet-01924ff38472dd079","subnet-057d1e5cd23afdff4"]
lb_target_group = {
    container_port       = 5000
    host_port            = 5000
    protocol             = "http"
    deregistration_delay = 300
  }
target_group_arn = "arn:aws:elasticloadbalancing:ap-south-1:364485175950:targetgroup/factorial-tg/47c373558c7eac75"
