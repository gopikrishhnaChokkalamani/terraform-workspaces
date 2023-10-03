output "instance_ami" {
  value = aws_instance.demo.ami
}

output "instance_arn" {
  value = aws_instance.demo.arn
}

output "instance_public_ip" {
  value = aws_instance.demo.public_ip
}
