terraform {
  backend "s3" {
    bucket         = "fundamentals-of-devops-tofu-state-202601301234"  # Bucket names must be globally unique!
    key            = "ch5/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "fundamentals-of-devops-tofu-state-202601301234"  # Used for locking
  }
}
