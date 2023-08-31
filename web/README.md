# Instructions to build and deploy the BOPTEST website

## Deploy website locally

### If you have Jekyll

If you already have a Jekyll environment installed and functional you can directly use the command `make build_docs_and_serve_web` to build the docs and test the website in your browser. 

### If you don't have Jekyll

If you don't have Jekyll you can create the Docker environment to build the website with the command `make build-env`. 
Note that this is the environment used to build and serve the actual website so you this procedure also ensures you're working with the right environment. 
After the environment is created (only needs to be created once) you can use the command `make run-build-docs-and-serve-web` to build the docs and test the website in your local browser. 

## Deploy the website with GitHub Actions

Normally, GitHub actions uses a default workflow to deploy the website from a branch with the source files living either at the `/` or the `/docs` directory of the repository.
We use a [custom workflow with GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages) to benefit from a controlled build environment and the possibility to have the website-related files in a dedicated `/web` directory. The specification of this custom workflow is located at `/.github/workflows/custom-web-build.yml` and it mostly follows the default workflow followed by GitHub Pages but with these two main modifications: 

1. Uses a predefined Docker environment to build the docs-* files and the website content sources.
2. Serves the website from the `/web` directory (instead of `/docs`). 