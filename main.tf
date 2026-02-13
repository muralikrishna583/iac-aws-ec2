data "aws_ami" "selected" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  owners = var.ami_owners
}

resource "aws_instance" "this" {
  ami                         = var.use_ami_lookup ? data.aws_ami.selected.id : var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = var.root_delete_on_termination
    encrypted             = var.root_volume_encrypted
  }

  dynamic "ebs_block_device" {
    for_each = var.add_ebs_volume ? [1] : []
    content {
      device_name           = var.ebs_device_name
      volume_size           = var.ebs_volume_size
      volume_type           = var.ebs_volume_type
      delete_on_termination = var.ebs_delete_on_termination
      encrypted             = var.ebs_encrypted
    }
  }

  tags = merge(
    {
      Name = var.instance_name
    },
    var.tags
    
  )
}
