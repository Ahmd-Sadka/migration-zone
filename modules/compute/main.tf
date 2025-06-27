resource "aws_instance" "compute_instances" {
  count         = var.instance_count
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index % length(var.subnet_ids)]
  associate_public_ip_address = true
  security_groups = [aws_security_group.compute_security_group.name]

  tags = merge(
    {
      Name = "poc-${var.env}-compute-instance-${count.index + 1}"
    },
    var.common_tags
  )

  lifecycle {
    prevent_destroy = false # Set to true to prevent accidental deletion of the instance
  }

  depends_on = [ aws_key_pair.my_key_pair ]
}

resource "aws_security_group" "compute_security_group" {
  name        = "poc-${var.env}-compute-sg"
  description = "Security group for compute instances in ${var.env} environment"
  vpc_id      = var.subnet_ids[0] # Assuming all subnets are in the same VPC

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # All protocols
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(
        {
        Name = "poc-${var.env}-compute-sg"
        },
        var.common_tags
    )
    lifecycle {
        create_before_destroy = true # Ensures the security group is created before the old one is destroyed
    }
  
}
