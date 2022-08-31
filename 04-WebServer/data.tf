data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

data "terraform_remote_state" "dev" {
  backend = "s3"
  config = {
    bucket = "cloudco-demo-tf-state"
    key    = "03-VPC-dev/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-locks"
  }
}

data "terraform_remote_state" "prod" {
  backend = "s3"
  config = {
    bucket = "cloudco-demo-tf-state"
    key    = "03-VPC-dev/terraform.tfstate"
    region = "eu-west-1"   
  }
}