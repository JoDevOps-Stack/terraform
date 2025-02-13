resource "aws_instance" "expense" { # "this" means name of resource
   count = length(var.instances)
  #count = 3
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  # tags = {
  #   Name = var.instances[count.index] # name of instance what we want to give
  # } 
  tags = merge( 
    var.common_tags,
    {
      Name = "${var.project}-${var.environment}-${var.instances[count.index]}" #expense-dev-mysql
    }
  )

}

resource "aws_security_group" "allow_tls" { #here allow_tls is the name of resource,we can give anything
  name        = "${var.project}-${var.environment}" #expense-dev, expense-prod
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
    Name = "${var.project}-${var.environment}"
  }
}