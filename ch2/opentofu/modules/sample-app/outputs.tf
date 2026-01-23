output "instance_id" {
  description = "EC2 instance ID"
  value = aws_instance.sample_app.id
}

output "security_group_id" {
  description = "Security group ID"
  value = aws_security_group.sample_app.id
}

output "public_ip" {
  description = "Public IP of EC2 instance"
  value = aws_instance.sample_app.public_ip
}
