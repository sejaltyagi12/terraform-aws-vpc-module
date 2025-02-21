#VPC
output "vpc_id" {
  value = aws_vpc.main.id
}

#we use locals for data processing
locals {
  #To format the subnet IDs which may be multiples in format of subnet_name = {id=, az=}
  public_subnet_output = {
    for key, config in local.public_subnet : key => {
      subnet_id = aws_subnet.main[key].id
      az        = aws_subnet.main[key].availability_zone
    }
  }

  private_subnet_output = {
    for key, config in local.private_subnet : key => {
      subnet_id = aws_subnet.main[key].id
      az        = aws_subnet.main[key].availability_zone
    }
  }
}

output "public_subnets" {
  value = local.public_subnet_output
}

output "private_subnets" {
  value = local.private_subnet_output
}

output "security_group_ids" {
  description = "List of security group IDs"
  value       = { for key, sg in aws_security_group.sg : key => sg.id }
}
