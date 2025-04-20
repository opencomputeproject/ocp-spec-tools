# OCP Specification Tools

This repo contains tooling for rendering OCP specifications from Markdown.

## TCG Pandoc

The scripts in this repository rely on TCG's [Pandoc](https://github.com/TrustedComputingGroup/pandoc) tooling. See the [guide](https://github.com/TrustedComputingGroup/pandoc/blob/main/guide.tcg) there for more information on Markdown.

### Running locally

```sh
./ocp-pandoc-wrapper.sh tcg-pandoc/docker_run --pdf spec.pdf spec.ocp
```
