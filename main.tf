resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "supabase_project" "project" {
  organization_id = var.organization_id
  name            = var.project_name
  region          = var.region
  # instance_size     = var.instance_size
  database_password = random_password.password.result

}

resource "aws_secretsmanager_secret" "db_password" {
  name        = "${var.project_name}-database-password"
  description = "Database password for Supabase project: ${var.project_name}"
}

resource "aws_secretsmanager_secret_version" "db_password_val" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.password.result
}

resource "supabase_apikey" "api_key" {
  project_ref = supabase_project.project.id
  name        = "${var.project_name}-key"
}

resource "supabase_settings" "production" {
  count = var.settings_config != null ? 1 : 0

  project_ref = supabase_project.project.id
  database    = var.settings_config.database != null ? jsonencode(var.settings_config.database) : null
  network     = var.settings_config.network != null ? jsonencode(var.settings_config.network) : null
  api         = var.settings_config.api != null ? jsonencode(var.settings_config.api) : null
  auth        = var.settings_config.auth != null ? jsonencode(var.settings_config.auth) : null
  storage     = var.settings_config.storage != null ? jsonencode(var.settings_config.storage) : null
}