vpc_config = {
  cidr_block = "10.0.0.0/16"
  name       = "dev-vpc"
}

subnet_config = {
  public_subnet = {
    cidr_block = "10.0.0.0/24"
    az         = "ap-south-1a"
    public     = true
  }

  private_subnet = {
    cidr_block = "10.0.1.0/24"
    az         = "ap-south-1b"
  }
}

security_group_config = {
  web_sg = {
    description = "Security group for web server"
    ingress = [
      {
        description = "Allow HTTP traffic"
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow SSH access"
        protocol    = "tcp"
        from_port   = 22
        to_port     = 22
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        description = "Allow all outbound traffic"
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}
