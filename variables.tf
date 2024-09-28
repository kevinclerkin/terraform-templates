#Variables
variable "aws_instance_type" {
    description = "The type of instance to launch"
    default = "t2.micro"
  
}

variable "aws_instance_name" {
    description = "The name of the instance"
    default = "TerraformInstance"
}