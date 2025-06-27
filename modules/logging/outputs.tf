output "s3_bucket_arn" {
  value = aws_s3_bucket.logs[0].arn
}

output "log_group_name" {
  value       = local.enabled ? aws_cloudwatch_log_group.vpc_logs[0].name : ""
}

output "flow_logs_enabled" {
  value = "Logging active for ${var.env} environment"
}