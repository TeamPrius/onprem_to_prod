# route table for onprem
resource "aws_route_table" "onprem_transit_gateway_route" {
  vpc_id = aws_vpc.onprem.id

  route {
    cidr_block         = aws_subnet.public_subnet_1.cidr_block         # put aws_vpc.prod_vpc.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

  route {
    cidr_block         = aws_subnet.public_subnet_2.cidr_block         # not necessary
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id    # not necessary
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.onprem_igw.id
  }

  #route {
  #  cidr_block         = aws_subnet.private_subnet_nonprod.cidr_block       # put aws_vpc.nonprod_vpc.cidr_block
  #  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  #}
}


#Create Public Route table associations

resource "aws_route_table_association" "onprem_internet_gateway_route_association" {
  subnet_id      = aws_subnet.public_subnet_onprem.id
  route_table_id = aws_route_table.onprem_transit_gateway_route.id
}
