resource "aws_launch_configuration" "asg_lc" {
  name          = "coalfire-asg-launch-configuration"
  image_id      = var.ami
  instance_type = var.instance_type
  user_data     = var.user_data

  root_block_device {
    volume_size = 20
  }

  iam_instance_profile = var.asg_instance_profile

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.asg_lc.id
  min_size             = 2
  max_size             = 6
  desired_capacity     = 2
  vpc_zone_identifier  = var.private_subnets

  tag {
    key                 = "Name"
    value               = "Coalfire-ASG-Instance"
    propagate_at_launch = true
  }
}
