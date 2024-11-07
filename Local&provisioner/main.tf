resource "aws_instance" "web" {
  ami           = var.aws_ami_id
  instance_type = "t2.micro"
  key_name = "testkey"

  tags = {
    Name = local.aws_instance_name
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip}>>public_ip.txt"
  }
   provisioner "remote-exec" {
    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("C:/Users/LENOVO/Downloads/testkey.pem")
    host     = self.public_ip
  }

    inline = [ 
        "sleep 30",
        "sudo apt update",
        "sudo apt install git -y",
        "sudo apt install apache2 -y",
        "sudo rm -rf /var/www/html/*",
        "sudo git clone https://github.com/cloudacademy/static-website-example.git /var/www/html"
         ]
  }
/* provisioner "file" {

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("C:/Users/LENOVO/Downloads/testkey.pem")
    host     = self.public_ip
  }
  source = "public_ip.txt"
  destination = "public_ip.txt"
}
 */
}

output "aws_server_ip" {
  description = "Server Public Ip"
  value = aws_instance.web.public_ip
}