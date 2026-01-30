provider "aws" {
  region = "ap-southeast-2"
}

module "oidc_provider" {
  source  = "brikis98/devops/book//modules/github-aws-oidc"
  version = "1.0.0"

  provider_url = "https://token.actions.githubusercontent.com"

}

module "iam_roles" {
  source  = "brikis98/devops/book//modules/gh-actions-iam-roles"
  version = "1.0.0"

  name              = "lambda-sample"
  oidc_provider_arn = module.oidc_provider.oidc_provider_arn

  enable_iam_role_for_testing = true

  github_repo      = "mitcha871/devops_sandbox"  # This forms a condition in the trust policy to specify which repos are allowed to assume an IAM role
  lambda_base_name = "lambda-sample"

  enable_iam_role_for_plan  = true  # Read only. The OIDC provider will be able to assume this role from any branch
  enable_iam_role_for_apply = true  # Read/write. The OIDC provider will be able to assume this role from main only.

  tofu_state_bucket         = "fundamentals-of-devops-tofu-state-202601301234"
  tofu_state_dynamodb_table = "fundamentals-of-devops-tofu-state-202601301234"
}
