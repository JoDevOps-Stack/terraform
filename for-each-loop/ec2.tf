resource "aws_instance" "this" { # "this" means name of resource
  for_each = var.instances # terraform will give us a variable called ecah
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_loop.id]
  instance_type          = each.value 
  tags = {
    Name = each.key # name of instance what we want to give
  }
}


resource "aws_security_group" "allow_loop" { #here allow_tls is the name of resource,we can give anything
  name        = "allow_loop"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "allow_loop"
  }
}

output "ec2_info" {
  value = aws_instance.this
}