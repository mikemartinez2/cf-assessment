variable "ami" {
  description = "AMI ID for the ASG instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the ASG instances"
  type        = string
}

variable "private_subnets" {
  description = "Subnets for the ASG instances"
  type        = list(string)
}

variable "user_data" {
  description = "User data script"
  type        = string
}

variable "asg_instance_profile" {
  description = "IAM instance profile for ASG instances"
  type        = string
}
