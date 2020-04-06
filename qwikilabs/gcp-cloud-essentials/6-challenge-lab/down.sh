#!/usr/bin/env bash

# Q1
gcloud compute images list
gcloud compute instances list
gcloud compute instances delete nucleus-jumphost --zone australia-southeast1-c --quiet

# Q2
gcloud container clusters list
#kubectl delete svc/hello-app --wait
#kubectl delete deploy/hello-app --wait
gcloud container clusters delete gcelab2 --zone australia-southeast1-c --quiet

# Q3
#gcloud compute instance-templates create nginx-template --metadata-from-file startup-script=startup.sh
gcloud compute forwarding-rules list
gcloud compute forwarding-rules delete http-content-rule --global --quiet
gcloud compute target-http-proxies list
gcloud compute target-http-proxies delete http-lb-proxy --quiet
gcloud compute url-maps list
gcloud compute url-maps delete web-map --quiet
gcloud compute backend-services list
gcloud compute backend-services remove-backend nginx-backend --instance-group nginx-group --instance-group-zone australia-southeast1-c --global --quiet
gcloud compute backend-services delete nginx-backend --global --quiet
gcloud compute instance-groups managed get-named-ports nginx-group --zone australia-southeast1-c
gcloud compute health-checks list
gcloud compute health-checks delete http-basic-check --quiet

gcloud compute forwarding-rules list
gcloud compute forwarding-rules delete nginx-lb --region australia-southeast1 --quiet
gcloud compute firewall-rules list
gcloud compute firewall-rules delete www-firewall --quiet
gcloud compute instance-groups managed list
gcloud compute instance-groups managed delete nginx-group --zone australia-southeast1-c --quiet
gcloud compute target-pools list
gcloud compute target-pools delete nginx-pool --region australia-southeast1 --quiet
gcloud compute instance-templates list
gcloud compute instance-templates delete nginx-template --quiet

rm startup.sh
