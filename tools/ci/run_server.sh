#!/bin/bash
set -euo pipefail

tools/deploy.sh ci_test
mkdir ci_test/config
mkdir ci_test/data

#test config
cp tools/ci/ci_config.txt ci_test/config/config.txt
cp tools/ci/ci_maps.txt ci_test/config/maps.txt

cd ci_test
DreamDaemon fortune13.dmb -close -trusted -verbose -params "log-directory=ci"

cd ..

cat ci_test/data/logs/ci/clean_run.lk # this is to print a success message or return an error on fail
