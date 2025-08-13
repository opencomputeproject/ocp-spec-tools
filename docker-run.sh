#!/usr/bin/env bash

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

docker_image=${DOCKER_IMAGE:-"ghcr.io/trustedcomputinggroup/pandoc:latest"}

echo "Launching container: ${docker_image}"
docker run \
  --workdir=/workspace \
  --volume=$(pwd):/workspace \
  --volume=$(realpath $(dirname "$0")):/ocp-spec-tools \
  "${docker_image}" \
  --crossref=tcg \
  --resourcedir /ocp-spec-tools \
  --csl /ocp-spec-tools/ocp-pandoc-resources/ieee.csl \
  --nogitversion \
  --template /ocp-spec-tools/ocp-pandoc-resources/pdf/ocp.tex \
  --template_html /ocp-spec-tools/ocp-pandoc-resources/html/ocp.html.template \
  --html_stylesheet /ocp-spec-tools/ocp-pandoc-resources/html/style.css \
  "$@"
