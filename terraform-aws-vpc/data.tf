data "aws_availability_zones" "available" {   # To see the availability zones
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_route_table" "main" {   # to get route table id of default vpc
  vpc_id = local.default_vpc_id
  filter {
    name = "association.main"
    values = ["true"]
  }
}