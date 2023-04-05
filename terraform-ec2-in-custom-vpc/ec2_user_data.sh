#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd.service
sudo cd /var/www/html
echo "<html><body><h1>Up and Running using Terraform with custom VPC and EC2 instance</h1></body></html>" | sudo tee /var/www/html/index.html