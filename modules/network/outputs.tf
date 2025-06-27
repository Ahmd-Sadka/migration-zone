output "vpc_id" {
  value = aws_vpc.zone_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.zone_public_subnets[*].id
}

output "igw_id" {
  value = aws_internet_gateway.zone_igw.id
}

output "security_group_id" {
  value = aws_security_group.zone_public_sg.id
}