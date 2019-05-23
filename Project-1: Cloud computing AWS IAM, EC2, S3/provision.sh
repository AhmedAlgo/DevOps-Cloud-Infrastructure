#!/bin/bash
# assign variables
ACTION=${1}
function remove_file() {
nginx -s stop
rm /usr/share/nginx/html/* .html
yum remove nginx -y
}
function show_version() {
version=1.0.0
echo $version
}
function display_help() {
cat << EOF
Usage: ${0} {-h|--help|-r|--remove|-v|--version}
OPTIONS:
-r | --remove Stop the Nginx service,Delete the files in the website document root directory,Uninstall the Nginx software package 
-h | --help Display the command help
-v | --version Display the version of the script
EOF
}
case "$ACTION" in
-h|--help)
display_help
;;
-r|--remove)
remove_file "${2:-server}"
;;
-v|--version)
show_version
;;

*)
sudo yum update -y
sudo yum install git -y
sudo amazon-linux-extras install nginx1.12 -y
sudo service nginx start
sudo chkconfig nginx on
sudo aws s3 cp s3://ahmed-algo-assignment-4/index.html/usr/share/nginx/html/index.html
exit 1
esac

