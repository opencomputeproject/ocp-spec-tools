# Github Pages integration guide

This repo provides tooling to enable Github to automatically render specifications and publish them to Github Pages.

To enable this, add a file to `.github/workflows/deploy_pages.yml` with the following contents. Explanatory comments can be elided.

The JSON portion within the following contents must be customized based on which specifications are to be rendered.

```
name: Deploy specifications to GitHub pages

on:
  push:
    branches: ["main"]  # Runs any time a new change is pushed to the main branch.
permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

defaults:
  run:
    shell: bash
jobs:
  # Name of this particular job. Referenced below with "needs: [spec-render]"
  spec-render:
    # "@stable" refers to the 'stable' tag at https://github.com/opencomputeproject/ocp-spec-tools/tags.
    # This tag will be updated as new features are added. This string could also be a git commit hash to
    # pin to a particular version, but if there are bug fixes the hash would need to be updated.
    uses: opencomputeproject/ocp-spec-tools/.github/workflows/render.yml@stable
    with:
      # Release versions listed at https://github.com/trustedComputingGroup/pandoc/releases
      tcg-container-version: 0.18.14
      # The previous "stable" in `render.yml@stable` refers to the version of the "render.yml" file,
      # whereas this refers to the version of the template files at
      # https://github.com/opencomputeproject/ocp-spec-tools/tree/main/ocp-pandoc-resources that are
      # used to render the specifications.
      ocp-template-ref: stable

      # Spec configuration blob.
      #
      # As it is encoded in JSON, mind the lack of commas after the last field of each
      # entry and after the last entry in the list.
      #
      # Each entry has the following fields:
      #
      #  - src: path to the spec.ocp file, relative to the root of the repository.
      #  - [optional] append_git_rev_to_version: whether to insert the git commit hash
      #                                          into the version string when rendering.
      #  - [optional] gh_pages_html: path to where the HTML file should be rendered.
      #  - [optional] gh_pages_pdf: path to where the PDF file should be rendered.
      inputs: >-
        [                                                                        <-- 
          {
            "src": "specifications/spec-name/spec.ocp",
            "append_git_rev_to_version": true,
            "gh_pages_html": "spec-name/HEAD",
            "gh_pages_pdf": "spec-name/HEAD/pdf"
          },
          {
            "src": "specifications/spec-name-2/spec.ocp",
            "append_git_rev_to_version": true,
            "gh_pages_html": "spec-name-2/HEAD"
          }
        ]
      artifact-name: rendered-specs  # Referenced below with "name: rendered-specs"
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: [spec-render]
    steps:
      - name: Download artifacts
        uses: actions/download-artifact@v4
        with:
          name: rendered-specs
          path: gh-pages        # Writes rendered specs to the gh-pages path, where
                                # they'll be published on the web.
      - name: Upload static files as artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: "gh-pages"
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

See [render-sample-spec.yml](.github/workflows/render-sample-spec.yml) for an example usage, which publishes [sample-spec/spec.ocp](sample-spec/spec.ocp) to the following URLs:

- HTML: [https://opencomputeproject.github.io/ocp-spec-tools/sample-spec/HEAD](https://opencomputeproject.github.io/ocp-spec-tools/sample-spec/HEAD)
- PDF: [https://opencomputeproject.github.io/ocp-spec-tools/sample-spec/HEAD/pdf](https://opencomputeproject.github.io/ocp-spec-tools/sample-spec/HEAD/pdf)

For an additional example, see https://github.com/opencomputeproject/Security/blob/main/.github/workflows/deploy_pages.yml