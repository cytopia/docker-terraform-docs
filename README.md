# Docker image for `terraform-docs`

[![Build Status](https://travis-ci.com/cytopia/docker-terraform-docs.svg?branch=master)](https://travis-ci.com/cytopia/docker-terraform-docs)
[![Tag](https://img.shields.io/github/tag/cytopia/docker-terraform-docs.svg)](https://github.com/cytopia/docker-terraform-docs/releases)
[![](https://images.microbadger.com/badges/version/cytopia/terraform-docs:latest.svg)](https://microbadger.com/images/cytopia/terraform-docs:latest "terraform-docs")
[![](https://images.microbadger.com/badges/image/cytopia/terraform-docs:latest.svg)](https://microbadger.com/images/cytopia/terraform-docs:latest "terraform-docs")
[![](https://img.shields.io/badge/github-cytopia%2Fdocker--terraform--docs-red.svg)](https://github.com/cytopia/docker-terraform-docs "github.com/cytopia/docker-terraform-docs")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)


[![Docker hub](http://dockeri.co/image/cytopia/terraform-docs)](https://hub.docker.com/r/cytopia/terraform-docs)


Dockerized version of [terraform-docs](https://github.com/segmentio/terraform-docs)<sup>[1]</sup>,
which additionally implements `terraform-docs-replace` allowing you to automatically and safely
replace the `terraform-docs` generated output infile.

<sub>[1] Official project: https://github.com/segmentio/terraform-docs</sub>


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

The working directory inside the Docker container is `/docs/` and should be mounted locally to
where your Terraform module is located.


## Usage

#### Output to stdout
Create markdown output and sent to stdout:
```bash
docker run --rm \
  -v $(pwd):/docs \
  cytopia/terraform-docs \
  --sort-inputs-by-required terraform-docs --with-aggregate-type-defaults md .
```

#### Store in file
Create README.md with `terraform-docs` output:
```bash
docker run --rm \
  -v $(pwd):/docs \
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
  -v $(pwd):/docs \
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
  -v $(pwd):/docs \
  -e DELIM_START=TFDOC_START \
  -e DELIM_CLOSE=TFDOC_END \
  cytopia/terraform-docs \
  terraform-docs-replace --sort-inputs-by-required --with-aggregate-type-defaults md INFO.md
```


## Example projects

Find below some example projects how this Docker image is used in CI to verify if the README.md has
been updated with the latest changes generated from `terraform-docs`:

* https://github.com/cytopia/terraform-aws-rds/blob/master/Makefile


## License

**[MIT License](LICENSE)**

Copyright (c) 2019 [cytopia](https://github.com/cytopia)
