resource "aws_instance" "webserver" {
  instance_type           = var.webserver_instance_type
  ami                     = var.webserver_ami
  key_name                = var.webserver_key_name
  vpc_security_group_ids  = [var.webserver_vpc_security_group_ids, aws_security_group.webserver_sg.id, data.aws_security_group.data_webserver_sg.id]
  disable_api_termination = var.webserver_disable_api_termination
  #count                   = var.webserver_count
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

data "aws_ami" "data_webserver_ami" {
  name = [ "al2023-ami-2023.9.20251117.1-kernel-6.1-x86_64" ]
}

data "aws_instance" "data_webserver_instance" {
  instance_id = "i-09bbf61f4f0ef246f"
}