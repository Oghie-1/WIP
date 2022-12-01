#!/bin/bash

#aigbemanuel@gmail.com

gcloud compute instances create my-instance \
     --zone=us-central1-c \
     --image=debian-10-buster \
     --machine-type=n1-standard-1 \
     --boot-disk-size="10GB"


gcloud compute instances create my-instance \
    --zone=us-central1-c --machine-type=n1-standard-1 \
    --network-interface=subnet=default,no-address \
    --metadata=enable-oslogin=true --maintenance-policy=MIGRATE \
    

gcloud compute instances create my-vm-2 \
    --zone=europe-west1-c --machine-type=n1-standard-2 \


gcloud compute instances create my-vm-3 \
    --zone=us-central1-a --machine-type=e2-custom-2-4096 \
   