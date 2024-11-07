resource "aws_instance" "demoserver" {
  ami           = var.aws_ami_id
  instance_type = var.aws_instance_type

  tags = {
    Name = "demo-server"
  }
}
