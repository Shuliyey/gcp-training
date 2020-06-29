#!/usr/bin/env bash

dir_name=$(cd `dirname $0` && pwd)

gcloud auth list
gcloud config list project
bucket_name=zeyu-$(uuidgen | tr '[:upper:]' '[:lower:]')
echo ${bucket_name} | tee ${dir_name}/bucket_name
gsutil mb gs://${bucket_name}
gsutil list

wget --output-document ada.jpg https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg
ls -lah
gsutil cp ada.jpg ${bucket_name}
rm ada.jpg

gsutil ls gs://${bucket_name}
gsutil cp -r gs://${bucket_name}/ada.jpkg .
ls -lah
gsutil cp gs://${bucket_name}/ada.jpg gs://${bucket_name}/image-folder/
gsutil ls gs://${bucket_name}
gsutil ls -l gs://${bucket_name}/ada.jpg

gsutil acl ch -u AllUsers:R gs://${bucket_name}/ada.jpg
gsutil acl ch -u AllUsers:R gs://${bucket_name}/image-folder/ada.jpg
gsutil ls -l gs://${bucket_name}/ada.jpg
gsutil ls -l gs://${bucket_name}/image-folder/ada.jpg
