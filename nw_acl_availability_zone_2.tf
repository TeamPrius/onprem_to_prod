# create network access control lists for both availability zones

# network access control list for presentation layer in both zones
resource "aws_network_acl" "presentation_network_acl_availability_zone_2" {
  vpc_id     = aws_vpc.prod_vpc.id
  subnet_ids = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  # incoming rules
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # outgoing rules
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "NACL For Presentation Layer "
  }

}
##########################################################################################

# network access control list for business logic layer
resource "aws_network_acl" "bus_log_network_acl_availability_zone_2" {
  vpc_id     = aws_vpc.prod_vpc.id
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_3.id]

  # incoming rule for CIDR block 10.0.1.0/24
  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 80
    to_port    = 80
  }


  # incoming rule for CIDR block 10.0.4.0/24
  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "10.0.4.0/24"
    from_port  = 80
    to_port    = 80
  }



  # outgoing rule for CIDR block 10.0.1.0/24
  egress {
    protocol   = "tcp"
    rule_no    = 201
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 80
    to_port    = 80
  }
  
  
  
  
  # outgoing rule for CIDR block 10.0.4.0/24
  egress {
    protocol   = "tcp"
    rule_no    = 202
    action     = "allow"
    cidr_block = "10.0.4.0/24"
    from_port  = 80
    to_port    = 80
  }
  
}
##########################################################################################


# network access control list for database layer
resource "aws_network_acl" "database_network_acl_availability_zone_2" {
  vpc_id     = aws_vpc.prod_vpc.id
  subnet_ids = [aws_subnet.private_subnet_2.id, aws_subnet.private_subnet_4.id]

  # incoming rule for CIDR block "10.0.2.0/24"
  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "10.0.2.0/24" 
    from_port  = 3306
    to_port    = 3306
  }





   # incoming rule for CIDR block "10.0.5.0/24"
    ingress {
    protocol   = "tcp"
    rule_no    = 104
    action     = "allow"
    cidr_block = "10.0.5.0/24" 
    from_port  = 3306
    to_port    = 3306
  }

   
   
   
   
   
   
   
   
  # outgoing rule for CIDR block 10.0.2.0/24
  egress {
    protocol   = "tcp"
    rule_no    = 203
    action     = "allow"
    cidr_block = "10.0.2.0/24"
    from_port  = 3306
    to_port    = 3306
  }
  
  
  
  
    # outgoing rule for CIDR block 10.0.5.0/24
	egress {
    protocol   = "tcp"
    rule_no    = 204
    action     = "allow"
    cidr_block = "10.0.5.0/24"
    from_port  = 3306
    to_port    = 3306
  }
  
	
	
	
	}