resource "aws_s3_bucket" "images" {
  bucket = "coalfire-images"

}

resource "aws_s3_bucket" "logs" {
  bucket = "coalfire-logs"

}

resource "aws_s3_object" "Memes" {
    bucket = "aws_s3_bucket.images.id"
    key    = "Memes"
    #source = "images/Memes/"
}

resource "aws_s3_object" "Active" {
    bucket = "aws_s3_bucket.logs.id"
    key    = "Active"
    # source = "logs/Active/"
}

resource "aws_s3_object" "Inactive" {
    bucket = "aws_s3_bucket.logs.id"
    key    = "Inactive"
    # source = "logs/Inactive/"
}

resource "aws_s3_bucket_policy" "log_bucket_policy" {
  bucket = aws_s3_bucket.logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:PutObject",
        "s3:PutObjectAcl"
      ]
      Effect   = "Allow"
      Resource = "${aws_s3_bucket.logs.arn}/*"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.s3_logging_role}"
      }
    }]
  })
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_lifecycle_configuration" "images" {
  bucket = aws_s3_bucket.images.id

  rule {
    id = "archive"

    # expiration {
    #   days = 90
    # }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id = "active"

    filter {
      prefix = "logs/Active/"
    }

    # expiration {
    #   days = 90
    # }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    status = "Enabled"
  }

  rule {
    id = "Inactive"

    filter {
      prefix = "logs/Inactive/"
    }

    expiration {
      days = 90
    }

    status = "Enabled"
  }
}

