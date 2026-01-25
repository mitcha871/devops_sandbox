# Packer installation

https://developer.hashicorp.com/packer/install

# Packer execution

Packer creates a temporary security group, ssh keys, and an EC2 instance, connects to it, runs the build commands, shuts down the instance, exports it as a deployable AMI and cleans up the resources it created along the way.

If Packer is re-run it will simply create a new image.

```
$ packer init .
Installed plugin github.com/hashicorp/amazon v1.8.0 in "/home/me/.config/packer/plugins/github.com/hashicorp/amazon/packer-plugin-amazon_v1.8.0_x5.0_linux_amd64"

$ packer build .
amazon-ebs.amazon-linux: output will be in this color.

==> amazon-ebs.amazon-linux: Prevalidating any provided VPC information
==> amazon-ebs.amazon-linux: Prevalidating AMI Name: sample-app-packer-xxxxx
==> amazon-ebs.amazon-linux: Found Image ID: ami-xxxxx
==> amazon-ebs.amazon-linux: Creating temporary keypair: packer_xxxxx
==> amazon-ebs.amazon-linux: Creating temporary security group for this instance: packer_xxxxx
==> amazon-ebs.amazon-linux: Authorizing access to port 22 from [0.0.0.0/0] in the temporary security groups...
==> amazon-ebs.amazon-linux: Launching a source AWS instance...
==> amazon-ebs.amazon-linux: Instance ID: i-xxxxx
==> amazon-ebs.amazon-linux: Waiting for instance (i-xxxxx) to become ready...
==> amazon-ebs.amazon-linux: Using SSH communicator to connect: xx.xx.xx.xx
==> amazon-ebs.amazon-linux: Waiting for SSH to become available...
==> amazon-ebs.amazon-linux: Connected to SSH!
==> amazon-ebs.amazon-linux: Uploading app.js => /home/ec2-user/app.js
    amazon-ebs.amazon-linux: app.js 606 B / 606 B [==============================================================================================================================================] 100.00% 0s
==> amazon-ebs.amazon-linux: Pausing 30s before the next provisioner...
==> amazon-ebs.amazon-linux: Provisioning with shell script: install-node.sh
==> amazon-ebs.amazon-linux: Repository 'nodesource-nodejs' is missing name in configuration, using id.
==> amazon-ebs.amazon-linux: Amazon Linux 2023 Kernel Livepatch repository   277 kB/s |  30 kB     00:00
==> amazon-ebs.amazon-linux: nodesource-nodejs                               1.1 MB/s | 431 kB     00:00
==> amazon-ebs.amazon-linux: Dependencies resolved.
==> amazon-ebs.amazon-linux: ================================================================================
==> amazon-ebs.amazon-linux:  Package          Arch   Version                              Repository   Size
==> amazon-ebs.amazon-linux: ================================================================================
==> amazon-ebs.amazon-linux: Installing:
==> amazon-ebs.amazon-linux:  nodejs           x86_64 1:18.20.8-1.amzn2023.0.2             amazonlinux  13 M
==> amazon-ebs.amazon-linux: Installing dependencies:
==> amazon-ebs.amazon-linux:  libbrotli        x86_64 1.0.9-4.amzn2023.0.2                 amazonlinux 315 k
==> amazon-ebs.amazon-linux:  nodejs-libs      x86_64 1:18.20.8-1.amzn2023.0.2             amazonlinux  14 M
==> amazon-ebs.amazon-linux: Installing weak dependencies:
==> amazon-ebs.amazon-linux:  nodejs-docs      noarch 1:18.20.8-1.amzn2023.0.2             amazonlinux 7.8 M
==> amazon-ebs.amazon-linux:  nodejs-full-i18n x86_64 1:18.20.8-1.amzn2023.0.2             amazonlinux 8.4 M
==> amazon-ebs.amazon-linux:  nodejs-npm       x86_64 1:10.8.2-1.18.20.8.1.amzn2023.0.2    amazonlinux 1.9 M
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux: Transaction Summary
==> amazon-ebs.amazon-linux: ================================================================================
==> amazon-ebs.amazon-linux: Install  6 Packages
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux: Total download size: 45 M
==> amazon-ebs.amazon-linux: Installed size: 224 M
==> amazon-ebs.amazon-linux: Downloading Packages:
==> amazon-ebs.amazon-linux: (1/6): libbrotli-1.0.9-4.amzn2023.0.2.x86_64.rp 7.5 MB/s | 315 kB     00:00
==> amazon-ebs.amazon-linux: (2/6): nodejs-docs-18.20.8-1.amzn2023.0.2.noarc  58 MB/s | 7.8 MB     00:00
==> amazon-ebs.amazon-linux: (3/6): nodejs-18.20.8-1.amzn2023.0.2.x86_64.rpm  60 MB/s |  13 MB     00:00
==> amazon-ebs.amazon-linux: (4/6): nodejs-full-i18n-18.20.8-1.amzn2023.0.2.  38 MB/s | 8.4 MB     00:00
==> amazon-ebs.amazon-linux: (5/6): nodejs-npm-10.8.2-1.18.20.8.1.amzn2023.0  27 MB/s | 1.9 MB     00:00
==> amazon-ebs.amazon-linux: (6/6): nodejs-libs-18.20.8-1.amzn2023.0.2.x86_6  61 MB/s |  14 MB     00:00
==> amazon-ebs.amazon-linux: --------------------------------------------------------------------------------
==> amazon-ebs.amazon-linux: Total                                           113 MB/s |  45 MB     00:00
==> amazon-ebs.amazon-linux: Running transaction check
==> amazon-ebs.amazon-linux: Transaction check succeeded.
==> amazon-ebs.amazon-linux: Running transaction test
==> amazon-ebs.amazon-linux: Transaction test succeeded.
==> amazon-ebs.amazon-linux: Running transaction
==> amazon-ebs.amazon-linux:   Preparing        :                                                        1/1
==> amazon-ebs.amazon-linux:   Installing       : nodejs-docs-1:18.20.8-1.amzn2023.0.2.noarch            1/6
==> amazon-ebs.amazon-linux:   Installing       : libbrotli-1.0.9-4.amzn2023.0.2.x86_64                  2/6
==> amazon-ebs.amazon-linux:   Installing       : nodejs-libs-1:18.20.8-1.amzn2023.0.2.x86_64            3/6
==> amazon-ebs.amazon-linux:   Installing       : nodejs-full-i18n-1:18.20.8-1.amzn2023.0.2.x86_64       4/6
==> amazon-ebs.amazon-linux:   Installing       : nodejs-npm-1:10.8.2-1.18.20.8.1.amzn2023.0.2.x86_64    5/6
==> amazon-ebs.amazon-linux:   Installing       : nodejs-1:18.20.8-1.amzn2023.0.2.x86_64                 6/6
==> amazon-ebs.amazon-linux:   Running scriptlet: nodejs-1:18.20.8-1.amzn2023.0.2.x86_64                 6/6
==> amazon-ebs.amazon-linux: INFO: registered node-18 in the alternatives
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:   Verifying        : libbrotli-1.0.9-4.amzn2023.0.2.x86_64                  1/6
==> amazon-ebs.amazon-linux:   Verifying        : nodejs-1:18.20.8-1.amzn2023.0.2.x86_64                 2/6
==> amazon-ebs.amazon-linux:   Verifying        : nodejs-docs-1:18.20.8-1.amzn2023.0.2.noarch            3/6
==> amazon-ebs.amazon-linux:   Verifying        : nodejs-full-i18n-1:18.20.8-1.amzn2023.0.2.x86_64       4/6
==> amazon-ebs.amazon-linux:   Verifying        : nodejs-libs-1:18.20.8-1.amzn2023.0.2.x86_64            5/6
==> amazon-ebs.amazon-linux: ================================================================================
==> amazon-ebs.amazon-linux: WARNING:
==> amazon-ebs.amazon-linux:   A newer release of "Amazon Linux" is available.
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:   Available Versions:
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:   Version 2023.10.20260120:
==> amazon-ebs.amazon-linux:     Run the following command to upgrade to 2023.10.20260120:
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:       dnf upgrade --releasever=2023.10.20260120
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:     Release notes:
==> amazon-ebs.amazon-linux:      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.10.20260120.html
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:   Version 2023.10.20260120:
==> amazon-ebs.amazon-linux:     Run the following command to upgrade to 2023.10.20260120:
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:       dnf upgrade --releasever=2023.10.20260120
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux:     Release notes:
==> amazon-ebs.amazon-linux:      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.10.20260120.html
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux: ================================================================================
==> amazon-ebs.amazon-linux:   Verifying        : nodejs-npm-1:10.8.2-1.18.20.8.1.amzn2023.0.2.x86_64    6/6
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux: Installed:
==> amazon-ebs.amazon-linux:   libbrotli-1.0.9-4.amzn2023.0.2.x86_64
==> amazon-ebs.amazon-linux:   nodejs-1:18.20.8-1.amzn2023.0.2.x86_64
==> amazon-ebs.amazon-linux:   nodejs-docs-1:18.20.8-1.amzn2023.0.2.noarch
==> amazon-ebs.amazon-linux:   nodejs-full-i18n-1:18.20.8-1.amzn2023.0.2.x86_64
==> amazon-ebs.amazon-linux:   nodejs-libs-1:18.20.8-1.amzn2023.0.2.x86_64
==> amazon-ebs.amazon-linux:   nodejs-npm-1:10.8.2-1.18.20.8.1.amzn2023.0.2.x86_64
==> amazon-ebs.amazon-linux:
==> amazon-ebs.amazon-linux: Complete!
==> amazon-ebs.amazon-linux: Stopping the source instance...
==> amazon-ebs.amazon-linux: Stopping instance
==> amazon-ebs.amazon-linux: Waiting for the instance to stop...
==> amazon-ebs.amazon-linux: Creating AMI sample-app-packer-xxxxx from instance i-xxxxx
==> amazon-ebs.amazon-linux: Attaching run tags to AMI...
==> amazon-ebs.amazon-linux: AMI: ami-xxxxx
==> amazon-ebs.amazon-linux: Waiting for AMI to become ready...
==> amazon-ebs.amazon-linux: Skipping Enable AMI deprecation...
==> amazon-ebs.amazon-linux: Skipping Enable AMI deregistration protection...
==> amazon-ebs.amazon-linux: Modifying attributes on AMI (ami-xxxxx)...
==> amazon-ebs.amazon-linux: Modifying: description
==> amazon-ebs.amazon-linux: Modifying attributes on snapshot (snap-xxxxx)...
==> amazon-ebs.amazon-linux: Terminating the source AWS instance...
==> amazon-ebs.amazon-linux: Cleaning up any extra volumes...
==> amazon-ebs.amazon-linux: No volumes to clean up, skipping
==> amazon-ebs.amazon-linux: Deleting temporary security group...
==> amazon-ebs.amazon-linux: Deleting temporary keypair...
Build 'amazon-ebs.amazon-linux' finished after 4 minutes 13 seconds.

==> Wait completed after 4 minutes 13 seconds

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs.amazon-linux: AMIs were created:
ap-southeast-4: ami-xxxxx

$
```
