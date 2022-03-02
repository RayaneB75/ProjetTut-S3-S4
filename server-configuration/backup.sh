#!/bin/bash

d=$(date %)
# Backup des containers:
for i in www openvpn ns portainer dicom mail
do
	echo "Backup du container $i en cours"
	sudo docker commit -p $i backup-$i
	echo "Sauvegarde dans le répertoire /var/services/homes/rayane/backup"
	sudo docker save -o /var/services/homes/rayane/backup/backup-$i.tar backup-$i
done