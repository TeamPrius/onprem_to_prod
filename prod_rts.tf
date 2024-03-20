# Presentation Layer Public Route Table For Public Subnets
resource "aws_route_table" "transit_gateway_route" {   # bad name, be specific
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = aws_subnet.public_subnet_onprem.cidr_block                 # use aws_vpc.onprem_vpc.cidr_block
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }

  tags = {
    Name = "PublicRouteTable1"
  }
}


#Create Public Route table1 associations

resource "aws_route_table_association" "availability_zone_1_transit_gateway_route_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.transit_gateway_route.id
}

resource "aws_route_table_association" "availability_zone_2_transit_gateway_route_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.transit_gateway_route.id
}
###########################################################################################


# Business Logic Layer Private Route Table For Private Subnet 3

resource "aws_route_table" "bus_log_layer_rt" {                                       # add additional route from app layer to onprem vpc
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_availability_zone_1.id
  }
}


# create public route table association for Private Subnet 1
resource "aws_route_table_association" "bus_log_layer_rta_availability_zone_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.bus_log_layer_rt.id
}


# create private route table association for Private Subnet 3
resource "aws_route_table_association" "bus_log_layer_rta" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.bus_log_layer_rt.id
}


###########################################################################################





#Database Storage Layer Private Route Table for Private Subnet 2

resource "aws_route_table" "pvtroute2" {                               # add additional route from app layer to onprem vpc
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_availability_zone_1.id
  }


  tags = {
    Name = "PrivateRouteTable2"
  }
}


#Create Private Route table2 association for Private Subnet 2


resource "aws_route_table_association" "pvtrta2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.pvtroute2.id
}





# Database Storage Layer Private Route Table for Private Subnet 4
resource "aws_route_table" "data_stor_layer_rt" {
  vpc_id = aws_vpc.prod_vpc.id
}


# create private route table association for Private Subnet 4
resource "aws_route_table_association" "data_stor_layer_rta" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.data_stor_layer_rt.id
}