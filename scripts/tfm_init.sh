#!/bin/bash
chmod +x scripts/*.sh
WKDIR=$PWD

run_scripts(){
  if ! terraform init -input=false -backend=false; then exit $?; fi
  source "$WKDIR"/scripts/lint.sh
  source "$WKDIR"/scripts/validate.sh
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
          