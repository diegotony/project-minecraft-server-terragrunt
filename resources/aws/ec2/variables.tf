variable "tags" {
  description = "description tags"
}

variable "ami" {
  description = "The OS that be used in instance"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type eg. t2.micro, t2.small etc"
}

variable "security_groups" {
  description = "security group"
}

variable "key_name" {
  type        = string
  description = "Key Access Key"
}

variable "user_data" {
  description = "Commands that you wish execute in instance"
  default     = <<EOF
    #! /bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello world  from $(hostname -f) </h1>" > /var/www/html/index.html
  EOF
}

