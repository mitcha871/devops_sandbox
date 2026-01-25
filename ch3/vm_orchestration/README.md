The concept here is to create VM images that have out Node app and pm2 installed and deploy these in an auto-scaling group (ASG).
* In GCP these are Managed Instance Groups.
* In Azure these are Scale Sets.

Building the images

```
$ packer init sample-app.pkr.hcl  # This is to initialize the aws plugins required for the build.
$ packer build sample-app.pkr.hcl  # Remember that the build environment is an EC2 server, so you need to be authenticated with AWS.
```

To create the ASG we need three things:

* A launch template
* An ASG that utilizes the launch template to deploy EC2 instances
* A security group for the EC2 instances

We also need a load balancer. While we can BYO with e.g. nginx, using the managed service has the following pros:

* Availability - redundancy and automatic failover is built-in.
* Scalability - managed load balancer automatically scale to the load.
* Maintenance - managed by the provider.
* Security - managed by the provider, and AWS is compliant with SOC 2, HIPAA, PCI DSS, ISO 27001.
* Encryption - made easier by the provider.

We select an Application Load Balancer for this example. Here we use a remote Tofu module to implement the ASG and ALB.

```
tofu init
tofu apply
```

With this code we've created a scalable, resilient, self healing, cloud service, that supports a zero-downtime upgrade strategy.

Upgrades are simply: rebuilding the image with a change and then updating the ASG to point to the new image through OpenTofu.

In this example we had a ASG with min 3 and max 10 with the rollout strategy allowing a miniumum healthy of 100% and maximum healthy of 200%.

What this looked like was: during the upgrade rollout we went from 3 instances to 6 instances. Then the older instances were removed leaving only the new ones.

```
OpenTofu will perform the following actions:

  # module.asg.aws_autoscaling_group.sample_app will be updated in-place
  ~ resource "aws_autoscaling_group" "sample_app" {
        id                               = "sample-app-xxxxxx"
        name                             = "sample-app-xxxxxx"
        # (27 unchanged attributes hidden)

      + instance_refresh {
          + strategy = "Rolling"

          + preferences {
              + auto_rollback                = true
              + max_healthy_percentage       = 200
              + min_healthy_percentage       = 100
              + scale_in_protected_instances = "Ignore"
              + skip_matching                = false
              + standby_instances            = "Ignore"
            }
        }

      ~ launch_template {
            id      = "lt-yyyyyy"
            name    = "sample-app-zzzzzz"
          ~ version = "2" -> (known after apply)
        }

        # (4 unchanged blocks hidden)
    }

  # module.asg.aws_launch_template.sample_app will be updated in-place
  ~ resource "aws_launch_template" "sample_app" {
        id                      = "lt-yyyyyy"
      ~ image_id                = "ami-iiiiii" -> "ami-jjjjjj"
      ~ latest_version          = 2 -> (known after apply)
        name                    = "sample-app-zzzzzz"
        tags                    = {}
        # (10 unchanged attributes hidden)
    }

Plan: 0 to add, 2 to change, 0 to destroy.
```
