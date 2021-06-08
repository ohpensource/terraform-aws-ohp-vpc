#!/bin/sh
export AWS_DEFAULT_REGION="eu-west-1"

# tflint
if ! command -v tflint >/dev/null 2>&1;
then
    echo "tflint could not be found - installing"
    apk add --update openssl
    apk add curl
    tflint_latest_url=$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")
    wget "$tflint_latest_url" -O tflint_linux_amd64.zip
    unzip tflint_linux_amd64.zip -o
    mkdir -p /usr/local/tflint/bin
    export PATH=/usr/local/tflint/bin:$PATH
    install tflint /usr/local/tflint/bin
fi

tflint 

# validate
find . -name ".terraform" -prune -o -type f -name "*.tf" -not -path "./examples/*" -exec dirname {} \;|sort -u | while read -r m; do (cd "$m" && terraform validate) || exit 1 ; done
