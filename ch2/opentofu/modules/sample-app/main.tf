resource "aws_security_group" "sample_app" {  # The general syntax for a resource is "<provider>_<type>" "<name>"
  name = var.name
  description = "Allow traffic for ${var.name}"
}

# Book example
# Note that this is not best practice. Best practice is using aws_vpc_security_group_ingress_rule and aws_vpc_security_group_egress_rule
# resource "aws_security_group_rule" "allow_inbound_http" {
#   type = "ingress"
#   protocol = "tcp"
#   from_port = 8080  # start of port range
#   to_port = 8080  # end of port range
#   security_group_id = aws_security_group.sample_app.id
#   cidr_blocks = ["0.0.0.0/0"]
# }

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_ssh" {
  security_group_id = aws_security_group.sample_app.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_http" {
  security_group_id = aws_security_group.sample_app.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  ip_protocol = "tcp"
  to_port     = 8080
}

data "aws_ami" "sample_app" {
  filter {
    name = "name"
    values = ["sample-app-packer-*"]
  }
}

resource "aws_instance" "sample_app" {
  ami = data.aws_ami.sample_app.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sample_app.id]
  user_data = file("${path.module}/user-data.sh")

  # Edit to add ssh functionality
  # Interestingly, adding a key forces replacement of the resource
  key_name = "mykey"
  #

  tags = {
    Name = var.name
  }
}
