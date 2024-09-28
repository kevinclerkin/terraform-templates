#Outputs
output "instance_id" {
    description = "value of the ec2 instance id"
    value = aws_instance.app_server.id
}

output "instance_public_ip" {
    description = "value of the ec2 instance public ip"
    value = aws_instance.app_server.public_ip
  
}