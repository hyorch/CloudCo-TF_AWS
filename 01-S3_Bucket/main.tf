# 01- S3 Backend to store VPC tfstatus

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket-name
}

# Enable versioning so we can see the full revision history of our state files
resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = var.bucket-name
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "aes256_encryption" {
  bucket = var.bucket-name
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.bucket-encryption
    }
  }
}

