module "ec2" {
  source = "./modules/ec2"
  aws_ami_id = var.ami_id
  aws_instance_type = var.instance_type_id
}