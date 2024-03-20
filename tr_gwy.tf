# create transit gateway for ec2 instance
resource "aws_ec2_transit_gateway" "transit_gateway" {
  description                     = "Transit gateway for onprem ec2 instance"
}


# Attach On-Prem VPC to Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "onprem_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.onprem.id
  subnet_ids         = [aws_subnet.public_subnet_onprem.id]
}


# Attach Prod VPC to Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "prod_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.prod_vpc.id
  subnet_ids         = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}


# Attach nonprod VPC to Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "nonprod_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.nonprod.id
  subnet_ids         = [aws_subnet.private_subnet_nonprod.id]
}