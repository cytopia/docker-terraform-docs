# Docker image for `terraform-docs`

[![Tag](https://img.shields.io/github/tag/cytopia/docker-terraform-docs.svg)](https://github.com/cytopia/docker-terraform-docs/releases)
[![](https://img.shields.io/badge/github-cytopia%2Fdocker--terraform--docs-red.svg)](https://github.com/cytopia/docker-terraform-docs "github.com/cytopia/docker-terraform-docs")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

[![lint](https://github.com/cytopia/docker-terraform-docs/workflows/lint/badge.svg)](https://github.com/cytopia/docker-terraform-docs/actions?query=workflow%3Alint)
[![build](https://github.com/cytopia/docker-terraform-docs/workflows/build/badge.svg)](https://github.com/cytopia/docker-terraform-docs/actions?query=workflow%3Abuild)
[![nightly](https://github.com/cytopia/docker-terraform-docs/workflows/nightly/badge.svg)](https://github.com/cytopia/docker-terraform-docs/actions?query=workflow%3Anightly)


> #### All [#awesome-ci](https://github.com/topics/awesome-ci) Docker images
>
> [ansible-lint][alint-git-lnk] **•**
> [ansible][ansible-git-lnk] **•**
> [awesome-ci][aci-git-lnk] **•**
> [bandit][bandit-git-lnk] **•**
> [black][black-git-lnk] **•**
> [checkmake][cm-git-lnk] **•**
> [eslint][elint-git-lnk] **•**
> [file-lint][flint-git-lnk] **•**
> [gofmt][gfmt-git-lnk] **•**
> [goimports][gimp-git-lnk] **•**
> [golint][glint-git-lnk] **•**
> [jsonlint][jlint-git-lnk] **•**
> [kubeval][kubeval-git-lnk] **•**
> [linkcheck][linkcheck-git-lnk] **•**
> [mypy][mypy-git-lnk] **•**
> [php-cs-fixer][pcsf-git-lnk] **•**
> [phpcbf][pcbf-git-lnk] **•**
> [phpcs][pcs-git-lnk] **•**
> [phplint][plint-git-lnk] **•**
> [pycodestyle][pycs-git-lnk] **•**
> [pydocstyle][pyds-git-lnk] **•**
> [pylint][pylint-git-lnk] **•**
> [terraform-docs][tfdocs-git-lnk] **•**
> [terragrunt-fmt][tgfmt-git-lnk] **•**
> [terragrunt][tg-git-lnk] **•**
> [yamlfmt][yfmt-git-lnk] **•**
> [yamllint][ylint-git-lnk]

View **[Dockerfiles](https://github.com/cytopia/docker-terraform-docs/blob/master/Dockerfiles/)** on GitHub.


**Available Architectures:**  `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6`

Tiny Alpine-based multistage-build dockerized version of [terraform-docs](https://github.com/terraform-docs/terraform-docs)<sup>[1]</sup>,
which additionally implements `terraform-docs-replace` allowing you to automatically and safely
replace the `terraform-docs` generated output infile.
Furthermore this implementation is also **Terraform >= 0.12 ready**<sup>[2]</sup>. See [Generic Usage](#generic) for more details.
The image is built nightly against multiple stable versions and pushed to Dockerhub.

* <sub>[1] Official project: https://github.com/terraform-docs/terraform-docs</sub>
* <sub>[2] Based on an awk script by [cloudposse/build-harness](https://github.com/cloudposse/build-harness/blob/master/bin/terraform-docs.awk)</sub>

## :whale: Available Docker image versions

[![](https://img.shields.io/docker/pulls/cytopia/terraform-docs.svg)](https://hub.docker.com/r/cytopia/terraform-docs)
[![Docker](https://badgen.net/badge/icon/:latest?icon=docker&label=cytopia/terraform-docs)](https://hub.docker.com/r/cytopia/terraform-docs)

#### Rolling releaess

The following Docker image tags are rolling releases and are built and updated every night.

[![nightly](https://github.com/cytopia/docker-terraform-docs/workflows/nightly/badge.svg)](https://github.com/cytopia/docker-terraform-docs/actions?query=workflow%3Anightly)

| Docker Tag           | Git Ref   | Terraform Docs | Available Architectures                      |
|----------------------|-----------|--------------|----------------------------------------------|
| `latest`             | master    | latest       | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.16.0`             | master    | **`0.16.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.15.0`             | master    | **`0.15.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.14.1`             | master    | **`0.14.1`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.14.0`             | master    | **`0.14.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.13.0`             | master    | **`0.13.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.12.1`             | master    | **`0.12.1`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.12.0`             | master    | **`0.12.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.11.2`             | master    | **`0.11.2`** | `amd64`                                      |
| `0.11.1`             | master    | **`0.11.1`** | `amd64`                                      |
| `0.11.0`             | master    | **`0.11.0`** | `amd64`                                      |
| `0.10.1`             | master    | **`0.10.1`** | `amd64`                                      |
| `0.10.0`             | master    | **`0.10.0`** | `amd64`                                      |
| `0.9.1`              | master    | **`0.9.1`**  | `amd64`                                      |
| `0.9.0`              | master    | **`0.9.0`**  | `amd64`                                      |
| `0.8.2`              | master    | **`0.8.2`**  | `amd64`                                      |
| `0.8.1`              | master    | **`0.8.1`**  | `amd64`                                      |
| `0.8.0`              | master    | **`0.8.0`**  | `amd64`                                      |
| `0.7.0`              | master    | **`0.7.0`**  | `amd64`                                      |
| `0.6.0`              | master    | **`0.6.0`**  | `amd64`                                      |
| `0.5.0`              | master    | **`0.5.0`**  | `amd64`                                      |
| `0.4.5`              | master    | **`0.4.5`**  | `amd64`                                      |
| `0.4.0`              | master    | **`0.4.0`**  | `amd64`                                      |
| `0.3.0`              | master    | **`0.3.0`**  | `amd64`                                      |
| `0.2.0`              | master    | **`0.2.0`**  | `amd64`                                      |
| `0.1.1`              | master    | **`0.1.1`**  | `amd64`                                      |
| `0.1.0`              | master    | **`0.1.0`**  | `amd64`                                      |


#### Point in time releases

The following Docker image tags are built once and can be used for reproducible builds. Its version never changes so you will have to update tags in your pipelines from time to time in order to stay up-to-date.

[![build](https://github.com/cytopia/docker-terraform-docs/workflows/build/badge.svg)](https://github.com/cytopia/docker-terraform-docs/actions?query=workflow%3Abuild)


| Docker Tag           | Git Ref   | Terraform Docs | Available Architectures                      |
|----------------------|-----------|--------------|----------------------------------------------|
| `latest-0.32`        | tag: 0.32 | latest       | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.16.0-0.32`        | tag: 0.32 | **`0.16.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.15.0-0.32`        | tag: 0.32 | **`0.15.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.14.1-0.32`        | tag: 0.32 | **`0.14.1`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.14.0-0.32`        | tag: 0.32 | **`0.14.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.13.0-0.32`        | tag: 0.32 | **`0.13.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.12.1-0.32`        | tag: 0.32 | **`0.12.1`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.12.0-0.32`        | tag: 0.32 | **`0.12.0`** | `amd64`, `i386`, `arm64`, `arm/v7`, `arm/v6` |
| `0.11.2-0.32`        | tag: 0.32 | **`0.11.2`** | `amd64`                                      |
| `0.11.1-0.32`        | tag: 0.32 | **`0.11.1`** | `amd64`                                      |
| `0.11.0-0.32`        | tag: 0.32 | **`0.11.0`** | `amd64`                                      |
| `0.10.1-0.32`        | tag: 0.32 | **`0.10.1`** | `amd64`                                      |
| `0.10.0-0.32`        | tag: 0.32 | **`0.10.0`** | `amd64`                                      |
| `0.9.1-0.32`         | tag: 0.32 | **`0.9.1`**  | `amd64`                                      |
| `0.9.0-0.32`         | tag: 0.32 | **`0.9.0`**  | `amd64`                                      |
| `0.8.2-0.32`         | tag: 0.32 | **`0.8.2`**  | `amd64`                                      |
| `0.8.1-0.32`         | tag: 0.32 | **`0.8.1`**  | `amd64`                                      |
| `0.8.0-0.32`         | tag: 0.32 | **`0.8.0`**  | `amd64`                                      |
| `0.7.0-0.32`         | tag: 0.32 | **`0.7.0`**  | `amd64`                                      |
| `0.6.0-0.32`         | tag: 0.32 | **`0.6.0`**  | `amd64`                                      |
| `0.5.0-0.32`         | tag: 0.32 | **`0.5.0`**  | `amd64`                                      |
| `0.4.5-0.32`         | tag: 0.32 | **`0.4.5`**  | `amd64`                                      |
| `0.4.0-0.32`         | tag: 0.32 | **`0.4.0`**  | `amd64`                                      |
| `0.3.0-0.32`         | tag: 0.32 | **`0.3.0`**  | `amd64`                                      |
| `0.2.0-0.32`         | tag: 0.32 | **`0.2.0`**  | `amd64`                                      |
| `0.1.1-0.32`         | tag: 0.32 | **`0.1.1`**  | `amd64`                                      |
| `0.1.0-0.32`         | tag: 0.32 | **`0.1.0`**  | `amd64`                                      |



## :capital_abcd: Environment variables

The following Docker environment variables are available. These will only need to be used when
using `terraform-docs-replace` or `terraform-docs-replace-012`.

| Variable | Default | Required | Comment |
|----------|---------|----------|---------|
| DELIM_START | `<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->` | No | The starting delimiter in the file in where you want to replace the `terraform-docs` output. |
| DELIM_CLOSE | `<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->` | No | The ending delimiter in the file in where you want to replace the `terraform-docs` output. |


## :open_file_folder: Docker mounts

The working directory inside the Docker container is **`/data/`** and should be mounted locally to
where your Terraform module is located.


## :computer: Usage

### Generic
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
<PATH-TO-FILE>              File in where to auto-replace terraform-docs block.
```

### Output to stdout
Create markdown output and sent to stdout:
```bash
# [Terraform < 0.12]
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs --sort-by-required md .

# [Terraform >= 0.12]
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs-012 --sort-by-required md .
```

### Store in file
Create README.md with `terraform-docs` output:
```bash
# [Terraform < 0.12]
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs --sort-by-required md . > README.md

# [Terraform >= 0.12]
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs-012 --sort-by-required md . > README.md
```

### Replace in README.md
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
# [Terraform < 0.12]
# Path to README.md must be specified as last command.
# Note that the command changes from terraform-docs to terraform-docs-replace
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs-replace --sort-by-required md README.md

# [Terraform >= 0.12]
# Path to README.md must be specified as last command.
# Note that the command changes from terraform-docs to terraform-docs-replace
docker run --rm \
  -v $(pwd):/data \
  cytopia/terraform-docs \
  terraform-docs-replace-012 --sort-by-required md README.md
```

### Replace in INFO.md with different delimiter
You are able to use different delimiter. Let's imagine the following delimiter:

`INFO.md:`
```markdown
<!-- TFDOC_START -->
## Inputs
...
<!-- TFDOC_END -->
```

```bash
# [Terraform < 0.12]
# Path to INFO.md must be specified as last command.
# Note that the command changes from terraform-docs to terraform-docs-replace
docker run --rm \
  -v $(pwd):/data \
  -e DELIM_START='<!-- TFDOC_START -->' \
  -e DELIM_CLOSE='<!-- TFDOC_END -->' \
  cytopia/terraform-docs \
  terraform-docs-replace --sort-by-required md INFO.md

# [Terraform >= 0.12]
# Path to INFO.md must be specified as last command.
# Note that the command changes from terraform-docs to terraform-docs-replace
docker run --rm \
  -v $(pwd):/data \
  -e DELIM_START='<!-- TFDOC_START -->' \
  -e DELIM_CLOSE='<!-- TFDOC_END -->' \
  cytopia/terraform-docs \
  terraform-docs-replace-012 --sort-by-required md INFO.md
```

### Example Makefile
You can add the following Makefile to your project for easy generation of terraform-docs output in
a Terraform module. It takes into consideration the Main module, sub-modules and examples.

```make
ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: gen _gen-main _gen-examples _gen-modules _update-tf-docs

CURRENT_DIR     = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TF_EXAMPLES     = $(sort $(dir $(wildcard $(CURRENT_DIR)examples/*/)))
TF_MODULES      = $(sort $(dir $(wildcard $(CURRENT_DIR)modules/*/)))
TF_DOCS_VERSION = 0.6.0

# Adjust your delimiter here or overwrite via make arguments
DELIM_START = <!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
DELIM_CLOSE = <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

gen: _update-tf-docs
	@echo "################################################################################"
	@echo "# Terraform-docs generate"
	@echo "################################################################################"
	@$(MAKE) --no-print-directory _gen-main
	@$(MAKE) --no-print-directory _gen-examples
	@$(MAKE) --no-print-directory _gen-modules

_gen-main:
	@echo "------------------------------------------------------------"
	@echo "# Main module"
	@echo "------------------------------------------------------------"
	@if docker run --rm \
		-v $(CURRENT_DIR):/data \
		-e DELIM_START='$(DELIM_START)' \
		-e DELIM_CLOSE='$(DELIM_CLOSE)' \
		cytopia/terraform-docs:$(TF_DOCS_VERSION) \
		terraform-docs-replace --sort-by-required md README.md; then \
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
			cytopia/terraform-docs:$(TF_DOCS_VERSION) \
			terraform-docs-replace --sort-by-required md $${DOCKER_PATH}/README.md; then \
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
			cytopia/terraform-docs:$(TF_DOCS_VERSION) \
			terraform-docs-replace --sort-by-required md $${DOCKER_PATH}/README.md; then \
			echo "OK"; \
		else \
			echo "Failed"; \
			exit 1; \
		fi; \
	)

_update-tf-docs:
	docker pull cytopia/terraform-docs:$(TF_DOCS_VERSION)
```

### Travis CI integration
With the above Makefile in place, you can easily add a Travis CI rule to ensure the terraform-docs
output is always up-to-date and will fail otherwise (due to git changes):
```yml
---
sudo: required
language: minimal
services:
  - docker
script:
  - make gen
  - git diff --quiet || { echo "Build Changes"; git diff; git status; false; }
```


## :information_source: Example projects

Find below some example projects how this Docker image is used in CI to verify if the README.md has
been updated with the latest changes generated from `terraform-docs`:

* https://github.com/cytopia/terraform-aws-rds/blob/master/Makefile
* https://github.com/Flaconi/terraform-aws-microservice/blob/master/Makefile


## Related [#awesome-ci](https://github.com/topics/awesome-ci) projects

### Docker images

Save yourself from installing lot's of dependencies and pick a dockerized version of your favourite
linter below for reproducible local or remote CI tests:

| GitHub | DockerHub | Type | Description |
|--------|-----------|------|-------------|
| [awesome-ci][aci-git-lnk]        | [![aci-hub-img]][aci-hub-lnk]         | Basic      | Tools for git, file and static source code analysis |
| [file-lint][flint-git-lnk]       | [![flint-hub-img]][flint-hub-lnk]     | Basic      | Baisc source code analysis |
| [linkcheck][linkcheck-git-lnk]   | [![linkcheck-hub-img]][flint-hub-lnk] | Basic      | Search for URLs in files and validate their HTTP status code |
| [ansible][ansible-git-lnk]       | [![ansible-hub-img]][ansible-hub-lnk] | Ansible    | Multiple versions and flavours of Ansible |
| [ansible-lint][alint-git-lnk]    | [![alint-hub-img]][alint-hub-lnk]     | Ansible    | Lint Ansible |
| [gofmt][gfmt-git-lnk]            | [![gfmt-hub-img]][gfmt-hub-lnk]       | Go         | Format Go source code **<sup>[1]</sup>** |
| [goimports][gimp-git-lnk]        | [![gimp-hub-img]][gimp-hub-lnk]       | Go         | Format Go source code **<sup>[1]</sup>** |
| [golint][glint-git-lnk]          | [![glint-hub-img]][glint-hub-lnk]     | Go         | Lint Go code |
| [eslint][elint-git-lnk]          | [![elint-hub-img]][elint-hub-lnk]     | Javascript | Lint Javascript code |
| [jsonlint][jlint-git-lnk]        | [![jlint-hub-img]][jlint-hub-lnk]     | JSON       | Lint JSON files **<sup>[1]</sup>** |
| [kubeval][kubeval-git-lnk]       | [![kubeval-hub-img]][kubeval-hub-lnk] | K8s        | Lint Kubernetes files |
| [checkmake][cm-git-lnk]          | [![cm-hub-img]][cm-hub-lnk]           | Make       | Lint Makefiles |
| [phpcbf][pcbf-git-lnk]           | [![pcbf-hub-img]][pcbf-hub-lnk]       | PHP        | PHP Code Beautifier and Fixer |
| [phpcs][pcs-git-lnk]             | [![pcs-hub-img]][pcs-hub-lnk]         | PHP        | PHP Code Sniffer |
| [phplint][plint-git-lnk]         | [![plint-hub-img]][plint-hub-lnk]     | PHP        | PHP Code Linter **<sup>[1]</sup>** |
| [php-cs-fixer][pcsf-git-lnk]     | [![pcsf-hub-img]][pcsf-hub-lnk]       | PHP        | PHP Coding Standards Fixer |
| [bandit][bandit-git-lnk]         | [![bandit-hub-img]][bandit-hub-lnk]   | Python     | A security linter from PyCQA
| [black][black-git-lnk]           | [![black-hub-img]][black-hub-lnk]     | Python     | The uncompromising Python code formatter |
| [mypy][mypy-git-lnk]             | [![mypy-hub-img]][mypy-hub-lnk]       | Python     | Static source code analysis |
| [pycodestyle][pycs-git-lnk]      | [![pycs-hub-img]][pycs-hub-lnk]       | Python     | Python style guide checker |
| [pydocstyle][pyds-git-lnk]       | [![pyds-hub-img]][pyds-hub-lnk]       | Python     | Python docstyle checker |
| [pylint][pylint-git-lnk]         | [![pylint-hub-img]][pylint-hub-lnk]   | Python     | Python source code, bug and quality checker |
| [terraform-docs][tfdocs-git-lnk] | [![tfdocs-hub-img]][tfdocs-hub-lnk]   | Terraform  | Terraform doc generator (TF 0.12 ready) **<sup>[1]</sup>** |
| [terragrunt][tg-git-lnk]         | [![tg-hub-img]][tg-hub-lnk]           | Terraform  | Terragrunt and Terraform |
| [terragrunt-fmt][tgfmt-git-lnk]  | [![tgfmt-hub-img]][tgfmt-hub-lnk]     | Terraform  | `terraform fmt` for Terragrunt files **<sup>[1]</sup>** |
| [yamlfmt][yfmt-git-lnk]          | [![yfmt-hub-img]][yfmt-hub-lnk]       | Yaml       | Format Yaml files **<sup>[1]</sup>** |
| [yamllint][ylint-git-lnk]        | [![ylint-hub-img]][ylint-hub-lnk]     | Yaml       | Lint Yaml files |

> **<sup>[1]</sup>** Uses a shell wrapper to add **enhanced functionality** not available by original project.

[aci-git-lnk]: https://github.com/cytopia/awesome-ci
[aci-hub-img]: https://img.shields.io/docker/pulls/cytopia/awesome-ci.svg
[aci-hub-lnk]: https://hub.docker.com/r/cytopia/awesome-ci

[flint-git-lnk]: https://github.com/cytopia/docker-file-lint
[flint-hub-img]: https://img.shields.io/docker/pulls/cytopia/file-lint.svg
[flint-hub-lnk]: https://hub.docker.com/r/cytopia/file-lint

[linkcheck-git-lnk]: https://github.com/cytopia/docker-linkcheck
[linkcheck-hub-img]: https://img.shields.io/docker/pulls/cytopia/linkcheck.svg
[linkcheck-hub-lnk]: https://hub.docker.com/r/cytopia/linkcheck

[jlint-git-lnk]: https://github.com/cytopia/docker-jsonlint
[jlint-hub-img]: https://img.shields.io/docker/pulls/cytopia/jsonlint.svg
[jlint-hub-lnk]: https://hub.docker.com/r/cytopia/jsonlint

[ansible-git-lnk]: https://github.com/cytopia/docker-ansible
[ansible-hub-img]: https://img.shields.io/docker/pulls/cytopia/ansible.svg
[ansible-hub-lnk]: https://hub.docker.com/r/cytopia/ansible

[alint-git-lnk]: https://github.com/cytopia/docker-ansible-lint
[alint-hub-img]: https://img.shields.io/docker/pulls/cytopia/ansible-lint.svg
[alint-hub-lnk]: https://hub.docker.com/r/cytopia/ansible-lint

[kubeval-git-lnk]: https://github.com/cytopia/docker-kubeval
[kubeval-hub-img]: https://img.shields.io/docker/pulls/cytopia/kubeval.svg
[kubeval-hub-lnk]: https://hub.docker.com/r/cytopia/kubeval

[gfmt-git-lnk]: https://github.com/cytopia/docker-gofmt
[gfmt-hub-img]: https://img.shields.io/docker/pulls/cytopia/gofmt.svg
[gfmt-hub-lnk]: https://hub.docker.com/r/cytopia/gofmt

[gimp-git-lnk]: https://github.com/cytopia/docker-goimports
[gimp-hub-img]: https://img.shields.io/docker/pulls/cytopia/goimports.svg
[gimp-hub-lnk]: https://hub.docker.com/r/cytopia/goimports

[glint-git-lnk]: https://github.com/cytopia/docker-golint
[glint-hub-img]: https://img.shields.io/docker/pulls/cytopia/golint.svg
[glint-hub-lnk]: https://hub.docker.com/r/cytopia/golint

[elint-git-lnk]: https://github.com/cytopia/docker-eslint
[elint-hub-img]: https://img.shields.io/docker/pulls/cytopia/eslint.svg
[elint-hub-lnk]: https://hub.docker.com/r/cytopia/eslint

[cm-git-lnk]: https://github.com/cytopia/docker-checkmake
[cm-hub-img]: https://img.shields.io/docker/pulls/cytopia/checkmake.svg
[cm-hub-lnk]: https://hub.docker.com/r/cytopia/checkmake

[pcbf-git-lnk]: https://github.com/cytopia/docker-phpcbf
[pcbf-hub-img]: https://img.shields.io/docker/pulls/cytopia/phpcbf.svg
[pcbf-hub-lnk]: https://hub.docker.com/r/cytopia/phpcbf

[pcs-git-lnk]: https://github.com/cytopia/docker-phpcs
[pcs-hub-img]: https://img.shields.io/docker/pulls/cytopia/phpcs.svg
[pcs-hub-lnk]: https://hub.docker.com/r/cytopia/phpcs

[plint-git-lnk]: https://github.com/cytopia/docker-phplint
[plint-hub-img]: https://img.shields.io/docker/pulls/cytopia/phplint.svg
[plint-hub-lnk]: https://hub.docker.com/r/cytopia/phplint

[pcsf-git-lnk]: https://github.com/cytopia/docker-php-cs-fixer
[pcsf-hub-img]: https://img.shields.io/docker/pulls/cytopia/php-cs-fixer.svg
[pcsf-hub-lnk]: https://hub.docker.com/r/cytopia/php-cs-fixer

[bandit-git-lnk]: https://github.com/cytopia/docker-bandit
[bandit-hub-img]: https://img.shields.io/docker/pulls/cytopia/bandit.svg
[bandit-hub-lnk]: https://hub.docker.com/r/cytopia/bandit

[black-git-lnk]: https://github.com/cytopia/docker-black
[black-hub-img]: https://img.shields.io/docker/pulls/cytopia/black.svg
[black-hub-lnk]: https://hub.docker.com/r/cytopia/black

[mypy-git-lnk]: https://github.com/cytopia/docker-mypy
[mypy-hub-img]: https://img.shields.io/docker/pulls/cytopia/mypy.svg
[mypy-hub-lnk]: https://hub.docker.com/r/cytopia/mypy

[pycs-git-lnk]: https://github.com/cytopia/docker-pycodestyle
[pycs-hub-img]: https://img.shields.io/docker/pulls/cytopia/pycodestyle.svg
[pycs-hub-lnk]: https://hub.docker.com/r/cytopia/pycodestyle

[pyds-git-lnk]: https://github.com/cytopia/docker-pydocstyle
[pyds-hub-img]: https://img.shields.io/docker/pulls/cytopia/pydocstyle.svg
[pyds-hub-lnk]: https://hub.docker.com/r/cytopia/pydocstyle

[pylint-git-lnk]: https://github.com/cytopia/docker-pylint
[pylint-hub-img]: https://img.shields.io/docker/pulls/cytopia/pylint.svg
[pylint-hub-lnk]: https://hub.docker.com/r/cytopia/pylint

[tfdocs-git-lnk]: https://github.com/cytopia/docker-terraform-docs
[tfdocs-hub-img]: https://img.shields.io/docker/pulls/cytopia/terraform-docs.svg
[tfdocs-hub-lnk]: https://hub.docker.com/r/cytopia/terraform-docs

[tg-git-lnk]: https://github.com/cytopia/docker-terragrunt
[tg-hub-img]: https://img.shields.io/docker/pulls/cytopia/terragrunt.svg
[tg-hub-lnk]: https://hub.docker.com/r/cytopia/terragrunt

[tgfmt-git-lnk]: https://github.com/cytopia/docker-terragrunt-fmt
[tgfmt-hub-img]: https://img.shields.io/docker/pulls/cytopia/terragrunt-fmt.svg
[tgfmt-hub-lnk]: https://hub.docker.com/r/cytopia/terragrunt-fmt

[yfmt-git-lnk]: https://github.com/cytopia/docker-yamlfmt
[yfmt-hub-img]: https://img.shields.io/docker/pulls/cytopia/yamlfmt.svg
[yfmt-hub-lnk]: https://hub.docker.com/r/cytopia/yamlfmt

[ylint-git-lnk]: https://github.com/cytopia/docker-yamllint
[ylint-hub-img]: https://img.shields.io/docker/pulls/cytopia/yamllint.svg
[ylint-hub-lnk]: https://hub.docker.com/r/cytopia/yamllint


### Makefiles

Visit **[cytopia/makefiles](https://github.com/cytopia/makefiles)** for dependency-less, seamless project integration and minimum required best-practice code linting for CI.
The provided Makefiles will only require GNU Make and Docker itself removing the need to install anything else.


## :page_facing_up: License


**[MIT License](LICENSE)**

Copyright (c) 2019 [cytopia](https://github.com/cytopia)
