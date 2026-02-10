Example of using var files to set up an application in different environments that have different requirements.

In a real world case, each account would have its own S3 bucket and DynamoDB for managing the Terraform state.

```
tofu init -var-file=prod.tfvars -reconfigure
tofu apply -var-file=prod.tfvars
```
