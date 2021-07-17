#!/usr/bin/env bash

gcloud compute instances delete privatenet-eu-vm --zone=europe-west4-b
gcloud compute instances delete privatenet-us-vm --zone=us-central1-f
gcloud compute instances delete management-au-vm --zone=australia-southeast1-a
gcloud compute networks subnets delete privatenet-us0
gcloud compute networks subnets delete privatenet-eu0
gcloud compute networks delete privatenet
gcloud compute networks subnets delete managementnet-au0
gcloud compute networks delete managementnet
