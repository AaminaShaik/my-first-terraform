resource "aws_security_group" "my-sg" {
  name        = var.sg_name
  description = "allow"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3360
    to_port     = 3360
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }

}
