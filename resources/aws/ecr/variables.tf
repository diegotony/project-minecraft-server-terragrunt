variable "name" {
  type        = string
  description = "container registry name"
}

variable "image_tag_mutability" {
  type        = string
  description = "image_tag_mutability"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "scan_on_push"
  default     = true
}