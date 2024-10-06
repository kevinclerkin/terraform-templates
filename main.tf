#Provider Block
provider "aws" {
    profile = "default"
    region = "us-east-1"
}

# VPC
resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Subnet
resource "aws_subnet" "test_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Route Table
resource "aws_route_table" "test_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
}
}

# Route Table Association
resource "aws_route_table_association" "aws_subnet_route" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_rt.id
}

# Security Group
resource "aws_security_group" "test_sg" {
  name = "test_sg"
  vpc_id = aws_vpc.test_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
   
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }  

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
        Name = "test_sg"
    }
}

#Network Interface
resource "aws_network_interface" "test_interface" {
  subnet_id       = aws_subnet.test_subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.test_sg.id]

}

#Elastic IP
resource "aws_eip" "ip_1" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.test_interface.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.test_igw]
}

#EC2 Instance
resource "aws_instance" "nginx_server"{
    ami = var.ec2-ami
    instance_type = var.aws_instance_type

    availability_zone = "us-east-1a"
    key_name = "EC2Key"

    network_interface {
        network_interface_id = aws_network_interface.test_interface.id
        device_index = 0
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                echo '<h1>your very own nginx server</h1>' | sudo tee /var/www/html/index.nginx-debian.html
                sudo systemctl enable nginx
                sudo systemctl start nginx
                EOF

    tags = {
        Name = var.ec2_instance_name
    }
}