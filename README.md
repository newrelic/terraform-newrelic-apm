[![Community Project header](https://github.com/newrelic/open-source-office/raw/master/examples/categories/images/Community_Project.png)](https://github.com/newrelic/open-source-office/blob/master/examples/categories/index.md#category-community-project)

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
data "newrelic_alert_channel" "pager" {
    name = "Page Developer Toolkit Team"
}

module "dummy-app-monitor" {
    source = "newrelic/apm/newrelic"

    account_id = 2520528
    application_name = "Dummy App"

    # An Apdex alert condition will be created with sensible defaults without the use of these attributes.
    apdex_warning_threshold = 0.9
    apdex_critical_threshold = 0.8

    # An error rate alert condition will be created with sensible defaults without the use of these attributes.
    error_rate_warning_threshold = 5
    error_rate_critical_threshold = 10

    # Specifying an application URL will provision a Synthetics monitor and associated alert condition.
    application_url = "https://www.dummyapp.com"
    synthetics_monitor_verify_ssl = true

    # Response time alert condition will not be provisioned unless a critical violation threshold is specified.
    response_time_critical_threshold = 3

    channel_ids = [data.newrelic_alert_channel.pager.id]
}
```

## Notes

1. This module does not create a notification channel. Use the [newrelic_alert_channel](https://www.terraform.io/docs/providers/newrelic/r/alert_channel.html) resource for this.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| newrelic | >= 1.15.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_id | The account ID the application reports to | `number` | n/a | yes |
| apdex\_critical\_threshold | The threshold below which a critical violation will be triggered for the Apdex condition (percentage satisfied users) | `number` | `0.7` | no |
| apdex\_duration | The evaluation window length of the Apdex condition (minutes) | `number` | `5` | no |
| apdex\_t | The response time above which a transaction is considered tolerable | `number` | `0.4` | no |
| apdex\_warning\_threshold | The threshold below which a warning violation will be triggered for the Apdex condition (percentage satisfied users) | `number` | `0.8` | no |
| application\_name | The name of the New Relic application to monitor | `string` | n/a | yes |
| application\_url | The URL to use when configuring a Synthetics monitor for this application | `string` | n/a | yes |
| channel\_ids | The notification channel IDs to link to this alert policy | `list(number)` | n/a | yes |
| error\_rate\_critical\_threshold | The threshold above which a critical violation will be triggered for the error rate condition (errors/minute) | `number` | `5` | no |
| error\_rate\_duration | The evaluation window length of the error rate condition (minutes) | `number` | `5` | no |
| error\_rate\_warning\_threshold | The threshold above which a warning violation will be triggered for the error rate condition (errors/minute) | `number` | `2` | no |
| incident\_preference | The rollup strategy of the alert policy.  Valid values are PER\_POLICY, PER\_CONDITION, and PER\_CONDITION\_AND\_TARGET | `string` | `"PER_POLICY"` | no |
| policy\_name | The name of the alert policy to manage | `string` | n/a | yes |
| response\_time\_critical\_threshold | The threshold above which a critical violation will be triggered for the response time condition (seconds) | `number` | n/a | yes |
| response\_time\_duration | The evaluation window length of the error rate condition (minutes) | `number` | `5` | no |
| response\_time\_warning\_threshold | The threshold above which a warning violation will be triggered for the response time condition (seconds) | `number` | `1` | no |
| runbook\_url | A URL that points to a runbook for when this application is failing | `string` | n/a | yes |
| synthetics\_condition\_duration | The evaluation window length of the Synthetics condition (minutes) | `number` | `5` | no |
| synthetics\_condition\_threshold | The threshold above which a critical violation will be triggered for the Synthetics condition (failure count) | `number` | `0` | no |
| synthetics\_monitor\_frequency | The interval on which to run Synthetics checks against the provided application URL | `number` | `5` | no |
| synthetics\_monitor\_locations | The locations to run Synthetics checks from | `list(string)` | <pre>[<br>  "AWS_US_EAST_1"<br>]</pre> | no |
| synthetics\_monitor\_validation\_string | An optional string to check existence of when running Synthetics checks | `string` | n/a | yes |
| synthetics\_monitor\_verify\_ssl | If true, verifies SSL when running Synthetics checks | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| apdex\_condition\_id | The ID of the provisioned Apdex condition. |
| error\_rate\_condition\_id | The ID of the provisioned error rate condition. |
| policy\_id | The ID of the provisioned alert policy. |
| reponse\_time\_condition\_id | The ID of the provisioned response time condition. |
| synthetics\_condition\_id | The ID of the provisioned Synthetics condition. |
| synthetics\_monitor\_id | The ID of the provisioned Synthetics monitor. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Community Support

New Relic hosts and moderates an online forum where you can interact with New Relic employees as well as other customers to get help and share best practices. Like all New Relic open source community projects, there's a related topic in the New Relic Explorers Hub. You can find this project's topic/threads here:

[https://discuss.newrelic.com/t/new-relic-terraform-provider-1-16-0/98241](https://discuss.newrelic.com/t/new-relic-terraform-provider-1-16-0/98241)

Please do not report issues with this project to New Relic Global Technical Support. Instead, visit the [`Explorers Hub`](https://discuss.newrelic.com/t/new-relic-terraform-provider-1-16-0/98241) for troubleshooting and best-practices.

## License

Apache 2.0 Licensed. See [LICENSE](https://github.com/newrelic/terraform-newrelic-apm/blob/master/LICENSE) for full details.
