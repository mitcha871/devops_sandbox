# Creating an organization will permanently convert your account to a paid account and remove and bonus sign up credits!

provider "aws" {
  region = "ap-southeast-2"
}

module "child_accounts" {
  source  = "brikis98/devops/book//modules/aws-organizations"
  version = "1.0.0"

  create_organization = true # Organizations must be enabled on the root account to use.

  accounts = {
    development = "${var.email}+dev@${var.email_provider}"
    staging     = "${var.email}+stage@${var.email_provider}"
    production  = "${var.email}+prod@${var.email_provider}"
  }

}
