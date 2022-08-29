output "instance_public_ip" {
  description = "Public IP address of the Jenkins instance"
  value       = aws_instance.Jenkins.public_ip
}

output "jenkins_dns_name" {
  description = "Public DNS address of the Jenkins instance"
  value       = aws_instance.Jenkins.public_dns
}