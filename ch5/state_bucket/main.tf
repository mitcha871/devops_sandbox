provider "aws" {
  region = "ap-southeast-2"
}

module "state" {
  source  = "brikis98/devops/book//modules/state-bucket"
  version = "1.0.0"

  name = "fundamentals-of-devops-tofu-state-202601301234"
}
