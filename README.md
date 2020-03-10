# New Relic APM Terraform module

Terraform module which creates a monitoring strategy for application resources reporting into New Relic.

This module is capable of creating an alert policy, simple Synthetics monitor, and alert conditions (Apdex (High), Response Time (High), Error rate (High), Synthetics failure) for a given application reporting data into APM.

The following resource types are provisioned via use of this module:

* [Alert Policy](https://www.terraform.io/docs/providers/newrelic/r/alert_policy.html)
* [NRQL Alert Condition](https://www.terraform.io/docs/providers/newrelic/r/nrql_alert_condition.html)
* [Synthetics Monitor](https://www.terraform.io/docs/providers/newrelic/r/synthetics_monitor.html)
* [Synthetics Alert Condition](https://www.terraform.io/docs/providers/newrelic/r/synthetics_alert_condition.html)

## Terraform versions

Terraform 0.12 is required.

## Usage

```hcl
module "dummy-app-monitor" {
    source = "newrelic/apm"

    account_id = 2520528
    application_name = "Dummy App"

    apdex_warning_threshold = 0.9
    apdex_critical_threshold = 0.8

    error_rate_warning_threshold = 5
    error_rate_critical_threshold = 10

    # Specifying an application URL will provision a Synthetics monitor and associated alert condition
    application_url = "https://www.dummyapp.com"
    synthetics_monitor_verify_ssl = true

    # Response time alert condition will not be provisioned unless a critical violation threshold is specified
    response_time_critical_threshold = 3

    # The HCL here references a notification channel that has been previously provisioned
    channel_ids = [newrelic_alert_channel.pager.id]
}
```

## Notes

1. This module does not create a notification channel. Use the [newrelic_alert_channel](https://www.terraform.io/docs/providers/newrelic/r/alert_channel.html) resource for this.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

MIT Licensed. See LICENSE for full details.