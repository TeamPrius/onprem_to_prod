# create load balancer
resource "aws_lb" "prod_vpclb" {
  name               = "Application-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_sg.id}"]
  subnets            = ["${aws_subnet.private_subnet_1.id}", "${aws_subnet.private_subnet_3.id}"]
  #depends_on         = [aws_nat_gateway.nat_gw_availability_zone_1]
}


# create load balancer target group
resource "aws_lb_target_group" "prod_vpclb_target_group" {
  name        = "prod-vpclb-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.prod_vpc.id

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  stickiness {
    enabled         = true
    type            = "lb_cookie"
    cookie_duration = 86400
  }
}


# create target group attachment
resource "aws_lb_target_group_attachment" "prod_vpclb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.prod_vpclb_target_group.arn
  target_id        = aws_instance.business_logic_tier_availability_zone_1.id
  port             = 80
}


# create load balancer listener
resource "aws_lb_listener" "prod_vpclb_listener" {
  load_balancer_arn = aws_lb.prod_vpclb.arn
  port              = 80
  protocol          = "HTTP"
  #depends_on        = [aws_lb_target_group.prod_vpclb_target_group]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_vpclb_target_group.arn
  }
}


resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
  lb_target_group_arn    = aws_lb_target_group.prod_vpclb_target_group.arn
}