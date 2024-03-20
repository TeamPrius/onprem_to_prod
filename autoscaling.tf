# create autoscaling group for both availability zones

#  autoscaling group
resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity    = 2 # desired number of instances at a given time
  max_size            = 5 # maximum number of instances group should have
  min_size            = 2 # minimum number of instances group should have
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_3.id]
  target_group_arns   = [aws_lb_target_group.prod_vpclb_target_group.arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}


# launch template or launch configuration
resource "aws_launch_template" "launch_template" {
  name          = "launch-template"
  image_id      = data.aws_ami.amazonlinux2023.id
  instance_type = "t2.micro"
  user_data     = filebase64("./userdata.sh")

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 5
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.private_subnet_1.id
    security_groups             = [aws_security_group.business_logic_layer_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Launch template"
    }
  }
}