data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "vpc_id" {
    default = "vpc-0b0f40afb6442f5a4"
}

variable "subnet_id" {
    default = "subnet-02caf56191e2ec8cc"
}

variable "key_name" {
    #default = "chavessh"
    default = "challenge-sre"
}


resource "aws_security_group" "permitir_ssh" {
  name        = "permitir_ssh"
  description = "Permite SSH na instancia EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
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
    Name = "permitir_ssh"
  }
}

resource "aws_security_group" "permitir_http" {
  name        = "permitir_http"
  description = "Libera porta 80 HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP to EC2"
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
    Name = "permitir_http"
  }
}

resource "aws_security_group" "permitir_https" {
  name        = "permitir_https"
  description = "Libera porta 443 HTTPS"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS to EC2"
    from_port   = 443
    to_port     = 443
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
    Name = "permitir_https"
  }
}

resource "aws_instance" "nginxserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.permitir_ssh.id, aws_security_group.permitir_http.id, aws_security_group.permitir_https.id]
  associate_public_ip_address = true

  tags = {
    Name = "nginxserver"
  }
}
