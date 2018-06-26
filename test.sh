#/bin/sh

set -e

main() {
  test_aws_federation
}

test_aws_federation() {
  cd aws_federation
  terraform init
  terraform validate
  terraform fmt -check -diff
  cd -
}

main
