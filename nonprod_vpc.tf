# nonprod vpc

resource "aws_vpc" "nonprod" {
  cidr_block = "172.19.0.0/24"  
  tags = {
     Name = "nonprod vpc"
  }
}

# create private subnet

resource "aws_subnet" "private_subnet_nonprod" {
  vpc_id                  = aws_vpc.nonprod.id
  cidr_block              = "172.19.0.0/25"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  
  tags = {
    Name = "private subnet in nonprod"
  }
}


