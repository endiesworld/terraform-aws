output "ec2_instance_public_ip" {
    value = module.myapp-webserver.ec2_instance.public_ip
}
output "vpc_id" {
    value = aws_vpc.myapp-vpc.id
}