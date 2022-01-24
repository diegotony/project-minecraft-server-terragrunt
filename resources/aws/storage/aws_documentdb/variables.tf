variable "name" {

}

variable "docdb_subnet_group_subnet_ids" {

}


# Instance
variable "aws_docdb_cluster_instance_count" {
  default = 1
}

variable "docdb_instance_class" {
  default = "db.r5.xlarge"
  # default = "db.t3.medium"

}

variable "master_username" {
  default = "el_admin"

}

variable "master_password" {
  default = "1_r0Ck_yoU"
}

variable "aws_security_group" {

}

variable "family" {
  default = "docdb4.0"
}

variable "tls" {
  default = "tls"
}

variable "tls-value" {
  default = "disabled"
}

variable "common_tags" {
  default = {}

}