output "ec2_instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_profile.id
}

output "asg_instance_profile" {
  value = aws_iam_instance_profile.asg_instance_profile.id
}

output "s3_logging_role" {
  value = aws_iam_role.s3_logging_role.name
}