locals {
  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    neo4j_username = var.neo4j_username
    neo4j_password = var.neo4j_password
    neo4j_db_name  = var.neo4j_db_name
  })
}

resource "aws_instance" "neo4j" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group]
  key_name               = var.key_name
  user_data              = local.user_data

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = merge(var.tags, { Name = "${var.environment}-neo4j" })
}
