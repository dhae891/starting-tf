resource "aws_vpc" "my-vpc-lab" {
  tags = {
    Name = "test-terraform-vpc"
  }
  # The CIDR block for the VPC
  cidr_block = "10.0.0.0/16"  
  instance_tenancy = "default"
}
resource "aws_subnet" "public-lab" {
  # The VPC ID for the subnet
  vpc_id = aws_vpc.my-vpc-lab.id
  # The CIDR block for the subnet
  cidr_block = "10.0.1.0/24"
  # The availability zone for the subnet
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf-public-subnet"
  }
}
resource "aws_subnet" "private-lab" {
  # The VPC ID for the private subnet
  vpc_id = aws_vpc.my-vpc-lab.id
  # The CIDR block for the private subnet
  cidr_block = "10.0.2.0/24"
  # The availability zone for the private subnet
  availability_zone = "us-east-1a"
  # The map public IP on launch for the private subnet
  tags = {
    Name = "tf-private-subnet"
  }
}
resource "aws_internet_gateway" "igw-lab" {
  # The VPC ID for the internet gateway
  vpc_id = aws_vpc.my-vpc-lab.id
  tags = {
    Name = "tf-igw"
  }
}
resource "aws_route_table" "public-rt" {
  # The VPC ID for the route table
  vpc_id = aws_vpc.my-vpc-lab.id
  # The route for the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-lab.id
}
  # The tags for the route table
  tags = {
    Name = "tf-public-rt"
  }
}
resource "aws_route_table_association" "public-rt-aws_assoc" {
  # The subnet ID for the route table association
  subnet_id = aws_subnet.public-lab.id
  # The route table ID for the route table association
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table" "private-rt" {
  # The VPC ID for the route table
  vpc_id = aws_vpc.my-vpc-lab.id
  tags = {
    Name = "tf-private-rt"
  }

}
resource "aws_route_table_association" "private-rt-aws_assoc" {
  # The subnet ID for the route table association
  subnet_id = aws_subnet.private-lab.id
  # The route table ID for the route table association
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_security_group" "my-sg-lab" {
  name   = "my-sg-lab"
  vpc_id = aws_vpc.my-vpc-lab.id
  tags = {
    Name = "my-sg-lab"
  }
  # The VPC ID for the security group
  # The description for the security group
  description = "Allow TLS inbound traffic and all outbound traffic"
  # The tags for the security group
  # The ingress rule for the security group
  ingress {
    # The protocol for the ingress rule
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.206.80.74/32"]
    description = "Allow SSH access from my IP"

}
  ingress {
    # The protocol for the ingress rule
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS access from anywhere"
}
  # The egress rule for the security group
  egress {
    # The protocol for the egress rule
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
}
}
