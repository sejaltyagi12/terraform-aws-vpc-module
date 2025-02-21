resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  for_each = var.subnet_config

  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags ={
    Name = each.key
  }    
}

locals {
  public_subnet = {
    #key={} if public is true in subnet_config
    for key, config in var.subnet_config : key => config if config.public
  }

  private_subnet = {
    #key={} if public is false in subnet_config
    for key, config in var.subnet_config : key => config if !config.public
  }
}

#Internet Gateway, if there is atleast one public subnet
#The below created ig is not a single ig, it is a list of ig
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet) > 0 ? 1 : 0
}

resource "aws_route_table" "main" {
  count = length(local.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id   #as there is only one ig in the list
  }
}

#It will be different for every public subnet
resource "aws_route_table_association" "main" {
  for_each = local.public_subnet

  subnet_id = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id     #as there is only one route table in the list
} 
