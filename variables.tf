variable "organization_id" {
  type        = string
  description = "The organization ID where the Supabase project will be created."
}

variable "project_name" {
  type        = string
  description = "The name of the Supabase project."
}

variable "region" {
  type        = string
  description = "The AWS region to deploy the Supabase project in."
}

variable "instance_size" {
  type        = string
  description = "The size of the supabase database"
  default     = "micro"
}