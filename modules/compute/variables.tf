variable "env" {
    description = "Environment name preprod or prod"
    type        = string
  
}

variable "subnet_ids" {
    description = "List of subnet IDs where the compute resources will be deployed"
    type        = list(string)
}

variable "instance_type" {
    description = "Type of EC2 instance to launch"
    type        = string
    default     = "t2.micro"
}

variable "instance_count" {
    description = "Number of EC2 instances to launch"
    type        = number
}

variable "common_tags" {
    type        = map(string)
    description = "Tags to apply to all resources"
    default     = {}
}

variable "security_group_id" {
    description = "Security group ID to associate with the compute instances"
    type        = string
  
}