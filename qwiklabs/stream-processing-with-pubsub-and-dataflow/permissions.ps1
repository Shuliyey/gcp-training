user=${USER:-xxx@xxxxxx}
project=${PROJECT:-project-xxxxxxx}

gcloud projects add-iam-policy-binding --member="user:${user}" --role="roles/pubsub.admin" ${project}
gcloud projects add-iam-policy-binding --member="user:${user}" --role="roles/cloudscheduler.admin" ${project}
gcloud projects add-iam-policy-binding --member="user:${user}" --role="roles/monitoring.admin" ${project}
gcloud projects add-iam-policy-binding --member="user:${user}" --role="roles/appengine.appCreator" ${project}