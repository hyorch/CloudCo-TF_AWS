terraform {
  backend "s3" {
    # Replace this with your bucket data. NO VARS ARE ALLOWED IN BACKEND SECTION
    bucket = "cloudco-demo-tf-state"
    key    = "05-EKS/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-locks"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }
  }

  required_version = "~> 1.2.0"
}



