resource "aws_instance" "webserver" {
  ami      = data.aws_ami.ubuntu.id # Latest Ubuntu 20.04
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg-webserver.id]  
  #subnet_id = "subnet-0ef5e6f0e925bb4df"
  subnet_id = data.terraform_remote_state.vpc_state.outputs.vpc_nets_id[0].id
  key_name = var.ssh_key_name # SSH Key

  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World $HOSTNAME !" > index.html
              nohup busybox httpd -f -p "${var.http_port}" &
              EOF
 
  tags = {
    Name = var.server_name
  }  
  
}