#!/usr/bin/env bash

OCP_CONTACT="https://www.opencompute.org/contact"
RESOURCE_DIR_NAME=ocp-pandoc-resources

print_usage() {
  echo "Usage:"
  echo "$(basename "${0}") [options] [build.sh arguments]"
  echo
  echo "Arguments:"
  echo "  Arguments to this script are passed as parameters to build.sh inside of the Docker container"
  echo
  echo "Environment:"
  echo "  DOCKER_IMAGE: set this env variable to the docker image to run, defaults to ${docker_image}"
  echo
  echo "Miscellaneous:"
  echo "  --help: output this message"
}

if test "${1}" == "--help"; then
  print_usage
  exit 0
fi

resource_dir="$(realpath $(dirname "$0")/${RESOURCE_DIR_NAME})"

docker_image=${DOCKER_IMAGE:-"ghcr.io/trustedcomputinggroup/pandoc:latest"}

echo "Launching container: ${docker_image}"
docker run \
  --workdir=/workspace \
  --volume=$(pwd):/workspace \
  --volume=${resource_dir}:/extra_resources/${RESOURCE_DIR_NAME} \
  "${docker_image}" \
  --crossref=tcg \
  --metadata_contact "${OCP_CONTACT}" \
  --metadata_logo extra/ocp-pandoc-resources/img/ocp_logo.png \
  --nogitversion \
  --template extra/ocp-pandoc-resources/ocp.tex \
  --csl extra/ocp-pandoc-resources/ieee.csl \
  "$@"
