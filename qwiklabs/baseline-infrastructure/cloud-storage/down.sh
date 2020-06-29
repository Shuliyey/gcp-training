#/usr/bin/env bash

dir_name=$(cd `dirname $0` && pwd)
bucket_name=$(cat ${dir_name}/bucket_name)

gsutil ls -l gs://${bucket_name}/ada.jpg
gsutil ls -l gs://${bucket_name}/image-folder/ada.jpg
gsutil acl ch -d AllUsers gs://${bucket_name}/ada.jpg
gsutil acl ch -d AllUsers gs://${bucket_name}/image-folder/ada.jpg
gsutil rm gs://${bucket_name}/ada.jpg
gsutil rm gs://${bucket_name}/image-folder/ada.jpg
