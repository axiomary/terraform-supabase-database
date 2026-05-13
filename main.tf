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