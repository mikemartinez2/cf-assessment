output "s3_bucket_images" {
  value = aws_s3_bucket.images.bucket
}

output "s3_bucket_logs" {
  value = aws_s3_bucket.logs.bucket
}

output "s3_bucket_logs_arn" {
  value = aws_s3_bucket.logs.arn
}