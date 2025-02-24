vpc_config = {
  cidr_block = "10.2.0.0/16"
  name       = "qa-vpc"
}

subnet_config = {
  public_subnet = {
    cidr_block = "10.2.0.0/24"
    az         = "ap-south-1a"
    public     = true
  }

  private_subnet = {
    cidr_block = "10.2.1.0/24"
    az         = "ap-south-1b"
  }
}


