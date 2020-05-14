SYSTEM_SPECIFIC_FILE := "$(shell sudo dmidecode --type system | sed -ne '8p' | sha256sum -z | awk '{ print $$1 }').txt"
.PHONY: system-specific
system-specific:
	touch $(SYSTEM_SPECIFIC_FILE)
