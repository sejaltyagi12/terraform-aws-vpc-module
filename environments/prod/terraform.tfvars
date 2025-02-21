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