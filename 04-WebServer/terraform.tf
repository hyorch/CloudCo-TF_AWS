terraform {
  backend "s3" {
    # Replace this with your bucket data. NO VARS ARE ALLOWED IN BACKEND SECTION
    bucket = "cloudco-demo-tf-state"
    key    = "04-VPC/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-locks"
  }
}



