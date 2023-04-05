variable "region" {
  description = "AWS region"
  default = "us-east-1"
}
variable "instance_name" {
  description = "AWS instance name"
  default = "ec2-from-terraform"
}
variable "instance_id" {
  description = "AWS instance Id"
  default = "ami-006dcf34c09e50022"
}
variable "instance_type" {
  description = "AWS instance Type"
  default = "t3.micro"
}

variable "security_grp_name" {
  description = "Security Group Name"
  default = "web-server-sg"
}