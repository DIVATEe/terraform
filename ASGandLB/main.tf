resource "aws_instance" "web" {
  ami = "ami-02b8269d5e85954ef"
  key_name = "Oct30"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ "sg-0a1badee4156834ca" ]
}