# first ec2 instance
resource "aws_instance" "amazonlinuxec2" {
  ami              	 	= "ami-0f403e3180720dd7e"
  instance_type     		= "t2.micro"
  subnet_id         		= aws_subnet.private_subnet_nonprod.id
  availability_zone 		= "us-east-1a"
  associate_public_ip_address   = false
  vpc_security_group_ids 	= ["${aws_security_group.nonprod_sg.id}"]

  tags = {
    Name = "Amazon Linux EC2"
  }
}


# second ec2 instance
resource "aws_instance" "suselinuxec2" {
  ami              	 	= "ami-05efd9e66ddc3cf4b"
  instance_type     		= "t2.micro"
  subnet_id         		= aws_subnet.private_subnet_nonprod.id
  availability_zone 		= "us-east-1a"
  associate_public_ip_address   = false
  vpc_security_group_ids 	= ["${aws_security_group.nonprod_sg.id}"]

  tags = {
    Name = "SUSE Linux EC2"
  }
}


# third ec2 instance
resource "aws_instance" "ubuntuec2" {
  ami              	 	= "ami-07d9b9ddc6cd8dd30"
  instance_type     		= "t2.micro"
  subnet_id         		= aws_subnet.private_subnet_nonprod.id
  availability_zone 		= "us-east-1a"
  associate_public_ip_address   = false
  vpc_security_group_ids 	= ["${aws_security_group.nonprod_sg.id}"]

  tags = {
    Name = "Linux Ubuntu EC2"
  }
}


# fourth ec2 instance
resource "aws_instance" "windowsec2" {
  ami              	 	= "ami-0f9c44e98edf38a2b"
  instance_type     		= "t2.micro"
  subnet_id         		= aws_subnet.private_subnet_nonprod.id
  availability_zone 		= "us-east-1a"
  associate_public_ip_address   = false
  vpc_security_group_ids 	= ["${aws_security_group.nonprod_sg.id}"]


  tags = {
    Name = "MS Windows EC2"
  }
}

# fifth ec2 instance
resource "aws_instance" "redhatec2" {
  ami              	 	= "ami-0fe630eb857a6ec83"
  instance_type     		= "t2.micro"
  subnet_id         		= aws_subnet.private_subnet_nonprod.id
  availability_zone 		= "us-east-1a"
  associate_public_ip_address   = false
  vpc_security_group_ids 	= ["${aws_security_group.nonprod_sg.id}"]

  tags = {
    Name = "Linux Red Hat EC2"
  }
}


