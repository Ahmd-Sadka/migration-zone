# output "my_key" {
#   value = aws_key_pair.my_key_pair.key_name
# }

output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.compute_instances[*].id
}

output "instance_public_ips" {
  description = "Public IPs of the created instances"
  value       = aws_instance.compute_instances[*].public_ip
}