#!/usr/bin/env bash

# enable permission to network (roles can be reduced further to achieve minimum permission)

user=${USER:-xxx@xxxxxx}
project=${PROJECT:-project-xxxxxxx}

gcloud projects add-iam-policy-binding --member=user:${user} --role=roles/compute.admin ${project}
gcloud projects add-iam-policy-binding --member=user:${user} --role=roles/storage.admin ${project}
gcloud projects add-iam-policy-binding --member=user:${user} --role=roles/compute.orgSecurityResourceAdmin ${project}