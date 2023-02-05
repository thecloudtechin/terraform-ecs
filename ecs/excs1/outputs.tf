output "ec2-public-ip" {
    value = aws_instance.server.*.public_ip
  
}