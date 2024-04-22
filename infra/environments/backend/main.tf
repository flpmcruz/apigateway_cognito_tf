

module "prod_backend" {
  source      = "../../modules/s3_dynamo_backend"
  bucket_name = var.prod_backend_bucket_name
  table_name  = var.prod_backend_table_name
}

module "dev_backend" {
  source      = "../../modules/s3_dynamo_backend"
  bucket_name = var.dev_backend_bucket_name
  table_name  = var.dev_backend_table_name
}
