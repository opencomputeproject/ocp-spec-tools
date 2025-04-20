# OCP Specification Tools

This repo contains tooling for rendering OCP specifications from Markdown.

## TCG Pandoc

The scripts in this repository rely on TCG's [Pandoc](https://github.com/TrustedComputingGroup/pandoc) tooling. See the [guide](https://github.com/TrustedComputingGroup/pandoc/blob/main/guide.tcg) there for more information on Markdown.

### Running locally

See the [How to Run Locally](https://github.com/TrustedComputingGroup/pandoc/blob/main/README.md#how-to-run-locally) section on running the Docker container locally. Note that instead of directly invoking `./docker_run`, this repo provides a wrapper script for producing OCP-style specifications.

```sh
./ocp-pandoc-wrapper.sh path/to/docker_run --pdf spec.pdf spec.ocp
```
