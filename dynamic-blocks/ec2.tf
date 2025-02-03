resource "aws_instance" "this" { # "this" means name of resource
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_ports.id]
  instance_type          = "t3.micro"
  tags = {
    Name = "terraform-demo" # name of instance what we want to give
  }
}


resource "aws_security_group" "allow_ports" { #here allow_tls is the name of resource,we can give anything
  name        = "allow_ports"
  description = "Allow TLS inbound traffic and all outbound traffic"

   dynamic "ingress" {  #map 
    for_each = var.ingress_ports   #for each loop 
    content {
    from_port   = ingress.value["from_port"]
    to_port     = ingress.value["to_port"]
    protocol    = ingress.value["protocol"]
    cidr_blocks = ingress.value["cidr_blocks"]
  }
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