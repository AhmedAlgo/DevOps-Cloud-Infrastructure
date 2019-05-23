#!/bin/bash
# assign variables
ACTION=${1}

function create_files() {
touch rds-message.txt
chmod u+x rds-message.txt
nc -vz ecotech-db1.cifgs1lsgbkk.us-east-1.rds.amazonaws.com 3306 > rds-message.txt
touch  ecoweb1-identity.json
chmod u+x ecoweb1-identity.json
curl http://169.254.169.254/latest/dynamic/instance-identity/document/ -w "\n" > ecoweb1-identity.json
}
function show_version() {
version=0.1.0
echo $version
}
function display_help() {
cat << EOF
Usage: ${0} {-c|--creat|-v|--version}
OPTIONS:
-c | --create Create the rds-message.tx and ecoweb1-identity.json
-h | --help Display the command help
-v | --version Display the version of the script
EOF
}

if [[ $# -eq 0 ]]; then
echo "Usage ${0} {-c|--creat|-h|--help|-v|--version}"
exit 0
fi

case "$1" in
-h|--help) display_help ;;
-c|--create) create_files ;;
-v|--version) show_version ;;

*) echo "Bad inputs"
esac

