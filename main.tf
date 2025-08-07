provider "aws" {
    region = "us-west-2"
}


resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}


module "myapp-subnet-1" {
    source = "./modules/subnet"
    subnet_cidr_block = var.subnet_cidr_block
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.myapp-vpc.id     
}

# resource " aws_default_route_table" "myapp-default-route-table" {
#     default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.myapp-igw.id
#     }
#     tags = {
#         Name = "${var.env_prefix}-default-route-table"
#     }
# }

module "myapp-webserver" {
    source = "./modules/webserver"
    vpc_id = aws_vpc.myapp-vpc.id
    subnet_id = module.myapp-subnet-1.subnet.id # This reference is updated to use the subnet created in the imported subnet module above
    subnet_cidr_block = var.subnet_cidr_block
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
    my_IP = var.my_IP
    instance_type = var.instance_type
    image_name = var.image_name
    key_name = var.key_name
    public_key_path = var.public_key_path
    private_key_path = var.private_key_path
}   