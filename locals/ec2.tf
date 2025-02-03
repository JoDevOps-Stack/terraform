resource "aws_instance" "this" { # "this" means name of resource
  ami                    = local.ami_id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = local.instance_type
  tags = {
    Name = local.name # name of instance what we want to give
  }
}


resource "aws_security_group" "allow_tls" { #here allow_tls is the name of resource,we can give anything
  name        = "allow_tls_changed"
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
    Name = "allow_tls"
  }
}