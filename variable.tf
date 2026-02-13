variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  validation {
    condition     = var.use_ami_lookup || length(var.ami_id) > 0
    error_message = "ami_id must not be empty unless `use_ami_lookup` is true"
  }
}

variable "use_ami_lookup" {
  description = "If true, look up the AMI using `ami_name_filter` and `ami_owners` instead of using `ami_id`"
  type        = bool
  default     = false
}

variable "ami_name_filter" {
  description = "Name filter (glob) used to find the latest AMI when `use_ami_lookup` is true"
  type        = string
  default     = ""
  validation {
    condition     = !var.use_ami_lookup || length(var.ami_name_filter) > 0
    error_message = "ami_name_filter must be set when use_ami_lookup is true"
  }
}

variable "ami_owners" {
  description = "List of owner IDs or aliases (e.g. 'amazon') to filter AMIs when `use_ami_lookup` is true"
  type        = list(string)
  default     = ["amazon"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where instance will be launched"
  type        = string
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "subnet_id must not be empty"
  }
}

variable "security_group_ids" {
  description = "List of Security Group IDs"
  type        = list(string)
  validation {
    condition     = length(var.security_group_ids) > 0
    error_message = "security_group_ids must contain at least one security group id"
  }
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
  validation {
    condition     = length(var.instance_name) > 0
    error_message = "instance_name must not be empty"
  }
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 8
  validation {
    condition     = var.root_volume_size > 0
    error_message = "root_volume_size must be greater than 0"
  }
}

variable "root_volume_type" {
  description = "Root EBS volume type"
  type        = string
  default     = "gp3"
  validation {
    condition = contains(["gp2", "gp3", "io1", "io2", "st1", "sc1", "standard"], var.root_volume_type)
    error_message = "root_volume_type must be a valid EBS volume type (gp2, gp3, io1, io2, st1, sc1, standard)"
  }
}

variable "root_volume_encrypted" {
  description = "Whether the root volume is encrypted"
  type        = bool
  default     = true
}

variable "root_delete_on_termination" {
  description = "Whether to delete the root volume on instance termination"
  type        = bool
  default     = true
}

variable "add_ebs_volume" {
  description = "Create an additional EBS volume alongside the root volume"
  type        = bool
  default     = false
}

variable "ebs_device_name" {
  description = "Device name for the additional EBS volume"
  type        = string
  default     = "/dev/sdh"
  validation {
    condition     = can(regex("^/dev/[a-z0-9]+$", var.ebs_device_name)) && regex("^/dev/[a-z0-9]+$", var.ebs_device_name)
    error_message = "ebs_device_name must be a valid device path like /dev/sdh"
  }
}

variable "ebs_volume_size" {
  description = "Size (GB) for the additional EBS volume"
  type        = number
  default     = 20
  validation {
    condition     = var.ebs_volume_size > 0
    error_message = "ebs_volume_size must be greater than 0"
  }
}

variable "ebs_volume_type" {
  description = "Type for the additional EBS volume"
  type        = string
  default     = "gp3"
  validation {
    condition = contains(["gp2", "gp3", "io1", "io2", "st1", "sc1", "standard"], var.ebs_volume_type)
    error_message = "ebs_volume_type must be a valid EBS volume type (gp2, gp3, io1, io2, st1, sc1, standard)"
  }
}

variable "ebs_encrypted" {
  description = "Whether the additional EBS volume is encrypted"
  type        = bool
  default     = true
}

variable "ebs_delete_on_termination" {
  description = "Whether to delete the additional EBS volume on instance termination"
  type        = bool
  default     = true
}
