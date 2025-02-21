vpc_config = {
  cidr_block = "10.1.0.0/16"
  name       = "prod-vpc"
}

subnet_config = {
  public_subnet_1 = {
    cidr_block = "10.1.0.0/24"
    az         = "ap-south-1a"
    public     = true
  }

  public_subnet_2 = {
    cidr_block = "10.1.1.0/24"
    az         = "ap-south-1b"
    public     = true
  }

  private_subnet_1 = {
    cidr_block = "10.1.2.0/24"
    az         = "ap-south-1a"
  }

  private_subnet_2 = {
    cidr_block = "10.1.3.0/24"
    az         = "ap-south-1b"
  }
}

security_group_config = {
  prod_sg = {
    description = "Security Group for Production Environment"

    ingress = [
      {
        description = "Allow SSH access from a specific admin IP"
        protocol    = "tcp"
        from_port   = 22
        to_port     = 22
        cidr_blocks = ["192.168.1.100/32"]  # Replace with your actual admin IP
      },
      {
        description = "Allow HTTP traffic"
        protocol    = "tcp"
        from_port   = 80
        to_port     = 80
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow HTTPS traffic"
        protocol    = "tcp"
        from_port   = 443
        to_port     = 443
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "Allow application port (e.g., 8080)"
        protocol    = "tcp"
        from_port   = 8080
        to_port     = 8080
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
