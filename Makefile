ifneq (,)
.error This Makefile requires GNU Make.
endif

# Ensure additional Makefiles are present
MAKEFILES = Makefile.docker Makefile.lint
$(MAKEFILES): URL=https://raw.githubusercontent.com/devilbox/makefiles/master/$(@)
$(MAKEFILES):
	@if ! (curl --fail -sS -o $(@) $(URL) || wget -O $(@) $(URL)); then \
		echo "Error, curl or wget required."; \
		echo "Exiting."; \
		false; \
	fi
include $(MAKEFILES)

# Set default Target
.DEFAULT_GOAL := help


# -------------------------------------------------------------------------------------------------
# Default configuration
# -------------------------------------------------------------------------------------------------
# Own vars
TAG        = latest

# Makefile.docker overwrites
NAME       = tfdocs
VERSION    = latest
IMAGE      = cytopia/terraform-docs
FLAVOUR    = latest

FILE       = Dockerfile
ifeq ($(strip $(VERSION)),0.1.0)
	FILE = Dockerfile-0.11
else
	ifeq ($(strip $(VERSION)),0.1.1)
		FILE = Dockerfile-0.11
	else
		ifeq ($(strip $(VERSION)),0.2.0)
			FILE = Dockerfile-0.11
		else
			ifeq ($(strip $(VERSION)),0.3.0)
				FILE = Dockerfile-0.11
			else
				ifeq ($(strip $(VERSION)),0.4.0)
					FILE = Dockerfile-0.11
				else
					ifeq ($(strip $(VERSION)),0.4.5)
						FILE = Dockerfile-0.11
					else
						ifeq ($(strip $(VERSION)),0.5.0)
							FILE = Dockerfile-0.11
						else
							ifeq ($(strip $(VERSION)),0.6.0)
								FILE = Dockerfile-0.11
							else
								ifeq ($(strip $(VERSION)),0.7.0)
									FILE = Dockerfile-0.11
								endif
							endif
						endif
					endif
				endif
			endif
		endif
	endif
endif
DIR        = Dockerfiles

# Building from master branch: Tag == 'latest'
ifeq ($(strip $(TAG)),latest)
	ifeq ($(strip $(VERSION)),latest)
		DOCKER_TAG = $(FLAVOUR)
	else
		ifeq ($(strip $(FLAVOUR)),latest)
			DOCKER_TAG = $(VERSION)
		else
			DOCKER_TAG = $(FLAVOUR)-$(VERSION)
		endif
	endif
# Building from any other branch or tag: Tag == '<REF>'
else
	ifeq ($(strip $(FLAVOUR)),latest)
		DOCKER_TAG = $(VERSION)-$(TAG)
	else
		DOCKER_TAG = $(FLAVOUR)-$(VERSION)-$(TAG)
	endif
endif

# Makefile.lint overwrites
FL_IGNORES  = .git/,.github/,tests/,Dockerfiles/data/
SC_IGNORES  = .git/,.github/,tests/
JL_IGNORES  = .git/,.github/


# -------------------------------------------------------------------------------------------------
#  Default Target
# -------------------------------------------------------------------------------------------------
.PHONY: help
help:
	@echo "lint                                     Lint project files and repository"
	@echo
	@echo "build [ARCH=...] [TAG=...]               Build Docker image"
	@echo "rebuild [ARCH=...] [TAG=...]             Build Docker image without cache"
	@echo "push [ARCH=...] [TAG=...]                Push Docker image to Docker hub"
	@echo
	@echo "manifest-create [ARCHES=...] [TAG=...]   Create multi-arch manifest"
	@echo "manifest-push [TAG=...]                  Push multi-arch manifest"
	@echo
	@echo "test [ARCH=...]                          Test built Docker image"
	@echo


# -------------------------------------------------------------------------------------------------
#  Docker Targets
# -------------------------------------------------------------------------------------------------
.PHONY: build
build: ARGS=--build-arg VERSION=$(VERSION)
build: docker-arch-build

.PHONY: rebuild
rebuild: ARGS=--build-arg VERSION=$(VERSION)
rebuild: docker-arch-rebuild

.PHONY: push
push: docker-arch-push


# -------------------------------------------------------------------------------------------------
#  Manifest Targets
# -------------------------------------------------------------------------------------------------
.PHONY: manifest-create
manifest-create: docker-manifest-create

.PHONY: manifest-push
manifest-push: docker-manifest-push


