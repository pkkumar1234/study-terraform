variable "aws_ami_id" {
    type = string
    default = "ami-09b0a86a2c84101e1"
  
}

variable "aws_server_name" {
  default = "website"
}
variable "aws_env" {
  default = "dev"
}
variable "aws_test" {
  default = "devtest"
}
