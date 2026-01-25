provider "aws" {
  region = "ap-southeast-4"
}

module "asg" {
  source  = "brikis98/devops/book//modules/asg" # Here we're using a remote module
  version = "1.0.0"

  name          = "sample-app-asg"
  ami_name      = "sample-app-packer-*"  # This happens to find the most recent image that matches this string.
  user_data     = filebase64("${path.module}/user-data.sh")
  app_http_port = 8080

  instance_type = "t3.micro"
  min_size      = 3
  max_size      = 10

  # We set this to associate the ASG with the Application Load Balancer.
  # ARN is Amazon Resource Name
  # This also includes auto-healing; the ASG will use the ALB to detect if the app instance is healthy.
  target_group_arns = [module.alb.target_group_arn]

  # AWS ASG's support rolling deployments through a feature called instance refresh
  instance_refresh = {
    min_healthy_percentage = 100
    max_healthy_percentage = 200
    auto_rollback          = true
  }
}

module "alb" {
  source  = "brikis98/devops/book//modules/alb"
  version = "1.0.0"

  name                  = "sample-app-alb" # Name of the load balancer
  alb_http_port         = 80
  app_http_port         = 8080
  app_health_check_path = "/"
}
