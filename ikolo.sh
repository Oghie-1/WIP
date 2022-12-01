#!/bin/bash

#aigbemanuel@gmail.com

gcloud compute networks subnets list --network default

gcloud compute routes list --filter="network= default AND priority=1000"

gcloud compute firewall-rules list

gcloud compute firewall-rules delete default

gcloud compute networks delete default

gcloud compute networks subnets list --sort-by=NETWORK

gcloud compute instances create test-instance

gcloud compute networks create mynetwork 

gcloud compute firewall-rules create mynetwork-rules --network mynetwork --allow tcp:22,tcp:3389,icmp


gcloud compute instances create mynet-us-vm --subnet=auto --network=mynetwork\
    --zone=us-central1-a --machine-type=e2-micro \
    --image-family=debian-11 --image-project=debian-cloud --boot-disk-size=10GB \

gcloud compute instances list

gcloud compute instances create mynet-eu-vm --network=mynetwork\
    --zone=europe-west1-c --machine-type=e2-micro \
    --image-family=debian-11 --image-project=debian-cloud --boot-disk-size=10GB \


gcloud compute instances create my-instance \
     --zone=us-central1-c \
     --image=debian-11-bullseye \
     --machine-type=e2-micro \
     --boot-disk-size="10GB"


ping -c 3 mynet-eu-vm-ip


gcloud compute instances list
gcloud compute networks list


gcloud compute networks create managementnet \
    --subnet-mode=custom \
    --zone=us-central1 \
    --range=10.240.0.0/20


gcloud compute networks create privatenet \
    --subnet-mode=custom \
    --zone=us-central1 \
    --range=10.240.0.0/20

gcloud compute networks subnets create privatesubnet-us \
    --network=privatenet --region=Lab region \
    --range=172.16.0.0/24



gcloud compute networks list


gcloud compute networks subnets list --sort-by=network

gcloud compute firewall-rules create managementnet-allow-icmp-ssh-rdp \
     --network managementnet --allow tcp:22,tcp:3389,icmp \
     --source-ranges=0.0.0.0/0 

gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp \
    --direction=INGRESS --priority=1000 --network=privatenet \
    --action=ALLOW --rules=icmp,tcp:22,tcp:3389 \
    --source-ranges=0.0.0.0/0

gcloud compute instances create managementment-us-vm \
     --zone=us-central1-c \
     --image=debian-11-bullseye \
     --machine-type=e2-micro \
     --boot-disk-size="10GB" \
      --boot-disk-type=pd-standard \
     --network=managementnet \
     --subnetwor=managementsubnet-us

    
gcloud compute instances create privatenet-us-vm \
    --network=privatenet --machine-type=e2-micro \
    --subnet=privatesubnet-us --image-family=debian-11 \
    --image-project=debian-cloud --boot-disk-size=10GB \
    --boot-disk-type=pd-standard \
    --boot-disk-device-name=privatenet-us-vm

gcloud compute instances list --sort-by=zone