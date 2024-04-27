# Create Security group for Web Server in private subnet

resource "aws_security_group" "ws1_sg1" {
  name        = "ws1-sg1"
  description = "Allow web server network traffic"
  vpc_id      = aws_vpc.eb_vpc1.id

  ingress {
    description = "SSH from my IP" // It should be limited to your own IP or IP of subnet
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.5/32"]  // Use IP of Bastion/Jumbbox Server
  }

  ingress {
    description = "HTTP from anywhere"  
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/24"]  //Use private ip of reverse proxy server

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ws1-sg1"
  }
}