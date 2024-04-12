## Create AWS infrastructure using Terraform HCL
***
>This repository contains the Terraform project that I've worked on and I'm currently working on. Make sure to go through the pre-requisites for the labs.
### Pre-requisites :-
#### 1. Get Access Key ID and Secret Access Key from AWS Account.
In upeer right corner of console select account name or number -> Select Security Credentials -> In the Access Key section click on Create access key -> Under Secret access key -> show -> Copy Access key ID and secret key OR you can download .csv file. ( If Create access key option is not available, then you already have the maximum number of access keys. You must delete one of the existing access keys before you can create a new key )
#### 2. Create Terraform user in aws account with Programatic Access
Login to AWS console and create IAM User namely "tf-user" with Programatic Acces.
#### 3. Setup your Environment and install Extensions
I'm using VS Code. We'll set it up with the AWS Toolkit and Terraform extensions.
#### 4. Create the key pair for Amazon EC2 Instance. -OR- You can import public key to Amazon EC2
Open Amazon EC2 Console -> Network & Security -> Key Pairs -> Create key pair -> Name -> ec2-key -> Key Pair Type -> Choose ed25519 or rsa -> Private Key File format -> Choose pem for OpenSSH & ppk for PuTTY
#### 5. Install AWS CLI on local machine.
* On Ubuntu machine
```
apt update
apt install awscli -y
```
* On MacBook machine
```
# Install homebrew
# Install python3 on macos as it is pre-requisites 
brew install python@3.12
brew install awscli
aws --version
```
* On Windows machine grafhically awscli latest version can be installed.
#### 6. Install Terraform
* On Ubuntu machine and MacOS

[Terraform-install-on-ubuntu](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli "Terraform-install-on-ubuntu")
* On Windows machine

[Terraform-install-on-Windows](https://phoenixnap.com/kb/how-to-install-terraform "Terraform-install-on-Windows")
#### 7. Configure the credentials files
Go to the location C:\Users\terraform\.aws\credentials & Add the AWS Access key ID and Secret key in this file.
```[project-dev]
aws_access_key_id = AKTF1234ABCDEFGHIKJ
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```
#### 8. Add SSH Public key on GitHub account.
### Steps :-