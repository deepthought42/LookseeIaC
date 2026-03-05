resource "aws_secretsmanager_secret" "this" {
  for_each = var.secrets
  name     = "${var.environment}/${each.key}"
  tags     = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each      = var.secrets
  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = each.value
}
