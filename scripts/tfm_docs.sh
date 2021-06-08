#!/bin/bash

# Install Terraform-docs if not installed
TFM_DOCS_VER="0.13.0"
MOD_DIR="modules"

if ! command -v terraform-docs >/dev/null 2>&1; then
  echo -e "\n ## Installing terraform-docs"
  curl -Lo ./terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v${TFM_DOCS_VER}/terraform-docs-v${TFM_DOCS_VER}-linux-amd64.tar.gz"
  tar -xzf terraform-docs.tar.gz 
  chmod +x terraform-docs 
  mv terraform-docs /usr/local/bin/terraform-docs
fi

# Create docs for each module
if [ -d "$MOD_DIR" ]; then
  for f in $(ls -d ./$MOD_DIR/*); do
      # cycle through each module dir and create docs
      echo -e "\n ## Creating terraform docs for module $f"
      terraform-docs markdown table "./$f" --sort-by required --output-file README.md 
      git add "./$f/README.md"
  done
else
  echo -e "\n ## Creating terraform docs for root module"
  terraform-docs markdown table . --sort-by required --output-file  README.md
fi  