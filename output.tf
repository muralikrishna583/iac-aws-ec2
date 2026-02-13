output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP address"
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "Private IP address"
  value       = aws_instance.this.private_ip
}

output "root_volume_id" {
  description = "Root EBS volume ID"
  value       = try(aws_instance.this.root_block_device[0].volume_id, null)
}

output "ebs_volume_id" {
  description = "Additional EBS volume ID (if created)"
  value       = try(aws_instance.this.ebs_block_device[0].volume_id, null)
}
