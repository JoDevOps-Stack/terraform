output "public_ip" {                     #here output giving for users
    value = aws_instance.this.public_ip     
}

output "private_ip" {
    value = aws_instance.this.private_ip
}