locals {
  enabled = var.enable
}

# Unique suffix for bucket naming
resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "logs" {
  count = local.enabled ? 1 : 0
  force_destroy = true
  bucket = "poc-${var.env}-logs-${random_id.bucket_id.hex}"

#   versioning {
#     enabled = true
#   }
depends_on = [ random_id.bucket_id ]

  tags = merge(
    var.common_tags,
    { Name = "${var.env}-logs-bucket" }
  )
}


# CloudWatch Log Group for VPC Flow Logs
resource "aws_cloudwatch_log_group" "vpc_logs" {
  count = local.enabled ? 1 : 0

  name              = "poc-${var.env}-vpc-flow-logs"
  retention_in_days = 14

  tags = merge(
    var.common_tags,
    { Name = "${var.env}-logs-group" }
  )
}

resource "aws_iam_role" "flow_log_role" {
  name               = "poc-${var.env}-flow-log-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "flow_log_policy" {
  name   = "poc-${var.env}-flow-log-policy"
  role   = aws_iam_role.flow_log_role.id
  policy = data.aws_iam_policy_document.flow_log_policy.json
}
# Flow Log to CloudWatch
resource "aws_flow_log" "to_cloudwatch" {
  count                = local.enabled ? 1 : 0
  iam_role_arn        = aws_iam_role.flow_log_role.arn
  log_destination      = aws_cloudwatch_log_group.vpc_logs[0].arn
  log_destination_type = "cloud-watch-logs"
  vpc_id               = var.vpc_id
  traffic_type         = "ALL"

  tags = merge(
    var.common_tags,
    { Name = "${var.env}-flow-log-cw" }
  )
}

# Flow Log to S3
resource "aws_flow_log" "to_s3" {
  count                = local.enabled ? 1 : 0
  log_destination      = aws_s3_bucket.logs[0].arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    { Name = "${var.env}-flow-log-s3" }
  )
}