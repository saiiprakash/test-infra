variable "name" {
    description = "The name of the Service to create"
    default     = ""
    
}
variable "cluster" {
    description = "The cluster arn that service needs to create"
    default     = ""
    
}
variable "launch_type" {
    description = "The launch type that the service needs"
    default     = "FARGATE"
    
}
/*variable "task_definition" {
    description = "The task defintion for the service"
    type = string
    
}*/
variable "desired_count" {
    description = ""
    type = number
    default = 1
}
/*variable "security_groups" {
    description = "The security groups for the service"
    type = list(string)
    
}*/
variable "subnets" {
    description = "The subnets for  the service"
    type = list(string)    
}

variable "lb_target_group" {
  description = "The target group to connectect the container to the load balancer listerner."
  type        = map

  default = {
    container_port       = 80
    host_port            = 80
    protocol             = "http"
    deregistration_delay = 300
  }
}
variable target_group_arn {
    description = "The arn of the target group"
    type =string
}