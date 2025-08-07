variable vpc_cidr_block {}
variable subnet_cidr_block {}
variable avail_zone {}
variable env_prefix {}
variable my_IP {} # Replace with your machine IP address
variable image_name {
    default = "amzn2-ami-hvm-2*-x86_64-gp2" # Replace with your desired image name
}
variable instance_type {
    default = "t2.micro" 
}
variable key_name {
    default = "my-key-pair" # Replace with your key pair name
}
variable public_key_path {
    default = "~/.ssh/id_rsa.pub" # Replace with the path to your public key
}
variable private_key_path {
    default = "~/.ssh/id_rsa" # Replace with the path to your private key
}