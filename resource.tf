resource "aws_instance" "example" {

  instance_type          = "t3.micro"
  ami                    = "ami-087d1c9a513324697"
  key_name               = "Oct30"
  vpc_security_group_ids = ["sg-0a1badee4156834ca"]
}