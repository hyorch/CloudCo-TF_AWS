output "server_dns" {
    value = aws_instance.webserver.public_dns
}