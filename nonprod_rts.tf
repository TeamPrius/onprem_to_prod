#Create Route Table for the private subnet in nonprod

resource "aws_route_table" "nonprod_private_subnet_rt" {
  vpc_id = aws_vpc.nonprod.id
  
  route {
    cidr_block         = aws_vpc.prod_vpc.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
}


resource "aws_route_table_association" "nonprod_private_subnet_rta" {
  subnet_id      = aws_subnet.private_subnet_nonprod.id
  route_table_id = aws_route_table.nonprod_private_subnet_rt.id
}