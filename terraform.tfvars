cidr_blocks = [
  {
    cidr_block = "10.0.0.0/16"
    name       = "main-vpc"
  },
  {
    cidr_block = "10.0.1.0/24"
    name       = "subnet-1"
  }
]

avail_zone = "us-west-2a"
