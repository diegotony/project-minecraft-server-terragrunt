resource "aws_instance" "ec2" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = var.security_groups
  key_name        = var.key_name
  user_data       = var.user_data
  tags            = var.tags

}