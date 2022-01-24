variable "source_dir" {
  type        = string
  description = "(optional) describe your variable"
}

variable "output_path" {
  type        = string
  description = "(optional) describe your variable"
}

variable "bucket" {
  type        = string
  description = "(optional) describe your variable"
}

variable "runtime" {
  type        = string
  description = "(optional) describe your variable"
}

variable "handler" {
  type        = string
  description = "(optional) describe your variable"
}

variable "function_name" {
  type        = string
  description = "(optional) describe your variable"

}

variable "environment" {
  description = "(optional) describe your variable"
  default = {
    foo = "bar"
  }
}
