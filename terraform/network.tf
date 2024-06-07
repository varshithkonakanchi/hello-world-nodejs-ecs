resource "aws_security_group" "default" {
  name        = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id      = "vpc-0c2d38d7a412c2a3f"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
