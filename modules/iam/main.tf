resource "aws_iam_role" "ec2_role" {
  name = "coalfire-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "coalfire-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "asg_role" {
  name = "coalfire-asg-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "asg_policy_attachment" {
  role       = aws_iam_role.asg_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_instance_profile" "asg_instance_profile" {
  name = "coalfire-asg-instance-profile"
  role = aws_iam_role.asg_role.name
}

resource "aws_iam_role" "s3_logging_role" {
  name = "coalfire-s3-logging-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_logging_policy" {
  name        = "coalfire-s3-logging-policy"
  description = "Policy to allow writing logs to S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:PutObject",
        "s3:PutObjectAcl"
      ]
      Resource = [
        "arn:aws:s3:::logs/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_logging_policy_attachment" {
  role       = aws_iam_role.s3_logging_role.name
  policy_arn = aws_iam_policy.s3_logging_policy.arn
}