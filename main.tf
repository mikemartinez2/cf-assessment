terraform {
  backend "s3" {
    bucket = "coalfire-techassessment-tf-state"
    key    = "techassessment.tfstate"
    region = "us-east-1"
  }
}

data "aws_ami" "redhat_8" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["RHEL-8.*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  availability_zones = ["us-east-1b", "us-east-1a"]
  public_subnet_cidrs = ["10.1.0.0/24", "10.1.1.0/24"]
  private_subnet_cidrs = ["10.1.2.0/24", "10.1.3.0/24"]
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2_instance" {
  source            = "./modules/ec2_instance"
  ami               = data.aws_ami.redhat_8.id
  instance_type     = var.instance_type
  subnet_id         = element(module.vpc.public_subnets, 1)
  user_data         = file("./user_data.sh")
  key_name          = var.key_name
  security_group_id = module.security_groups.ec2_sg_id
}

module "asg" {
  source               = "./modules/asg"
  ami                  = data.aws_ami.redhat_8.id
  instance_type        = var.instance_type
  private_subnets      = module.vpc.private_subnets
  user_data            = file("./user_data.sh")
  asg_instance_profile = module.iam.asg_instance_profile
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  security_group_id = module.security_groups.alb_sg_id
}

module "s3" {
  source = "./modules/s3"
  s3_logging_role = module.iam.s3_logging_role
}

module "iam" {
  source = "./modules/iam"
}


