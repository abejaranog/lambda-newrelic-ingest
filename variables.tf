variable "AWS_account" {
  type        = string
  description = "AWS Account to be deployed the stack in"
}

variable "AWS_region" {
  type        = string
  description = "AWS Region"
  default     = "us-west-2"
}

variable "newrelic_keymap" {
  type        = map(string)
  description = "New Relic API key"
  default = {
    LicenseKey = ""
  }
}

variable "newrelic_account_id" {
  type = string
}
variable "lambda_name" {
  type        = string
  description = "Lambda Name"
}