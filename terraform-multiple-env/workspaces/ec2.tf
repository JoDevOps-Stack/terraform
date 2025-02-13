resource "aws_instance" "this" { 
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = lookup(var.instance_type, terraform.workspace)
  tags = {
    Name = "terraform-demo-${terraform.workspace}"
  }

}

resource "aws_security_group" "allow_tls" { #here allow_tls is the name of resource,we can give anything
  name        = "allow_tls_${terraform.workspace}"
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