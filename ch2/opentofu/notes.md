Terraform/OpenTofu will recognize all `.tf` files - though you should generally follow convention:

* main.tf
* variables.tf
* outputs.tf

etc.


# Installing OpenTofu

https://opentofu.org/docs/intro/install/snap/

# Running

_Note that it read the AMI ID_

```
$ tofu init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v6.28.0...
- Installed hashicorp/aws v6.28.0 (signed, key ID 0C0AF313E5FD9F80)

Providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://opentofu.org/docs/cli/plugins/signing/

OpenTofu has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that OpenTofu can guarantee to make the same selections by default when
you run "tofu init" in the future.

OpenTofu has been successfully initialized!

You may now begin working with OpenTofu. Try running "tofu plan" to see
any changes that are required for your infrastructure. All OpenTofu commands
should now work.

If you ever set or change modules or backend configuration for OpenTofu,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
$ tofu plan
data.aws_ami.sample_app: Reading...
data.aws_ami.sample_app: Read complete after 1s [id=ami-xxxxx]

OpenTofu used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

OpenTofu will perform the following actions:

  # aws_instance.sample_app will be created
  + resource "aws_instance" "sample_app" {
      + ami                                  = "ami-xxxxx"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "ap-southeast-4"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "sample_app_tofu"
        }
      + tags_all                             = {
          + "Name" = "sample_app_tofu"
        }
      + tenancy                              = (known after apply)
      + user_data                            = <<-EOT
            #!/usr/bin/env bash

            nohup node /home/ec2-user/app.js &
        EOT
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # aws_security_group.sample_app will be created
  + resource "aws_security_group" "sample_app" {
      + arn                    = (known after apply)
      + description            = "Allow traffic for sample_app_tofu"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "sample_app_tofu"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-southeast-4"
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_security_group_rule.allow_inbound will be created
  + resource "aws_security_group_rule" "allow_inbound" {
      + cidr_blocks              = [
          + "0.0.0.0/0",
        ]
      + from_port                = 8080
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + region                   = "ap-southeast-4"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 8080
      + type                     = "ingress"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + instance_id        = (known after apply)
  + public_ip          = (known after apply)
  + sescurity_group_id = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so OpenTofu can't guarantee to take exactly these actions if you run "tofu apply" now.

$ tofu apply
...
...
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

instance_id = "i-xxxxx"
public_ip = "xx.xx.xx.xx"
sescurity_group_id = "sg-xxxxx"

$ curl xx.xx.xx.xx:8080
Hello World!
```

Then do `tofu destroy` to clean things up
