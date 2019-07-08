ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: build rebuild lint test _test-version _test-run-one _test-run-two tag pull login push enter

CURRENT_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

DIR = .
FILE = Dockerfile
IMAGE = cytopia/terraform-docs
TAG = latest

build:
	docker build --build-arg VERSION=$(TAG) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)

rebuild: pull
	docker build --no-cache --build-arg VERSION=$(TAG) -t $(IMAGE) -f $(DIR)/$(FILE) $(DIR)

lint:
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-cr --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-crlf --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-trailing-single-newline --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-trailing-space --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-utf8 --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(CURRENT_DIR):/data cytopia/file-lint file-utf8-bom --text --ignore '.git/,.github/,tests/' --path .

test:
	@$(MAKE) --no-print-directory _test-version
	@$(MAKE) --no-print-directory _test-run-one
	@$(MAKE) --no-print-directory _test-run-two

_test-version:
	@echo "------------------------------------------------------------"
	@echo "- Testing correct version"
	@echo "------------------------------------------------------------"
	@if [ "$(TAG)" = "latest" ]; then \
		echo "Fetching latest version from GitHub"; \
		LATEST="$$( \
			curl -L -sS  https://github.com/segmentio/terraform-docs/releases/latest/ \
				| tac | tac \
				| grep -Eo "segmentio/terraform-docs/releases/tag/v[.0-9]+" \
				| head -1 \
				| sed 's/.*v//g' \
		)"; \
		echo "Testing for latest: dev"; \
		if ! docker run --rm $(IMAGE) | grep -E "^(terraform-docs[[:space:]])?(version[[:space:]])?dev"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for tag: $(TAG)"; \
		if ! docker run --rm $(IMAGE) | grep -E "^v?$(TAG)$$"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	fi; \
	echo "Success"; \

_test-run-one:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs (1/2)"
	@echo "------------------------------------------------------------"
	@echo '<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' > tests/basic/TEST-$(TAG).md
	@echo >> tests/basic/TEST-$(TAG).md
	@echo '<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' >> tests/basic/TEST-$(TAG).md
	@if ! docker run --rm -v $(CURRENT_DIR)/tests/basic:/data $(IMAGE) terraform-docs-replace md TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep '## Inputs' tests/basic/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep 'test description' tests/basic/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

_test-run-two:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs (2/2)"
	@echo "------------------------------------------------------------"
	$(eval TFDOC_ARG_SORT = $(shell \
		if [ "$(TAG)" = "latest" ] || [ "$(TAG)" = "0.6.0" ] || [ "$(TAG)" = "0.5.0" ]; then \
			echo "--sort-inputs-by-required"; \
		fi; \
	))
	$(eval TFDOC_ARG_AGGREGATE = $(shell \
		if [ "$(TAG)" = "latest" ] || [ "$(TAG)" = "0.6.0" ] || [ "$(TAG)" = "0.5.0" ] || [ "$(TAG)" = "0.4.5" ] || [ "$(TAG)" = "0.4.0" ]; then \
			echo "--with-aggregate-type-defaults"; \
		fi; \
	))
	@# ---- Test Terraform < 0.12 ----
	@if ! docker run --rm -v $(CURRENT_DIR)/tests/default:/data $(IMAGE) terraform-docs-replace $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi
	@# ---- Test Terraform >= 0.12 ----
	@if ! docker run --rm -v $(CURRENT_DIR)/tests/0.12:/data $(IMAGE) terraform-docs-replace-012 $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

tag:
	docker tag $(IMAGE) $(IMAGE):$(TAG)

pull:
	@grep -E '^\s*FROM' Dockerfile \
		| sed -e 's/^FROM//g' -e 's/[[:space:]]*as[[:space:]]*.*$$//g' \
		| xargs -n1 docker pull;

login:
	yes | docker login --username $(USER) --password $(PASS)

push:
	@$(MAKE) tag TAG=$(TAG)
	docker push $(IMAGE):$(TAG)

enter:
	docker run --rm --name $(subst /,-,$(IMAGE)) -it --entrypoint=/bin/sh $(ARG) $(IMAGE):$(TAG)
