output "public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "sg_web_id" {
  value = aws_security_group.web.id
}
