
resource "aws_security_group" "myapp-sg" {
    vpc_id = var.vpc_id
    name = "${var.env_prefix}-sg"
    description = "Security group for ${var.env_prefix} environment"
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_IP] # Replace with your machine IP address
        description = "SSH access"
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Replace with your IP address
        description = "HTTP access"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
    tags = {
        Name = "${var.env_prefix}-sg"
    }
}

data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = [var.image_name] # Replace with your desired image name
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

# output "aws_ami_id" {
#     value = data.aws_ami.latest-amazon-linux-image.id 
# }

resource "aws_key_pair" "ssh-key" {
    key_name = var.key_name
    public_key = file(var.public_key_path)
}

resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.instance_type

    key_name = aws_key_pair.ssh-key.key_name

    availability_zone = var.avail_zone
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.myapp-sg.id]

    associate_public_ip_address = true

    user_data = file("./modules/webserver/entry_script.sh") # Replace with your user data script path
    
    user_data_replace_on_change =  true

    
    tags = {
        Name = "${var.env_prefix}-server"
    }
}
