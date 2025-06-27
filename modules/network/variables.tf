variable "env" {
    description = "Environment name preprod or prod"
    type = string
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_count" {
    description = "Number of public subnets to create"
    type = number
}

variable "common_tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}