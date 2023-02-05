resource "aws_security_group" "allow-ssh" {
    vpc_id = aws_vpc.dgweb-vpc.id
    ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["103.182.166.31/32"]
  }
  egress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "allow-ssh"
  }

  
}

resource "aws_security_group" "allow-web" {
    vpc_id = aws_vpc.dgweb-vpc.id
    ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "allow-http"
  }

  
}
