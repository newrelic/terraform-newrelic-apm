terraform {
  required_version = ">= 0.12.6"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.21"
    }
  }
}
