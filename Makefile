ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: build rebuild lint test _test-version _test-run-generate-one _test-run-generate-two _test-run-replace-one _test-run-replace-two tag pull login push enter

# --------------------------------------------------------------------------------------------------
# VARIABLES
# --------------------------------------------------------------------------------------------------
DIR = .
FILE_012 = Dockerfile-0.12
FILE_011 = Dockerfile-0.11
IMAGE = cytopia/terraform-docs
TAG = latest
NO_CACHE =


# --------------------------------------------------------------------------------------------------
# DEFAULT TARGET
# --------------------------------------------------------------------------------------------------
help:
	@echo "lint                   Lint this repository."
	@echo "build   [TAG=x.y.z]    Build terraform-docs docker image."
	@echo "rebuild [TAG=x.y.z]    Build terraform-docs docker image without cache."
	@echo "test    [TAG=x.y.z]    Test built terraform-docs docker image."


# --------------------------------------------------------------------------------------------------
# BUILD TARGETS
# --------------------------------------------------------------------------------------------------
build:
	if [ "$(TAG)" = "0.1.0" ] \
	|| [ "$(TAG)" = "0.1.1" ] \
	|| [ "$(TAG)" = "0.2.0" ] \
	|| [ "$(TAG)" = "0.3.0" ] \
	|| [ "$(TAG)" = "0.4.0" ] \
	|| [ "$(TAG)" = "0.4.5" ] \
	|| [ "$(TAG)" = "0.5.0" ] \
	|| [ "$(TAG)" = "0.6.0" ] \
	|| [ "$(TAG)" = "0.7.0" ]; then \
		docker build $(NO_CACHE) --build-arg VERSION=$(TAG) -t $(IMAGE) -f $(DIR)/$(FILE_011) $(DIR); \
	else \
		docker build $(NO_CACHE) --build-arg VERSION=$(TAG) -t $(IMAGE) -f $(DIR)/$(FILE_012) $(DIR); \
	fi

rebuild: NO_CACHE=--no-cache
rebuild: build


# --------------------------------------------------------------------------------------------------
# LINT TARGETS
# --------------------------------------------------------------------------------------------------
lint:
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-cr --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-crlf --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-trailing-single-newline --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-trailing-space --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-utf8 --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-utf8-bom --text --ignore '.git/,.github/,tests/' --path .


# --------------------------------------------------------------------------------------------------
# TEST TARGETS
# --------------------------------------------------------------------------------------------------
test:
	@$(MAKE) --no-print-directory _test-version
	@$(MAKE) --no-print-directory _test-run-generate-one
	@$(MAKE) --no-print-directory _test-run-generate-two
	@$(MAKE) --no-print-directory _test-run-replace-one
	@$(MAKE) --no-print-directory _test-run-replace-two

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
		echo "Testing for latest: (dev|latest)"; \
		if ! docker run --rm $(IMAGE) | grep -E "^(terraform-docs[[:space:]])?(version[[:space:]])?(dev|latest)"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for tag: $(TAG)"; \
		if ! docker run --rm $(IMAGE) | grep -E "^(terraform-docs version)?\s?v?$(TAG)(\s.*)?$$"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	fi; \
	echo "Success"; \

_test-run-generate-one:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs (1/2)"
	@echo "------------------------------------------------------------"
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs md /data/output/generate/basic/ > tests/output/generate/basic/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep '## Inputs' tests/output/generate/basic/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/generate/basic/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/generate/basic/TEST-$(TAG).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

_test-run-generate-two:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs (2/2)"
	@echo "------------------------------------------------------------"
	$(eval TFDOC_ARG_SORT = $(shell \
		if [ "$(TAG)" != "0.1.0" ] && [ "$(TAG)" != "0.1.1" ] && [ "$(TAG)" != "0.2.0" ] && [ "$(TAG)" != "0.3.0" ] && [ "$(TAG)" != "0.4.0" ] && [ "$(TAG)" != "0.4.5" ]; then \
			echo "--sort-inputs-by-required"; \
		fi; \
	))
	$(eval TFDOC_ARG_AGGREGATE = $(shell \
		if [ "$(TAG)" != "0.1.0" ] && [ "$(TAG)" != "0.1.1" ] && [ "$(TAG)" != "0.2.0" ] && [ "$(TAG)" != "0.3.0" ]; then \
			echo "--with-aggregate-type-defaults"; \
		fi; \
	))
	@# ---- Test Terraform < 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/generate/default/ > tests/output/generate/default/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/generate/default/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/generate/default/TEST-$(TAG).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi
	@# ---- Test Terraform >= 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-012 $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/generate/0.12/ > tests/output/generate/0.12/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/generate/0.12/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/generate/0.12/TEST-$(TAG).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi
	@echo "Success";

_test-run-replace-one:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs-replace (1/2)"
	@echo "------------------------------------------------------------"
	@echo '<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' > tests/output/replace/basic/TEST-$(TAG).md
	@echo >> tests/output/replace/basic/TEST-$(TAG).md
	@echo '<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' >> tests/output/replace/basic/TEST-$(TAG).md
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-replace md /data/output/replace/basic/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep '## Inputs' tests/output/replace/basic/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep 'test description' tests/output/replace/basic/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/replace/basic/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/replace/basic/TEST-$(TAG).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

_test-run-replace-two:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs-replace (2/2)"
	@echo "------------------------------------------------------------"
	$(eval TFDOC_ARG_SORT = $(shell \
		if [ "$(TAG)" != "0.1.0" ] && [ "$(TAG)" != "0.1.1" ] && [ "$(TAG)" != "0.2.0" ] && [ "$(TAG)" != "0.3.0" ] && [ "$(TAG)" != "0.4.0" ] && [ "$(TAG)" != "0.4.5" ]; then \
			echo "--sort-inputs-by-required"; \
		fi; \
	))
	$(eval TFDOC_ARG_AGGREGATE = $(shell \
		if [ "$(TAG)" != "0.1.0" ] && [ "$(TAG)" != "0.1.1" ] && [ "$(TAG)" != "0.2.0" ] && [ "$(TAG)" != "0.3.0" ]; then \
			echo "--with-aggregate-type-defaults"; \
		fi; \
	))
	@# ---- Test Terraform < 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-replace $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/replace/default/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/replace/default/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/replace/default/TEST-$(TAG).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi
	@# ---- Test Terraform >= 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-replace-012 $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/replace/0.12/TEST-$(TAG).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/replace/0.12/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/replace/0.12/TEST-$(TAG).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";


# --------------------------------------------------------------------------------------------------
# HELPER TARGETS
# --------------------------------------------------------------------------------------------------
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
