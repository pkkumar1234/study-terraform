terraform {
  backend "s3" {
    bucket = "terraform-tf-state-fil"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
