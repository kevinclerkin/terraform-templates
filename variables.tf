#Variables
variable "aws_instance_type" {
    description = "The type of instance to launch"
    default = "t2.micro"
  
}

variable "aws_instance_name" {
    description = "The name of the instance"
    default = "TerraformInstance"
}

variable "vpc_cidr" {
    description = "value of the vpc cidr block"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    description = "value of the vpc name"
    type = string
    default = "TestVPC1"
}

variable "subnet_cidr" {
    description = "value of the subnet cidr block"
    type = string
    default = "10.0.1.0/24"
}

variable "subnet_name" {
    description = "value of the subnet name"
    type = string
    default = "TestSubnet1"
  
}

variable "igw_name" {
    description = "value of the internet gateway name"
    type = string
    default = "TestIGW1"
}

variable "ec2-ami" {
    description = "value of the ec2 ami"
    type = string
    default = "ami-0e86e20dae9224db8"
  
}

variable "ec2-instance-type" {
    description = "value of the ec2 instance type"
    type = string
    default = "t2.micro"
  
}

variable "ec2_instance_name" {
    description = "value of the ec2 instance name"
    type = string
    default = "TestInstance1"
  
}