# --------------------------------------------------------------------------------------------------
# Test Targets
# --------------------------------------------------------------------------------------------------
.PHONY: test
test: _test-version
test: _test-run-generate-one
test: _test-run-generate-two
test: _test-run-replace-one
test: _test-run-replace-two

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
		echo "Testing for latest: (dev|latest|beta)"; \
		if ! docker run --rm --platform $(ARCH) $(IMAGE):$(DOCKER_TAG) | grep -E "^(terraform-docs[[:space:]])?(version[[:space:]])?(v?[.0-9]+)?-?(dev|latest|beta)?"; then \
			echo "Failed"; \
			exit 1; \
		fi; \
	else \
		echo "Testing for version: $(VERSION)"; \
		if ! docker run --rm --platform $(ARCH) $(IMAGE):$(DOCKER_TAG) | grep -E "^(terraform-docs version)?\s?v?$(VERSION)(\s.*)?$$"; then \
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
	if ! docker run --rm --platform $(ARCH) -v $(PWD)/tests:/data $(IMAGE):$(DOCKER_TAG) terraform-docs md /data/output/generate/basic/ > tests/output/generate/basic/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi;
	@if ! grep '## Inputs' tests/output/generate/basic/TEST-$(VERSION).md; then \
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
	@#
	@# ---- Test Terraform < 0.12 ----
	if ! docker run --rm --platform $(ARCH) -v $(PWD)/tests:/data $(IMAGE):$(DOCKER_TAG) terraform-docs $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/generate/default/ > tests/output/generate/default/TEST-$(VERSION).md; then \
		echo "Failed 1"; \
		exit 1; \
	fi;
	@if ! grep -E '^variable.*$$' tests/output/generate/default/main.tf \
		| awk -F'"' '{print $$2}' \
		| xargs -n1 sh -c '\
			if ! cat tests/output/generate/default/TEST-$(VERSION).md \
				| sed "s/\\\//g" \
				| grep -E "([[:space:]]|\[)$$1([[:space:]]|\])" >/dev/null; \
			then \
				echo "[ERROR] $$1"; \
				false; \
			else \
				echo "[SUCC]  $$1"; \
				true; \
			fi' -- ; \
	then \
		echo "Failed 2"; \
		exit 1; \
	fi;
	@#
	@# ---- Test Terraform >= 0.12 ----
	if ! docker run --platform $(ARCH) --rm -v $(PWD)/tests:/data $(IMAGE):$(DOCKER_TAG) terraform-docs-012 $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/generate/0.12/ > tests/output/generate/0.12/TEST-$(VERSION).md; then \
		echo "Failed 3"; \
		exit 1; \
	fi;
	@if ! grep -E '^variable.*$$' tests/output/generate/0.12/main.tf \
		| awk -F'"' '{print $$2}' \
		| xargs -n1 sh -c '\
			if ! cat tests/output/generate/0.12/TEST-$(VERSION).md \
				| sed "s/\\\//g" \
				| grep -E "([[:space:]]|\[)$$1([[:space:]]|\])" >/dev/null; \
			then \
				echo "[ERROR] $$1"; \
				false; \
			else \
				echo "[SUCC]  $$1"; \
				true; \
			fi' -- ;\
	then \
		echo "Failed 4"; \
		exit 1; \
	fi;
	@#
	@echo "Success";

.PHONY: _test-run-replace-one
_test-run-replace-one:
	@echo "------------------------------------------------------------"
	@echo "- Testing terraform-docs-replace (1/2)"
	@echo "------------------------------------------------------------"
	@echo '<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' > tests/output/replace/basic/TEST-$(VERSION).md
	@echo >> tests/output/replace/basic/TEST-$(VERSION).md
	@echo '<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' >> tests/output/replace/basic/TEST-$(VERSION).md
	if ! docker run --rm --platform $(ARCH) -v $(PWD)/tests:/data $(IMAGE):$(DOCKER_TAG) terraform-docs-replace md /data/output/replace/basic/TEST-$(VERSION).md; then \
		echo "Failed 1"; \
		exit 1; \
	fi;
	@if ! grep '## Inputs' tests/output/replace/basic/TEST-$(VERSION).md; then \
		echo "Failed 2"; \
		exit 1; \
	fi; \
	if ! grep 'test description' tests/output/replace/basic/TEST-$(VERSION).md; then \
		echo "Failed 3"; \
		exit 1; \
	fi; \
	if ! grep -E '^variable.*$$' tests/output/replace/basic/main.tf \
		| awk -F'"' '{print $$2}' \
		| xargs -n1 sh -c '\
			if ! cat tests/output/replace/basic/TEST-$(VERSION).md \
				| sed "s/\\\//g" \
				| grep -E "([[:space:]]|\[)$$1([[:space:]]|\])" >/dev/null; \
			then \
				echo "[ERROR] $$1"; \
				false; \
			else \
				echo "[SUCC]  $$1"; \
				true; \
			fi' -- ; \
	then \
		echo "Failed 4"; \
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
	@#
	@# ---- Test Terraform < 0.12 ----
	if ! docker run --rm --platform $(ARCH) -v $(PWD)/tests:/data $(IMAGE):$(DOCKER_TAG) terraform-docs-replace $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/replace/default/TEST-$(VERSION).md; then \
		echo "Failed 1"; \
		exit 1; \
	fi;
	@if ! grep -E '^variable.*$$' tests/output/replace/default/main.tf \
		| awk -F'"' '{print $$2}' \
		| xargs -n1 sh -c '\
			if ! cat tests/output/replace/default/TEST-$(VERSION).md \
				| sed "s/\\\//g" \
				| grep -E "([[:space:]]|\[)$$1([[:space:]]|\])" >/dev/null; \
			then \
				echo "[ERROR] $$1"; \
				false; \
			else \
				echo "[SUCC]  $$1"; \
				true; \
			fi' -- ; \
	then \
		echo "Failed 2"; \
		exit 1; \
	fi;
	@#
	@# ---- Test Terraform >= 0.12 ----
	if ! docker run --rm --platform $(ARCH) -v $(PWD)/tests:/data $(IMAGE):$(DOCKER_TAG) terraform-docs-replace-012 $(TFDOC_ARG_SORT) $(TFDOC_ARG_AGGREGATE) md /data/output/replace/0.12/TEST-$(VERSION).md; then \
		echo "Failed"; \
		exit 1; \
	fi;
	@if ! grep -E '^variable.*$$' tests/output/replace/0.12/main.tf \
		| awk -F'"' '{print $$2}' \
		| xargs -n1 sh -c '\
			if ! cat tests/output/replace/0.12/TEST-$(VERSION).md \
				| sed "s/\\\//g" \
				| grep -E "([[:space:]]|\[)$$1([[:space:]]|\])" >/dev/null; \
			then \
				echo "[ERROR] $$1"; \
				false; \
			else \
				echo "[SUCC]  $$1"; \
				true; \
			fi' -- ; \
	then \
		echo "Failed 3"; \
		exit 1; \
	fi; \
	echo "Success";
