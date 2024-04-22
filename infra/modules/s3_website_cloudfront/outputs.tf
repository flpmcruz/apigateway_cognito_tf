output "cloudfront_url" {
  value = aws_cloudfront_distribution.my-distribution.domain_name
}
output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}