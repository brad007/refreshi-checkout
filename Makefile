# Refreshi checkout: local development commands. Run `make` to list them.
#
# There is no separate backend to start: the GraphQL API (schema, resolvers,
# idempotency rules) and the Peach Payments simulator run inside the app
# (lib/infrastructure/core/graphql/local/), and start with it on every target below.

PORT ?= 8686
DEVICE ?= chrome
CLASH_FONTS := $(foreach w,500 600 700,assets/fonts/ClashDisplay-$(w).ttf)

.DEFAULT_GOAL := help
.PHONY: help setup fonts deps codegen run web serve ios android devices test coverage analyze check clean

help: ## List the available commands
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "} {printf "  make %-10s %s\n", $$1, $$2}'

setup: fonts deps ## First-time setup: download fonts and fetch packages

fonts: $(CLASH_FONTS) ## Download Clash Display from Fontshare (not redistributable, so not in git)

$(CLASH_FONTS):
	./tool/fetch_fonts.sh

deps: ## Fetch Dart/Flutter packages
	flutter pub get

codegen: deps ## Regenerate GraphQL types, freezed, injectable, routes and mocks
	dart run build_runner build --delete-conflicting-outputs

run: setup ## Run with hot reload (DEVICE=chrome by default; see `make devices`)
	flutter run -d $(DEVICE)

web: setup ## Run in Chrome with hot reload
	flutter run -d chrome

serve: setup ## Release build at localhost:8686 (PORT=...), deep links and refresh work
	flutter build web --release
	python3 tool/serve_web.py build/web $(PORT)

ios: setup ## Run on the iOS Simulator (opens it first)
	open -a Simulator
	flutter run -d iPhone

android: setup ## Run on a running Android emulator
	flutter run -d emulator

devices: ## List the devices `make run DEVICE=...` accepts
	flutter devices

test: setup ## Run the test suite
	flutter test

coverage: setup ## Run tests with coverage (writes coverage/lcov.info)
	flutter test --coverage

analyze: deps ## Static analysis
	flutter analyze

check: analyze test ## Analyze, then test: run before pushing

clean: ## Remove build output (keeps downloaded fonts)
	flutter clean
