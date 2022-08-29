resource "aws_security_group" "sg-jenkins" {
  name = "jenkins-sg"
  ingress {
    from_port   = var.http_jenkins_port
    to_port     = var.http_jenkins_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { #all ports allowed
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}