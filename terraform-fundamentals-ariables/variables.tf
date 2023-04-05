variable "region" {
  type = string
  description = "AWS region"
  default = "us-east-1"
}

variable "account_active" {
  type = bool
  description = "Is AWS Account Active"
  default = true
}

variable "account_id" {
  type = number
  description = "AWS Account Id"
  default = 12345
}

variable "availability_zones" {
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b"]
  description = "List of availability zones"
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8380
      external = 8300
      protocol = "tcp"
    }]
  //if you add sensitive here and did not add in output
  //it will error out
  //sensitive = true
}

//variable "tfvars_variable" {}
variable "terraform_tfvars_variable" {}
variable "global_variable" {}

variable "testing_output_sensitive" {
  type = string
  default = "testing_output_sensitive"
}