variable "env" {
  description = "Environment name (e.g., dev, preprod, prod)"
  type        = string
  default     = "prod"
}

variable "enable" {
  description = "Whether to enable logging (only allowed for prod)"
  type        = bool
  default     = false
  validation {
    condition     = var.enable ? var.env == "prod" : true
    error_message = "Logging module can only be enabled in 'prod' environment"
  }
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "public_subnets_count" {
  description = "Number of public subnets to create"
  type        = number

}

variable "instance_count" {
  description = "Number of instances to create in the public subnets"
  type        = number
  default     = 2
}

variable "common_tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}