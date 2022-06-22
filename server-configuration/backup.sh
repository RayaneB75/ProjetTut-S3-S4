#!/bin/bash

rm /var/services/homes/rayane/backup/last/*
echo
echo `date`
#Backup des containers:
m=$(date | cut -d " " -f2)
j=$(date | cut -d " " -f3)

for i in www openvpn ns portainer orthanc emr
do
        echo "Backup du container $i en cours"
        sudo docker commit -p $i backup-$i
        mkdir -p /volume1/docker/rayane/backup/auto
        echo "Sauvegarde dans le repertoire /volume1/docker/rayane/backup/auto"
        sudo docker save -o /volume1/docker/rayane/backup/auto/$j-$m-$i.tar backup-$i
        sudo chown rayane /volume1/docker/rayane/backup/auto/$j-$m-$i.tar
        sudo chgrp users /volume1/docker/rayane/backup/auto/$j-$m-$i.tar
        sudo chmod 744 /volume1/docker/rayane/backup/auto/$j-$m-$i.tar
        sudo cp /volume1/docker/rayane/backup/auto/$j-$m-$i.tar /volume1/docker/rayane/backup/last/backup-$i.tar
done