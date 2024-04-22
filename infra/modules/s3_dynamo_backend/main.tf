resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = var.bucket_name
}

resource "aws_dynamodb_table" "tfstate-dynamodb-table" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key = "LockID"
}
