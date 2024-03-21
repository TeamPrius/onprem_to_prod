# create security groups and ingress/egress rules

# Presentation Layer


# Availability Zone 1


#Create Security Group for Web Server
resource "aws_security_group" "appsg" {
  name        = "app_sg"
  description = "Security Group for the jump server"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "App-SG"
  }
}

#Inbound rule
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_pings" {
  security_group_id            = aws_security_group.appsg.id
  #referenced_security_group_id = 
  cidr_ipv4         = "0.0.0.0/0"
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}


#Outbound rule
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.appsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



# Availability Zone 2


# security group for Presentation Layer Availability Zone 2
#resource "aws_security_group" "presentation_layer_sg_availability_zone_2" {
#  name        = "Pres-SG-Availability-Zone-2"
#  description = "Security group for Presentation Layer of availability zone 2"
#  vpc_id      = aws_vpc.prod_vpc.id
#
#  tags = {
#    Name = "Pres-SG-Availability-Zone-2"
#  }
#}


# incoming rules

# allow http access from internet
#resource "aws_vpc_security_group_ingress_rule" "presentation_layer_ingr_availability_zone_2" {
#  security_group_id = aws_security_group.presentation_layer_sg_availability_zone_2.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 80
#  to_port           = 80
#  ip_protocol       = "tcp"
#}

# allow ssh access from internet
#resource "aws_vpc_security_group_ingress_rule" "ssh_presentation_layer_ingr_availability_zone_2" {
#  security_group_id = aws_security_group.presentation_layer_sg_availability_zone_2.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 22
#  to_port           = 22
#  ip_protocol       = "tcp"
#}

# allow https access from internet
#resource "aws_vpc_security_group_ingress_rule" "https_presentation_layer_ingr_availability_zone_2" {
#  security_group_id = aws_security_group.presentation_layer_sg_availability_zone_2.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 443
#  to_port           = 443
#  ip_protocol       = "tcp"
#}

# allow ping access from internet
#resource "aws_vpc_security_group_ingress_rule" "ping_presentation_layer_ingr_availability_zone_2" {
#  security_group_id = aws_security_group.presentation_layer_sg_availability_zone_2.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 8
#  to_port           = 0
#  ip_protocol       = "icmp"
#}


# outgoing rules
#resource "aws_vpc_security_group_egress_rule" "presentation_layer_egr_availability_zone_2" {
#  security_group_id = aws_security_group.presentation_layer_sg_availability_zone_2.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1"
#}
###########################################################################################

# Note that Availability Zone 1 repeats the presentation layer security group


# security group for Business Logic Layer
resource "aws_security_group" "business_logic_layer_sg" {
  name        = "business-logic-sg"
  description = "Security group for Business Logic Layer of availability zone 2"
  vpc_id      = aws_vpc.prod_vpc.id


  ingress {
    description     = "SSH from application tier"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.appsg.id}"]
  }

  ingress {
    description     = "HTTP from load balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.lb_sg.id}"]
  }

  ingress {
    description = "all icmp from onprem"
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    cidr_blocks = [aws_vpc.onprem.cidr_block]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bus-Log-Layer-SG-Availability-Zone-2"
  }
}


# incoming rules


#resource "aws_vpc_security_group_ingress_rule" "business_logic_layer_sg_ingr" {
#  security_group_id = aws_security_group.business_logic_layer_sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol = "-1"
#}


# http
#resource "aws_vpc_security_group_ingress_rule" "business_logic_layer_sg_ingr_http" {
#  security_group_id = aws_security_group.business_logic_layer_sg.id
#  cidr_ipv4 = "0.0.0.0/0"  # access from any ip address
#  from_port = 80
#  to_port = 80
#  ip_protocol = "tcp"
#}

# http
#resource "aws_vpc_security_group_ingress_rule" "business_logic_layer_sg_ingr_https" {
#  security_group_id = aws_security_group.business_logic_layer_sg.id
#  cidr_ipv4 = "0.0.0.0/0"  # access from any ip address
#  from_port = 443
#  to_port = 443
#  ip_protocol = "tcp"
#}

# ssh from application layer
#resource "aws_vpc_security_group_ingress_rule" "business_logic_layer_sg_ingr_ssh" {
#  security_group_id = aws_security_group.business_logic_layer_sg.id
#  cidr_ipv4 = "0.0.0.0/0"  # access from any ip address
#  from_port = 22
#  to_port = 22
#  ip_protocol = "tcp"
#}

# ping
#resource "aws_vpc_security_group_ingress_rule" "business_logic_layer_sg_ingr_ping" {
#  security_group_id = aws_security_group.business_logic_layer_sg.id
#  cidr_ipv4 = "0.0.0.0/0"  # access from any ip address
#  from_port = 8
#  to_port = 0
# ip_protocol = "icmp"
#}


# outgoing rules
#resource "aws_vpc_security_group_egress_rule" "business_logic_layer_sg_egr" {
#  security_group_id = aws_security_group.business_logic_layer_sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1"
#}
###########################################################################################




# Data Storage Layer


# Availability Zone 1


# Create security group for RDS
resource "aws_security_group" "rds_sg" {
  name         = "Security Group for RDS"
  description  = "Allow inbound/outbound MySQL traffic"
  vpc_id       = aws_vpc.prod_vpc.id
  #depends_on  = [aws_vpc.prod_vpc]

  ingress {
    description     = "allow inbound MYSQL access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.business_logic_layer_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Allow inbound MySQL connections
#resource "aws_security_group_rule" "allow_mysql_in" {
#  description       = "Allow inbound MySQL connections"
#  type              = "ingress"
#  from_port         = "3306"
#  to_port           = "3306"
#  protocol          = "tcp"
#  cidr_blocks       = ["10.0.2.0/24", "10.0.5.0/24"]
#  security_group_id = aws_security_group.rds_sg.id
#}



# Availability Zone 2


# security group for Data Storage Layer
resource "aws_security_group" "data_storage_layer_sg_availability_zone_2" {
  name        = "Data-Stor-Layer-SG-Availability-Zone-2"
  description = "Security group for Data Storage Layer of availability zone 2"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "Data-Stor-Bus-Log-Layer-SG-Availability-Zone-2"
  }
}


# incoming rules

# allow mysql access
resource "aws_vpc_security_group_ingress_rule" "data_storage_layer_ingr_availability_zone_2" {
  security_group_id            = aws_security_group.data_storage_layer_sg_availability_zone_2.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.business_logic_layer_sg.id
}


# outgoing rules
resource "aws_vpc_security_group_egress_rule" "data_storage_layer_egr_availability_zone_2" {
  security_group_id = aws_security_group.data_storage_layer_sg_availability_zone_2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
###########################################################################################


# security group for Load Balancer
resource "aws_security_group" "lb_sg" {
  name        = "LB-SG"
  description = "Security group for Load Balancer"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "LB-SG"
  }
}


# incoming rules

# allow http access from internet
resource "aws_vpc_security_group_ingress_rule" "lb_sg_ingr" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}


# outgoing rules
resource "aws_vpc_security_group_egress_rule" "lb_sg_egr" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}