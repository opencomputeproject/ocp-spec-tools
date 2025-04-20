#!/usr/bin/env bash

OCP_CONTACT="https://www.opencompute.org/contact"
RESOURCE_DIR="$(realpath $(dirname "$0")/ocp-pandoc-resources)"

print_usage() {
	echo "Usage:"
	echo "$(basename "${0}") [docker_run path] [docker_run arguments]"
	echo
	echo "Arguments:"
    echo "  Path to docker_run from https://github.com/TrustedComputingGroup/pandoc."
	echo "  Further arguments to this script are passed as parameters to docker_run."
	echo
	echo "Options:"
	echo
	echo "Miscellaneous"
	echo "  --help: output this message"
}

# hand process options as we want all options to go to docker run command except ones we know
if [[ "${1}" == "--help" || -z "$*" ]]; then
	print_usage
	exit 0
fi

docker_run_path="$1"
shift

$docker_run_path \
    --extra_resource_dir "${RESOURCE_DIR}" \
    --template extra/ocp-pandoc-resources/ocp.tex \
    --metadata_contact "${OCP_CONTACT}" \
    --metadata_logo extra/ocp-pandoc-resources/img/ocp_logo.png \
    --crossref=tcg \
    --nogitversion \
    "$@"