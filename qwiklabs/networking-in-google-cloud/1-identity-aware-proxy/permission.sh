#!/usr/bin/env bash

# enable permission to access appengine (roles can be reduced further to achieve minimum permission)

user=${USER:-xxx@xxxxxx}
project=${PROJECT:-project-xxxxxxx}

gcloud projects add-iam-policy-binding --member=user:${user} --role=roles/appengine.appAdmin ${project}
gcloud projects add-iam-policy-binding --member=user:${user} --role=roles/storage.admin ${project}
gcloud projects add-iam-policy-binding --member=user:${user} --role=roles/iam.serviceAccountUser ${project}
gcloud projects add-iam-policy-binding --member=user:${user} --role=roles/cloudbuild.builds.editor${project}