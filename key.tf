# create key for ssh
resource "aws_key_pair" "ssh_key" {
  key_name   = "bastion-host-ssh-key"
  public_key = ""
}



