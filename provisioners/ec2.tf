resource "aws_instance" "this" { # "this" means name of resource
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  tags = {
    Name = "terraform-demo" # name of instance what we want to give
  }
  
  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory"
  }

  connection {
    type      = "ssh"
    user      = "ec2-user"
    password  = "DevOps321"         
    host      = self.public_ip    #to connect server public ip should give.
                                     # from owr lapy we cant connect with private ip
  }

  provisioner "remote-exec" {
    when = destroy
    inline = [
    "sudo systemctl stop nginx",
    ]
}

}
resource "aws_security_group" "allow_tls" { #here allow_tls is the name of resource,we can give anything
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp" # tcp means internet protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" # tcp means internet protocol
    cidr_blocks = ["0.0.0.0/0"]
   }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "allow_tls"
  }
}
