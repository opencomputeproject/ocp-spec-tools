# OCP Specification Tools

This repo contains tooling for rendering OCP specifications from Markdown.

## TCG Pandoc

The scripts in this repository rely on TCG's [Pandoc](https://github.com/TrustedComputingGroup/pandoc) tooling. See the [Guide](https://github.com/TrustedComputingGroup/pandoc/blob/main/guide.tcg) (in PDF form on the TCG Pandoc [Releases](https://github.com/TrustedComputingGroup/pandoc/releases) page).

## How to Run Locally

Due to the complexity of the various Pandoc and LaTeX dependencies at work,
it's easiest to use TCG's published [Docker containers](https://github.com/trustedcomputinggroup/pandoc/pkgs/container/pandoc).

```sh
./docker-pull.sh

# Must run from the directory containing the input file
./docker-run.sh --pdf sample-spec.pdf sample-spec.ocp
```

HTML support is experimental.

```sh
./docker-run.sh --html sample-spec.html sample-spec.ocp
```

## How to Build Locally

See the TCG Pandoc [README](https://github.com/TrustedComputingGroup/pandoc/blob/main/README.md#how-to-build-locally) for how to build locally.
