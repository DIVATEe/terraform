resource "aws_instance" "webserver" {
    instance_type = "t3.micro"
    ami = "ami-02b8269d5e85954ef"
    key_name = "Oct30"
    vpc_security_group_ids = [ "sg-0a1badee4156834ca" ]
    disable_api_termination = false
    count = 2
}