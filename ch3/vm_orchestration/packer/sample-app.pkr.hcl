packer {
  required_plugins  {
    amazon = {
      version = ">= 1.8.0"
      source = "github.com/hashicorp/amazon"
    }
  }
}

data "amazon-ami" "amazon-linux" {  # Use the amazon-ami data source to look up an amazon linux machine image
  filters = {
    name = "al2023-ami-2023.*-x86_64"
  }
  owners = ["amazon"]
  most_recent = true
  region = "ap-southeast-4"
}

source "amazon-ebs" "amazon-linux" {  # Packer creates an EC2 instance to work in
  ami_name = "sample-app-packer-${uuidv4()}"
  ami_description = "Amazon Linux AMI with node sample app"
  instance_type = "t3.micro"
  region = "ap-southeast-4"
  source_ami = data.amazon-ami.amazon-linux.id  # The machine image that is spun up is the amazon AMI from above
  ssh_username = "ec2-user"
}

build {  # An ordered sequence of build steps that Packer runs in the source.amazon-ebs.amazon-linux instance
  sources = ["source.amazon-ebs.amazon-linux"]

  provisioner "file" {  # Copy this file into the image.
    sources = ["sample_app"]
    destination = "/tmp/"
  }

  provisioner "shell" {  # Run this script
    script = "install-node.sh"
    pause_before = "30s"
  }
}
