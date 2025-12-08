resource "aws_instance" "web" {
  ami                    = var.web_ami
  key_name               = var.web_key_name
  instance_type          = var.web_instance_type
  vpc_security_group_ids = [var.web_vpc_security_group_ids]
}