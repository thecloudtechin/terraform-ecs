resource "aws_alb" "dgweb-alb" {
    internal = "false"
    load_balancer_type = "application"
    security_groups = [aws_security_group.allow-web.id]
    subnets = [aws_subnet.dgweb-pub-sn1.id,aws_subnet.dgweb-pub-sn2.id]
  
}

resource "aws_alb_target_group" "dgweb-tg" {
    name = "dgweb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.dgweb-vpc.id
    
  
}

resource "aws_alb_listener" "dgweb-alb-http" {
    load_balancer_arn = aws_alb.dgweb-alb.arn
    
    port = 80
    protocol = "HTTP"
    
    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.dgweb-tg.arn
     # port = "80"

    }
  
}


resource "aws_alb_target_group_attachment" "dgweb" {
    target_group_arn = aws_alb_target_group.dgweb-tg.arn
    target_id = aws_instance.server.id





  
}