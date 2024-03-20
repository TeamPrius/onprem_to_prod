# create internet gateway for prod environment
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "Prod VPC Internet Gateway"
  }
}


