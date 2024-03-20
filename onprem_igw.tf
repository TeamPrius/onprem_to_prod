# create internet gateway
resource "aws_internet_gateway" "onprem_igw" {
  vpc_id = aws_vpc.onprem.id

  tags = {
    Name = "on Prem VPC Internet Gateway"
  }
}



