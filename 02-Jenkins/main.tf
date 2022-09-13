
resource "aws_instance" "Jenkins" {
  #ami      = data.aws_ami.ubuntu.id # Latest Ubuntu 20.04
  ami = "ami-07702eb3b2ef420a9" # force AMI to avoid reinstalling
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg-jenkins.id]
  iam_instance_profile =  aws_iam_instance_profile.jenkins_ec2_profile.name
  key_name = var.ssh_key_name # SSH Key
 
  tags = {
    Name = var.instance_name
  }
}

# RUN Manually On-Demand
# terraform taint null_resource.jenkins_installer
# terraform apply -target="null_resource.jenkins_installer"
resource "null_resource" "jenkins_installer" {
  triggers = {
    #No triggers to automatic re-install, just execute on first deploy or on-demand.
  }
  provisioner "file" {
    source = "jenkins.sh"
    destination = "/tmp/jenkins.sh"
    connection {
      type="ssh"
      user="ubuntu"
      private_key= file(var.ssh_key_file)
      host = aws_instance.Jenkins.public_ip
    }
  }
  provisioner "remote-exec" {
    connection {
      type="ssh"
      user="ubuntu"
      private_key= file(var.ssh_key_file)
      host = aws_instance.Jenkins.public_ip
    }
    inline = [
      "chmod +x /tmp/jenkins.sh",
      "/tmp/jenkins.sh"
    ]
  }    
}





