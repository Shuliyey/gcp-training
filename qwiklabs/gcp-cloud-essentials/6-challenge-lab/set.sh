#!/usr/bin/env bash

echo "============= before ============="
gcloud config list
gcloud config set compute/zone australia-southeast1-b
gcloud config set compute/region australia-southeast1
echo "============= after ============="
gcloud config list
