ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: lint build rebuild lint test tag pull-base-image login push enter

# --------------------------------------------------------------------------------------------------
# Variables
# --------------------------------------------------------------------------------------------------
DIR = .
FILE_012 = Dockerfile-0.12
FILE_011 = Dockerfile-0.11
IMAGE = cytopia/terraform-docs
TAG = latest
VERSION = latest
NO_CACHE =


# --------------------------------------------------------------------------------------------------
# Default Target
# --------------------------------------------------------------------------------------------------
help:
	@echo "lint                      Lint project files and repository"
	@echo "build   [VERSION=...]     Build terraform-docs docker image"
	@echo "rebuild [VERSION=...]     Build terraform-docs docker image without cache"
	@echo "test    [VERSION=...]     Test built terraform-docs docker image"
	@echo "tag TAG=...               Retag Docker image"
	@echo "login USER=... PASS=...   Login to Docker hub"
	@echo "push [TAG=...]            Push Docker image to Docker hub"


# --------------------------------------------------------------------------------------------------
# Lint Targets
# --------------------------------------------------------------------------------------------------
lint: lint-workflow
lint: lint-files

.PHONY: lint-workflow
lint-workflow:
	@echo "################################################################################"
	@echo "# Lint Workflow"
	@echo "################################################################################"
	@\
	GIT_CURR_MAJOR="$$( git tag | sort -V | tail -1 | sed 's|\.[0-9]*$$||g' )"; \
	GIT_CURR_MINOR="$$( git tag | sort -V | tail -1 | sed 's|^[0-9]*\.||g' )"; \
	GIT_NEXT_TAG="$${GIT_CURR_MAJOR}.$$(( GIT_CURR_MINOR + 1 ))"; \
		if ! grep 'refs:' -A 100 .github/workflows/nightly.yml \
		| grep  "          - '$${GIT_NEXT_TAG}'" >/dev/null; then \
		echo "[ERR] New Tag required in .github/workflows/nightly.yml: $${GIT_NEXT_TAG}"; \
			exit 1; \
		else \
		echo "[OK] Git Tag present in .github/workflows/nightly.yml: $${GIT_NEXT_TAG}"; \
	fi
	@echo

.PHONY: lint-files
lint-files:
	@echo "################################################################################"
	@echo "# Lint Files"
	@echo "################################################################################"
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-cr --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-crlf --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-trailing-single-newline --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-trailing-space --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-utf8 --text --ignore '.git/,.github/,tests/' --path .
	@docker run --rm -v $(PWD):/data cytopia/file-lint file-utf8-bom --text --ignore '.git/,.github/,tests/' --path .
	@echo


# --------------------------------------------------------------------------------------------------
# Build Targets
# --------------------------------------------------------------------------------------------------
build:
	if [ "$(VERSION)" = "0.1.0" ] \
	|| [ "$(VERSION)" = "0.1.1" ] \
	|| [ "$(VERSION)" = "0.2.0" ] \
	|| [ "$(VERSION)" = "0.3.0" ] \
	|| [ "$(VERSION)" = "0.4.0" ] \
	|| [ "$(VERSION)" = "0.4.5" ] \
	|| [ "$(VERSION)" = "0.5.0" ] \
	|| [ "$(VERSION)" = "0.6.0" ] \
	|| [ "$(VERSION)" = "0.7.0" ]; then \
		docker build $(NO_CACHE) --build-arg VERSION=$(VERSION) -t $(IMAGE) -f $(DIR)/$(FILE_011) $(DIR); \
	else \
		docker build $(NO_CACHE) --build-arg VERSION=$(VERSION) -t $(IMAGE) -f $(DIR)/$(FILE_012) $(DIR); \
	fi

rebuild: NO_CACHE=--no-cache
rebuild: pull-base-image
rebuild: build



# --------------------------------------------------------------------------------------------------
# Test Targets
# --------------------------------------------------------------------------------------------------
test:
	@$(MAKE) --no-print-directory _test-version
	@$(MAKE) --no-print-directory _test-run-generate-one
	@$(MAKE) --no-print-directory _test-run-generate-two
	@$(MAKE) --no-print-directory _test-run-replace-one
	@$(MAKE) --no-print-directory _test-run-replace-two

.PHONY: _test-version
_test-version:
	@echo "------------------------------------------------------------"
	@echo "- Testing correct version"
	@echo "------------------------------------------------------------"
	@if [ "$(VERSION)" = "latest" ]; then \
		echo "Fetching latest version from GitHub"; \
		LATEST="$$( \
			curl -L -sS  https://github.com/terraform-docs/terraform-docs/releases/latest/ \
				| tac | tac \
				| grep -Eo "terraform-docs/terraform-docs/releases/tag/v[.0-9]+" \
				| head -1 \
				| sed 's/.*v//g' \
		)"; \
		echo "Testing for latest: (dev|latest)"; \
		if ! docker run --rm $(IMAGE) | grep -E "^(terraform-docs[[:space:]])?(version[[:space:]])?(dev|latest|v$$LATEST-[0-9]+-[0-9a-z]{8}[[:space:]])"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for version: $(VERSION)"; \
		if ! docker run --rm $(IMAGE) | grep -E "^(terraform-docs version)?\s?v?$(VERSION)(\s.*)?$$"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	fi; \
	echo "Success"; \

.PHONY: _test-run-generate-one
_test-run-generate-one:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs (1/2)"
	@echo "------------------------------------------------------------"
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs md /data/output/generate/basic/ > tests/output/generate/basic/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep '## Inputs' tests/output/generate/basic/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/generate/basic/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/generate/basic/TEST-$(VERSION).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

