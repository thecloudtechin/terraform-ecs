resource "aws_instance" "server" {
    availability_zone = var.az[0]
    subnet_id = aws_subnet.dgweb-pub-sn1.id
    instance_type = "t2.micro"
    ami = "ami-0597375488017747e"
    key_name = "dove-key"
    security_groups = ["${aws_security_group.allow-ssh.id}"]
   # count = "2"
    tags = {
      "Name" = "web-server"
    }

    connection {
      user = var.USERNAME
      private_key = file(var.PRIV_KEY)
      host = self.public_ip
    }


    provisioner "remote-exec" {
      inline = [
        "sudo apt update",
        "sudo apt install apache2",
        "sudo systemctl restart apache2"
      ]
      
    }
    
  
}