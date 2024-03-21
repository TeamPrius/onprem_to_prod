# on Prem EC2 instance
resource "aws_instance" "onprem_ec2" {
  ami                         = data.aws_ami.amazonlinux2023.id # ami
  instance_type               = "t2.micro"                      # ami instance type
  subnet_id                   = aws_subnet.public_subnet_onprem.id   # get public subnet id
  availability_zone           = "us-east-1a"                    # get availability zone
  associate_public_ip_address = true                            # gives public ip address
  vpc_security_group_ids      = ["${aws_security_group.onprem_sg.id}"]
  key_name                    = aws_key_pair.ssh_key.id

  user_data = filebase64("./userdata_tennable.sh")
  metadata_options {
    http_tokens   = "optional" # optional tokens
    http_endpoint = "enabled"
  }

  tags = {
    Name = "onprem EC2"
  }
}