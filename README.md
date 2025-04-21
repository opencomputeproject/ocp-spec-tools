# OCP Specification Tools

This repo contains tooling for rendering OCP specifications from Markdown.

## TCG Pandoc

The scripts in this repository rely on TCG's [Pandoc](https://github.com/TrustedComputingGroup/pandoc) tooling. See the [Guide](https://github.com/TrustedComputingGroup/pandoc/blob/main/guide.tcg) (in PDF form on the TCG Pandoc [Releases](https://github.com/TrustedComputingGroup/pandoc/releases) page).

## How to Run Locally

Your workflow may prefer local development and rendering. Due to the complexity of the various Pandoc
and LaTeX dependencies at work, it's easiest to use the Docker containers published at
https://github.com/trustedcomputinggroup/pandoc/pkgs/container/pandoc from this repository.

```sh
# To grab `docker_run`
git submodule update --init --recursive

docker pull ghcr.io/trustedcomputinggroup/pandoc:latest

# Must run from the directory containing the input file
cd sample

../ocp-pandoc-wrapper.sh ../tcg-pandoc/docker_run --pdf spec.pdf spec.ocp
```

## How to Build Locally

See the TCG Pandoc [README](https://github.com/TrustedComputingGroup/pandoc/blob/main/README.md#how-to-build-locally) for how to build locally.
