variable "web_ami" {
  default = "ami-02b8269d5e85954ef"
}
variable "web_instance_type" {
  default = "t3.small"
}
variable "web_key_name" {
  default = "Oct30"
}
variable "web_vpc_security_group_ids" {
  default = "sg-0a1badee4156834ca"
}