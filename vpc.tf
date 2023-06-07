provider "aws" {
    region = var.region
      
}
//create a vpc
resource "aws_vpc" "demo_vpc" {
    cidr_block = var.vpc_cidr
}
//create a subnet
resource "aws_subnet" "demo_subnet" {
    vpc_id = "aws_vpc.demo_vpc.id"
    cidr_block = "10.10.0.0/24"
    tags = {
      Name = "demo-subnet"
    }
  
}
// create internet gateway

resource "aws_internet_gateway" "demoigw" {
    vpc_id = "aws_vpc.demo_vpc.id"
    tags = {
      Name = "demo-igw"
    }
  
}
//create route table
resource "aws_route_table" "demo_route" {
  vpc_id = "aws_vpc.demo_vpc.id"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demoigw.id
  }

  tags = {
    Name = "demo-rt"
  }
}
resource "aws_route_table_association" "demo-rt-association" {
    subnet_id = aws_subnet.demo_subnet.id
    route_table_id = aws_route_table.demo_route.id
  
}
resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
  
  vpc_id      = "aws_vpc.demo_vpc.id"

  ingress {
    
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
} 
resource "aws_instance" "ec1machine" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.demo_subnet.id
    vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]
    tags = {
        Name = "nis"
    }
  
}
