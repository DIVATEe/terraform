resource "aws_instance" "webserver" {
  instance_type           = var.webserver_instance_type
  ami                     = var.webserver_ami
  key_name                = var.webserver_key_name
  vpc_security_group_ids  = [var.webserver_vpc_security_group_ids]
  disable_api_termination = var.webserver_disable_api_termination
  count                   = var.webserver_count
}