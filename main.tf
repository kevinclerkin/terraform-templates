#Provider Block
provider "aws" {
    profile = "default"
    region = "us-east-1"
}

#Resource Block
resource "aws_instance" "app_server"{
    ami = "ami-0e86e20dae9224db8"
    instance_type = "t2.micro"

    tags = {
        Name = "TerraformInstance1"
    }
}