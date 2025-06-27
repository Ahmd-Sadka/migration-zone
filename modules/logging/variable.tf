variable "env" {
  type        = string
  description = "Environment name (must be 'prod' to enable logging)"
}

variable "enable" {
  type        = bool
  description = "Whether to enable logging (only allowed for prod)"
  default     = false
  validation {
    condition     = var.enable ? var.env == "prod" : true
    error_message = "Logging module can only be enabled in 'prod' environment"
  }
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to attach Flow Logs to"
}

variable "common_tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
