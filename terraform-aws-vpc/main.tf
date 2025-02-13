resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames   
  instance_tenancy = "default"     #in general it is default               
  
  #expense-dev
  tags = merge(
    var.common_tags,
    {
      Name = local.resource_name  
    }
  )
  }

resource "aws_internet_gateway" "main" {   #creating IGW
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
        Name = local.resource_name 
    }

  )
    
  }
#expense-dev-public-us-east-1a
resource "aws_subnet" "public" {             # creating subnets
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    var.public_subnet_tags,
   
   {
    
    Name = "${local.resource_name}-public-${local.az_names[count.index]}"
  }

)

}
#expense-dev-private-us-east-1a
resource "aws_subnet" "private" {    
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.private_subnet_tags,
   
   {
    
    Name = "${local.resource_name}-private-${local.az_names[count.index]}"
  }

)

}

#expense-dev-database-us-east-1a
resource "aws_subnet" "database" {    
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.common_tags,
    var.database_subnet_tags,
   
   {
    
    Name = "${local.resource_name}-database-${local.az_names[count.index]}"
  }

)

}

resource "aws_eip" "nat" {       # creating Elastic IP
  domain   = "vpc"
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.id        #connecting Elastc IP to NAT
  subnet_id     = aws_subnet.public[0].id        # connecting NAT to 2 private subnets

  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,
    {
      Name = local.resource_name
    }
  )
   depends_on = [aws_internet_gateway.main]

  }
    #expense-dev-public (route name)
  resource "aws_route_table" "public" {          # creating route table
  vpc_id = aws_vpc.main.id
   
  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
      Name = "${local.resource_name}-public"
    }

  )
  }


#expense-dev-private (route name)
  resource "aws_route_table" "private" {          # creating route table
  vpc_id = aws_vpc.main.id
   
  tags = merge(
    var.common_tags,
    var.private_route_table_tags,
    {
      Name = "${local.resource_name}-private"
    }

  )
  }

  #expense-dev-database(route name)
  resource "aws_route_table" "database" {          # creating route table
  vpc_id = aws_vpc.main.id
   
  tags = merge(
    var.common_tags,
    var.database_route_table_tags,
    {
      Name = "${local.resource_name}-database"
    }
  )
}

resource "aws_route" "public" {    # connecting IGW to public route
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id   # here gateway id sytax
}

resource "aws_route" "private" {   # connecting NAT to private route
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.example.id  # here gateway id sytax
}

resource "aws_route" "database" { # connecting NAT to database route
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.example.id  # here gateway id sytax
}

resource "aws_route_table_association" "public" {  # associating route to public subnet
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {  # associating route to public subnet
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {  # associating route to public subnet
  count = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}
