# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "ibrahim-key"
  public_key = "${file("${var.key_path}")}"
}

resource "aws_instance" "web" {
  ami             = "ami-0507f77897697c4ba" 
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.sg.id]
#  user_data = file("./scripts.sh")
   source_dest_check = false

   connection {
     type        = "ssh"
     user        = "ec2-user"
     private_key = "${file("${var.key_path_priv}")}"
     host        = self.public_ip
   }

   provisioner "file" {
     source      = "infra"
     destination = "/tmp/infra"
   }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/infra /opt/",
      "echo '*** Installing apache'",
      "sudo dnf install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo cp /opt/infra/index.html /var/www/html",
      "echo '*** Completed Installing apache'"
    ]
  }

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}
