# create nonprod security groups

resource "aws_security_group" "nonprod_sg" {
  name        = "nonprod-sg"
  description = "allow https and icmp traffic"
  vpc_id      = aws_vpc.nonprod.id

  tags = {
    Name = "nonprod-sg"
  }
}


# ingress rules
resource "aws_vpc_security_group_ingress_rule" "https_nonprod_sg_ingr" {
  security_group_id = aws_security_group.nonprod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_ingress_rule" "icmp_nonprod_sg_ingr" {
  security_group_id = aws_security_group.nonprod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
}


#Outbound rules

resource "aws_vpc_security_group_egress_rule" "nonprod_sg_egr" {
  security_group_id = aws_security_group.nonprod_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

