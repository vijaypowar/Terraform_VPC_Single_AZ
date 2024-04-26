# lab001_VPC_With_Single AZ //This is for small client, Dev & Prod will be in same VPC
#------------------------------------------------------------------------------------
# This terraform template deploys a VPC with 
# 1 VPC >> 10.10.0.0/16
# 1 Public Subnet >> az > 1a >> 10.10.1.0/24
# 1 Private Subnet >> az > 1a >> 10.10.51.0/24 
# 1 Public Route table / Route table association
# 1 Private route table  / Route table association
# 1 reverse proxy server in public subnet
# 1 Security Group for reverse proxy
# 1 Web server in private instance
# 1 Security Group fro web server
# 1 Internet Gateway >> IGW mapped with VPC
# 1 NAT Gateway >> Created in public subnet and associated with private route table
#-----------------------------------------------------------------------------------
# Naming conventions //Suppose client Name is Emprise Bank
# eb-vpc, eb-subnet1-public, eb-subnet1-private, eb-igw, eb-nat, eb-pub-rt, eb-priv-rt  //network.tf
# reverse-proxy, eb-sg-rp  //reverse-proxy.tf
# web-server, eb-sg-web  //web-server.tf
# Declaration of variables  // variables.tf
# Variables   //terraform.tfvars
# 






