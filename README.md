# OCP Specification Tools

This repo contains tooling for rendering OCP specifications from Markdown.

## TCG Pandoc

The scripts in this repository rely on TCG's [Pandoc](https://github.com/TrustedComputingGroup/pandoc) tooling. See the [Guide](https://github.com/TrustedComputingGroup/pandoc/blob/main/guide.tcg) (in PDF form on the TCG Pandoc [Releases](https://github.com/TrustedComputingGroup/pandoc/releases) page).

## How to install on a Windows platform

On Windows platform, this tooling can be run on using the Windows Linux Subsystem (WLS) and Docker Desktop.  The installation flow is described in [INSTALL_WINDOWS.md](INSTALL_WINDOWS.md).

## How to integrate with Github Pages

This repo provides a [reusable Github workflow](.github/workflows/render.yml) for rendering specifications to PDF or HTML and publishing them to Github Pages. See [GITHUB_PAGES.md](GITHUB_PAGES.md) for details.

## How to run locally

```sh
# One-time setup
git clone git@github.com:opencomputeproject/ocp-spec-tools.git && ocp-spec-tools/docker-pull.sh
echo alias ocp_render=\"$(realpath ocp-spec-tools/docker-run.sh)\" >> ~/.bashrc && source ~/.bashrc

# Demonstrating use with the sample specification.
# Must run from the directory containing the input file.
cd ocp-spec-tools/sample-spec
ocp_render --pdf spec.pdf spec.ocp

# HTML is also supported.
ocp_render --html spec.html spec.ocp
```

## How to build the tooling locally

If you would like to make changes to the rendering tooling and test them locally, see the TCG Pandoc [README](https://github.com/TrustedComputingGroup/pandoc/blob/main/README.md#how-to-build-locally) for how to build the tooling on your local machine.

## Tips and tricks

### Diagrams

Specification diagrams may be generated using draw.io. These can be edited with the [Draw.io Integration](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio) Visual Studio Code extension.

When creating new diagrams, be sure to enable a white background. Otherwise, the diagram will not be legible to viewers with dark mode enabled.

<p align="center">
  <img src="./images/drawio_background.png" alt="draw.io background color" width="200px" style="box-shadow: 0px 2px 5px gray;" />
</p>

### Tables

This tooling supports multiple table syntaxes. See [here](https://pandoc.org/demo/example33/8.9-tables.html) for more details on each supported syntax.

Text may overflow table cells when rendered to PDF. There are several techniques for addressing this:

- Shrink the page margin
- Reduce the table font size
- Manually adjust column widths

The page margin can be adjusted by adding `geometry: "left=0.5in,right=0.5in"` to the YAML front-matter.

Table font size can be adjusted like so:

```
Table: some table {#tbl:some-table .small}  <-- or `.tiny` for even smaller font size

+-------+-------+
| Col 1 | Col 2 |
+=======+=======+
| Some  | text  |
+-------+-------+
```

Table column widths can be adjusted like so:

```
The column widths are based on the relative widths of the separator row after the column headers.

| Col 1 | Col 2 | Col 3 | Col 4 |
|----|---|-------|----|                     <-- The widths of the separators on this line determine column widths.
| Some | text | of | varying length |
| 123 | 123 | 123 | 123 |


| Col 1 | Col 2 | Col 3 | Col 4          |
| ----- | ----- | ----- | -------------- |  <-- Auto-formatting a table will make these lengths match the column text.
| Some  | text  | of    | varying length |
| 123   | 123   | 123   | 123            |


+-------+-------+-------+---------+
| Col 1 | Col 2 | Col 3 | Col 4   |
+=======+=======+=======+=========+         <-- Grid tables let you wrap text within the cell to control the column width.
| Some  | text  | of    | varying |
|       |       |       | length  |
+-------+-------+-------+---------+
| 123   | 123   | 123   | 123     |
+-------+-------+-------+---------+
```

It is recommended to use a plugin to aid in formatting grid tables. This [Table Formatter](https://marketplace.visualstudio.com/items?itemName=shuworks.vscode-table-formatter) extension is suitable. When using this extension, ensure that its settings match what appear here:

<p align="center">
  <img src="./images/table_formatter_settings.png" alt="Table formatter settings" width="600px" style="box-shadow: 0px 2px 5px gray;" />
</p>

Note: do not use the extension's "Table: Format All" command, as the extension misinterprets the YAML frontmatter as a table, and attempts to format it.

Note: while grid tables support rowspan or colspan cells, this extension cannot format them. One workaround is to format the table with all edges present, and then as a last step, remove the edges needed to produce the desired rowspan or colspan cells.
