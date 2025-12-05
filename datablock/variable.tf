variable "webserver_instance_type" {
  default = "t3.micro"
}
variable "webserver_ami" {
  default = "ami-02b8269d5e85954ef"
}
variable "webserver_key_name" {
  default = "Oct30"
}
variable "webserver_vpc_security_group_ids" {
  default = "sg-0a1badee4156834ca"
}
variable "webserver_disable_api_termination" {
  default = false
}
#variable "webserver_count" {
#  default = 2
#}