gcloud compute instances create blue --zone="australia-southeast1-b" --machine-type="e2-micro" --network="default" --subnet="default" --tags="web-server,blue" --image="debian-10-buster-v20210701" --image-project="debian-cloud" --boot-disk-size="10GB" --labels="canary=blue" --private-network-ip="10.152.0.4"
gcloud compute instances create green --zone="australia-southeast1-c" --machine-type="e2-micro" --network="default" --subnet="default" --tags="web-server,green" --image="debian-10-buster-v20210701" --image-project="debian-cloud" --boot-disk-size="10GB" --labels="canary=green" --private-network-ip="10.152.0.5"

gcloud compute ssh blue

# sudo apt-get install nginx-light -y
# sudo sed -i -E "s/^(<h1>Welcome to )nginx\!(<\/h1>)$/\1$(hostname) server\!\2/g" /var/www/html/index.nginx-debian.html

gcloud compute ssh green

# sudo apt-get install nginx-light -y
# sudo sed -i -E "s/^(<h1>Welcome to )nginx\!(<\/h1>)$/\1$(hostname) server\!\2/g" /var/www/html/index.nginx-debian.html