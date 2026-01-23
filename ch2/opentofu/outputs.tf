output "sample_app_1_instance_id" {
  description = "EC2 instance ID 1"
  value = module.sample_app_1.instance_id
}

output "sample_app_1_security_group_id" {
  description = "Security group ID 1"
  value = module.sample_app_1.security_group_id
}

output "sample_app_1_public_ip" {
  description = "Public IP of EC2 instance 1"
  value = module.sample_app_1.public_ip
}

output "sample_app_2_instance_id" {
  description = "EC2 instance ID 2"
  value = module.sample_app_2.instance_id
}

output "sample_app_2_security_group_id" {
  description = "Security group ID 2"
  value = module.sample_app_2.security_group_id
}

output "sample_app_2_public_ip" {
  description = "Public IP of EC2 instance 2"
  value = module.sample_app_2.public_ip
}
