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

variable "settings_config" {
  description = "The configuration for Supabase production settings"
  type = object({
    database = optional(object({
      statement_timeout = optional(string)
    }))

    network = optional(object({
      restrictions = optional(list(string))
    }))

    api = optional(object({
      db_schema            = optional(string)
      db_extra_search_path = optional(string)
      max_rows             = optional(number)
    }))

    auth = optional(object({
      site_url             = optional(string)
      mailer_otp_exp       = optional(number)
      mfa_phone_otp_length = optional(number)
      sms_otp_length       = optional(number)
    }))

    storage = optional(object({
      fileSizeLimit = optional(number)
      features = optional(object({
        imageTransformation = optional(object({ enabled = optional(bool) }))
        s3Protocol          = optional(object({ enabled = optional(bool) }))
      }))
    }))
  })
  default = null
}