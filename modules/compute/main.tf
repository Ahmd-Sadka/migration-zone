resource "aws_instance" "compute_instances" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index % length(var.subnet_ids)]
  associate_public_ip_address = true
  security_groups = [var.security_group_id]

  tags = merge(
    {
      Name = "poc-${var.env}-compute-instance-${count.index + 1}"
    },
    var.common_tags
  )

  lifecycle {
    prevent_destroy = false # Set to true to prevent accidental deletion of the instance
  }

  # depends_on = [
  #   aws_key_pair.my_key_pair,
  # ]
}


