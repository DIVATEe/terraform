resource "aws_instance" "webserver" {
  instance_type           = var.webserver_instance_type
  ami                     = var.webserver_ami
  key_name                = var.webserver_key_name
  vpc_security_group_ids  = [var.webserver_vpc_security_group_ids, aws_security_group.webserver_sg.id, data.aws_security_group.data_webserver_sg.id]
  disable_api_termination = var.webserver_disable_api_termination
  #count                   = var.webserver_count

  user_data = <<-EOF
                 #!/bin/bash
                 sudo apt update -y
                 sudo apt install nginx -y
                 # Create directory for Docker key
                 install -m 0755 -d /etc/apt/keyrings

                 # Add Docker's official GPG key
                 curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                 chmod a+r /etc/apt/keyrings/docker.asc

                 # Add the Docker repository to Apt sources
                 cat <<EOF >/etc/apt/sources.list.d/docker.sources
                 Types: deb
                 URIs: https://download.docker.com/linux/ubuntu
                 Suites: $(. /etc/os-release && echo "$"{UBUNTU_CODENAME:-$VERSION_CODENAME}"")
                 Components: stable
                 Signed-By: /etc/apt/keyrings/docker.asc
                 apt-get update -y

                 # Install Docker and plugins
                 apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

                 # Enable and start Docker
                 systemctl enable docker
                 systemctl start docker
                 EOF


}

resource "aws_security_group" "webserver_sg" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



output "webserver_publicip" {
  value = aws_instance.webserver.public_ip
}

output "webserver_privateip" {
  value = aws_instance.webserver.private_ip
}

output "webserver_sg_arn" {
  value = aws_security_group.webserver_sg.arn
}

output "webserver_sg_id" {
  value = aws_security_group.webserver_sg.id
}


data "aws_security_group" "data_webserver_sg" {
  name = "launch-wizard-1"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "aws_instance" "data_webserver_instance" {
  instance_id = "i-09bbf61f4f0ef246f"
}