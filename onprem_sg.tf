#Create Security Group for on Prem instance
resource "aws_security_group" "onprem_sg" {
  name        = "app_sg"
  description = "Security Group for the onprem EC2"
  vpc_id      = aws_vpc.onprem.id

  ingress {
    description = "SSH from application layer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "onprem EC2"
  }
}

#Inbound rule
#resource "aws_vpc_security_group_ingress_rule" "onprem_allow_http" {
#  security_group_id = aws_security_group.onprem_sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 80
#  ip_protocol       = "tcp"
#  to_port           = 80
#}

#resource "aws_vpc_security_group_ingress_rule" "onprem_allow_ssh" {
#  security_group_id = aws_security_group.onprem_sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 22
#  ip_protocol       = "tcp"
#  to_port           = 22
#}

#resource "aws_vpc_security_group_ingress_rule" "onprem_allow_https" {
#  security_group_id = aws_security_group.onprem_sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port         = 443
#  ip_protocol       = "tcp"
#  to_port           = 443
#}

#resource "aws_vpc_security_group_ingress_rule" "onprem_allow_pings" {
#  security_group_id            = aws_security_group.onprem_sg.id
#  #referenced_security_group_id = 
#  cidr_ipv4         = "0.0.0.0/0"
#  from_port                    = 8
#  ip_protocol                  = "icmp"
#  to_port                      = 0
#}


#Outbound rule
#resource "aws_vpc_security_group_egress_rule" "onprem_allow_all_traffic_ipv4" {
#  security_group_id = aws_security_group.onprem_sg.id
#  cidr_ipv4         = "0.0.0.0/0"
#  ip_protocol       = "-1" # semantically equivalent to all ports
#}
