# create key for ssh
resource "aws_key_pair" "ssh_key" {
  key_name   = "bastion-host-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2RywCbjjek7Ji6VvAHaPWdLCywWHD77tOKTcfI5des8stKvIQeQul8ZrKfbH/mlO+2H5VconVbtbP7UZw5sxajN3g7pq/QeBRGUtMYRKaxt0kNnhRZtIJ9Fiz2ehVxOhneMI2cn/jCDzUW2+KDavtRLfLszHFsmroN+0WHTZqkn4B6vIBdGgNUrP6/+z8wWysEgbXbkms2l7xnOk2SCvq4KlWXzL+gM9DvA9ZUSerEUCr+wSMuVH8r1cJkp6UsUAuyMBI4AF4anUCqawg2ZJcuWEXQWfdqhAtjVwt5igaECGUjJ0uVl0d2WKCP9+13Vqahzr14H1ddCZZRe/PWhaJ+vmQs/3G284kA384d0IhBR1Ix6zjQG4ugQUeThBf6KYHBhZV651SSJKfoKRPsgnLxLo3OIS4z8rMhsHQNYBEWepGIM0Lg+9C8rJn722ZDB5HjPPPIC4YmqHG6+TqzylQ6o52m8NExiHpBZEwDu1S2chC/0+Nx62J2whr87xWYwU= colineta@DESKTOP-RKJPQQ7"
}



