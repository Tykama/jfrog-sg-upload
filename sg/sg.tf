resource "aws_security_group" "tls" {
  name = var.sg_name
  description = "Allow inbound traffic from port 22"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      description = "Allow inbound traffic from port 22"
      from_port  = port.value
      to_port    = port.value
      protocol   = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      description = "Allow outbound traffic from all ports"
      from_port  = port.value
      to_port    = port.value
      protocol   = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = var.tg_name
  }
}

provider "aws" {
  region = var.region
}
