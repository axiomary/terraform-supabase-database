output "database_password_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret containing the DB password."
  value       = aws_secretsmanager_secret.db_password.arn
}

output "database_password_secret_name" {
  description = "The friendly name of the secret."
  value       = aws_secretsmanager_secret.db_password.name
}