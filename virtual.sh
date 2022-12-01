#!/bin/bash

#aigbemanuel@gmail.com


gcloud compute networks delete mynetwork


gcloud compute networks create mynetwork --subnet-mode=auto --mtu=1460 --bgp-routing-mode=regional

gcloud compute firewall-rules create allow-custom --network=mynetwork \
    --direction=INGRESS --priority=65534 --source-ranges=10.128.0.0/9 --action=ALLOW --rules=all

gcloud compute firewall-rules create allow-icmp --network=mynetwork \
    --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=icmp

gcloud compute firewall-rules create allow-rdp --network=mynetwork \
    --direction=INGRESS --priority=65534 --source-ranges=0.0.0.0/0 --action=ALLOW --rules=tcp:3389


gcloud compute instances create utility --zone=europe-west2-c \
    --machine-type=n1-standard-1 --network-interface=subnet=mynetwork,no-address --metadata=enable-oslogin=true \
    --create-disk=auto-delete=yes,boot=yes,device-name=utility,image=projects/debian-cloud/global/images/debian-10-buster-v20221102,mode=rw,size=10 \
    --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any \

gcloud compute instances create windows --zone=europe-west1-c --machine-type=n1-standard-2 --network-interface=subnet=default \
    --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD \
    --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=windows,image=projects/windows-cloud/global/images/windows-server-2016-dc-core-v20221109,mode=rw,size=100 \
    --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

gcloud compute instances create custom-vm --zone=asia-southeast1-a --machine-type=e2-custom-2-4096 \
    --network-interface=subnet=mynetwork --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD \
    --create-disk=auto-delete=yes,boot=yes,device-name=custom-vm,image=projects/debian-cloud/global/images/debian-10-buster-v20221102,mode=rw,size=10 \
    --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

gcloud compute instances create windows-x --zone=europe-west1-c --machine-type=n1-standard-2 \
    --create-disk=auto-delete=yes,boot=yes,device-name=windows,image=windows-server-2016-dc-v20221109,mode=rw,size=100,\
    --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any


gcloud compute instances list


