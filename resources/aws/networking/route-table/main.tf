# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet-gateway_id
  }

}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id      = var.public-subnet_id
  route_table_id = aws_route_table.web-public-rt.id
}
