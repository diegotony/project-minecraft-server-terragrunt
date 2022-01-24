
data "aws_availability_zones" "available" {
  state = "available"
}


locals {
  documentdb_name = "documentdb-${var.name}"
  default_tag = {
    env       = "dev"
    createdBy = "ops-team"
    details   = "Resource created from terrform"
  }
  tags = merge(local.default_tag, var.common_tags, { Name = local.documentdb_name })
}

resource "aws_docdb_subnet_group" "service" {
  name       = "${local.documentdb_name}-subnet-group"
  subnet_ids = var.docdb_subnet_group_subnet_ids
}

resource "aws_docdb_cluster_instance" "service" {
  count              = var.aws_docdb_cluster_instance_count
  identifier         = "${local.documentdb_name}-${count.index}"
  cluster_identifier = aws_docdb_cluster.service.id
  instance_class     = var.docdb_instance_class
}

resource "aws_docdb_cluster" "service" {
  skip_final_snapshot             = true
  backup_retention_period         = 0
  apply_immediately               = true
  db_subnet_group_name            = aws_docdb_subnet_group.service.name
  cluster_identifier              = "${local.documentdb_name}-cluster"
  engine                          = "docdb"
  master_username                 = var.master_username
  master_password                 = var.master_password
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.service.name
  vpc_security_group_ids          = var.aws_security_group
}

resource "aws_docdb_cluster_parameter_group" "service" {
  family = var.family
  name   = "${local.documentdb_name}-parameter-group"

  parameter {
    name  = var.tls
    value = var.tls-value
  }
}