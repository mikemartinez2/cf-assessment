resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "Coalfire-EC2-Instance-Sub2"
  }

  user_data = var.user_data

  security_groups = [var.security_group_id]
}
