Example of running tests of IaC.

These tests deploy real infrastructure, run some tests, and then destroy everything afterwards.

You should also consider static tests.

```
$ tofu init && tofu test

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/archive from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/http from the dependency lock file
- Reusing previous version of hashicorp/time from the dependency lock file
- Using previously-installed hashicorp/archive v2.7.1
- Using previously-installed hashicorp/aws v5.100.0
- Using previously-installed hashicorp/http v3.5.0
- Using previously-installed hashicorp/time v0.13.1

OpenTofu has been successfully initialized!

You may now begin working with OpenTofu. Try running "tofu plan" to see
any changes that are required for your infrastructure. All OpenTofu commands
should now work.

If you ever set or change modules or backend configuration for OpenTofu,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
deploy.tftest.hcl... pass
  run "deploy"... pass
  run "validate"... pass

Success! 2 passed, 0 failed.
```