.PHONY: _test-run-generate-two
_test-run-generate-two:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs (2/2)"
	@echo "------------------------------------------------------------"
	$(eval TFDOC_ARG_SORT = $(shell \
		if [ "$(VERSION)" = "0.5.0" ] || [ "$(VERSION)" = "0.6.0" ] || [ "$(VERSION)" = "0.7.0" ] || [ "$(VERSION)" = "0.8.0" ] || [ "$(VERSION)" = "0.8.1" ] || [ "$(VERSION)" = "0.8.2" ] || [ "$(VERSION)" = "0.9.0" ] || [ "$(VERSION)" = "0.9.1" ]; then \
			echo "--sort-inputs-by-required"; \
		fi; \
	))
	$(eval TFDOC_ARG_AGGREGATE = $(shell \
		if [ "$(VERSION)" = "0.4.0" ] ||[ "$(VERSION)" = "0.4.5" ] ||  [ "$(VERSION)" = "0.5.0" ] || [ "$(VERSION)" = "0.6.0" ] || [ "$(VERSION)" = "0.7.0" ] || [ "$(VERSION)" = "0.8.0" ] || [ "$(VERSION)" = "0.8.1" ] || [ "$(VERSION)" = "0.8.2" ] || [ "$(VERSION)" = "0.9.0" ] || [ "$(VERSION)" = "0.9.1" ]; then \
			echo "--with-aggregate-type-defaults"; \
		fi; \
	))
	@# ---- Test Terraform < 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/generate/default/ > tests/output/generate/default/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/generate/default/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/generate/default/TEST-$(VERSION).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi
	@# ---- Test Terraform >= 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-012 $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/generate/0.12/ > tests/output/generate/0.12/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/generate/0.12/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/generate/0.12/TEST-$(VERSION).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi
	@echo "Success";

.PHONY: _test-run-replace-one
_test-run-replace-one:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs-replace (1/2)"
	@echo "------------------------------------------------------------"
	@echo '<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' > tests/output/replace/basic/TEST-$(VERSION).md
	@echo >> tests/output/replace/basic/TEST-$(VERSION).md
	@echo '<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' >> tests/output/replace/basic/TEST-$(VERSION).md
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-replace md /data/output/replace/basic/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep '## Inputs' tests/output/replace/basic/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep 'test description' tests/output/replace/basic/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/replace/basic/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/replace/basic/TEST-$(VERSION).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";

.PHONY: _test-run-replace-two
_test-run-replace-two:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs-replace (2/2)"
	@echo "------------------------------------------------------------"
	$(eval TFDOC_ARG_SORT = $(shell \
		if [ "$(VERSION)" = "0.5.0" ] || [ "$(VERSION)" = "0.6.0" ] || [ "$(VERSION)" = "0.7.0" ] || [ "$(VERSION)" = "0.8.0" ] || [ "$(VERSION)" = "0.8.1" ] || [ "$(VERSION)" = "0.8.2" ] || [ "$(VERSION)" = "0.9.0" ] || [ "$(VERSION)" = "0.9.1" ]; then \
			echo "--sort-inputs-by-required"; \
		fi; \
	))
	$(eval TFDOC_ARG_AGGREGATE = $(shell \
		if [ "$(VERSION)" = "0.4.0" ] ||[ "$(VERSION)" = "0.4.5" ] ||  [ "$(VERSION)" = "0.5.0" ] || [ "$(VERSION)" = "0.6.0" ] || [ "$(VERSION)" = "0.7.0" ] || [ "$(VERSION)" = "0.8.0" ] || [ "$(VERSION)" = "0.8.1" ] || [ "$(VERSION)" = "0.8.2" ] || [ "$(VERSION)" = "0.9.0" ] || [ "$(VERSION)" = "0.9.1" ]; then \
			echo "--with-aggregate-type-defaults"; \
		fi; \
	))
	@# ---- Test Terraform < 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-replace $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/replace/default/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/replace/default/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/replace/default/TEST-$(VERSION).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi
	@# ---- Test Terraform >= 0.12 ----
	@if ! docker run --rm -v $(PWD)/tests:/data $(IMAGE) terraform-docs-replace-012 $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/replace/0.12/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/replace/0.12/main.tf | awk -F'"' '{print $$2}' | xargs -n1 sh -c 'if ! cat tests/output/replace/0.12/TEST-$(VERSION).md | sed "s/\\\//g" | grep -E "[[:space:]]$$1[[:space:]]" >/dev/null; then echo "[ERROR] $$1"; false; else echo "[SUCC]  $$1"; true; fi' -- ; then \
		echo "Failed"; \
		exit 1; \
	fi; \
	echo "Success";


# -------------------------------------------------------------------------------------------------
#  Deploy Targets
# -------------------------------------------------------------------------------------------------
tag:
	docker tag $(IMAGE) $(IMAGE):$(TAG)

login:
	yes | docker login --username $(USER) --password $(PASS)

push:
	docker push $(IMAGE):$(TAG)


# --------------------------------------------------------------------------------------------------
# Helper Targets
# --------------------------------------------------------------------------------------------------
pull-base-image:
	@grep -E '^\s*FROM' Dockerfile-0.11 \
		| sed -e 's/^FROM//g' -e 's/[[:space:]]*as[[:space:]]*.*$$//g' \
		| xargs -n1 docker pull;
	@grep -E '^\s*FROM' Dockerfile-0.12 \
		| sed -e 's/^FROM//g' -e 's/[[:space:]]*as[[:space:]]*.*$$//g' \
		| xargs -n1 docker pull;

enter:
	docker run --rm --name $(subst /,-,$(IMAGE)) -it --entrypoint=/bin/sh $(ARG) $(IMAGE):$(VERSION)
