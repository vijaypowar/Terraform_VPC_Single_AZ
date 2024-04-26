# Creates the security group for the EC2-Nginx server.
resource "aws_security_group" "lab03-secgroup-1" {
  name        = "lab03-secgroup-1"
  description = "Allow web server network traffic"
  vpc_id      = aws_vpc.lab03-vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab03-secgroup-1"
  }
}


# Imports the keypair
resource "aws_key_pair" "rp_ec2_key" {
  key_name   = "rp-ec2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Creates the EC2 instance with NGINX installed in Public subnet
resource "aws_instance" "reverse_proxy1" {
  instance_type               = var.instance_type
  ami                         = var.ami_id
  key_name                    = aws_key_pair.rp_ec2_key.id
  vpc_security_group_ids      = [aws_security_group.rp_sg_1.id]
  subnet_id                   = aws_subnet.aws_subnet.eb_vpc1_public_subnet1.id.id
  associate_public_ip_address = true
  user_data                   = file("reverse-proxy1.tpl")

  root_block_device {
    volume_size = var.ebs_size
  }

  tags = {
    Name = "reverse-proxy1"
  }
}
