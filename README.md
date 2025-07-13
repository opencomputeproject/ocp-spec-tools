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

## Tips and tricks

### Diagrams

Specification diagrams may be generated using draw.io. These can be edited with the [Draw.io Integration](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio) Visual Studio Code extension.

When creating new diagrams, be sure to enable a white background. Otherwise, the diagram will not be legible to viewers with dark mode enabled.

<p align="center">
  <img src="./images/drawio_background.png" alt="draw.io background color" width="200px" style="box-shadow: 0px 2px 5px gray;" />
</p>

### Tables

This tooling supports multiple table syntaxes. See [here](https://pandoc.org/demo/example33/8.9-tables.html) for more details on each supported syntax.

Grid tables offer the most fine-grained control of column widths. With this syntax, a table's column widths in the rendered PDF is proportional to the column widths in the source file.

It is recommended to use a plugin to aid in formatting grid tables. The [Table Formatter](https://marketplace.visualstudio.com/items?itemName=shuworks.vscode-table-formatter) extension is suitable.

Note: do not use the extension's "Table: Format All" command, as the extension misinterprets the YAML frontmatter as a table, and attempts to format it.

Note: ensure that the extension settings match what appear here:

<p align="center">
  <img src="./images/table_formatter_settings.png" alt="Table formatter settings" width="500px" style="box-shadow: 0px 2px 5px gray;" />
</p>

Note: while grid tables support rowspan or colspan cells, this extension cannot format them. One workaround is to format the table with all edges present, and then as a last step, remove the edges needed to produce the desired rowspan or colspan cells.
