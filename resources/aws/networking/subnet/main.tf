# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

}
