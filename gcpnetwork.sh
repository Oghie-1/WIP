#!/bin/bash

#aigbemanuel@gmail.com


gcloud compute networks delete default


gcloud compute networks create mynetwork  --subnet-mode=auto --mtu=1460 --bgp-routing-mode=regional

gcloud compute firewall-rules create allow-custom --network=mynetwork \
    --direction=INGRESS --priority=65534 --source-ranges=10.128.0.0/9 --action=ALLOW --rules=all

gcloud compute firewall-rules create allow-icmp --network=mynetwork \
    --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=icmp

gcloud compute firewall-rules create allow-rdp --network=mynetwork \
    --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:3389

gcloud compute instances create mynet-us-vm --zone=us-west1-b --machine-type=f1-micro \
    --network-interface=network-tier=PREMIUM,subnet=mynetwork --metadata=enable-oslogin=true \
    --maintenance-policy=MIGRATE --provisioning-model=STANDARD

gcloud compute instances create mynet-eu-vm --zone=europe-central2-a --machine-type=f1-micro \
    --network-interface=network-tier=PREMIUM,subnet=mynetwork --metadata=enable-oslogin=true --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

ping -c 3 34.118.81.26

ping -c 3 10.186.0.2
