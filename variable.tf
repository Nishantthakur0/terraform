variable "region" {
    default = "us-east-2"
  
}
variable "vpc_cidr" {
    default = "10.10.0.0/16"
  
}

variable "ami" {
    default = "ami-0430580de6244e02e"
  
}
variable "instance_type" {
    default = "t2.micro"
  
}
variable "key_name" {
    default = "ansible1"
  
}