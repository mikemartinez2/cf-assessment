variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

# variable "ami" {
#   default = "ami-0dc2d3e4c0f9ebd18" # Update with your desired Red Hat Linux AMI
# }

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "mike-key"
}
