variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name"
  type        = string
  default     = null
}

variable "associate_public_ip" {
  description = "Associate public IP address"
  type        = bool
  default     = true
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
