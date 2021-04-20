resource "aws_secretsmanager_secret" "new_relic_license_key" {
  name                    = "NEW_RELIC_LICENSE_KEY"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "new_relic_license_key" {
  secret_id     = aws_secretsmanager_secret.new_relic_license_key.id
  secret_string = jsonencode(var.newrelic_keymap)
}