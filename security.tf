resource "aws_security_group" "vpce" {
  name   = "ecspf-vpce-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.2.0.0/16"]
  }
}
