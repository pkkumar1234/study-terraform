resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc1"
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "publicSubnet"
  }
}
resource "aws_subnet" "privatesubnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "privateSubnet"
  }
}

resource "aws_route_table" "pubrout1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "publicroute"
  }
}
resource "aws_route_table" "privrout2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "privateroute"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mygateway"
  }
}

resource "aws_route_table_association" "asscipublic" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.pubrout1.id
}

resource "aws_route_table_association" "assciprivate" {
  subnet_id      = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.privrout2.id
}

resource "aws_instance" "demoserver" {
  ami           = "ami-09b0a86a2c84101e1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.publicsubnet.id
  
  tags = {
    Name = "demo-server"
  }
}

