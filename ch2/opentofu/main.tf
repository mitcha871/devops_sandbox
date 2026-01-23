# The root (not reusable) module should define the provider. Reusable modules inherit the provider from the root module.
provider "aws" {
  region = "ap-southeast-4"
}

# Modules may be local
module "sample_app_1" {
  source = "./modules/sample-app"

  name = "sample-app-1"
}

module "sample_app_2" {
  source = "./modules/sample-app"

  name = "sample-app-2"
}

# Or modules may be remote
# module "sample_app_3" {
#   # Note the double // to specify a folder path, and ref to specify a Git reference.
#   source = "github.com/brikis98/devops-book//ch2/tofu/modules/ec2-instance?ref=1.0.0"
#   name = "sample-app-1"
# }

# Or they can be public or private registries on e.g. Github, GitLab, Bitbucket, OpenTofu, Terraform
# module "sample_app_3" {
#   source = "brikis98/devops/book//modules/ec2-instance"
#   version = "1.0.0"
# }
