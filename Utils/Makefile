init:
	# Install bundler if not installed
	if ! gem spec bundler > /dev/null 2>&1; then\
  		echo "bundler gem is not installed! Run gem install bundler to install it";\
  		-sudo gem install bundler;\
	fi
	-bundle install --path .bundle
	-bundle exec pod repo update
	-bundle exec pod install

## Used to build target. Usually, it is not called manually, it is necessary for the CI to work.
build:
	bundle exec fastlane build clean:true

## Run tests
test:
	bundle exec fastlane tests

## Allows you to perfrom swiftlint autocorrect command.
format:
	./Pods/SwiftLint/swiftlint autocorrect --config .swiftlint.yml

## Run SwiftLint check
lint:
	./Pods/SwiftLint/swiftlint lint --config .swiftlint.yml

## Execute pod install command
pod:
	-bundle exec pod install

## Default configuration for beta command
config ?= debug

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)


TARGET_MAX_CHAR_NUM=20
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
