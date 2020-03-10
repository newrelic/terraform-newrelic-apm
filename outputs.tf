output "policy_id" {
  value = newrelic_alert_policy.policy.id
}

output "apdex_condition_id" {
  value = newrelic_nrql_alert_condition.apdex_condition.id
}

output "error_rate_condition_id" {
  value = newrelic_nrql_alert_condition.error_rate_condition.id
}

output "synthetics_monitor_id" {
  value = length(newrelic_synthetics_monitor.synthetics_monitor) > 0 ? newrelic_synthetics_monitor.synthetics_monitor[0].id : null
}

output "synthetics_condition_id" {
  value = length(newrelic_nrql_alert_condition.synthetics_condition) > 0 ? newrelic_nrql_alert_condition.synthetics_condition[0].id : null
}

output "reponse_time_condition_id" {
  value = length(newrelic_nrql_alert_condition.response_time_condition) > 0 ? newrelic_nrql_alert_condition.response_time_condition[0].id : null
}