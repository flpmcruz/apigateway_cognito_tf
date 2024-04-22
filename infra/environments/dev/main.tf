locals {
  common_tags = {
    Environment = var.environment
    Owner       = "DevOps Team"
  }
}

module "my_website" {
  source      = "../../modules/s3_website_cloudfront"
  name        = "${var.distribution_name}-${var.environment}"
  price_class = var.price_class

  tags = local.common_tags
}

module "apigateway" {
  source            = "../../modules/apigateway"
  name              = "${var.api_name}-${var.environment}"
  api_resource_path = var.api_resource_path
  stage_name        = var.environment
  pool_name         = "${var.pool_name}-${var.environment}"

  lambda_name      = "${var.lambda_name}-${var.environment}"
  source_code_path = "../../../backend/dev/index.js"

  waf_acl_name   = "${var.waf_acl_name}-${var.environment}"
  create_waf_acl = false

  tags = local.common_tags
}
