provider "aws" {
  region = "ap-southeast-2"  # Interestingly, creating a function URL did not work in ap-southeast-4
}

module "function" {
  source  = "brikis98/devops/book//modules/lambda"
  version = "1.0.0"

  name        = var.name  # Name of the function
  src_dir     = "${path.module}/src"  # Source files for the function
  runtime     = "nodejs20.x"  # The AWS Lambda runtime. Others include Python, Java, Ruby, .Net
  handler     = "index.handler"  # Function entrypoint
  memory_size = 128  # Increasing the memory for the function proportionally increases the CPU available to it
  timeout     = 5  # The maximum amount of time (minutes) that this function may run for

  environment_variables = {
    NODE_ENV = "production"
  }
  create_url = true
}

# This additional permission was also required in order to have unauthenticated access to the function
resource "aws_lambda_permission" "add_lambda_InvokeFunction" {
  statement_id           = "AllowLambdaInvokeFunction"
  action                 = "lambda:InvokeFunction"
  function_name          = module.function.function_name
  principal              = "*"
}
