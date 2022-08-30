terraform {
  backend "s3" {
    # Replace this with your bucket data. NO VARS ARE ALLOWED IN BACKEND SECTION
    bucket = "cloudco-demo-tf-state"
    key    = "03-VPC/terraform.tfstate"
    region = "eu-west-1"
  }
}