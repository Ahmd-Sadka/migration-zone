resource "aws_vpc" "zone_vpc" {  
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge(
    {
      Name = "poc-${var.env}-vpc"
    },
    var.common_tags
  )
    lifecycle {
        prevent_destroy =  false # Set to true to prevent accidental deletion of the VPC
    } 
}

resource "aws_internet_gateway" "zone_igw" {
  vpc_id = aws_vpc.zone_vpc.id
  tags = merge(
    {
      Name = "poc-${var.env}-igw"
    },
    var.common_tags
  )
}

resource "aws_route_table" "zone_public_rt" {
  vpc_id = aws_vpc.zone_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zone_igw.id
  }
    tags = merge(
        {
        Name = "poc-${var.env}-public-rt"
        },
        var.common_tags
    )
}

resource "aws_route_table_association" "zone_public_rt_assoc" {
  count = var.public_subnet_count
  subnet_id = aws_subnet.zone_public_subnets[count.index].id
  route_table_id = aws_route_table.zone_public_rt.id
}

resource "aws_subnet" "zone_public_subnets" {
  count = var.public_subnet_count
  vpc_id = aws_vpc.zone_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
    tags = merge(
        {
        Name = "poc-${var.env}-public-subnet-${count.index + 1}"
        },
        var.common_tags
    )
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_security_group" "zone_public_sg" {
  name        = "poc-${var.env}-sg"
  description = "Security group for compute instances in ${var.env} environment"
  vpc_id      = aws_vpc.zone_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # All protocols
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(
        {
        Name = "poc-${var.env}-sg"
        },
        var.common_tags
    )
}
