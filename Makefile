.PHONY: changelog release

changelog:
	git-chglog -o CHANGELOG.md $(version)