#!/usr/bin/env bash

# managementnet vpc

gcloud compute networks create managementnet --description="qwilabs tutorial - multi vpc networks (managementnet)" --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create managementnet-au0 --description="managementnet au subnet0" --range=10.130.0.0/20 --network=managementnet --region=australia-southeast1 --secondary-range=au-subnet0-range2=10.134.0.0/20

# privatenet vpc
gcloud compute networks create privatenet --subnet-mode=custom --description="qwilabs tutorial - multi vpc networks (privatenet)"
gcloud compute networks subnets create privatenet-us0 --network=privatenet --region=us-central1 --range=172.16.0.0/24 --secondary-range=us-subnet0-range2=172.17.0.0/24 --secondary-range=us-subnet0-range3=172.18.0.0/24
gcloud compute networks subnets create privatenet-eu0 --network=privatenet --region=europe-west4 --range=172.20.0.0/20 --secondary-range=eu-subnet0-range2=172.24.0.0/20 --secondary-range=eu-subnet0-range3=172.28.0.0/20

# network/subnet list
gcloud compute networks list
gcloud compute networks subnets list --sort-by=NETWORK
gcloud compute networks subnets list --network=managementnet
gcloud compute networks subnets list --network=privatenet

# managementnet firewall
gcloud compute firewall-rules create managementnet-allow-icmp-ssh-rdp --description="managementnet allow icmp, ssh, rdp" --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules="tcp:22,tcp:3389,icmp" --source-ranges=0.0.0.0/0

# privatenet firewall
gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --description="privatenet allow icmp, ssh, rdp" --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules="icmp,tcp:22,tcp:3389" --source-ranges=0.0.0.0/0

# firewall list
gcloud compute firewall-rules list
gcloud compute firewall-rules list --sort-by=NETWORK
gcloud compute firewall-rules list --filter="network=managementnet"
gcloud compute firewall-rules list --filter="network=privatenet"

# managementnet vms
gcloud compute instances create  managementnet-au-vm --zone=australia-southeast1-a --machine-type=f1-micro --network-interface="network=managementnet,subnet=managementnet-au0,private-network-ip=10.130.0.2,aliases=10.130.0.3/32;10.130.0.4/32;10.130.0.128/25;au-subnet0-range2:10.134.0.2/32;au-subnet0-range2:/32;au-subnet0-range2:10.135.0.0/24;" --network-interface="network=default,subnet=default,private-network-ip=10.152.0.2,aliases=10.152.0.3/32;/32;10.152.0.32/27"

# gcloud compute instances create managementnet-au-vm --zone=australia-southeast1-a --machine-type=f1-micro --subnet=managementnet-au0 --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=377096152061-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=debian-10-buster-v20210512 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-balanced --boot-disk-device-name=managementnet-au-vm --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

# privatenet vms
gcloud compute instances create privatenet-us-vm --zone=us-central1-f --machine-type=f1-micro --network-interface="network=privatenet,subnet=privatenet-us0,private-network-ip=172.16.0.2,aliases=172.16.0.3/32;172.16.0.4/32;us-subnet0-range2:172.17.0.2/32;us-subnet0-range2:/32;us-subnet0-range3:172.18.0.2/32;us-subnet0-range3:172.18.0.3/32;us-subnet0-range3:172.18.0.128/28"

gcloud compute instances create privatenet-eu-vm --zone=europe-west4-b --machine-type=f1-micro --network-interface="network=privatenet,subnet=privatenet-eu0,private-network-ip=172.20.0.2,aliases=172.20.0.3/32;/32;172.20.1.0/24;eu-subnet0-range2:172.24.0.2/32;eu-subnet0-range2:/32;eu-subnet0-range3:172.28.0.2/32;eu-subnet0-range3:172.28.0.3/32;eu-subnet0-range3:172.28.1.128/25;eu-subnet0-range3:172.28.4.0/22" --network-interface="network=default,subnet=default,private-network-ip=10.164.0.2,aliases=10.164.0.3/32;/32;10.164.0.32/27"