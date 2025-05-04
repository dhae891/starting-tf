resource "aws_instance" "ec2-container" {
    ami = "ami-084568db4383264d4" # Ubuntu 24.04 LTS
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-lab.id
    #count = 2 # For multiple instances
    tags = {
        Name = "tf-ec2-container"
    }
}