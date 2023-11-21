# Creating VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "terra-vpc"
    env = var.env_name
  }
}

# Creating Public Subnets
resource "aws_subnet" "terra_pub" {
  vpc_id = aws_vpc.terra_vpc.id
  count = length(var.cidr_pub_subnet)
  cidr_block = var.cidr_pub_subnet[count.index]
  availability_zone = element(["ap-south-1a", "ap-south-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "terra-pub${count.index + 1}"
    env = var.env_name
  }
}
