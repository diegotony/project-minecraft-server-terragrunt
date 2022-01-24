variable "name" {
  type        = string
  description = "aws security group name"
}

variable "description" {
  type        = string
  description = "give a description"
}

variable "ingress" {
  type = map(object({
    description = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_blocks = any
    allow       = string
    type        = string
  }))

  default = {
    ssh-22 = {
      description = "Allow port 22 from VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      type        = "ingress"
    },
    http-80 = {
      description = "Allow port 80 from VPC"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      "type"      = "ingress"
    },

    minecraft = {
      description = "Allow port 25565 from VPC"
      from_port   = 25565
      to_port     = 25565
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      "type"      = "ingress"
    }
  }
}

variable "egress" {
  type = map(object({
    description = string
    from_port   = string
    to_port     = string
    protocol    = string
    cidr_blocks = any
    allow       = string
    type        = string
  }))

  default = {
    default = {
      description = "default"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      allow       = "true"
      type        = "egress"

    }
  }
}

variable "tags" {
}