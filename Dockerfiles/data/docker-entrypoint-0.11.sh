#!/bin/sh

set -e
set -u


###
### Default variables
###
DEF_DELIM_START='<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->'
DEF_DELIM_CLOSE='<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->'


###
### Environment variables
###

# Set delimiter
if ! env | grep -q '^DELIM_START='; then
	DELIM_START="${DEF_DELIM_START}"
fi
if ! env | grep -q '^DELIM_CLOSE='; then
	DELIM_CLOSE="${DEF_DELIM_CLOSE}"
fi


###
### Helper functions
###

# Returns all but the last argument as an array using a POSIX-compliant method
# for handling arrays.
# Credit: https://gist.github.com/akutz/7a39159bbbe9c299c79f1d2107ef1357
trim_last_arg() {
  _l="${#}" _i=0 _j="$((_l-1))" && while [ "${_i}" -lt "${_l}" ]; do
    if [ "${_i}" -lt "${_j}" ]; then
      printf '%s\n' "${1}" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/"
    fi
    shift; _i="$((_i+1))"
  done
  echo " "
}


print_usage() {
	>&2 echo "Error, Unsupported command."
	>&2 echo "Usage: cytopia/terraform-docs terraform-docs <ARGS> ."
	>&2 echo "       cytopia/terraform-docs terraform-docs-012 <ARGS> ."
	>&2 echo
	>&2 echo "       cytopia/terraform-docs terraform-docs-replace <ARGS> <PATH-TO-FILE>"
	>&2 echo "       cytopia/terraform-docs terraform-docs-replace-012 <ARGS> <PATH-TO-FILE>"
	>&2 echo
	>&2 echo
	>&2 echo "terraform-docs              Output as expected from terraform-docs"
	>&2 echo "terraform-docs-012          Same as above, but used for Terraform >= 0.12 modules"
	>&2 echo
	>&2 echo "terraform-docs-replace      Replaces directly inside README.md, if DELIM_START and DELIM_CLOSE are found."
	>&2 echo "terraform-docs-replace-012  Same as above, but used for Terraform >= 0.12 modules"
	>&2 echo
	>&2 echo "<ARGS>                      All arguments terraform-docs command can use."
	>&2 echo "<PATH-TO-FILE>              File in where to auto-replace terraform-docs block."
}


###
### Arguments appended?
###
if [ "${#}" -ge "1" ]; then

	###
	### Custom replace operation
	###
	if [ "${1}" = "terraform-docs-replace" ] || [ "${1}" = "terraform-docs-replace-012" ]; then

		# Store and Remove last argument (filename)
		eval MY_FILE="\${$#}"			# store last argument
		args="$(trim_last_arg "${@}")"	# get all the args except the last arg
		eval "set -- ${args}"			# update the shell's arguments with the new value


		# Check if file exists
		if [ ! -f "${MY_FILE}" ]; then
			>&2 echo "Error, File not found in: ${MY_FILE}"
			exit 1
		fi
		# Check if starting delimiter exists in file
		if ! grep -Fq "${DELIM_START}" "${MY_FILE}"; then
			>&2 echo "Error, Starting delimiter not found ${MY_FILE}: '${DELIM_START}'"
			exit 1
		fi
		# Check if closint delimiter exists in file
		if ! grep -Fq "${DELIM_CLOSE}" "${MY_FILE}"; then
			>&2 echo "Error, Closing delimiter not found ${MY_FILE}: '${DELIM_CLOSE}'"
			exit 1
		fi

		# Get owner and permissions of current file
		UID="$(stat -c %u "${MY_FILE}")"
		GID="$(stat -c %g "${MY_FILE}")"
		PERM="$(stat -c %a "${MY_FILE}")"

		# Terraform < 0.12
		if [ "${1}" = "terraform-docs-replace" ]; then
			# Remove first argument "replace"
			shift;
			# Get terraform-docs output
			>&2 echo "terraform-docs ${*} $(dirname "${MY_FILE}")"
			DOCS="$(terraform-docs "${@}" "$(dirname "${MY_FILE}")")"
		# Terraform >= 0.12
		else
			# Remove first argument "replace"
			shift;
			mkdir -p /tmp-012
			awk -f /terraform-docs.awk -- "$(dirname "${MY_FILE}")/"*.tf > "/tmp-012/tmp.tf"
			# Get terraform-docs output
			>&2 echo "terraform-docs-012 ${*} $(dirname "${MY_FILE}")"
			if ! DOCS="$(terraform-docs "${@}" "/tmp-012")"; then
				cat -n "/tmp-012/tmp.tf" >&2
				exit 1
			fi
		fi

		# Create temporary README.md
		mkdir -p /tmp
		grep -B 100000000 -F "${DELIM_START}" "${MY_FILE}" > /tmp/README.md
		printf "%s\\n\\n" "${DOCS}" >> /tmp/README.md
		grep -A 100000000 -F "${DELIM_CLOSE}" "${MY_FILE}" >> /tmp/README.md

		# Adjust permissions of temporary file
		chown "${UID}:${GID}" /tmp/README.md
		chmod "${PERM}" /tmp/README.md

		# Overwrite existing file
		mv -f /tmp/README.md "${MY_FILE}"
		exit 0

	###
	### terraform-docs command
	###
	elif [ "${1}" = "terraform-docs" ] || [ "${1}" = "terraform-docs-012" ]; then

		# Terraform < 0.12
		if [ "${1}" = "terraform-docs" ]; then
			>&2 echo "${*}"
			exec "${@}"

		# Terraform >= 0.12
		else

			# Store and Remove last argument (filename)
			eval MY_DIR="\${$#}"			# store last argument
			args="$(trim_last_arg "${@}")"	# get all the args except the last arg
			eval "set -- ${args}"			# update the shell's arguments with the new value

			mkdir -p /tmp-012
			awk -f /terraform-docs.awk -- "${MY_DIR}/"*.tf > "/tmp-012/tmp.tf"

			# Remove first argument
			shift

			# Execute
			>&2 echo "terraform-docs ${*} ${MY_DIR}"
			if ! terraform-docs "${@}" "/tmp-012/"; then
				cat -n "/tmp-012/tmp.tf" >&2
				exit 1
			fi
		fi

	###
	### Unsupported command
	###
	else
		print_usage
		exit 1

	fi

###
### No arguments appended
###
else
	exec terraform-docs --version
fi
