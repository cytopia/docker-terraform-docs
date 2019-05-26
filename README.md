# Docker image for `terraform-docs`

[![Build Status](https://travis-ci.com/cytopia/docker-terraform-docs.svg?branch=master)](https://travis-ci.com/cytopia/docker-terraform-docs)
[![Tag](https://img.shields.io/github/tag/cytopia/docker-terraform-docs.svg)](https://github.com/cytopia/docker-terraform-docs/releases)
[![](https://images.microbadger.com/badges/version/cytopia/terraform-docs.svg)](https://microbadger.com/images/cytopia/terraform-docs "terraform-docs")
[![](https://images.microbadger.com/badges/image/cytopia/terraform-docs.svg)](https://microbadger.com/images/cytopia/terraform-docs "terraform-docs")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)


[![Docker hub](http://dockeri.co/image/cytopia/terraform-docs)](https://hub.docker.com/r/cytopia/terraform-docs)


## Official project

https://github.com/segmentio/terraform-docs


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


## Docker mounts

The working directory inside the Docker container is `/docs/` and should be mounted locally to
where your Terraform module is located.


## Usage

#### Output to stdout
Create markdown output and sent to stdout:
```bash
docker run --rm \
  -v $(pwd):/docs \
  --sort-inputs-by-required --with-aggregate-type-defaults md .
```

#### Store in file
Create README.md with `terraform-docs` output:
```bash
docker run --rm \
  -v $(pwd):/docs \
  --sort-inputs-by-required --with-aggregate-type-defaults md . > README.md
```

#### Replace in README.md
Replace current `terraform-docs` blocks in README.md with current one in order to automatically
keep it up to date. For this to work, the `terraform-docs` information must be wrapped with the
following delimiter:
```markdown
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs
...
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
```

```bash
# Save output in variable
DOCS="$(
  docker run --rm \
    -v $(pwd):/docs \
    --sort-inputs-by-required --with-aggregate-type-defaults md .
)"

# Create new README
grep -B 100000000 -F '<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' README.md > README.md.tmp
printf "${DOCS}\n\n" >> README.md.tmp
grep -A 100000000 -F '<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->' README.md >> README.md.tmp

# Overwrite old README
mv -f README.md.tmp README.md
```


## Example projects

Find below some example projects how this Docker image is used in CI to verify if the README.md has
been updated with the latest changes generated from `terraform-docs`:

* https://github.com/cytopia/terraform-aws-rds/blob/master/Makefile


## License

**[MIT License](LICENSE)**

Copyright (c) 2019 [cytopia](https://github.com/cytopia)
