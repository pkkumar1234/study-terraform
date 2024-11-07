resource "aws_instance" "demoserver" {
  ami           = "ami-09b0a86a2c84101e1"
  instance_type = "t2.micro"

  tags = {
    Name = "demo-server"
  }
}
