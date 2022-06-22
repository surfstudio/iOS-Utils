init:
	# Install bundler if not installed
	if ! gem spec bundler > /dev/null 2>&1; then\
  		echo "bundler gem is not installed!";\
  		-sudo gem install bundler -v "1.17.3";\
	fi
	-bundle install --path .bundle

## Used to build target. Usually, it is not called manually, it is necessary for the CI to work.
build:
	xcodebuild clean build -scheme Utils -sdk iphonesimulator | bundle exec xcpretty -c

## Used to build target with SPM dependencies. Usually, it is not called manually, it is necessary for the CI to work.
spm_build:
	swift package clean
	swift build -Xswiftc "-sdk" -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios15.5-simulator" -Xswiftc "-lswiftUIKit"

## Run tests
test:
	xcodebuild test -scheme Utils -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO -enableCodeCoverage YES -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.5' | bundle exec xcpretty -c

## Run build for example project
example_build:
	cd UtilsExample && xcodebuild clean build -scheme UtilsExample -sdk iphonesimulator | bundle exec xcpretty -c

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
