#############################
# Global vars
#############################
PROJECT_NAME := $(shell basename $(shell pwd))

RELEASE_SCRIPT ?= ./scripts/release.sh

release:
	@echo "=== $(PROJECT_NAME) === [ release          ]: Generating release."
	$(RELEASE_SCRIPT) $(version)

.PHONY: release