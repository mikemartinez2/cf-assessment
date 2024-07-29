Terraform AWS Infrastructure

This project sets up a basic AWS infrastructure using Terraform. The setup includes a VPC, EC2 instance, Auto Scaling Group (ASG), Application Load Balancer (ALB), S3 buckets, IAM roles, and security groups.

```bash
project/
├── main.tf
├── variables.tf
├── outputs.tf
├── user_data.sh
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── asg/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── security_groups/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```