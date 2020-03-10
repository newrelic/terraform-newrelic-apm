variable "application_name" {
    description = "The name of the New Relic application to monitor"
    type = string
}

variable "account_id" {
    description = "The account ID the application reports to"
    type = number
}

variable "policy_name" {
    description = "The name of the alert policy to manage"
    type = string
    default = null
}

variable "runbook_url" {
    description = "A URL that points to a runbook for when this application is failing"
    type = string
    default = null
}

variable "incident_preference" {
  description = "The rollup strategy of the alert policy.  Valid values are PER_POLICY, PER_CONDITION, and PER_CONDITION_AND_TARGET"
  type = string
  default = "PER_POLICY"
}

variable "channel_ids" {
  description = "The notification channel IDs to link to this alert policy"
  type = list(number)
  default = null
}

variable "apdex_warning_threshold" {
  description = "The threshold below which a warning violation will be triggered for the Apdex condition (percentage satisfied users)"
  type = number
  default = 0.8
}

variable "apdex_critical_threshold" {
  description = "The threshold below which a critical violation will be triggered for the Apdex condition (percentage satisfied users)"
  type = number
  default = 0.7
}

variable "apdex_duration" {
  description = "The evaluation window length of the Apdex condition (minutes)"
  type = number
  default = 5
}

variable "apdex_t" {
  description = "The response time above which a transaction is considered tolerable"
  type = number
  default = 0.4
}

variable "error_rate_warning_threshold" {
  description = "The threshold above which a warning violation will be triggered for the error rate condition (errors/minute)"
  type = number
  default = 2
}

variable "error_rate_critical_threshold" {
  description = "The threshold above which a critical violation will be triggered for the error rate condition (errors/minute)"
  type = number
  default = 5
}

variable "error_rate_duration" {
  description = "The evaluation window length of the error rate condition (minutes)"
  type = number
  default = 5
}

variable "application_url" {
  description = "The URL to use when configuring a Synthetics monitor for this application"
  type = string
  default = null
}

variable "synthetics_monitor_frequency" {
  description = "The interval on which to run Synthetics checks against the provided application URL"
  type = number
  default = 5
}

variable "synthetics_monitor_locations" {
  description = "The locations to run Synthetics checks from"
  type = list(string)
  default = ["AWS_US_EAST_1"]
}

variable "synthetics_monitor_validation_string" {
  description = "An optional string to check existence of when running Synthetics checks"
  type = string
  default = null
}

variable "synthetics_monitor_verify_ssl" {
  description = "If true, verifies SSL when running Synthetics checks"
  type = bool
  default = false
}

variable "synthetics_condition_threshold" {
  description = "The threshold above which a critical violation will be triggered for the Synthetics condition (failure count)"
  type = number
  default = 0
}

variable "synthetics_condition_duration" {
  description = "The evaluation window length of the Synthetics condition (minutes)"
  type = number
  default = 5
}

variable "response_time_warning_threshold" {
  description = "The threshold above which a warning violation will be triggered for the response time condition (seconds)"
  type = number
  default = 1 
}

variable "response_time_critical_threshold" {
  description = "The threshold above which a critical violation will be triggered for the response time condition (seconds)"
  type = number
  default = null
}

variable "response_time_duration" {
  description = "The evaluation window length of the error rate condition (minutes)"
  type = number
  default = 5
}
