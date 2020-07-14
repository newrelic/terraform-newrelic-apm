locals {
  policy_name = var.policy_name == null ? "${var.application_name}: APM Monitoring" : var.policy_name
}

resource "newrelic_alert_policy" "policy" {
  name                = local.policy_name
  incident_preference = var.incident_preference
  channel_ids         = var.channel_ids
}

resource "newrelic_nrql_alert_condition" "apdex_condition" {
  policy_id = newrelic_alert_policy.policy.id

  name        = "Apdex (Low)"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = true

  warning {
    operator              = "below"
    threshold             = var.apdex_warning_threshold
    threshold_duration    = var.apdex_duration
    threshold_occurrences = "ALL"
  }

  critical {
    operator              = "below"
    threshold             = var.apdex_critical_threshold
    threshold_duration    = var.apdex_duration
    threshold_occurrences = "ALL"
  }

  nrql {
    query             = "SELECT apdex(duration, t: ${var.apdex_t}) FROM Transaction WHERE appName = '${var.application_name}' AND accountId = ${var.account_id}"
    evaluation_offset = 3
  }

  value_function = "single_value"
  violation_time_limit = "ONE_HOUR"
}

resource "newrelic_nrql_alert_condition" "error_rate_condition" {
  policy_id = newrelic_alert_policy.policy.id

  name        = "Error rate (High)"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = true

  critical {
    operator              = "above"
    threshold             = var.error_rate_critical_threshold
    threshold_duration    = var.error_rate_duration
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = var.error_rate_warning_threshold
    threshold_duration    = var.error_rate_duration
    threshold_occurrences = "ALL"
  }

  nrql {
    query             = "SELECT percentage(count(*), WHERE error IS TRUE) FROM Transaction WHERE appName = '${var.application_name}' AND accountId = ${var.account_id}"
    evaluation_offset = 3
  }

  value_function       = "single_value"
  violation_time_limit = "ONE_HOUR"
}

resource "newrelic_synthetics_monitor" "synthetics_monitor" {
  count = var.application_url == null ? 0 : 1

  name      = "${var.application_name}: SIMPLE"
  type      = "SIMPLE"
  frequency = var.synthetics_monitor_frequency
  status    = "ENABLED"
  locations = var.synthetics_monitor_locations

  uri               = var.application_url
  validation_string = var.synthetics_monitor_validation_string
  verify_ssl        = var.synthetics_monitor_verify_ssl
}


resource "newrelic_nrql_alert_condition" "synthetics_condition" {
  count = var.application_url == null ? 0 : 1

  policy_id = newrelic_alert_policy.policy.id

  name        = "Synthetics monitor failure"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = true

  critical {
    operator              = "above"
    threshold             = var.synthetics_condition_threshold
    threshold_duration    = var.synthetics_condition_duration
    threshold_occurrences = "ALL"
  }

  nrql {
    query             = "SELECT count(*) FROM SyntheticCheck WHERE result != 'SUCCESS' WHERE monitorId = '${newrelic_synthetics_monitor.synthetics_monitor[0].id}'"
    evaluation_offset = 3
  }

  value_function       = "single_value"
  violation_time_limit = "ONE_HOUR"
}

resource "newrelic_nrql_alert_condition" "response_time_condition" {
  count = var.response_time_critical_threshold == null ? 0 : 1

  policy_id = newrelic_alert_policy.policy.id

  name        = "Response time (High)"
  type        = "static"
  runbook_url = var.runbook_url
  enabled     = true

  warning {
    operator              = "above"
    threshold             = var.response_time_warning_threshold
    threshold_duration    = var.response_time_duration
    threshold_occurrences = "ALL"
  }

  critical {
    operator              = "above"
    threshold             = var.response_time_critical_threshold
    threshold_duration    = var.response_time_duration
    threshold_occurrences = "ALL"
  }

  nrql {
    query             = "SELECT average(duration) FROM Transaction WHERE appName = '${var.application_name}' AND accountId = ${var.account_id}"
    evaluation_offset = 3
  }

  value_function       = "single_value"
  violation_time_limit = "ONE_HOUR"
}
