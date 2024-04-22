resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "revbucket-${random_string.random.result}"
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "my-config" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}

#############################################################################################################
## Bucket Policy
#############################################################################################################
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

locals {
  origin = "S3-Origin-${random_string.random.result}"
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = local.origin
  description                       = "Descripcion OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "Policy",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.bucket.arn}/*"
      }
    ]
  })
}

#############################################################################################################
## CloudFront
#############################################################################################################
resource "aws_cloudfront_distribution" "my-distribution" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id                = local.origin
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin

    viewer_protocol_policy = "redirect-to-https"

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }
  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 0
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

#############################################################################################################
## Provisioning the website
#############################################################################################################
# resource "aws_s3_object" "build" {
#   for_each     = fileset("../frontend/dist/", "**")
#   bucket       = aws_s3_bucket.bucket.id
#   key          = each.value
#   source       = "../frontend/dist//${each.value}"
#   etag         = filemd5("../frontend/dist/${each.value}")
#   content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.key), null)
# }
# locals {
#   s3_origin_id = "myS3Origin"
#   mime_types = {
#     ".html" = "text/html"
#     ".png"  = "image/png"
#     ".jpg"  = "image/jpeg"
#     ".gif"  = "image/gif"
#     ".css"  = "text/css"
#     ".js"   = "application/javascript"
#   }
# }
