output "vpc_id" {
    value = aws_vpc.vpc.id  
}

output "vpc_nets_id" {
    value = aws_subnet.public[*].id
}