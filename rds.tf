resource "aws_db_subnet_group" "main" {
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1c.id,
  ]
}

resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["10.2.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_db_instance" "main" {
  db_name                 = "postgres"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "15.2"
  instance_class          = "db.t3.small"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  password                = var.db_password
  username                = var.db_username
  backup_retention_period = 0
  multi_az                = true
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds.id]
}

