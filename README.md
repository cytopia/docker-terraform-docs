# Docker image for `terraform-docs`

[![Build Status](https://travis-ci.com/cytopia/docker-terraform-docs.svg?branch=master)](https://travis-ci.com/cytopia/docker-terraform-docs)
[![Tag](https://img.shields.io/github/tag/cytopia/docker-terraform-docs.svg)](https://github.com/cytopia/docker-terraform-docs/releases)
[![](https://images.microbadger.com/badges/version/cytopia/terraform-docs:latest.svg)](https://microbadger.com/images/cytopia/terraform-docs:latest "terraform-docs")
[![](https://images.microbadger.com/badges/image/cytopia/terraform-docs:latest.svg)](https://microbadger.com/images/cytopia/terraform-docs:latest "terraform-docs")
[![](https://img.shields.io/badge/github-cytopia%2Fdocker--terraform--docs-red.svg)](https://github.com/cytopia/docker-terraform-docs "github.com/cytopia/docker-terraform-docs")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

> #### All awesome CI images
>
> [ansible](https://github.com/cytopia/docker-ansible) |
> [ansible-lint](https://github.com/cytopia/docker-ansible-lint) |
> [awesome-ci](https://github.com/cytopia/awesome-ci) |
> [eslint](https://github.com/cytopia/docker-eslint) |
> [jsonlint](https://github.com/cytopia/docker-jsonlint) |
> [terraform-docs](https://github.com/cytopia/docker-terraform-docs) |
> [yamllint](https://github.com/cytopia/docker-yamllint)


View **[Dockerfile](https://github.com/cytopia/docker-terraform-docs/blob/master/Dockerfile)** on GitHub.

[![Docker hub](http://dockeri.co/image/cytopia/terraform-docs)](https://hub.docker.com/r/cytopia/terraform-docs)

Tiny Alpine-based multistage-build dockerized version of [terraform-docs](https://github.com/segmentio/terraform-docs)<sup>[1]</sup>,
which additionally implements `terraform-docs-replace` allowing you to automatically and safely
replace the `terraform-docs` generated output infile.
Furthermore this implementation is also **Terraform >= 0.12 ready**<sup>[2]</sup>. See [Generic Usage](#generic) for more details.
The image is built nightly against multiple stable versions and pushed to Dockerhub.

* <sub>[1] Official project: https://github.com/segmentio/terraform-docs</sub>
* <sub>[2] Based on an awk script by [cloudposse/build-harness](https://github.com/cloudposse/build-harness/blob/master/bin/terraform-docs.awk)</sub>


## Available Docker image versions

| Docker tag | Build from |
|------------|------------|
| `latest`   | [Branch: master](https://github.com/segmentio/terraform-docs) |
| `0.6.0`    | [Tag: v0.6.0](https://github.com/segmentio/terraform-docs/tree/v0.6.0) |
| `0.5.0`    | [Tag: v0.5.0](https://github.com/segmentio/terraform-docs/tree/v0.5.0) |
| `0.4.5`    | [Tag: v0.4.5](https://github.com/segmentio/terraform-docs/tree/v0.4.5) |
| `0.4.0`    | [Tag: v0.4.0](https://github.com/segmentio/terraform-docs/tree/v0.4.0) |
| `0.3.0`    | [Tag: v0.3.0](https://github.com/segmentio/terraform-docs/tree/v0.3.0) |
| `0.2.0`    | [Tag: v0.2.0](https://github.com/segmentio/terraform-docs/tree/v0.2.0) |
| `0.1.1`    | [Tag: v0.1.1](https://github.com/segmentio/terraform-docs/tree/v0.1.1) |
| `0.1.0`    | [Tag: v0.1.0](https://github.com/segmentio/terraform-docs/tree/v0.1.0) |


## Environment variables

The following Docker environment variables are available. These will only need to be used when
using `terraform-docs-replace`.

| Variable | Default | Required | Comment |
|----------|---------|----------|---------|
| DELIM_START | `<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->` | No | The starting delimiter in the file in where you want to replace the `terraform-docs` output. |
| DELIM_CLOSE | `<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->` | No | The ending delimiter in the file in where you want to replace the `terraform-docs` output. |


## Docker mounts

The working directory inside the Docker container is `/data/` and should be mounted locally to
where your Terraform module is located.


## Usage

#### Generic
```bash
Usage: cytopia/terraform-docs terraform-docs <ARGS> .
       cytopia/terraform-docs terraform-docs-012 <ARGS> .

       cytopia/terraform-docs terraform-docs-replace <ARGS> <PATH-TO-FILE>
       cytopia/terraform-docs terraform-docs-replace-012 <ARGS> <PATH-TO-FILE>


terraform-docs              Output as expected from terraform-docs
terraform-docs-012          Same as above, but used for Terraform >= 0.12 modules

terraform-docs-replace      Replaces directly inside README.md, if DELIM_START and DELIM_CLOSE are found.
terraform-docs-replace-012  Same as above, but used for Terraform >= 0.12 modules

<ARGS>                      All arguments terraform-docs command can use.
```

#### Output to stdout
Create markdown output and sent to stdout:
```bash
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  --sort-inputs-by-required terraform-docs --with-aggregate-type-defaults md .
```

#### Store in file
Create README.md with `terraform-docs` output:
```bash
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs --sort-inputs-by-required --with-aggregate-type-defaults md . > README.md
```

#### Replace in README.md
Replace current `terraform-docs` blocks in README.md with current one in order to automatically
keep it up to date. For this to work, the `terraform-docs` information must be wrapped with the
following delimiter by default:

`README.md:`
```markdown
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs
...
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
```

```bash
# Path to README.md must be specified as last command.
# Note that the command changes from terraform-docs to terraform-docs-replace
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs-replace --sort-inputs-by-required --with-aggregate-type-defaults md README.md
```

#### Replace in INFO.md with different delimiter
You are able to use different delimiter. Let's imagine the following delimiter:

`INFO.md:`
```markdown
<!-- TFDOC_START -->
## Inputs
...
<!-- TFDOC_END -->
```

```bash
# Path to INFO.md must be specified as last command.
# Note that the command changes from terraform-docs to terraform-docs-replace
docker run --rm \
  -v $(pwd):/data \
  -e DELIM_START='TFDOC_START' \
  -e DELIM_CLOSE='TFDOC_END' \
  cytopia/terraform-docs \
  terraform-docs-replace --sort-inputs-by-required --with-aggregate-type-defaults md INFO.md
```

#### Example Makefile
You can add the following Makefile to your project for easy generation of terraform-docs output in
a Terraform module. It takes into consideration the Main module, sub-modules and examples.

```make
.PHONY: gen _gen-main _gen-examples _gen-modules

CURRENT_DIR     = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TF_EXAMPLES     = $(sort $(dir $(wildcard $(CURRENT_DIR)examples/*/)))
TF_MODULES      = $(sort $(dir $(wildcard $(CURRENT_DIR)modules/*/)))
TF_DOCS_VERSION = 0.6.0

# Adjust your delimiter here or overwrite via make arguments
DELIM_START = <!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
DELIM_CLOSE = <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

gen:
	@echo "################################################################################"
	@echo "# Terraform-docs generate"
	@echo "################################################################################"
	@$(MAKE) _gen-main
	@$(MAKE) _gen-examples
	@$(MAKE) _gen-modules

_gen-main:
	@echo "------------------------------------------------------------"
	@echo "# Main module"
	@echo "------------------------------------------------------------"
	@if docker run --rm \
		-v $(CURRENT_DIR):/data \
		-e DELIM_START='$(DELIM_START)' \
		-e DELIM_CLOSE='$(DELIM_CLOSE)' \
		cytopia/terraform-docs:${TF_DOCS_VERSION} \
		terraform-docs-replace --sort-inputs-by-required --with-aggregate-type-defaults md README.md; then \
		echo "OK"; \
	else \
		echo "Failed"; \
		exit 1; \
	fi

_gen-examples:
	@$(foreach example,\
		$(TF_EXAMPLES),\
		DOCKER_PATH="examples/$(notdir $(patsubst %/,%,$(example)))"; \
		echo "------------------------------------------------------------"; \
		echo "# $${DOCKER_PATH}"; \
		echo "------------------------------------------------------------"; \
		if docker run --rm \
			-v $(CURRENT_DIR):/data \
			-e DELIM_START='$(DELIM_START)' \
			-e DELIM_CLOSE='$(DELIM_CLOSE)' \
			cytopia/terraform-docs:${TF_DOCS_VERSION} \
			terraform-docs-replace --sort-inputs-by-required --with-aggregate-type-defaults md $${DOCKER_PATH}/README.md; then \
			echo "OK"; \
		else \
			echo "Failed"; \
			exit 1; \
		fi; \
	)

_gen-modules:
	@$(foreach module,\
		$(TF_MODULES),\
		DOCKER_PATH="modules/$(notdir $(patsubst %/,%,$(module)))"; \
		echo "------------------------------------------------------------"; \
		echo "# $${DOCKER_PATH}"; \
		echo "------------------------------------------------------------"; \
		if docker run --rm \
			-v $(CURRENT_DIR):/data \
			-e DELIM_START='$(DELIM_START)' \
			-e DELIM_CLOSE='$(DELIM_CLOSE)' \
			cytopia/terraform-docs:${TF_DOCS_VERSION} \
			terraform-docs-replace --sort-inputs-by-required --with-aggregate-type-defaults md $${DOCKER_PATH}/README.md; then \
			echo "OK"; \
		else \
			echo "Failed"; \
			exit 1; \
		fi; \
	)
```

#### Travis CI integration
With the above Makefile in place, you can easily add a Travis CI rule to ensure the terraform-docs
output is always up-to-date and will fail otherwise (due to git changes):
```yml
---
sudo: required
services:
  - docker
before_install: true
install: true
script:
  - make gen
  - git diff --quiet || { echo "Build Changes"; git diff; git status; false; }
```


## Example projects

Find below some example projects how this Docker image is used in CI to verify if the README.md has
been updated with the latest changes generated from `terraform-docs`:

* https://github.com/cytopia/terraform-aws-rds/blob/master/Makefile


## License

**[MIT License](LICENSE)**

Copyright (c) 2019 [cytopia](https://github.com/cytopia)
