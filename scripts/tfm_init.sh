#!/bin/bash

set -o pipefail

WKDIR=$PWD

run_scripts(){
  if ! terraform init -input=false -backend=false; then exit $?; fi
  
  # Terraform format 
  # terraform fmt -write=false -list=true -recursive -check

  # Validate and tflint
  # source "$WKDIR"/scripts/tfm_validate.sh
}

if [ -d modules ]; then
  cd ./modules || exit
  for f in *; do
    if [ -d "$f" ]; then
      # cycle through each module dir and initialize
      cd "$f" || exit
      echo -e "\n## Init module $f"
      run_scripts
      cd ..
    fi
  done
  cd ..
else
  run_scripts
fi   
