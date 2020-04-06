#!/usr/bin/env bash

# Q1
gcloud compute images list
gcloud compute instances create --machine-type f1-micro --zone australia-southeast1-c nucleus-jumphost
gcloud compute instances list

# Q2
gcloud container clusters create gcelab2 --zone australia-southeast1-c
gcloud container clusters get-credentials gcelab2 --zone australia-southeast1-c
kubectl create deploy hello-app --image="gcr.io/google-samples/hello-app:2.0"
kubectl scale deploy/hello-app --replicas=5
kubectl expose deploy hello-app --port="8080" --type=LoadBalancer

# Q3
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

gcloud compute instance-templates create nginx-template --metadata-from-file startup-script=startup.sh
gcloud compute target-pools create nginx-pool --region australia-southeast1
gcloud compute instance-groups managed create nginx-group --base-instance-name nginx --size 2 --template nginx-template --target-pool nginx-pool --zone australia-southeast1-c
gcloud compute firewall-rules create www-firewall --allow tcp:80
gcloud compute forwarding-rules create nginx-lb --region australia-southeast1 --ports=80 --target-pool nginx-pool
gcloud compute forwarding-rules list

gcloud compute health-checks create http http-basic-check
gcloud compute instance-groups managed set-named-ports nginx-group --named-ports http:80 --zone australia-southeast1-c
gcloud compute backend-services create nginx-backend --protocol HTTP --health-checks http-basic-check --global
gcloud compute backend-services add-backend nginx-backend --instance-group nginx-group --instance-group-zone australia-southeast1-c --global
gcloud compute url-maps create web-map --default-service nginx-backend
gcloud compute target-http-proxies create http-lb-proxy --url-map web-map
gcloud compute forwarding-rules create http-content-rule --global --target-http-proxy http-lb-proxy --ports 80
gcloud compute forwarding-rules list
